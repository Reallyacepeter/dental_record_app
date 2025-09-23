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

// import 'package:flutter/material.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:provider/provider.dart';
// import '../providers/dental_data_provider.dart';
// import '../widgets/common_app_bar.dart';
// import '../widgets/custom_bottom_nav_bar.dart';
// import 'dart:io';
// import 'package:path/path.dart' as path;
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
//       appBar: const CommonAppBar(
//         title: "615 : Dental Images",
//         showRecordBadge: true, // ✅ 켬
//       ),
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
//           ...provider.uploadedFiles.map((fileUrl) => Text(fileUrl)).toList(),
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
//   // Future<void> _uploadFile() async {
//   //   final result = await FilePicker.platform.pickFiles(allowMultiple: true);
//   //   if (result != null) {
//   //     final provider = Provider.of<DentalDataProvider>(context, listen: false);
//   //     final List<String> uploadedUrls = [];
//   //
//   //     for (final file in result.files) {
//   //       if (file.path != null) {
//   //         final filePath = file.path!;
//   //         final fileName = path.basename(filePath);
//   //
//   //         final storageRef = FirebaseStorage.instance.ref().child('uploads/$fileName');
//   //         final uploadTask = storageRef.putFile(File(filePath));
//   //         final snapshot = await uploadTask.whenComplete(() {});
//   //         final url = await snapshot.ref.getDownloadURL();
//   //         uploadedUrls.add(url);
//   //       }
//   //     }
//   //
//   //     final updatedList = [...provider.uploadedFiles, ...uploadedUrls];
//   //     provider.setDentalImages(uploads: updatedList);
//   //
//   //     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("파일이 업로드되었습니다.")));
//   //   }
//   // }
//   Future<void> _uploadFile() async {
//     final result = await FilePicker.platform.pickFiles(allowMultiple: true);
//     if (result != null) {
//       final provider = Provider.of<DentalDataProvider>(context, listen: false);
//       final List<String> uploadedUrls = [];
//
//       // ✅ 업로딩 시작 알림 (SnackBar + Progress)
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Row(
//             children: [
//               CircularProgressIndicator(),
//               SizedBox(width: 16),
//               Text("업로딩 중입니다..."),
//             ],
//           ),
//           duration: Duration(minutes: 1), // 업로드 완료 전에 사라지지 않도록 길게
//         ),
//       );
//
//       for (final file in result.files) {
//         if (file.path != null) {
//           final filePath = file.path!;
//           final fileName = path.basename(filePath);
//
//           final storageRef = FirebaseStorage.instance.ref().child('uploads/$fileName');
//           final uploadTask = storageRef.putFile(File(filePath));
//           final snapshot = await uploadTask.whenComplete(() {});
//           final url = await snapshot.ref.getDownloadURL();
//           uploadedUrls.add(url);
//         }
//       }
//
//       final updatedList = [...provider.uploadedFiles, ...uploadedUrls];
//       provider.setDentalImages(uploads: updatedList);
//
//       // ✅ 업로딩 SnackBar 닫기
//       ScaffoldMessenger.of(context).hideCurrentSnackBar();
//
//       // ✅ 완료 메시지
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("파일이 업로드 되었습니다.")),
//       );
//     }
//   }
// }

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart' as path;

import '../providers/dental_data_provider.dart';
import '../widgets/common_app_bar.dart';
import '../widgets/custom_bottom_nav_bar.dart';

import 'fullscreen_image_viewer.dart';
import 'pdf_viewer_screen.dart';
import 'video_player_screen.dart';
import '../services/file_cache_service.dart';
import '../models/uploaded_file_meta.dart';
import 'package:path/path.dart' as p;

class DentalImagesScreen extends StatefulWidget {
  @override
  State<DentalImagesScreen> createState() => _DentalImagesScreenState();
}

class _DentalImagesScreenState extends State<DentalImagesScreen> {
  final TextEditingController otherRadiographsController = TextEditingController();
  final TextEditingController _searchCtl = TextEditingController();

