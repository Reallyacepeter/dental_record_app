import 'package:flutter/material.dart';

class DentalDataScreen extends StatefulWidget {
  @override
  _DentalDataScreenState createState() => _DentalDataScreenState();
}

class _DentalDataScreenState extends State<DentalDataScreen> {
  // 데이터 저장 변수
  final Map<int, Map<String, dynamic>> fdiToothData = {}; // FDI 번호별 데이터
  String otherFindings = ""; // 기타 소견
  String dentitionType = ""; // 치열 유형
  int? ageMin; // 최소 나이
  int? ageMax; // 최대 나이
  String qualityCheckSignature = ""; // 품질 확인 서명
  DateTime? qualityCheckDate; // 품질 확인 날짜

  // 635번의 FDI 치아 번호
  final List<int> fdiTeeth = [
    14, 15, 18, 13, 21, 23, 22, 27, 16, 17, 12, 11, 24, 28,
    45, 36, 26, 46, 48, 44, 35, 37, 32, 34, 33, 47, 42, 41, 25, 43, 31, 38
  ];

  // 사용자 입력 UI 생성
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('치과 데이터 입력 (635-650)')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 635번: FDI 번호와 관련 데이터 입력
            Text("635: 특정 데이터 (Specific Data)", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: fdiTeeth.map((tooth) {
                return ElevatedButton(
                  onPressed: () => _showToothDialog(tooth),
                  child: Text("FDI $tooth"),
                );
              }).toList(),
            ),
            SizedBox(height: 16),

            // 640번: 기타 소견
            Text("640: 기타 소견 (Other Findings)", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            TextField(
              maxLines: 3,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "기타 소견을 입력하세요",
              ),
              onChanged: (value) {
                setState(() {
                  otherFindings = value;
                });
              },
            ),
            SizedBox(height: 16),

            // 645번: 치열 유형
            Text("645: 치열 유형 (Type of Dentition)", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            DropdownButton<String>(
              value: dentitionType.isEmpty ? null : dentitionType,
              hint: Text("치열 유형을 선택하세요"),
              items: ["유치", "혼합 치열", "영구 치열"]
                  .map((type) => DropdownMenuItem(
                value: type,
                child: Text(type),
              ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  dentitionType = value!;
                });
              },
            ),
            SizedBox(height: 16),

            // 647번: 나이 추정
            Text("647: 나이 추정 (Age Estimation)", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "최소 나이",
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      setState(() {
                        ageMin = int.tryParse(value);
                      });
                    },
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "최대 나이",
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      setState(() {
                        ageMax = int.tryParse(value);
                      });
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),

            // 650번: 품질 확인
            Text("650: 품질 확인 (Quality Check)", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            TextField(
              decoration: InputDecoration(
                labelText: "서명",
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  qualityCheckSignature = value;
                });
              },
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Text("날짜: "),
                Text(qualityCheckDate == null ? "선택되지 않음" : "${qualityCheckDate!.toLocal()}".split(' ')[0]),
                Spacer(),
                ElevatedButton(
                  onPressed: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime(2100),
                    );
                    if (pickedDate != null) {
                      setState(() {
                        qualityCheckDate = pickedDate;
                      });
                    }
                  },
                  child: Text("날짜 선택"),
                ),
              ],
            ),
            SizedBox(height: 16),

            // 저장 버튼
            ElevatedButton(
              onPressed: () {
                // 데이터를 저장하거나 제출
                _saveData();
              },
              child: Text("저장"),
            ),
          ],
        ),
      ),
    );
  }

  // FDI 치아 데이터 입력 다이얼로그
  void _showToothDialog(int tooth) {
    showDialog(
      context: context,
      builder: (context) {
        String detail = fdiToothData[tooth]?["detail"] ?? "";
        return AlertDialog(
          title: Text("FDI $tooth 데이터 입력"),
          content: TextField(
            maxLines: 3,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "세부 정보를 입력하세요",
            ),
            onChanged: (value) {
              detail = value;
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  fdiToothData[tooth] = {"detail": detail};
                });
                Navigator.pop(context);
              },
              child: Text("저장"),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("취소"),
            ),
          ],
        );
      },
    );
  }

  // 데이터 저장 함수
  void _saveData() {
    // 데이터 저장 로직 구현
    print("FDI 데이터: $fdiToothData");
    print("기타 소견: $otherFindings");
    print("치열 유형: $dentitionType");
    print("최소 나이: $ageMin, 최대 나이: $ageMax");
    print("품질 확인 서명: $qualityCheckSignature");
    print("품질 확인 날짜: $qualityCheckDate");
  }
}
