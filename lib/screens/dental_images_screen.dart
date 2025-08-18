// import 'package:flutter/material.dart';
// import 'package:file_picker/file_picker.dart';
//
// class DentalImagesScreen extends StatefulWidget {
//   final Map<String, dynamic> arguments;
//
//   DentalImagesScreen({required this.arguments});
//
//   @override
//   _DentalImagesScreenState createState() => _DentalImagesScreenState();
// }
//
// class _DentalImagesScreenState extends State<DentalImagesScreen> {
//   // 체크박스 상태 변수
//   bool paDigital = false;
//   bool paNonDigital = false;
//   bool bwDigital = false;
//   bool bwNonDigital = false;
//   bool opgDigital = false;
//   bool opgNonDigital = false;
//   bool ctDigital = false;
//   bool ctNonDigital = false;
//   bool otherDigital = false;
//   bool otherNonDigital = false;
//   bool photographsDigital = false;
//   bool photographsNonDigital = false;
//
//   // Other radiographs 입력 컨트롤러
//   final TextEditingController otherRadiographsController = TextEditingController();
//
//   // 업로드된 파일 리스트
//   List<String> uploadedFiles = [];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Dental Images and Records"),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Text(
//                 "PA",
//                 style: TextStyle(fontWeight: FontWeight.bold),
//               ),
//               Row(
//                 children: [
//                   Expanded(
//                     child: CheckboxListTile(
//                       title: const Text("Digital"),
//                       value: paDigital,
//                       onChanged: (value) {
//                         setState(() {
//                           paDigital = value ?? false;
//                         });
//                       },
//                     ),
//                   ),
//                   Expanded(
//                     child: CheckboxListTile(
//                       title: const Text("Non-Digital"),
//                       value: paNonDigital,
//                       onChanged: (value) {
//                         setState(() {
//                           paNonDigital = value ?? false;
//                         });
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//               const Divider(),
//               const Text(
//                 "BW",
//                 style: TextStyle(fontWeight: FontWeight.bold),
//               ),
//               Row(
//                 children: [
//                   Expanded(
//                     child: CheckboxListTile(
//                       title: const Text("Digital"),
//                       value: bwDigital,
//                       onChanged: (value) {
//                         setState(() {
//                           bwDigital = value ?? false;
//                         });
//                       },
//                     ),
//                   ),
//                   Expanded(
//                     child: CheckboxListTile(
//                       title: const Text("Non-Digital"),
//                       value: bwNonDigital,
//                       onChanged: (value) {
//                         setState(() {
//                           bwNonDigital = value ?? false;
//                         });
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//               const Divider(),
//               const Text(
//                 "OPG",
//                 style: TextStyle(fontWeight: FontWeight.bold),
//               ),
//               Row(
//                 children: [
//                   Expanded(
//                     child: CheckboxListTile(
//                       title: const Text("Digital"),
//                       value: opgDigital,
//                       onChanged: (value) {
//                         setState(() {
//                           opgDigital = value ?? false;
//                         });
//                       },
//                     ),
//                   ),
//                   Expanded(
//                     child: CheckboxListTile(
//                       title: const Text("Non-Digital"),
//                       value: opgNonDigital,
//                       onChanged: (value) {
//                         setState(() {
//                           opgNonDigital = value ?? false;
//                         });
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//               const Divider(),
//               const Text(
//                 "CT",
//                 style: TextStyle(fontWeight: FontWeight.bold),
//               ),
//               Row(
//                 children: [
//                   Expanded(
//                     child: CheckboxListTile(
//                       title: const Text("Digital"),
//                       value: ctDigital,
//                       onChanged: (value) {
//                         setState(() {
//                           ctDigital = value ?? false;
//                         });
//                       },
//                     ),
//                   ),
//                   Expanded(
//                     child: CheckboxListTile(
//                       title: const Text("Non-Digital"),
//                       value: ctNonDigital,
//                       onChanged: (value) {
//                         setState(() {
//                           ctNonDigital = value ?? false;
//                         });
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//               const Divider(),
//               const Text(
//                 "Other Radiographs",
//                 style: TextStyle(fontWeight: FontWeight.bold),
//               ),
//               TextField(
//                 controller: otherRadiographsController,
//                 decoration: const InputDecoration(
//                   hintText: "Specify other radiographs",
//                 ),
//               ),
//               Row(
//                 children: [
//                   Expanded(
//                     child: CheckboxListTile(
//                       title: const Text("Digital"),
//                       value: otherDigital,
//                       onChanged: (value) {
//                         setState(() {
//                           otherDigital = value ?? false;
//                         });
//                       },
//                     ),
//                   ),
//                   Expanded(
//                     child: CheckboxListTile(
//                       title: const Text("Non-Digital"),
//                       value: otherNonDigital,
//                       onChanged: (value) {
//                         setState(() {
//                           otherNonDigital = value ?? false;
//                         });
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//               const Divider(),
//               const Text(
//                 "Photographs",
//                 style: TextStyle(fontWeight: FontWeight.bold),
//               ),
//               Row(
//                 children: [
//                   Expanded(
//                     child: CheckboxListTile(
//                       title: const Text("Digital"),
//                       value: photographsDigital,
//                       onChanged: (value) {
//                         setState(() {
//                           photographsDigital = value ?? false;
//                         });
//                       },
//                     ),
//                   ),
//                   Expanded(
//                     child: CheckboxListTile(
//                       title: const Text("Non-Digital"),
//                       value: photographsNonDigital,
//                       onChanged: (value) {
//                         setState(() {
//                           photographsNonDigital = value ?? false;
//                         });
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 16),
//               ElevatedButton.icon(
//                 onPressed: _uploadFile,
//                 icon: const Icon(Icons.upload_file),
//                 label: const Text("Upload File(s)"),
//               ),
//               const SizedBox(height: 16),
//               const Text(
//                 "Uploaded Files:",
//                 style: TextStyle(fontWeight: FontWeight.bold),
//               ),
//               ...uploadedFiles.map((file) => Text(file)).toList(),
//               const SizedBox(height: 16),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   ElevatedButton(
//                     onPressed: () {
//                       Navigator.pop(context);
//                     },
//                     child: const Text("이전"),
//                   ),
//                   ElevatedButton(
//                     onPressed: _goToDentalFindingsScreen,
//                     child: const Text("다음"),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   void _goToDentalFindingsScreen() {
//     final selectedData = {
//       'paDigital': paDigital,
//       'paNonDigital': paNonDigital,
//       'bwDigital': bwDigital,
//       'bwNonDigital': bwNonDigital,
//       'opgDigital': opgDigital,
//       'opgNonDigital': opgNonDigital,
//       'ctDigital': ctDigital,
//       'ctNonDigital': ctNonDigital,
//       'otherDigital': otherDigital,
//       'otherNonDigital': otherNonDigital,
//       'photographsDigital': photographsDigital,
//       'photographsNonDigital': photographsNonDigital,
//       'otherRadiographs': otherRadiographsController.text,
//       'uploadedFiles': uploadedFiles,
//     };
//
//     Navigator.pushNamed(context, '/supplementaryDetails', arguments: selectedData);
//   }
//
//   Future<void> _uploadFile() async {
//     final result = await FilePicker.platform.pickFiles(
//       allowMultiple: true,
//     );
//     if (result != null) {
//       setState(() {
//         uploadedFiles.addAll(result.paths.map((path) => path ?? "Unknown File").toList());
//       });
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("파일이 업로드되었습니다.")),
//       );
//     }
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:provider/provider.dart';
// import '../providers/dental_data_provider.dart';
// import '../widgets/custom_bottom_nav_bar.dart';
//
// class DentalImagesScreen extends StatefulWidget {
//   @override
//   _DentalImagesScreenState createState() => _DentalImagesScreenState();
// }
//
// class _DentalImagesScreenState extends State<DentalImagesScreen> {
//   final TextEditingController otherRadiographsController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     final provider = Provider.of<DentalDataProvider>(context);
//
//     otherRadiographsController.text = provider.otherRadiographs;
//
//     return Scaffold(
//       appBar: AppBar(title: const Text("Dental Images and Records"),
//         automaticallyImplyLeading: false,),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(children: [
//           _buildCheckboxGroup("PA", provider.paDigital, provider.paNonDigital,
//                   (v) => provider.setDentalImages(paD: v), (v) => provider.setDentalImages(paND: v)),
//           _buildCheckboxGroup("BW", provider.bwDigital, provider.bwNonDigital,
//                   (v) => provider.setDentalImages(bwD: v), (v) => provider.setDentalImages(bwND: v)),
//           _buildCheckboxGroup("OPG", provider.opgDigital, provider.opgNonDigital,
//                   (v) => provider.setDentalImages(opgD: v), (v) => provider.setDentalImages(opgND: v)),
//           _buildCheckboxGroup("CT", provider.ctDigital, provider.ctNonDigital,
//                   (v) => provider.setDentalImages(ctD: v), (v) => provider.setDentalImages(ctND: v)),
//           const Divider(),
//           const Text("Other Radiographs", style: TextStyle(fontWeight: FontWeight.bold)),
//           TextField(
//             controller: otherRadiographsController,
//             onChanged: (v) => provider.setDentalImages(otherRadio: v),
//             decoration: const InputDecoration(hintText: "Specify other radiographs"),
//           ),
//           _buildCheckboxGroup("Other", provider.otherDigital, provider.otherNonDigital,
//                   (v) => provider.setDentalImages(otherD: v), (v) => provider.setDentalImages(otherND: v)),
//           _buildCheckboxGroup("Photographs", provider.photographsDigital, provider.photographsNonDigital,
//                   (v) => provider.setDentalImages(photoD: v), (v) => provider.setDentalImages(photoND: v)),
//           const SizedBox(height: 16),
//           ElevatedButton.icon(
//             onPressed: _uploadFile,
//             icon: const Icon(Icons.upload_file),
//             label: const Text("Upload File(s)"),
//           ),
//           const SizedBox(height: 16),
//           const Text("Uploaded Files:", style: TextStyle(fontWeight: FontWeight.bold)),
//           ...provider.uploadedFiles.map((file) => Text(file)).toList(),
//           const SizedBox(height: 16),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               ElevatedButton(onPressed: () => Navigator.pushReplacementNamed(context, '/materialsAvailable'), child: const Text("이전")),
//               ElevatedButton(
//                 onPressed: () => Navigator.pushReplacementNamed(context, '/supplementaryDetails'),
//                 child: const Text("다음"),
//               ),
//             ],
//           )
//         ]),
//       ),
//       bottomNavigationBar: CustomBottomNavBar(currentIndex: 0),
//     );
//   }
//
//   Widget _buildCheckboxGroup(String label, bool digital, bool nonDigital,
//       Function(bool?) onDigitalChanged, Function(bool?) onNonDigitalChanged) {
//     return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//       Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
//       Row(children: [
//         Expanded(
//           child: CheckboxListTile(
//             title: const Text("Digital"),
//             value: digital,
//             onChanged: onDigitalChanged,
//           ),
//         ),
//         Expanded(
//           child: CheckboxListTile(
//             title: const Text("Non-Digital"),
//             value: nonDigital,
//             onChanged: onNonDigitalChanged,
//           ),
//         )
//       ]),
//       const Divider(),
//     ]);
//   }
//
//   Future<void> _uploadFile() async {
//     final result = await FilePicker.platform.pickFiles(allowMultiple: true);
//     if (result != null) {
//       final provider = Provider.of<DentalDataProvider>(context, listen: false);
//       final updatedList = [...provider.uploadedFiles, ...result.paths.map((e) => e ?? "Unknown File")];
//       provider.setDentalImages(uploads: updatedList);
//       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("파일이 업로드되었습니다.")));
//     }
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:provider/provider.dart';
// import '../providers/dental_data_provider.dart';
// import '../widgets/custom_bottom_nav_bar.dart';
//
// class DentalImagesScreen extends StatefulWidget {
//   @override
//   _DentalImagesScreenState createState() => _DentalImagesScreenState();
// }
//
// class _DentalImagesScreenState extends State<DentalImagesScreen> {
//   final TextEditingController otherRadiographsController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     final provider = Provider.of<DentalDataProvider>(context);
//
//     otherRadiographsController.text = provider.otherRadiographs;
//
//     return Scaffold(
//       appBar: AppBar(title: const Text("Dental Images and Records"),
//         automaticallyImplyLeading: false,),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(children: [
//           _buildCheckboxGroup("PA", provider.paDigital, provider.paNonDigital,
//                   (v) => provider.setDentalImages(paD: v), (v) => provider.setDentalImages(paND: v)),
//           _buildCheckboxGroup("BW", provider.bwDigital, provider.bwNonDigital,
//                   (v) => provider.setDentalImages(bwD: v), (v) => provider.setDentalImages(bwND: v)),
//           _buildCheckboxGroup("OPG", provider.opgDigital, provider.opgNonDigital,
//                   (v) => provider.setDentalImages(opgD: v), (v) => provider.setDentalImages(opgND: v)),
//           _buildCheckboxGroup("CT", provider.ctDigital, provider.ctNonDigital,
//                   (v) => provider.setDentalImages(ctD: v), (v) => provider.setDentalImages(ctND: v)),
//           const Divider(),
//           const Text("Other Radiographs", style: TextStyle(fontWeight: FontWeight.bold)),
//           TextField(
//             controller: otherRadiographsController,
//             onChanged: (v) => provider.setDentalImages(otherRadio: v),
//             decoration: const InputDecoration(hintText: "Specify other radiographs"),
//           ),
//           _buildCheckboxGroup("Other", provider.otherDigital, provider.otherNonDigital,
//                   (v) => provider.setDentalImages(otherD: v), (v) => provider.setDentalImages(otherND: v)),
//           _buildCheckboxGroup("Photographs", provider.photographsDigital, provider.photographsNonDigital,
//                   (v) => provider.setDentalImages(photoD: v), (v) => provider.setDentalImages(photoND: v)),
//           const SizedBox(height: 16),
//           ElevatedButton.icon(
//             onPressed: _uploadFile,
//             icon: const Icon(Icons.upload_file),
//             label: const Text("Upload File(s)"),
//           ),
//           const SizedBox(height: 16),
//           const Text("Uploaded Files:", style: TextStyle(fontWeight: FontWeight.bold)),
//           ...provider.uploadedFiles.map((file) => Text(file)).toList(),
//           const SizedBox(height: 16),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               ElevatedButton(onPressed: () => Navigator.pushReplacementNamed(context, '/materialsAvailable'), child: const Text("이전")),
//               ElevatedButton(
//                 onPressed: () => Navigator.pushReplacementNamed(context, '/supplementaryDetails'),
//                 child: const Text("다음"),
//               ),
//             ],
//           )
//         ]),
//       ),
//       bottomNavigationBar: CustomBottomNavBar(currentIndex: 0),
//     );
//   }
//
//   Widget _buildCheckboxGroup(String label, bool digital, bool nonDigital,
//       Function(bool?) onDigitalChanged, Function(bool?) onNonDigitalChanged) {
//     return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//       Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
//       Row(children: [
//         Expanded(
//           child: CheckboxListTile(
//             title: const Text("Digital"),
//             value: digital,
//             onChanged: onDigitalChanged,
//           ),
//         ),
//         Expanded(
//           child: CheckboxListTile(
//             title: const Text("Non-Digital"),
//             value: nonDigital,
//             onChanged: onNonDigitalChanged,
//           ),
//         )
//       ]),
//       const Divider(),
//     ]);
//   }
//
//   Future<void> _uploadFile() async {
//     final result = await FilePicker.platform.pickFiles(allowMultiple: true);
//     if (result != null) {
//       final provider = Provider.of<DentalDataProvider>(context, listen: false);
//       final updatedList = [...provider.uploadedFiles, ...result.paths.map((e) => e ?? "Unknown File")];
//       provider.setDentalImages(uploads: updatedList);
//       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("파일이 업로드되었습니다.")));
//     }
//   }
// }

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:provider/provider.dart';
import '../providers/dental_data_provider.dart';
import '../widgets/common_app_bar.dart';
import '../widgets/custom_bottom_nav_bar.dart';
import 'dart:io';
import 'package:path/path.dart' as path;

