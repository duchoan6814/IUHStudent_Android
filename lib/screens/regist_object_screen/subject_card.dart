import 'package:flutter/material.dart';
import 'package:iuh_student/config/color_config.dart';

class SubjectCard extends StatelessWidget {
  final Map subject;

  const SubjectCard({Key? key, required this.subject}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    const titleStyle = TextStyle(
        color: ColorConfig.character,
        fontSize: 20.0,
        fontWeight: FontWeight.bold
    );

    return Container(
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: ColorConfig.orangeBackground,
        borderRadius: BorderRadius.all(Radius.circular(10.0))
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            subject["maHocPhan"],
            style: titleStyle,
          ),
          Text(
            subject["tenMonHoc"],
            style: titleStyle,
          ),
          const SizedBox(
            height: 5.0,
          ),
          Text(
            "Tín chỉ: " + subject["soTinChi"].toString(),
            style: const TextStyle(
                color: ColorConfig.character,
                fontSize: 17.0
            ),
          ),
          Row(
            children: [
              const Text(
                "Bắt buộc: ",
                style: TextStyle(
                    color: ColorConfig.character,
                    fontSize: 17.0
                ),
              ),
              Checkbox(
                value: subject["batBuoc"],
                onChanged: (value) {},
              )
            ],
          ),
          Text(
            "Loại học phần: " + subject["loaiHocPhan"].join(", "),
            style: const TextStyle(
                color: ColorConfig.character,
                fontSize: 17.0
            ),
          )
        ],
      ),
    );;
  }
}
