import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iuh_student/config/color_config.dart';

import 'lop_hoc_phan_card.dart';

class Step2 extends StatefulWidget {
  const Step2({Key? key}) : super(key: key);

  @override
  State<Step2> createState() => _Step2State();
}

class _Step2State extends State<Step2> {
  late List<Map> listTerm;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    listTerm = [
      {
        "maLopHocPhan": "422000360501",
        "tenLopHocPhan": "Phương pháp tính",
        "lopDuKien": "DHKTPM14BTT",
        "siSoToiDa": 80,
        "daDangKy": 40,
        "trangThai": "Đã khóa"
      },
      {
        "maLopHocPhan": "422000360501",
        "tenLopHocPhan": "Phương pháp tính",
        "lopDuKien": "DHKTPM14BTT",
        "siSoToiDa": 80,
        "daDangKy": 40,
        "trangThai": "Đã khóa"
      },
      {
        "maLopHocPhan": "422000360501",
        "tenLopHocPhan": "Phương pháp tính",
        "lopDuKien": "DHKTPM14BTT",
        "siSoToiDa": 80,
        "daDangKy": 40,
        "trangThai": "Đã khóa"
      },
      {
        "maLopHocPhan": "422000360501",
        "tenLopHocPhan": "Phương pháp tính",
        "lopDuKien": "DHKTPM14BTT",
        "siSoToiDa": 80,
        "daDangKy": 40,
        "trangThai": "Đã khóa"
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height - 210.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "LỚP HỌC PHẦN",
            style: TextStyle(
                color: ColorConfig.character,
                fontSize: 20.0,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 24.0,
          ),
          Expanded(
            child: ListView.separated(
                itemBuilder: (context, index) {
                  Map _lopHocPhan = listTerm[index];

                  return LopHocPhanCard(lopHocPhan: _lopHocPhan,);
                },
                separatorBuilder: (context, index) => const Divider(),
                itemCount: listTerm.length),
          )
        ],
      ),
    );
  }
}
