import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:iuh_student/config/color_config.dart';
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

  late Future<dynamic> dataResTienDoHocTap;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _diemTrungBinhChartData = getLineChartData;
    _diemCuaBanChartData = getBarChartData;
    dataResTienDoHocTap = getTienDoHocTapQuery();
  }

  Future<dynamic> getTienDoHocTapQuery() async {
    QueryOptions options = QueryOptions(
      document: gql(getTienDoHocTap),
    );

    final result = await clientA.query(options);

    var _data = result?.data?["getTienDoHocTap"]?["data"];

    return _data;
  }

  @override
  Widget build(BuildContext context) {
    String dropdownValue = "HK1 2018 - 2019";

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
      child: SingleChildScrollView(
        child: Column(
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
                  value: dropdownValue,
                  icon: const Icon(Icons.arrow_downward),
                  iconSize: 24,
                  elevation: 16,
                  style: const TextStyle(color: Colors.deepPurple),
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValue = newValue!;
                    });
                  },
                  items: <String>[
                    "HK1 2018 - 2019",
                    "HK2 2018 - 2019",
                    "HK1 2019 - 2020",
                    "HK2 2019 - 2020"
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                        value: value, child: Text(value));
                  }).toList(),
                )
              ],
            ),
            const SizedBox(
              height: 15.0,
            ),
            SfCartesianChart(
              primaryXAxis: CategoryAxis(),
              series: <ChartSeries>[
                ColumnSeries<DiemTrungBinhData, String>(
                    dataSource: _diemCuaBanChartData,
                    xValueMapper: (DiemTrungBinhData exp, _) => exp.tenMonHoc,
                    yValueMapper: (DiemTrungBinhData exp, _) => exp.diemSo),
                StackedLineSeries<DiemTrungBinhData, String>(
                    dataSource: _diemTrungBinhChartData,
                    xValueMapper: (DiemTrungBinhData exp, _) => exp.tenMonHoc,
                    yValueMapper: (DiemTrungBinhData exp, _) => exp.diemSo),
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
                          fontWeight: FontWeight.bold, fontSize: 20.0),
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
                TableRow(children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text("123125125125"),
                        Text("Lap trinh huong doi tuong")
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("3"),
                  )
                ]),
                TableRow(children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text("123125125125"),
                        Text("Lap trinh huong doi tuong")
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("3"),
                  )
                ]),
                TableRow(children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text("123125125125"),
                        Text("Lap trinh huong doi tuong")
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("3"),
                  )
                ]),
                TableRow(children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text("123125125125"),
                        Text("Lap trinh huong doi tuong")
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("3"),
                  )
                ]),
              ],
            ),
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

                    TienDoHocTapData _tongTinChi = TienDoHocTapData("Tổng số tín chỉ", _dataTienDoHocTap["tongTinChi"]);
                    TienDoHocTapData _tinChiDatDuoc = TienDoHocTapData("Tín chỉ đạt được", _dataTienDoHocTap["tinChiDatDuoc"]);

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
