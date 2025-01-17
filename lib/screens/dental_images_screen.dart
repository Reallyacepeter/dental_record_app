import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class DentalImagesScreen extends StatefulWidget {
  final Map<String, dynamic> arguments;

  DentalImagesScreen({required this.arguments});

  @override
  _DentalImagesScreenState createState() => _DentalImagesScreenState();
}

class _DentalImagesScreenState extends State<DentalImagesScreen> {
  // 체크박스 상태 변수
  bool paDigital = false;
  bool paNonDigital = false;
  bool bwDigital = false;
  bool bwNonDigital = false;
  bool opgDigital = false;
  bool opgNonDigital = false;
  bool ctDigital = false;
  bool ctNonDigital = false;
  bool otherDigital = false;
  bool otherNonDigital = false;
  bool photographsDigital = false;
  bool photographsNonDigital = false;

  // Other radiographs 입력 컨트롤러
  final TextEditingController otherRadiographsController = TextEditingController();

  // 업로드된 파일 리스트
  List<String> uploadedFiles = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dental Images and Records"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "PA",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  Expanded(
                    child: CheckboxListTile(
                      title: const Text("Digital"),
                      value: paDigital,
                      onChanged: (value) {
                        setState(() {
                          paDigital = value ?? false;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: CheckboxListTile(
                      title: const Text("Non-Digital"),
                      value: paNonDigital,
                      onChanged: (value) {
                        setState(() {
                          paNonDigital = value ?? false;
                        });
                      },
                    ),
                  ),
                ],
              ),
              const Divider(),
              const Text(
                "BW",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  Expanded(
                    child: CheckboxListTile(
                      title: const Text("Digital"),
                      value: bwDigital,
                      onChanged: (value) {
                        setState(() {
                          bwDigital = value ?? false;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: CheckboxListTile(
                      title: const Text("Non-Digital"),
                      value: bwNonDigital,
                      onChanged: (value) {
                        setState(() {
                          bwNonDigital = value ?? false;
                        });
                      },
                    ),
                  ),
                ],
              ),
              const Divider(),
              const Text(
                "OPG",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  Expanded(
                    child: CheckboxListTile(
                      title: const Text("Digital"),
                      value: opgDigital,
                      onChanged: (value) {
                        setState(() {
                          opgDigital = value ?? false;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: CheckboxListTile(
                      title: const Text("Non-Digital"),
                      value: opgNonDigital,
                      onChanged: (value) {
                        setState(() {
                          opgNonDigital = value ?? false;
                        });
                      },
                    ),
                  ),
                ],
              ),
              const Divider(),
              const Text(
                "CT",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  Expanded(
                    child: CheckboxListTile(
                      title: const Text("Digital"),
                      value: ctDigital,
                      onChanged: (value) {
                        setState(() {
                          ctDigital = value ?? false;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: CheckboxListTile(
                      title: const Text("Non-Digital"),
                      value: ctNonDigital,
                      onChanged: (value) {
                        setState(() {
                          ctNonDigital = value ?? false;
                        });
                      },
                    ),
                  ),
                ],
              ),
              const Divider(),
              const Text(
                "Other Radiographs",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextField(
                controller: otherRadiographsController,
                decoration: const InputDecoration(
                  hintText: "Specify other radiographs",
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: CheckboxListTile(
                      title: const Text("Digital"),
                      value: otherDigital,
                      onChanged: (value) {
                        setState(() {
                          otherDigital = value ?? false;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: CheckboxListTile(
                      title: const Text("Non-Digital"),
                      value: otherNonDigital,
                      onChanged: (value) {
                        setState(() {
                          otherNonDigital = value ?? false;
                        });
                      },
                    ),
                  ),
                ],
              ),
              const Divider(),
              const Text(
                "Photographs",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  Expanded(
                    child: CheckboxListTile(
                      title: const Text("Digital"),
                      value: photographsDigital,
                      onChanged: (value) {
                        setState(() {
                          photographsDigital = value ?? false;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: CheckboxListTile(
                      title: const Text("Non-Digital"),
                      value: photographsNonDigital,
                      onChanged: (value) {
                        setState(() {
                          photographsNonDigital = value ?? false;
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: _uploadFile,
                icon: const Icon(Icons.upload_file),
                label: const Text("Upload File(s)"),
              ),
              const SizedBox(height: 16),
              const Text(
                "Uploaded Files:",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              ...uploadedFiles.map((file) => Text(file)).toList(),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("이전"),
                  ),
                  ElevatedButton(
                    onPressed: _goToDentalFindingsScreen,
                    child: const Text("다음"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _goToDentalFindingsScreen() {
    final selectedData = {
      'paDigital': paDigital,
      'paNonDigital': paNonDigital,
      'bwDigital': bwDigital,
      'bwNonDigital': bwNonDigital,
      'opgDigital': opgDigital,
      'opgNonDigital': opgNonDigital,
      'ctDigital': ctDigital,
      'ctNonDigital': ctNonDigital,
      'otherDigital': otherDigital,
      'otherNonDigital': otherNonDigital,
      'photographsDigital': photographsDigital,
      'photographsNonDigital': photographsNonDigital,
      'otherRadiographs': otherRadiographsController.text,
      'uploadedFiles': uploadedFiles,
    };

    Navigator.pushNamed(context, '/supplementaryDetails', arguments: selectedData);
  }

  Future<void> _uploadFile() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
    );
    if (result != null) {
      setState(() {
        uploadedFiles.addAll(result.paths.map((path) => path ?? "Unknown File").toList());
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("파일이 업로드되었습니다.")),
      );
    }
  }
}
