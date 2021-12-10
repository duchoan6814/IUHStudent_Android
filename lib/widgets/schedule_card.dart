import 'package:flutter/material.dart';
import 'package:iuh_student/config/color_config.dart';

class ScheduleCard extends StatelessWidget {
  final Map scheduleItem;

  const ScheduleCard({Key? key, required this.scheduleItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
          color: ColorConfig.orangeBackground
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(scheduleItem["name"], style: TextStyle(
            color: ColorConfig.orangeCharacter,
            fontSize: 18.0,
            fontWeight: FontWeight.bold
          ),),
          Text(scheduleItem["className"] + " - " + scheduleItem["subjectClassId"]),
          Text("Tiết: " + scheduleItem["startAndEndTime"]),
          Text("Phòng: " + scheduleItem["location"]),
          Text("Giảng viên: " + scheduleItem["teacher"]),
          Text("Ghi chú: " + scheduleItem["note"])
        ],
      ),
    );
  }
}
