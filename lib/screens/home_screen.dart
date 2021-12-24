import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:iuh_student/config/color_config.dart';
import 'package:iuh_student/queries/get_hoc_ky.dart';
import 'package:iuh_student/queries/get_ket_qua_hoc_tap.dart';
import 'package:iuh_student/queries/get_qua_trinh_hoc_tap.dart';
import 'package:iuh_student/utils/graphql_config.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<DiemTrungBinhData> _diemTrungBinhChartData;
  late List<DiemTrungBinhData> _diemCuaBanChartData;
  late TooltipBehavior tooltip;
  String? dropdownValue;

  late Future<dynamic> dataResTienDoHocTap;
  late Future<dynamic> dataResHocKy;
  late Future<dynamic> dataResKetQuaHocTap;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _diemTrungBinhChartData = getLineChartData;
    _diemCuaBanChartData = getBarChartData;
    dataResTienDoHocTap = getTienDoHocTapQuery();
    tooltip = TooltipBehavior(enable: true);
    dataResHocKy = getHocKyQuery();
  }

  Future<dynamic> getTienDoHocTapQuery() async {
    QueryOptions options = QueryOptions(
      fetchPolicy: FetchPolicy.networkOnly,
      document: gql(getTienDoHocTap),
    );

    final result = await clientA.query(options);

    var _data = result?.data?["getTienDoHocTap"]?["data"];

    return _data;
  }

  Future<dynamic> getHocKyQuery() async {
    QueryOptions options = QueryOptions(
      fetchPolicy: FetchPolicy.networkOnly,
      document: gql(getHocKySimple),
    );

    final result = await clientA.query(options);

    var _data = result?.data?["getHocKySimple"]?["data"];

    setState(() {
      dropdownValue = _data?[_data?.length - 1]["hocKyId"];
      dataResKetQuaHocTap =
          getKetQuaHocTapQuery(_data?[_data?.length - 1]?["hocKyId"]);
    });

    return _data;
  }

  void refreshList(hocKyId) {
    // reload
    setState(() {
      dataResKetQuaHocTap = getKetQuaHocTapQuery(hocKyId);
    });
  }

  Future<dynamic> getKetQuaHocTapQuery(hocKyId) async {
    QueryOptions options = QueryOptions(
      fetchPolicy: FetchPolicy.networkOnly,
        document: gql(getKetQuaHocTap), variables: {"hocKyId": hocKyId});

    final result = await clientA.query(options);

    var _data = result?.data?["getKetQuaHocTap"]?["data"];

    return _data;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder(
                future: dataResHocKy,
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    final _listHocKy = snapshot?.data;

                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Kết quả học tập",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0,
                                  color: ColorConfig.character),
                            ),
                            DropdownButton(
                              value: dropdownValue ?? _listHocKy[_listHocKy?.length - 1]
                                      ["hocKyId"],
                              icon: const Icon(Icons.arrow_downward),
                              iconSize: 24,
                              elevation: 16,
                              style: const TextStyle(color: Colors.deepPurple),
                              underline: Container(
                                height: 2,
                                color: Colors.deepPurpleAccent,
                              ),
                              onChanged: (newValue) {
                                refreshList(newValue);
                                setState(() {
                                  dropdownValue = newValue as String?;
                                });
                              },
                              items: _listHocKy
                                  ?.map<DropdownMenuItem<String>>((_item) {
                                return DropdownMenuItem<String>(
                                    value: _item["hocKyId"],
                                    child: Text(_item["namHoc"]));
                              }).toList(),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        FutureBuilder(
                            future: dataResKetQuaHocTap,
                            builder: (BuildContext context,
                                AsyncSnapshot<dynamic> snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              } else {
                                final _listKetQuaHocTap = snapshot?.data;

                                List<DiemTrungBinhData> _listDiem =
                                    _listKetQuaHocTap
                                        ?.map<DiemTrungBinhData>((item) =>
                                            DiemTrungBinhData(
                                                item?["monHoc"]?["tenMonHoc"],
                                                item["diem"]))
                                        .toList();

                                List<DiemTrungBinhData> _listDiemTrungBinh =
                                    _listKetQuaHocTap
                                        ?.map<DiemTrungBinhData>((item) =>
                                            DiemTrungBinhData(
                                                item?["monHoc"]?["tenMonHoc"],
                                                item["diemTrungBinh"]))
                                        .toList();

                                return Column(
                                  children: [
                                    SfCartesianChart(
                                      primaryXAxis:
                                          CategoryAxis(isVisible: false),
                                      primaryYAxis: NumericAxis(
                                          maximum: 10, minimum: 0, interval: 1),
                                      tooltipBehavior: tooltip,
                                      series: <ChartSeries>[
                                        ColumnSeries<DiemTrungBinhData, String>(
                                            name: "Điểm của bạn",
                                            dataSource: _listDiem,
                                            xValueMapper:
                                                (DiemTrungBinhData exp, _) =>
                                                    exp.tenMonHoc,
                                            yValueMapper:
                                                (DiemTrungBinhData exp, _) =>
                                                    exp.diemSo),
                                        StackedLineSeries<DiemTrungBinhData,
                                                String>(
                                            name: "Điểm TB lớp học phần",
                                            dataSource: _listDiemTrungBinh,
                                            xValueMapper:
                                                (DiemTrungBinhData exp, _) =>
                                                    exp.tenMonHoc,
                                            yValueMapper:
                                                (DiemTrungBinhData exp, _) =>
                                                    exp.diemSo),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 15.0,
                                    ),
                                    Table(
                                      border: TableBorder.all(),
                                      children: [
                                        const TableRow(children: [
                                          Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text(
                                              "Môn học",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20.0),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text(
                                              "Tín chỉ",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20.0,
                                              ),
                                            ),
                                          )
                                        ]),
                                        ..._listKetQuaHocTap
                                            ?.map<TableRow>(
                                              (item) => TableRow(children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(item?["monHoc"]
                                                          ?["tenMonHoc"])
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: Text(item?["monHoc"]
                                                      ?["soTinChi"].toString() ?? ""),
                                                )
                                              ]),
                                            )
                                            .toList(),
                                      ],
                                    ),
                                  ],
                                );
                              }
                            }),
                      ],
                    );
                  }
                }),
            const SizedBox(
              height: 20.0,
            ),
            Row(
              children: const [
                Text(
                  "Tiến độ học tập",
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                )
              ],
            ),
            FutureBuilder(
                future: dataResTienDoHocTap,
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    final _dataTienDoHocTap = snapshot?.data ?? {};

                    TienDoHocTapData _tongTinChi = TienDoHocTapData(
                        "Tổng số tín chỉ", _dataTienDoHocTap["tongTinChi"]);
                    TienDoHocTapData _tinChiDatDuoc = TienDoHocTapData(
                        "Tín chỉ đạt được", _dataTienDoHocTap["tinChiDatDuoc"]);

                    return SfCircularChart(
                        legend: Legend(
                            isVisible: true,
                            overflowMode: LegendItemOverflowMode.wrap),
                        series: <CircularSeries>[
                          RadialBarSeries<TienDoHocTapData, String>(
                              maximumValue:
                                  _dataTienDoHocTap["tongTinChi"].toDouble(),
                              radius: '100%',
                              gap: '3%',
                              dataLabelSettings:
                                  const DataLabelSettings(isVisible: true),
                              enableTooltip: true,
                              dataSource: [_tinChiDatDuoc, _tongTinChi],
                              xValueMapper: (TienDoHocTapData exp, _) =>
                                  exp.key,
                              yValueMapper: (TienDoHocTapData exp, _) =>
                                  exp.value),
                        ]);
                  }
                })
          ],
        ),
      ),
    );
  }

  List<DiemTrungBinhData> getBarChartData = [
    DiemTrungBinhData("toán cao cấp", 9),
    DiemTrungBinhData("nhập môn lập trình", 7),
    DiemTrungBinhData("Những nguyên lý cơ bản của chủ nghĩa Mac-lenin", 4),
    DiemTrungBinhData("Lập trình thiết bị di động", 7)
  ];

  List<DiemTrungBinhData> getLineChartData = [
    DiemTrungBinhData("toán cao cấp", 4),
    DiemTrungBinhData("nhập môn lập trình", 6),
    DiemTrungBinhData("Những nguyên lý cơ bản của chủ nghĩa Mac-lenin", 10),
    DiemTrungBinhData("Lập trình thiết bị di động", 6),
  ];
}

class TienDoHocTapData {
  final String key;
  final int value;

  TienDoHocTapData(this.key, this.value);
}

class DiemTrungBinhData {
  DiemTrungBinhData(this.tenMonHoc, this.diemSo);

  final String tenMonHoc;
  final num diemSo;
}
