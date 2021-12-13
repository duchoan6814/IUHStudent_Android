import 'package:flutter/material.dart';

class LineSubjectResult extends StatelessWidget {
  final String stt;
  final String subjectName;
  final String score;

  const LineSubjectResult({Key? key, required this.stt, required this.subjectName, required this.score}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          border:
              Border.symmetric(horizontal: BorderSide(color: Colors.black12))),
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
      child: Row(
        children: [
          Text(stt),
          const SizedBox(
            width: 8.0,
          ),
          Expanded(child: Text(subjectName)),
          const SizedBox(
            width: 8.0,
          ),
          Text(score)
        ],
      ),
    );
  }
}
