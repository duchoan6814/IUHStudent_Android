import 'package:flutter/material.dart';
import 'package:iuh_student/config/color_config.dart';

class LopHocPhanCard extends StatelessWidget {
  final Map lopHocPhan;

  const LopHocPhanCard({Key? key, required this.lopHocPhan}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: const BoxDecoration(
          color: ColorConfig.orangeBackground,
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            lopHocPhan["tenLopHocPhan"],
            style: const TextStyle(
                color: ColorConfig.character,
                fontWeight: FontWeight.bold,
                fontSize: 17.0),
          ),
          Text(
            lopHocPhan["maLopHocPhan"] +
                " - " +
                lopHocPhan["lopDuKien"],
            style: const TextStyle(
                fontSize: 17.0, color: ColorConfig.character),
          ),
          Text(
            "Sĩ số tối đa: " +
                lopHocPhan["siSoToiDa"].toString(),
            style: const TextStyle(
                fontSize: 17.0, color: ColorConfig.character),
          ),
          Text(
            "Đã đăng ký: " + lopHocPhan["daDangKy"].toString(),
            style: const TextStyle(
                fontSize: 17.0, color: ColorConfig.character),
          ),
          Text(
            "Trạng thái: " + lopHocPhan["trangThai"].toString(),
            style: const TextStyle(
                fontSize: 17.0, color: ColorConfig.character),
          )
        ],
      ),
    );
  }
}
