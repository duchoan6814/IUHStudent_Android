import 'package:flutter/material.dart';
import 'package:iuh_student/config/color_config.dart';

class LichHocCard extends StatelessWidget {
  final Map lichHoc;

  const LichHocCard({Key? key, required this.lichHoc}) : super(key: key);

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
            lichHoc["lichHoc"],
            style: const TextStyle(
              color: ColorConfig.character,
              fontSize: 17.0,
            ),
          ),Text(
            lichHoc["nhomThucHanh"] ?? "",
            style: const TextStyle(
              color: ColorConfig.character,
              fontSize: 17.0,
            ),
          ),Text(
            lichHoc["phong"],
            style: const TextStyle(
              color: ColorConfig.character,
              fontSize: 17.0,
            ),
          ),Text(
            lichHoc["dayNha"],
            style: const TextStyle(
              color: ColorConfig.character,
              fontSize: 17.0,
            ),
          ),Text(
            lichHoc["giangVien"],
            style: const TextStyle(
              color: ColorConfig.character,
              fontSize: 17.0,
            ),
          ),Text(
            lichHoc["thoiGian"],
            style: const TextStyle(
              color: ColorConfig.character,
              fontSize: 17.0,
            ),
          ),

        ],
      ),
    );
  }
}