  // UI 상태
  bool gridMode = true;
  bool multiselect = false;
  final Set<String> selected = <String>{}; // url set
  String? folderFilter; // null = all
  String? tagFilter;    // null = all
  String sortKey = 'time'; // 'time' | 'name'
  bool sortAsc = false;

  // _DentalImagesScreenState 내부에 추가
  Widget _listItemWidget(UploadedFileMeta m) {
    final svc = FileCacheService.I;
    final isSel = selected.contains(m.url);

    return ListTile(
      leading: _thumbBox(m, svc, size: const Size(64, 64)),
      title: Text(m.name, overflow: TextOverflow.ellipsis),
      subtitle: Wrap(
        spacing: 6, runSpacing: 4, children: [
        if (m.folder != null && m.folder!.isNotEmpty)
          Chip(label: Text(m.folder!), visualDensity: VisualDensity.compact),
        ...m.tags.map((t) => Chip(label: Text('#$t'), visualDensity: VisualDensity.compact)),
        if (m.takenAt != null)
          Text('· ${_fmtDate(m.takenAt!)}', style: const TextStyle(color: Colors.black54)),
        if ((m.description ?? '').isNotEmpty)
          Text('· ${m.description}', maxLines: 1, overflow: TextOverflow.ellipsis),
      ],
      ),
      onTap: () => _openInApp(m),
      trailing: Wrap(
        spacing: 4,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          _typeBadge(m.kind),
          IconButton(
            icon: const Icon(Icons.edit_note),
            onPressed: () => _showMetaSheet(m),
          ),
          if (multiselect)
            Checkbox(
              value: isSel,
              onChanged: (_) => setState(() {
                if (!selected.add(m.url)) selected.remove(m.url);
              }),
            )
          else
            IconButton(
              icon: const Icon(Icons.delete_outline),
              onPressed: () => _deleteOne(m.url),
            ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    otherRadiographsController.dispose();
    _searchCtl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final p = context.watch<DentalDataProvider>();
    otherRadiographsController.text = p.otherRadiographs;

    final metas = _filtered(p);
    final folders = _allFolders(p);
    final tags = _allTags(p);

    return Scaffold(
      appBar: const CommonAppBar(
        title: "615 : Dental Images",
        showRecordBadge: true,
      ),
      // Scaffold(...) 안의 body를 아래로 교체
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  _topChecks(p),
                  const Divider(height: 1),
                  _toolbar(metas.length, folders, tags),
                  const Divider(height: 1),
                ],
              ),
            ),
            // grid 모드
            if (gridMode)
              SliverPadding(
                padding: EdgeInsets.fromLTRB(12, 8, 12, 16 + kBottomNavigationBarHeight),
                sliver: SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                        (context, i) {
                      final m = metas[i];
                      return LayoutBuilder(
                        builder: (context, constraints) {
                          final totalWidth = constraints.maxWidth.isFinite
                              ? constraints.maxWidth
                              : MediaQuery.of(context).size.width;
                          const crossAxisCount = 3;
                          const spacing = 8.0;
                          const childAspectRatio = 0.80;

                          final cellWidth = (totalWidth - (crossAxisCount - 1) * spacing) / crossAxisCount;
                          final cellHeight = cellWidth / childAspectRatio;

                          return SizedBox(
                            width: cellWidth,
                            height: cellHeight,
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () => _openInApp(m),
                                child: _thumbBox(m, FileCacheService.I, size: Size(cellWidth, cellHeight)),
                              ),
                            ),
                          );
                        },
                      );
                    },
                    childCount: metas.length,
                  ),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, mainAxisSpacing: 8, crossAxisSpacing: 8, childAspectRatio: .80,
                  ),
                ),
              )
            else // list 모드
              SliverPadding(
                padding: EdgeInsets.fromLTRB(12, 8, 12, 16 + kBottomNavigationBarHeight),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                        (context, i) => _listItemWidget(metas[i]),
                    childCount: metas.length,
                  ),
                ),
              ),
            // optional bottom spacing so FAB/BottomNav와 겹치지 않음
            // slivers 리스트 안 (마지막 부분 근처)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 12 + kBottomNavigationBarHeight),
                child: _navButtons(context),
              ),
            ),
            SliverToBoxAdapter(child: SizedBox(height: 8)),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _uploadFiles,
        icon: const Icon(Icons.upload_file),
        label: const Text('Upload'),
      ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 0),
    );
  }

  // ===== 상단 라디오/텍스트 입력 (원래 폼) =====
  Widget _topChecks(DentalDataProvider p) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _checkRow("PA", p.paDigital, p.paNonDigital,
                  (v) => p.setDentalImages(paD: v), (v) => p.setDentalImages(paND: v)),
          _checkRow("BW", p.bwDigital, p.bwNonDigital,
                  (v) => p.setDentalImages(bwD: v), (v) => p.setDentalImages(bwND: v)),
          _checkRow("OPG", p.opgDigital, p.opgNonDigital,
                  (v) => p.setDentalImages(opgD: v), (v) => p.setDentalImages(opgND: v)),
          _checkRow("CT", p.ctDigital, p.ctNonDigital,
                  (v) => p.setDentalImages(ctD: v), (v) => p.setDentalImages(ctND: v)),
          const SizedBox(height: 4),
          const Align(alignment: Alignment.centerLeft, child: Text("Other Radiographs", style: TextStyle(fontWeight: FontWeight.bold))),
          TextField(
            controller: otherRadiographsController,
            onChanged: (v) => p.setDentalImages(otherRadio: v),
            decoration: const InputDecoration(hintText: "Specify other radiographs"),
          ),
          _checkRow("Other", p.otherDigital, p.otherNonDigital,
                  (v) => p.setDentalImages(otherD: v), (v) => p.setDentalImages(otherND: v)),
          _checkRow("Photographs", p.photographsDigital, p.photographsNonDigital,
                  (v) => p.setDentalImages(photoD: v), (v) => p.setDentalImages(photoND: v)),
        ],
      ),
    );
  }

  Widget _checkRow(
      String label,
      bool digital,
      bool nonDigital,
      Function(bool?) onDigitalChanged,
      Function(bool?) onNonDigitalChanged,
      ) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold))),
            Expanded(
              child: CheckboxListTile(
                dense: true,
                title: const Text("Digital"),
                value: digital,
                onChanged: onDigitalChanged,
              ),
            ),
            Expanded(
              child: CheckboxListTile(
                dense: true,
                title: const Text("Non-Digital"),
                value: nonDigital,
                onChanged: onNonDigitalChanged,
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ===== 툴바(검색/필터/소트/그리드-리스트/멀선/일괄삭제) =====
  Widget _toolbar(int count, List<String> folders, List<String> tags) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          // 검색
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 360),
            child: TextField(
              controller: _searchCtl,
              decoration: InputDecoration(
                isDense: true,
                hintText: '검색(파일명/설명/태그)',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchCtl.text.isEmpty
                    ? null
                    : IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    setState(() => _searchCtl.clear());
                  },
                ),
                border: const OutlineInputBorder(),
              ),
              onChanged: (_) => setState(() {}),
            ),
          ),
          // 폴더 필터
          DropdownButton<String>(
            value: folderFilter,
            hint: const Text('Folder: All'),
            items: [
              const DropdownMenuItem<String>(value: null, child: Text('All Folders')),
              ...folders.map((f) => DropdownMenuItem(value: f, child: Text(f))),
            ],
            onChanged: (v) => setState(() => folderFilter = v),
          ),
          // 태그 필터
          DropdownButton<String>(
            value: tagFilter,
            hint: const Text('Tag: All'),
            items: [
              const DropdownMenuItem<String>(value: null, child: Text('All Tags')),
              ...tags.map((t) => DropdownMenuItem(value: t, child: Text('#$t'))),
            ],
            onChanged: (v) => setState(() => tagFilter = v),
          ),
          // 정렬
          DropdownButton<String>(
            value: sortKey,
            items: const [
              DropdownMenuItem(value: 'time', child: Text('Sort: Time')),
              DropdownMenuItem(value: 'name', child: Text('Sort: Name')),
            ],
            onChanged: (v) => setState(() => sortKey = v ?? 'time'),
          ),
          IconButton(
            tooltip: sortAsc ? 'Ascending' : 'Descending',
            onPressed: () => setState(() => sortAsc = !sortAsc),
            icon: Icon(sortAsc ? Icons.arrow_upward : Icons.arrow_downward),
          ),
          // 보기
          IconButton(
            tooltip: gridMode ? 'Grid' : 'List',
            onPressed: () => setState(() => gridMode = !gridMode),
            icon: Icon(gridMode ? Icons.grid_on : Icons.view_list),
          ),
          const SizedBox(width: 8),
          // 멀티선택/삭제
          FilterChip(
            label: Text(multiselect ? '선택중 ($count)' : '멀티선택'),
            selected: multiselect,
            onSelected: (v) {
              setState(() {
                multiselect = v;
                if (!multiselect) selected.clear();
              });
            },
          ),
          if (multiselect) ...[
            OutlinedButton.icon(
              onPressed: selected.isEmpty ? null : _deleteSelected,
              icon: const Icon(Icons.delete_sweep),
              label: Text('삭제(${selected.length})'),
            ),
            TextButton(
              onPressed: () => setState(() {
                if (selected.length == count) {
                  selected.clear();
                } else {
                  // 전체 선택 (화면에 보이는 것만)
                  final urls = _filtered(context.read<DentalDataProvider>()).map((m) => m.url);
                  selected
                    ..clear()
                    ..addAll(urls);
                }
              }),
              child: Text(selected.length == count ? '전체 해제' : '전체 선택'),
            ),
          ],
        ],
      ),
    );
  }

  // ===== 그리드/리스트 =====
  Widget _grid(List<UploadedFileMeta> metas) {
    final svc = FileCacheService.I;

    return GridView.builder(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, mainAxisSpacing: 8, crossAxisSpacing: 8, childAspectRatio: .80,
      ),
      itemCount: metas.length,
      itemBuilder: (_, i) {
        final m = metas[i];
        final isSel = selected.contains(m.url);

        return InkWell(
          onTap: () => _openInApp(m),
          onLongPress: () {
            setState(() {
              multiselect = true;
              if (!selected.add(m.url)) selected.remove(m.url);
            });
          },
          child: Stack(
            children: [
              _thumbBox(m, svc),
              Positioned(
                left: 6, top: 6,
                child: _typeBadge(m.kind),
              ),
              Positioned(
                right: 6, top: 6,
                child: IconButton(
                  visualDensity: VisualDensity.compact,
                  icon: const Icon(Icons.more_vert),
                  onPressed: () => _showMetaSheet(m),
                ),
              ),
              if (multiselect)
                Positioned(
                  right: 6, bottom: 6,
                  child: Checkbox(
                    value: isSel,
                    onChanged: (_) => setState(() {
                      if (!selected.add(m.url)) selected.remove(m.url);
                    }),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _list(List<UploadedFileMeta> metas) {
    final svc = FileCacheService.I;

    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
      itemCount: metas.length,
      separatorBuilder: (_, __) => const Divider(height: 12),
      itemBuilder: (_, i) {
        final m = metas[i];
        final isSel = selected.contains(m.url);

        return ListTile(
          leading: _thumbBox(m, svc, size: const Size(64, 64)),
          title: Text(m.name, overflow: TextOverflow.ellipsis),
          subtitle: Wrap(
            spacing: 6, runSpacing: 4, children: [
            if (m.folder != null && m.folder!.isNotEmpty)
              Chip(label: Text(m.folder!), visualDensity: VisualDensity.compact),
            ...m.tags.map((t) => Chip(label: Text('#$t'), visualDensity: VisualDensity.compact)),
            if (m.takenAt != null)
              Text('· ${_fmtDate(m.takenAt!)}', style: const TextStyle(color: Colors.black54)),
            if ((m.description ?? '').isNotEmpty)
              Text('· ${m.description}', maxLines: 1, overflow: TextOverflow.ellipsis),
          ],
          ),
          onTap: () => _openInApp(m),
          trailing: Wrap(
            spacing: 4,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              _typeBadge(m.kind),
              IconButton(
                icon: const Icon(Icons.edit_note),
                onPressed: () => _showMetaSheet(m),
              ),
              if (multiselect)
                Checkbox(
                  value: isSel,
                  onChanged: (_) => setState(() {
                    if (!selected.add(m.url)) selected.remove(m.url);
                  }),
                )
              else
                IconButton(
                  icon: const Icon(Icons.delete_outline),
                  onPressed: () => _deleteOne(m.url),
                ),
            ],
          ),
        );
      },
    );
  }

  // 썸네일 + 플레이 아이콘
  Widget _thumbBox(UploadedFileMeta m, FileCacheService svc, {Size size = const Size(200, 200)}) {
    final w = size.width, h = size.height;
    final br = BorderRadius.circular(12);

    if (m.kind == MediaKind.image) {
      return ClipRRect(
        borderRadius: br,
        child: Hero(
          tag: m.url,
          child: Image.network(
            m.url, width: w, height: h, fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(
              width: w, height: h, color: Colors.grey.shade200, child: const Icon(Icons.broken_image),
            ),
          ),
        ),
      );
    }

    if (m.kind == MediaKind.video) {
      return FutureBuilder<String?>(
        future: FileCacheService.I.getVideoThumbnail(m.url),
        builder: (_, snap) {
          final local = snap.data;
          Widget child;
          if (local != null && File(local).existsSync()) {
            child = Image.file(File(local), width: w, height: h, fit: BoxFit.cover);
          } else {
            child = Container(width: w, height: h, color: Colors.black12);
          }
          return ClipRRect(
            borderRadius: br,
            child: Stack(
              children: [
                Positioned.fill(child: child),
                const Positioned.fill(
                  child: Center(child: Icon(Icons.play_circle, size: 42, color: Colors.white70)),
                )
              ],
            ),
          );
        },
      );
    }

    if (m.kind == MediaKind.pdf) {
      return Container(
        width: w, height: h,
        decoration: BoxDecoration(color: Colors.red.shade50, borderRadius: br),
        child: const Center(child: Icon(Icons.picture_as_pdf, size: 48, color: Colors.red)),
      );
    }

    return Container(
      width: w, height: h,
      decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: br),
      child: const Center(child: Icon(Icons.insert_drive_file, size: 40)),
    );
  }

  // 타입 배지
  Widget _typeBadge(MediaKind kind) {
    final (icon, label, color) = switch (kind) {
      MediaKind.image => (Icons.image, 'IMG', Colors.indigo),
      MediaKind.pdf   => (Icons.picture_as_pdf, 'PDF', Colors.red),
      MediaKind.video => (Icons.play_arrow, 'VID', Colors.green),
      MediaKind.other => (Icons.insert_drive_file, 'FILE', Colors.grey),
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color.withOpacity(.1),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: color.withOpacity(.35)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 4),
          Text(label, style: TextStyle(fontSize: 11, color: color, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  // ===== 데이터 정렬/필터/검색 =====
  List<UploadedFileMeta> _filtered(DentalDataProvider p) {
    var metas = p.uploadedFilesMeta.values.toList();

    // 레거시 문자열 리스트와 동기 보정(혹시 남아있다면)
    for (final u in p.uploadedFiles) {
      metas ??= metas;
      if (!p.uploadedFilesMeta.containsKey(u)) {
        metas.add(_metaFromUrl(u));
      }
    }

    final q = _searchCtl.text.trim().toLowerCase();
    if (q.isNotEmpty) {
      metas = metas.where((m) {
        final inName = m.name.toLowerCase().contains(q);
        final inDesc = (m.description ?? '').toLowerCase().contains(q);
        final inTags = m.tags.any((t) => t.toLowerCase().contains(q));
        return inName || inDesc || inTags;
      }).toList();
    }

    if (folderFilter != null) {
      metas = metas.where((m) => (m.folder ?? '') == folderFilter).toList();
    }
    if (tagFilter != null) {
      metas = metas.where((m) => m.tags.contains(tagFilter)).toList();
    }

    metas.sort((a, b) {
      int c;
      if (sortKey == 'name') {
        c = a.name.toLowerCase().compareTo(b.name.toLowerCase());
      } else {
        // time: takenAt 우선, 그 다음 이름
        final ta = a.takenAt ?? DateTime.fromMillisecondsSinceEpoch(0);
        final tb = b.takenAt ?? DateTime.fromMillisecondsSinceEpoch(0);
        c = ta.compareTo(tb);
        if (c == 0) c = a.name.toLowerCase().compareTo(b.name.toLowerCase());
      }
      return sortAsc ? c : -c;
    });

    return metas;
  }

  List<String> _allFolders(DentalDataProvider p) {
    final s = <String>{};
    for (final m in p.uploadedFilesMeta.values) {
      if ((m.folder ?? '').isNotEmpty) s.add(m.folder!);
    }
    return s.toList()..sort();
  }

  List<String> _allTags(DentalDataProvider p) {
    final s = <String>{};
    for (final m in p.uploadedFilesMeta.values) {
      s.addAll(m.tags);
    }
    final l = s.toList()..sort();
    return l;
  }

  // ===== 업로드/삭제/열기 =====
  Future<void> _uploadFiles() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: true);
    if (result == null) return;

    final p = context.read<DentalDataProvider>();
    final urls = <String>[];

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Row(
          children: [
            SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2)),
            SizedBox(width: 16),
            Text("업로딩 중입니다..."),
          ],
        ),
        duration: Duration(minutes: 1),
      ),
    );

    try {
      for (final f in result.files) {
        final pathStr = f.path;
        if (pathStr == null) continue;
        final fileName = path.basename(pathStr);
        final ref = FirebaseStorage.instance.ref().child('uploads/$fileName');
        final snapshot = await ref.putFile(File(pathStr)).whenComplete(() {});
        final url = await snapshot.ref.getDownloadURL();
        urls.add(url);

        // 메타 자동 생성 + 저장
        final meta = _metaFromUrl(url);
        p.setUploadedFileMeta(meta); // 신규 저장
      }
      // 레거시 리스트에도 추가(겸용)
      final updated = [...p.uploadedFiles, ...urls];
      p.setDentalImages(uploads: updated);

      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('파일이 업로드 되었습니다.')));
    } catch (e) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('업로드 실패: $e')));
    }
  }

  UploadedFileMeta _metaFromUrl(String url) {
    final name = _fileName(url);
    final kind = _detectKind(url);
    return UploadedFileMeta(url: url, name: name, kind: kind);
  }

  // 파일명 얻기 (Firebase URL도 안전하게 처리)
  String _fileName(String url) {
    try {
      final uri = Uri.parse(url);
      // pathSegments 중에서 디코딩했을 때 확장자가 있는 마지막 세그먼트 반환
      for (final seg in uri.pathSegments.reversed) {
        final dec = Uri.decodeComponent(seg);
        if (p.extension(dec).isNotEmpty) return dec;
      }
      // 쿼리 파라미터에 name이 있으면 사용
      if (uri.queryParameters.containsKey('name')) {
        return Uri.decodeComponent(uri.queryParameters['name']!);
      }
      return uri.pathSegments.isNotEmpty ? Uri.decodeComponent(uri.pathSegments.last) : url;
    } catch (_) {
      return url;
    }
  }

  MediaKind _detectKind(String url) {
    final name = _fileName(url).toLowerCase();
    final ext = p.extension(name); // includes the dot, e.g. ".jpg"

    if (ext == '.jpg' || ext == '.jpeg' || ext == '.png' || ext == '.gif' || ext == '.webp' || ext == '.heic') {
      return MediaKind.image;
    }
    if (ext == '.pdf') return MediaKind.pdf;
    if (ext == '.mp4' || ext == '.mov' || ext == '.m4v' || ext == '.webm' || ext == '.mkv') {
      return MediaKind.video;
    }

    // 마지막 안전망: URL에 mime-like 토큰이 있으면 확인
    final low = url.toLowerCase();
    if (low.contains('image%2f') || low.contains('image/')) return MediaKind.image;
    if (low.contains('application%2fpdf') || low.contains('application/pdf')) return MediaKind.pdf;
    if (low.contains('video%2f') || low.contains('video/')) return MediaKind.video;

    return MediaKind.other;
  }

  Future<void> _deleteOne(String url) async {
    final p = context.read<DentalDataProvider>();
    try {
      final ref = FirebaseStorage.instance.refFromURL(url);
      await ref.delete();
      p.removeUploadedFile(url);
      p.removeUploadedFileMeta(url);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('삭제 완료')));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('삭제 실패: $e')));
    }
  }

  Future<void> _deleteSelected() async {
    if (selected.isEmpty) return;
    final ok = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('선택 항목 삭제'),
        content: Text('선택된 ${selected.length}개 파일을 삭제할까요?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('취소')),
          FilledButton(onPressed: () => Navigator.pop(context, true), child: const Text('삭제')),
        ],
      ),
    );
    if (ok != true) return;

    final toDel = selected.toList();
    setState(() => selected.clear());

    for (final url in toDel) {
      await _deleteOne(url);
    }
  }

  Future<void> _openInApp(UploadedFileMeta m) async {
    final svc = FileCacheService.I;

    switch (m.kind) {
      case MediaKind.image:
        Navigator.push(context, MaterialPageRoute(builder: (_) => FullscreenImageViewer(url: m.url, title: m.name)));
        return;
      case MediaKind.pdf:
        Navigator.push(context, MaterialPageRoute(builder: (_) => PdfViewerScreen(url: m.url, title: m.name)));
        return;
      case MediaKind.video:
        Navigator.push(context, MaterialPageRoute(builder: (_) => VideoPlayerScreen(url: m.url, title: m.name)));
        return;
      case MediaKind.other:
      // 그냥 시도만…(외부)
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('미지원 형식: 외부 앱으로 시도합니다.')));
        return;
    }
  }

  String _fmtDate(DateTime d) {
    return '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';
  }

  // ===== 메타데이터 편집 바텀시트 =====
  Future<void> _showMetaSheet(UploadedFileMeta meta) async {
    final p = context.read<DentalDataProvider>();

    final nameCtl = TextEditingController(text: meta.name);
    final folderCtl = TextEditingController(text: meta.folder ?? '');
    final descCtl = TextEditingController(text: meta.description ?? '');
    final takenCtl = TextEditingController(text: meta.takenAt != null ? _fmtDate(meta.takenAt!) : '');

    final tags = [...meta.tags];
    MediaKind kind = meta.kind;

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      showDragHandle: true,
      builder: (_) {
        return Padding(
          padding: EdgeInsets.only(
            left: 16, right: 16, top: 12,
            bottom: 16 + MediaQuery.of(context).viewInsets.bottom,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(meta.name, style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 12),
                Wrap(spacing: 8, runSpacing: 8, children: [
                  DropdownButton<MediaKind>(
                    value: kind,
                    items: MediaKind.values
                        .map((k) => DropdownMenuItem(value: k, child: Text(k.name.toUpperCase())))
                        .toList(),
                    onChanged: (v) => setState(() => kind = v ?? meta.kind),
                  ),
                  SizedBox(
                    width: 220,
                    child: TextField(
                      controller: nameCtl,
                      decoration: const InputDecoration(labelText: 'Name', border: OutlineInputBorder()),
                    ),
                  ),
                  SizedBox(
                    width: 220,
                    child: TextField(
                      controller: folderCtl,
                      decoration: const InputDecoration(labelText: 'Folder', border: OutlineInputBorder()),
                    ),
                  ),
                  SizedBox(
                    width: 220,
                    child: TextField(
                      controller: takenCtl,
                      readOnly: true,
                      decoration: const InputDecoration(
                        labelText: 'Taken at (yyyy-mm-dd)',
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(Icons.date_range),
                      ),
                      onTap: () async {
                        final now = DateTime.now();
                        final init = meta.takenAt ?? now;
                        final picked = await showDatePicker(
                          context: context,
                          initialDate: init,
                          firstDate: DateTime(1900),
                          lastDate: DateTime(now.year + 1),
                        );
                        if (picked != null) {
                          takenCtl.text = _fmtDate(picked);
                        }
                      },
                    ),
                  ),
                ]),
                const SizedBox(height: 12),
                TextField(
                  controller: descCtl,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                _TagsEditor(
                  initial: tags,
                  onChanged: (t) => tags
                    ..clear()
                    ..addAll(t),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('취소'),
                    ),
                    const Spacer(),
                    FilledButton.icon(
                      onPressed: () {
                        final upd = UploadedFileMeta(
                          url: meta.url,
                          name: nameCtl.text.trim().isEmpty ? meta.name : nameCtl.text.trim(),
                          kind: kind,
                          folder: folderCtl.text.trim().isEmpty ? null : folderCtl.text.trim(),
                          tags: tags,
                          description: descCtl.text.trim().isEmpty ? null : descCtl.text.trim(),
                          takenAt: takenCtl.text.trim().isEmpty ? null : DateTime.tryParse('${takenCtl.text.trim()} 12:00:00'),
                        );
                        p.setUploadedFileMeta(upd);
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.save),
                      label: const Text('저장'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );

    nameCtl.dispose();
    folderCtl.dispose();
    descCtl.dispose();
    takenCtl.dispose();
  }

  // 하단 네비
  Widget _navButtons(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ElevatedButton(
            onPressed: () => Navigator.pushReplacementNamed(context, '/materialsAvailable'),
            child: const Text("이전"),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pushReplacementNamed(context, '/supplementaryDetails'),
            child: const Text("다음"),
          ),
        ],
      ),
    );
  }
}

// ===== 태그 에디터 위젯 =====
class _TagsEditor extends StatefulWidget {
  final List<String> initial;
  final ValueChanged<List<String>> onChanged;
  const _TagsEditor({required this.initial, required this.onChanged});

  @override
  State<_TagsEditor> createState() => _TagsEditorState();
}

class _TagsEditorState extends State<_TagsEditor> {
  late List<String> tags;
  final _ctl = TextEditingController();

  @override
  void initState() {
    super.initState();
    tags = [...widget.initial];
  }

  @override
  void dispose() {
    _ctl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Tags'),
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: [
            for (final t in tags)
              InputChip(
                label: Text('#$t'),
                onDeleted: () {
                  setState(() {
                    tags.remove(t);
                    widget.onChanged(tags);
                  });
                },
              ),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 220),
              child: TextField(
                controller: _ctl,
                decoration: const InputDecoration(
                  hintText: '태그 입력 후 Enter',
                  border: OutlineInputBorder(),
                  isDense: true,
                ),
                onSubmitted: (v) {
                  final t = v.trim();
                  if (t.isEmpty) return;
                  setState(() {
                    if (!tags.contains(t)) tags.add(t);
                    widget.onChanged(tags);
                    _ctl.clear();
                  });
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
