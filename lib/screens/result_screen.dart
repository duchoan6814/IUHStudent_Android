import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:iuh_student/config/color_config.dart';
import 'package:collection/collection.dart';
import 'package:iuh_student/queries/get_diem.dart';
import 'package:iuh_student/utils/graphql_config.dart';
import 'package:iuh_student/widgets/line_subject_result.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({Key? key}) : super(key: key);

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  late List<bool> resultData;
  late Future<dynamic> listDiemThi;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listDiemThi = query();
  }

  Future<dynamic> query() async {
    QueryOptions options = QueryOptions(
      fetchPolicy: FetchPolicy.networkOnly,
      document: gql(getDiemThi),
    );

    final result = await clientA.query(options);

    var _data = result?.data?["getDiemThi"]?["data"];

    setState(() {
      resultData = _data?.map<bool>((item) => true).toList();
    });

    return _data;
  }

  @override
  Widget build(BuildContext context) {
    const titleStyle = TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20.0,
        color: ColorConfig.character);

    final handleOnTapScoreLine = (subject) {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    subject["tenMonHoc"],
                    style: TextStyle(
                        color: ColorConfig.character,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Divider(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Điểm thường kỳ: ",
                        style: TextStyle(
                            fontSize: 17.0, color: ColorConfig.character),
                      ),
                      Row(
                        children: subject["diemThuongKy"]
                            ?.map<Widget>((item) => Text(
                                  item.toString() +  " | ",
                                  style: TextStyle(
                                      fontSize: 17.0,
                                      fontWeight: FontWeight.bold,
                                      color: item <= 5
                                          ? ColorConfig.red
                                          : ColorConfig.character),
                                ))
                            .toList(),
                      )
                    ],
                  ),
                  Divider(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Điểm giữa kỳ: ",
                        style: TextStyle(
                            color: ColorConfig.character, fontSize: 17.0),
                      ),
                      Text(
                        subject["diemGiuaKy"].toString(),
                        style: TextStyle(
                            fontSize: 17.0,
                            color: subject["diemGiuaKy"] <= 5
                                ? ColorConfig.red
                                : ColorConfig.character,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  Divider(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Điểm thực hành: ",
                        style: TextStyle(
                            color: ColorConfig.character, fontSize: 17.0),
                      ),

                      Row(
                        children: subject["diemThucHanh"]?.map<Widget>((item) => Text(
                          item.toString() + " | ",
                          style: TextStyle(
                              fontSize: 17.0,
                              color: item <= 5
                                  ? ColorConfig.red
                                  : ColorConfig.character,
                              fontWeight: FontWeight.bold),
                        )).toList()
                      )

                    ],
                  ),
                  Divider(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Điểm cuối kỳ: ",
                        style: TextStyle(
                            color: ColorConfig.character, fontSize: 17.0),
                      ),
                      Text(
                        subject["diemCuoiKy"].toString(),
                        style: TextStyle(
                            fontSize: 17.0,
                            color: subject["diemCuoiKy"] == null ? ColorConfig.red : subject["diemCuoiKy"] <= 5
                                ? ColorConfig.red
                                : ColorConfig.character,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  Divider(
                    height: 30.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Điểm trung bình: ",
                        style: TextStyle(
                          fontSize: 17.0,
                          fontWeight: FontWeight.bold,
                          color: ColorConfig.character
                        ),
                      ),
                      Text(
                        subject["diemTrungBinh"].toString(),
                        style: TextStyle(
                          color: subject["diemTrungBinh"] != null ? (subject["diemTrungBinh"] <= 5 ? ColorConfig.red : ColorConfig.character) : ColorConfig.red,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold
                        ),
                      )
                    ],
                  ),
                  Divider(
                    height: 10.0,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Ghi chú:", style: TextStyle(
                        fontSize: 17.0,
                        color: ColorConfig.character,
                        fontWeight: FontWeight.bold
                      ),),
                      Text(
                          subject["ghiChu"] ?? "",
                        style: TextStyle(
                          color: ColorConfig.character,
                          fontSize: 17.0
                        ),
                      )
                    ],
                  )
                ],
              ),
            );
          });
    };

    var handleExpandClickHeader = (index, isExpanded) {
      var _dataResult = resultData;

      _dataResult = [
        ..._dataResult.sublist(0, index),
        !isExpanded,
        ..._dataResult.sublist(index + 1)
      ];

      setState(() {
        resultData = _dataResult;
      });
    };

    return FutureBuilder(
        future: listDiemThi,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            final _listHocKy = snapshot?.data ?? [];

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      "Kết quả học tập",
                      style: titleStyle,
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  ExpansionPanelList(
                      children: _listHocKy?.map<ExpansionPanel>((e) {
                        bool _isExpand = resultData[_listHocKy?.indexOf(e)];
                        String _termName = e["tenHocKy"];
                        List<dynamic> _listSubject = e["monHocs"];

                        return ExpansionPanel(
                            isExpanded: _isExpand,
                            headerBuilder: (context, isExpanded) {
                              return Padding(
                                padding: const EdgeInsets.only(left: 16.0),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        _termName,
                                        style: const TextStyle(
                                            color: ColorConfig.character,
                                            fontSize: 20.0),
                                      ),
                                    ]),
                              );
                            },
                            // body: Container(),
                            body: Column(
                                children: _listSubject.map((item) {
                              int? _stt = _listSubject?.indexOf(item);
                              final _subject = item;

                              return LineSubjectResult(
                                  onTap: handleOnTapScoreLine,
                                  stt: _stt! + 1,
                                  subject: _subject);
                            }).toList()),
                            canTapOnHeader: true);
                      }).toList(),
                      expansionCallback: handleExpandClickHeader)
                ],
              ),
            );
          }
        });
  }
}
