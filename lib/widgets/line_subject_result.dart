import 'package:flutter/material.dart';

class LineSubjectResult extends StatelessWidget {
  final int stt;
  final subject;
  final onTap;

  const LineSubjectResult(
      {Key? key, required this.stt, required this.onTap, this.subject})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final handleClickComponent = () {
      onTap(subject);
    };

    return InkWell(
      onTap: handleClickComponent,
      child: Container(
        decoration: const BoxDecoration(
            border: Border.symmetric(
                horizontal: BorderSide(color: Colors.black12))),
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        child: Row(
          children: [
            Text(stt.toString()),
            const SizedBox(
              width: 8.0,
            ),
            Expanded(child: Text(subject["tenMonHoc"])),
            const SizedBox(
              width: 8.0,
            ),
            Text(subject["diemTrungBinh"].toString() ?? "")
          ],
        ),
      ),
    );
  }
}
