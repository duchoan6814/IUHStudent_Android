import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:iuh_student/config/color_config.dart';
import 'package:iuh_student/widgets/schedule_card.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({Key? key}) : super(key: key);

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  late DateTime pickedTime;
  var datePickerTextController = TextEditingController();
  late List<Map> listExpanded;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pickedTime = DateTime.now();
    listExpanded = [
      {
        "title": "thu 2 (20/11/2021)",
        "listSchedule": [
          {
            "name": "Quan ly du an CNTT",
            "className": "DHKTPM14BTT",
            "subjectClassId": "05164865421",
            "startAndEndTime": "1-3",
            "location": "H.73",
            "teacher": "Dang Thi Thu Ha",
            "note": "day la dong ghi chu"
          }
        ],
        "expanded": true
      },
      {
        "title": "thu 3 (20/11/2021)",
        "listSchedule": [
          {
            "name": "Quan ly du an CNTT",
            "className": "DHKTPM14BTT",
            "subjectClassId": "05164865421",
            "startAndEndTime": "1-3",
            "location": "H.73",
            "teacher": "Dang Thi Thu Ha",
            "note": "day la dong ghi chu"
          }
        ],
        "expanded": true
      },
      {
        "title": "thu 4 (20/11/2021)",
        "listSchedule": [
          {
            "name": "Quan ly du an CNTT",
            "className": "DHKTPM14BTT",
            "subjectClassId": "05164865421",
            "startAndEndTime": "1-3",
            "location": "H.73",
            "teacher": "Dang Thi Thu Ha",
            "note": "day la dong ghi chu"
          }
        ],
        "expanded": true
      },
      {
        "title": "thu 5 (20/11/2021)",
        "listSchedule": [
          {
            "name": "Quan ly du an CNTT",
            "className": "DHKTPM14BTT",
            "subjectClassId": "05164865421",
            "startAndEndTime": "1-3",
            "location": "H.73",
            "teacher": "Dang Thi Thu Ha",
            "note": "day la dong ghi chu"
          }
        ],
        "expanded": true
      },
      {
        "title": "thu 6 (20/11/2021)",
        "listSchedule": [
          {
            "name": "Quan ly du an CNTT",
            "className": "DHKTPM14BTT",
            "subjectClassId": "05164865421",
            "startAndEndTime": "1-3",
            "location": "H.73",
            "teacher": "Dang Thi Thu Ha",
            "note": "day la dong ghi chu"
          },
          {
            "name": "Quan ly du an CNTT",
            "className": "DHKTPM14BTT",
            "subjectClassId": "05164865421",
            "startAndEndTime": "1-3",
            "location": "H.73",
            "teacher": "Dang Thi Thu Ha",
            "note": "day la dong ghi chu"
          }
        ],
        "expanded": false
      },
      {
        "title": "thu 7 (20/11/2021)",
        "listSchedule": [
          {
            "name": "Quan ly du an CNTT",
            "className": "DHKTPM14BTT",
            "subjectClassId": "05164865421",
            "startAndEndTime": "1-3",
            "location": "H.73",
            "teacher": "Dang Thi Thu Ha",
            "note": "day la dong ghi chu"
          }
        ],
        "expanded": true
      },
      {
        "title": "Chu nhat (20/11/2021)",
        "listSchedule": [
          {
            "name": "Quan ly du an CNTT",
            "className": "DHKTPM14BTT",
            "subjectClassId": "05164865421",
            "startAndEndTime": "1-3",
            "location": "H.73",
            "teacher": "Dang Thi Thu Ha",
            "note": "day la dong ghi chu"
          }
        ],
        "expanded": true
      }
    ];
    datePickerTextController.text =
        DateFormat("dd/MM/yyyy").format(pickedTime ?? DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    const titleStyle = TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20.0,
        color: ColorConfig.character);

    var handleExpandClickHeader = (index, isExpanded) {
      var _schedule = listExpanded;
      _schedule = [
        ..._schedule.sublist(0, index),
        {..._schedule[index], "expanded": !isExpanded},
        ..._schedule.sublist(index + 1)
      ];

      setState(() {
        listExpanded = _schedule;
      });
    };

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
                    decoration: const InputDecoration(hintText: "hello world"),
                    readOnly: true,
                    controller: datePickerTextController,
                    onTap: () async {
                      DateTime? _date = await showDatePicker(
                          context: context,
                          initialDate: pickedTime,
                          firstDate: DateTime(2004),
                          lastDate: DateTime(2100));

                      setState(() => {pickedTime: _date});

                      datePickerTextController.text =
                          DateFormat("dd/MM/yyyy").format(_date ?? DateTime.now());
                    },
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FlatButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.arrow_back_ios),
                  label: Text("Trở về"),
                  color: ColorConfig.orange,
                ),
                FlatButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.calendar_today_sharp),
                  label: Text("Hiện tại"),
                  color: ColorConfig.orange,
                ),
                FlatButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.keyboard_arrow_right),
                  label: Text("Tiếp theo"),
                  color: ColorConfig.orange,
                )
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            ExpansionPanelList(
                children: listExpanded.map((e) {
                  var _listSchedule = e["listSchedule"];

                  return ExpansionPanel(
                      isExpanded: e["expanded"],
                      headerBuilder: (context, isExpanded) {
                        String _title = e["title"];
                        return Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _title,
                                  style: TextStyle(
                                      color: ColorConfig.character, fontSize: 20.0),
                                ),
                              ]),
                        );
                      },
                      // body: Text("asdasdada"),
                      body: Container(
                        child: ListView.separated(
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ScheduleCard(scheduleItem: _listSchedule[index],)
                              );
                            },
                            separatorBuilder: (BuildContext context, int index) {
                              return SizedBox(
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

}
