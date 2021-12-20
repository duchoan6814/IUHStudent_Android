import 'package:flutter/material.dart';
import 'package:iuh_student/config/color_config.dart';
import 'package:collection/collection.dart';
import 'package:iuh_student/screens/regist_object_screen/subject_card.dart';

class StepOne extends StatefulWidget {
  const StepOne({Key? key}) : super(key: key);

  @override
  State<StepOne> createState() => _StepOneState();
}

class _StepOneState extends State<StepOne> {
  late Map currentTerm;
  late List<Map> listTerm;
  late List<Map> listSubject;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentTerm = {
      "id": 1,
      "name": "HK1 (2019 - 2020)"
    };

    listSubject = [
      {
        "maHocPhan": "4220003605",
        "tenMonHoc": "Phương pháp tính",
        "soTinChi": 3,
        "batBuoc": false,
        "loaiHocPhan": ["Học trước", "Song hành"]
      },
      {
        "maHocPhan": "4220003605",
        "tenMonHoc": "Phương pháp tính",
        "soTinChi": 3,
        "batBuoc": true,
        "loaiHocPhan": ["Học trước", "Song hành"]
      },
      {
        "maHocPhan": "4220003605",
        "tenMonHoc": "Phương pháp tính",
        "soTinChi": 3,
        "batBuoc": false,
        "loaiHocPhan": ["Học trước", "Song hành"]
      },
      {
        "maHocPhan": "4220003605",
        "tenMonHoc": "Phương pháp tính",
        "soTinChi": 3,
        "batBuoc": true,
        "loaiHocPhan": ["Học trước", "Song hành"]
      },
      {
        "maHocPhan": "4220003605",
        "tenMonHoc": "Phương pháp tính",
        "soTinChi": 3,
        "batBuoc": true,
        "loaiHocPhan": ["Học trước", "Song hành"]
      }

    ];

    listTerm = [
      {
        "id": 1,
        "name": "HK1 (2019 - 2020)"
      },
      {
        "id": 2,
        "name": "HK2 (2019 - 2020)"
      },
      {
        "id": 3,
        "name": "HK1 (2020 - 2021)"
      },
      {
        "id": 4,
        "name": "HK2 (2020 - 2021)"
      },
    ];
  }

  @override
  Widget build(BuildContext context) {

    const titleStyle = TextStyle(
        color: ColorConfig.character,
        fontSize: 20.0,
        fontWeight: FontWeight.bold
    );

    var handleDropDownSelect = (newValue) {
      var _term = listTerm.firstWhere((element) => element["id"].toString() == newValue);

      setState(() {
        currentTerm = _term;
      });
    };

    return SizedBox(
      height: MediaQuery.of(context).size.height - 210.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Học kỳ",
                style: titleStyle,

              ),
              DropdownButton(
                value: currentTerm["id"].toString(),
                icon: const Icon(Icons.arrow_downward),
                iconSize: 24,
                elevation: 16,
                style: const TextStyle(color: Colors.deepPurple),
                underline: Container(
                  height: 2,
                  color: Colors.deepPurpleAccent,
                ),
                onChanged: (newValue) {
                  handleDropDownSelect(newValue);
                },
                items: listTerm.map((item) {
                  return DropdownMenuItem<String>(
                      value: item["id"].toString(), child: Text(item["name"]));
                }).toList(),
              )
            ],
          ),
          const SizedBox(
            height: 20.0,
          ),

          Expanded(
            child: ListView.separated(
              itemCount: listSubject.length,
              itemBuilder: (context, index) {
                Map _subject = listSubject[index];
                return SubjectCard(subject: _subject);
              },
              separatorBuilder: (context, index) => const Divider(),
            ),
          )
        ],
      ),
    );
  }
}
