import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iuh_student/config/color_config.dart';
import 'package:collection/collection.dart';
import 'package:iuh_student/widgets/line_subject_result.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({Key? key}) : super(key: key);

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  late List<Map> resultData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    resultData = [
      {
        "hoc_ky_id": 123,
        "ten_hoc_ky": "HK1 (2018 - 2019)",
        "isExpand": true,
        "mon_hocs": [
          {
            "ten_mon_hoc": "Nhung nguyen ly co ban cua chu nghia mac-lenin",
            "diem": 5.5
          },
          {
            "ten_mon_hoc": "Nhung nguyen ly co ban cua chu nghia mac-lenin",
            "diem": 5.5
          },
          {
            "ten_mon_hoc": "Nhung nguyen ly co ban cua chu nghia mac-lenin",
            "diem": 5.5
          },
          {
            "ten_mon_hoc": "Nhung nguyen ly co ban cua chu nghia mac-lenin",
            "diem": 5.5
          },
        ]
      },
      {
        "hoc_ky_id": 123,
        "ten_hoc_ky": "HK1 (2018 - 2019)",
        "isExpand": true,
        "mon_hocs": [
          {
            "ten_mon_hoc": "Nhung nguyen ly co ban cua chu nghia mac-lenin",
            "diem": 5.5
          },
          {
            "ten_mon_hoc": "Nhung nguyen ly co ban cua chu nghia mac-lenin",
            "diem": 5.5
          },
          {
            "ten_mon_hoc": "Nhung nguyen ly co ban cua chu nghia mac-lenin",
            "diem": 5.5
          },
          {
            "ten_mon_hoc": "Nhung nguyen ly co ban cua chu nghia mac-lenin",
            "diem": 5.5
          },
        ]
      },
      {
        "hoc_ky_id": 123,
        "ten_hoc_ky": "HK1 (2018 - 2019)",
        "isExpand": true,
        "mon_hocs": [
          {
            "ten_mon_hoc": "Nhung nguyen ly co ban cua chu nghia mac-lenin",
            "diem": 5.5
          },
          {
            "ten_mon_hoc": "Nhung nguyen ly co ban cua chu nghia mac-lenin",
            "diem": 5.5
          },
          {
            "ten_mon_hoc": "Nhung nguyen ly co ban cua chu nghia mac-lenin",
            "diem": 5.5
          },
          {
            "ten_mon_hoc": "Nhung nguyen ly co ban cua chu nghia mac-lenin",
            "diem": 5.5
          },
        ]
      },
      {
        "hoc_ky_id": 123,
        "ten_hoc_ky": "HK1 (2018 - 2019)",
        "isExpand": true,
        "mon_hocs": [
          {
            "ten_mon_hoc": "Nhung nguyen ly co ban cua chu nghia mac-lenin",
            "diem": 5.5
          },
          {
            "ten_mon_hoc": "Nhung nguyen ly co ban cua chu nghia mac-lenin",
            "diem": 5.5
          },
          {
            "ten_mon_hoc": "Nhung nguyen ly co ban cua chu nghia mac-lenin",
            "diem": 5.5
          },
          {
            "ten_mon_hoc": "Nhung nguyen ly co ban cua chu nghia mac-lenin",
            "diem": 5.5
          },
        ]
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    const titleStyle = TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20.0,
        color: ColorConfig.character);

    var handleExpandClickHeader = (index, isExpanded) {
      var _dataResult = resultData;

      _dataResult = [
        ..._dataResult.sublist(0, index),
        {
          ..._dataResult[index],
          "isExpand": !isExpanded,
        },
        ..._dataResult.sublist(index + 1)
      ];

      setState(() {
        resultData = _dataResult;
      });
    };

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              "Kết quả học tập",
              style: titleStyle,
            ),
          ),
          const SizedBox(height: 20.0,),
          ExpansionPanelList(
              children: resultData.map((e) {
                bool _isExpand = e["isExpand"];
                String _termName = e["ten_hoc_ky"];
                List<Map> _listSubject = e["mon_hocs"];

                return ExpansionPanel(
                    isExpanded: _isExpand,
                    headerBuilder: (context, isExpanded) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _termName,
                                style: const TextStyle(
                                    color: ColorConfig.character,
                                    fontSize: 20.0),
                              ),
                            ]),
                      );
                    },
                    body: Column(
                        children: _listSubject.mapIndexed((index, item) {
                          String _stt = (index + 1).toString();
                          String _subjectName = item["ten_mon_hoc"];
                          String _score = item["diem"].toString();

                      return LineSubjectResult(stt: _stt, subjectName: _subjectName, score: _score);
                    }).toList()),
                    canTapOnHeader: true);
              }).toList(),
              expansionCallback: handleExpandClickHeader)
        ],
      ),
    );
  }
}
