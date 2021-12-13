import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:iuh_student/config/color_config.dart';
import 'package:iuh_student/queries/queries.dart';
import 'package:iuh_student/screens/screens.dart';
import 'package:iuh_student/storage/context.dart';
import 'package:iuh_student/utils/global_storage.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:graphql_flutter/graphql_flutter.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<DiemTrungBinhData> _diemTrungBinhChartData;
  late List<DiemTrungBinhData> _diemCuaBanChartData;
  late List<DiemTrungBinhData> _tienDoHocTapData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _diemTrungBinhChartData = getLineChartData;
    _diemCuaBanChartData = getBarChartData;
    _tienDoHocTapData = getTienDo;
  }

  @override
  Widget build(BuildContext context) {
    String dropdownValue = "HK1 2018 - 2019";

    return Query(
      options: QueryOptions(
        document: gql(getProfileQuery),
      ),
      builder: (QueryResult result,
          { VoidCallback? refetch, FetchMore? fetchMore }) {

        if (result.hasException) {
          print("result" + result.exception.toString());
          WidgetsBinding.instance!.addPostFrameCallback((_) async {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage()));
          });
        }

        currentStudent = result.data?["getProfile"]?["data"];
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
                SfCircularChart(
                    legend: Legend(
                        isVisible: true,
                        overflowMode: LegendItemOverflowMode.wrap
                    ),
                    series: <CircularSeries>[
                      RadialBarSeries<DiemTrungBinhData, String>(
                          maximumValue: _tienDoHocTapData[1].diemSo.toDouble(),
                          radius: '100%',
                          gap: '3%',
                          dataLabelSettings: const DataLabelSettings(isVisible: true),
                          enableTooltip: true,
                          dataSource: _tienDoHocTapData,
                          xValueMapper: (DiemTrungBinhData exp, _) => exp.tenMonHoc,
                          yValueMapper: (DiemTrungBinhData exp, _) => exp.diemSo),
                    ])
              ],
            ),
          ),
        );
      },
    );
  }

  List<DiemTrungBinhData> getTienDo = [
    DiemTrungBinhData("Da xong", 70),
    DiemTrungBinhData("Tong", 155),
  ];

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

class DiemTrungBinhData {
  DiemTrungBinhData(this.tenMonHoc, this.diemSo);

  final String tenMonHoc;
  final num diemSo;
}
