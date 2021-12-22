import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:intl/intl.dart';
import 'package:iuh_student/config/color_config.dart';
import 'package:iuh_student/queries/get_lich_hoc.dart';
import 'package:iuh_student/utils/graphql_config.dart';
import 'package:iuh_student/widgets/schedule_card.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({Key? key}) : super(key: key);

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  late DateTime pickedTime;
  var datePickerTextController = TextEditingController();
  late Future<dynamic> listExpanded;
  late List<bool> listBool;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pickedTime = DateTime.now();
    listExpanded = query(pickedTime.toIso8601String());
    datePickerTextController.text =
        DateFormat("dd/MM/yyyy").format(pickedTime ?? DateTime.now());
  }

  void refreshList(date) {
    // reload
    setState(() {
      listExpanded = query(date?.toIso8601String());
    });
  }

  Future<dynamic> query(date) async {
    QueryOptions options = QueryOptions(
        document: gql(getLichHoc),
        variables: {"date": date});

    final result = await clientA.query(options);

    var _data = result?.data?["getLichHoc"]?["data"];


    setState(() {
      listBool = _data?.map<bool>((item) => true).toList();
    });

    return _data;
  }

  @override
  Widget build(BuildContext context) {
    const titleStyle = TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20.0,
        color: ColorConfig.character);

    var handleExpandClickHeader = (index, isExpanded) {
      var _schedule = listBool;
      _schedule = [
        ..._schedule.sublist(0, index),
        !isExpanded,
        ..._schedule.sublist(index + 1)
      ];

      setState(() {
        listBool = _schedule;
      });
    };

    return FutureBuilder(
        future: listExpanded,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            final _listLichHoc = snapshot.data ?? [];

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          "Lịch học, lịch thi",
                          style: titleStyle,
                        ),
                        const SizedBox(
                          width: 50.0,
                        ),
                        Flexible(
                          child: TextField(
                            decoration:
                                const InputDecoration(hintText: "hello world"),
                            readOnly: true,
                            controller: datePickerTextController,
                            onTap: () async {
                              DateTime? _date = await showDatePicker(
                                  context: context,
                                  initialDate: pickedTime,
                                  firstDate: DateTime(2004),
                                  lastDate: DateTime(2100));

                              setState(() => pickedTime = _date!);

                              refreshList(_date);

                              datePickerTextController.text =
                                  DateFormat("dd/MM/yyyy")
                                      .format(_date ?? DateTime.now());
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        FlatButton.icon(
                          onPressed: () {
                            DateTime _date = pickedTime;

                            DateTime _newDate = DateTime(_date.year, _date.month, _date.day - 7);

                            setState(()  => pickedTime = _newDate);

                            refreshList(_newDate);

                            datePickerTextController.text =
                                DateFormat("dd/MM/yyyy")
                                    .format(_newDate ?? DateTime.now());

                          },
                          icon: const Icon(Icons.arrow_back_ios),
                          label: const Text("Trở về"),
                          color: ColorConfig.orange,
                        ),
                        FlatButton.icon(
                          onPressed: () {
                            DateTime _date = DateTime.now();

                            setState(() => pickedTime = _date);

                            refreshList(_date);

                            datePickerTextController.text =
                                DateFormat("dd/MM/yyyy")
                                    .format(_date ?? DateTime.now());

                          },
                          icon: const Icon(Icons.calendar_today_sharp),
                          label: const Text("Hiện tại"),
                          color: ColorConfig.orange,
                        ),
                        FlatButton.icon(
                          onPressed: () {
                            DateTime _date = pickedTime;

                            DateTime _nameDate = DateTime(_date.year, _date.month, _date.day + 7);

                            setState(() => pickedTime = _nameDate);

                            refreshList(_nameDate);

                            datePickerTextController.text =
                                DateFormat("dd/MM/yyyy")
                                    .format(_nameDate ?? DateTime.now());

                          },
                          icon: const Icon(Icons.keyboard_arrow_right),
                          label: const Text("Tiếp theo"),
                          color: ColorConfig.orange,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    ExpansionPanelList(
                        children: _listLichHoc?.map<ExpansionPanel>((item) {
                          var _listSchedule = item?["monHocs"] ?? [];

                          return ExpansionPanel(
                              isExpanded: listBool[_listLichHoc?.indexOf(item)],
                              headerBuilder: (context, isExpanded) {
                                String _title = item["name"] ?? "";
                                return Padding(
                                  padding: const EdgeInsets.only(left: 16.0),
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          _title,
                                          style: const TextStyle(
                                              color: ColorConfig.character,
                                              fontSize: 20.0),
                                        ),
                                      ]),
                                );
                              },
                              body: Container(
                                  child: ListView.separated(
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: ScheduleCard(scheduleItem: _listSchedule?[index],)
                                        );
                                      },
                                      separatorBuilder: (BuildContext context, int index) {
                                        return const SizedBox(
                                          height: 10.0,
                                        );
                                      },
                                      itemCount: _listSchedule.length),
                                  ),
                              canTapOnHeader: true);
                        }).toList(),
                        expansionCallback: handleExpandClickHeader)
                  ],
                ),
              ),
            );
          }
        });

  }
}