class DentalImagesScreen extends StatefulWidget {
  @override
  _DentalImagesScreenState createState() => _DentalImagesScreenState();
}

class _DentalImagesScreenState extends State<DentalImagesScreen> {
  final TextEditingController otherRadiographsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DentalDataProvider>(context);

    otherRadiographsController.text = provider.otherRadiographs;

    return Scaffold(
      appBar: const CommonAppBar(
        title: "615 : Dental Images",
        showRecordBadge: true, // ✅ 켬
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: [
          _buildCheckboxGroup("PA", provider.paDigital, provider.paNonDigital,
                  (v) => provider.setDentalImages(paD: v), (v) => provider.setDentalImages(paND: v)),
          _buildCheckboxGroup("BW", provider.bwDigital, provider.bwNonDigital,
                  (v) => provider.setDentalImages(bwD: v), (v) => provider.setDentalImages(bwND: v)),
          _buildCheckboxGroup("OPG", provider.opgDigital, provider.opgNonDigital,
                  (v) => provider.setDentalImages(opgD: v), (v) => provider.setDentalImages(opgND: v)),
          _buildCheckboxGroup("CT", provider.ctDigital, provider.ctNonDigital,
                  (v) => provider.setDentalImages(ctD: v), (v) => provider.setDentalImages(ctND: v)),
          const Divider(),
          const Text("Other Radiographs", style: TextStyle(fontWeight: FontWeight.bold)),
          TextField(
            controller: otherRadiographsController,
            onChanged: (v) => provider.setDentalImages(otherRadio: v),
            decoration: const InputDecoration(hintText: "Specify other radiographs"),
          ),
          _buildCheckboxGroup("Other", provider.otherDigital, provider.otherNonDigital,
                  (v) => provider.setDentalImages(otherD: v), (v) => provider.setDentalImages(otherND: v)),
          _buildCheckboxGroup("Photographs", provider.photographsDigital, provider.photographsNonDigital,
                  (v) => provider.setDentalImages(photoD: v), (v) => provider.setDentalImages(photoND: v)),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: _uploadFile,
            icon: const Icon(Icons.upload_file),
            label: const Text("Upload File(s)"),
          ),
          const SizedBox(height: 16),
          const Text("Uploaded Files:", style: TextStyle(fontWeight: FontWeight.bold)),
          ...provider.uploadedFiles.map((fileUrl) => Text(fileUrl)).toList(),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(onPressed: () => Navigator.pushReplacementNamed(context, '/materialsAvailable'), child: const Text("이전")),
              ElevatedButton(
                onPressed: () => Navigator.pushReplacementNamed(context, '/supplementaryDetails'),
                child: const Text("다음"),
              ),
            ],
          )
        ]),
      ),
      bottomNavigationBar: CustomBottomNavBar(currentIndex: 0),
    );
  }

  Widget _buildCheckboxGroup(String label, bool digital, bool nonDigital,
      Function(bool?) onDigitalChanged, Function(bool?) onNonDigitalChanged) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
      Row(children: [
        Expanded(
          child: CheckboxListTile(
            title: const Text("Digital"),
            value: digital,
            onChanged: onDigitalChanged,
          ),
        ),
        Expanded(
          child: CheckboxListTile(
            title: const Text("Non-Digital"),
            value: nonDigital,
            onChanged: onNonDigitalChanged,
          ),
        )
      ]),
      const Divider(),
    ]);
  }

  Future<void> _uploadFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: true);
    if (result != null) {
      final provider = Provider.of<DentalDataProvider>(context, listen: false);
      final List<String> uploadedUrls = [];

      for (final file in result.files) {
        if (file.path != null) {
          final filePath = file.path!;
          final fileName = path.basename(filePath);

          final storageRef = FirebaseStorage.instance.ref().child('uploads/$fileName');
          final uploadTask = storageRef.putFile(File(filePath));
          final snapshot = await uploadTask.whenComplete(() {});
          final url = await snapshot.ref.getDownloadURL();
          uploadedUrls.add(url);
        }
      }

      final updatedList = [...provider.uploadedFiles, ...uploadedUrls];
      provider.setDentalImages(uploads: updatedList);

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("파일이 업로드되었습니다.")));
    }
  }
}

