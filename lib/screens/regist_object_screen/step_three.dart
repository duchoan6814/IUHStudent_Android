import 'package:flutter/material.dart';
import 'package:iuh_student/config/color_config.dart';
import 'package:iuh_student/config/color_config.dart';
import 'package:iuh_student/screens/regist_object_screen/lich_hoc_card.dart';

class StepThree extends StatefulWidget {
  const StepThree({Key? key}) : super(key: key);

  @override
  State<StepThree> createState() => _StepThreeState();
}

class _StepThreeState extends State<StepThree> {
  late List<Map> listLichHoc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listLichHoc = [
      {
        "lichHoc": "LT - Thứ 2 (T9 - T11)",
        "nhomThucHanh": null,
        "phong": "B12.12",
        "dayNha": "H",
        "giangVien": "ThS Nguyễn Mạnh Hải",
        "thoiGian": "29/7/2019 - 11/11/2019"
      },
      {
        "lichHoc": "LT - Thứ 2 (T9 - T11)",
        "nhomThucHanh": null,
        "phong": "B12.12",
        "dayNha": "H",
        "giangVien": "ThS Nguyễn Mạnh Hải",
        "thoiGian": "29/7/2019 - 11/11/2019"
      },
      {
        "lichHoc": "LT - Thứ 2 (T9 - T11)",
        "nhomThucHanh": null,
        "phong": "B12.12",
        "dayNha": "H",
        "giangVien": "ThS Nguyễn Mạnh Hải",
        "thoiGian": "29/7/2019 - 11/11/2019"
      },
      {
        "lichHoc": "LT - Thứ 2 (T9 - T11)",
        "nhomThucHanh": null,
        "phong": "B12.12",
        "dayNha": "H",
        "giangVien": "ThS Nguyễn Mạnh Hải",
        "thoiGian": "29/7/2019 - 11/11/2019"
      },
      {
        "lichHoc": "LT - Thứ 2 (T9 - T11)",
        "nhomThucHanh": null,
        "phong": "B12.12",
        "dayNha": "H",
        "giangVien": "ThS Nguyễn Mạnh Hải",
        "thoiGian": "29/7/2019 - 11/11/2019"
      },
      {
        "lichHoc": "LT - Thứ 2 (T9 - T11)",
        "nhomThucHanh": null,
        "phong": "B12.12",
        "dayNha": "H",
        "giangVien": "ThS Nguyễn Mạnh Hải",
        "thoiGian": "29/7/2019 - 11/11/2019"
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
            "CHI TIẾT LỚP HỌC PHẦN",
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
                  Map _lichHoc = listLichHoc[index];

                  return LichHocCard(
                    lichHoc: _lichHoc,
                  );
                },
                separatorBuilder: (context, index) => const Divider(),
                itemCount: listLichHoc.length),
          ),
          const SizedBox(
            height: 10.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {},
                child: const Text(
                  "Hoàn thành",
                  style: TextStyle(color: ColorConfig.red),
                ),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(ColorConfig.redLight),
                ),
              )
            ],
          )
        ],
      ),
    );
    ;
  }
}
