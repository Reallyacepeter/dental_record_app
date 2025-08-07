// import 'package:flutter/material.dart';
//
// class DentalFindingsScreen extends StatefulWidget {
//   @override
//   _DentalFindingsScreenState createState() => _DentalFindingsScreenState();
// }
//
// class _DentalFindingsScreenState extends State<DentalFindingsScreen> {
//   final Map<int, Map<String, String>> toothData = {}; // 치아별 데이터 저장
//
//   final List<List<int>> teethArrangement = [
//     [18, 17, 16, 15, 14, 13, 12, 11], // 첫 번째 행
//     [21, 22, 23, 24, 25, 26, 27, 28], // 두 번째 행
//     [38, 37, 36, 35, 34, 33, 32, 31], // 세 번째 행
//     [41, 42, 43, 44, 45, 46, 47, 48], // 네 번째 행
//   ];
//
//   final Set<int> selectedTeeth = {}; // 다중 선택된 치아
//   bool isMultiSelectMode = false; // 다중 선택 모드 활성화 여부
//
//   void toggleMultiSelectMode() {
//     setState(() {
//       isMultiSelectMode = false;
//       selectedTeeth.clear(); // 선택된 치아 초기화
//     });
//   }
//
//   void handleToothTap(int toothNumber) {
//     if (isMultiSelectMode) {
//       setState(() {
//         if (selectedTeeth.contains(toothNumber)) {
//           selectedTeeth.remove(toothNumber);
//         } else {
//           selectedTeeth.add(toothNumber);
//         }
//       });
//     } else {
//       showInputDialog(toothNumber); // 단일 치아 선택 대화 상자
//     }
//   }
//
//   void handleToothLongPress(int toothNumber) {
//     if (!isMultiSelectMode) {
//       setState(() {
//         isMultiSelectMode = true; // 다중 선택 모드 활성화
//         selectedTeeth.add(toothNumber); // 첫 번째 치아 선택
//       });
//     }
//   }
//
//   void showMultiSelectionDialog() {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return MultiToothSelectionDialog(
//           selectedTeeth: selectedTeeth.toList(),
//           onSave: (appliedData) {
//             setState(() {
//               for (var tooth in selectedTeeth) {
//                 toothData[tooth] = appliedData; // 모든 선택된 치아에 동일한 데이터 적용
//               }
//               toggleMultiSelectMode(); // 다중 선택 모드 종료
//             });
//           },
//         );
//       },
//     );
//   }
//
//   void showInputDialog(int toothNumber) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return ToothSelectionDialog(
//           toothNumber: toothNumber,
//           initialData: toothData[toothNumber] ?? {},
//           onSave: (selectedData) {
//             setState(() {
//               toothData[toothNumber] = selectedData; // 데이터 업데이트
//             });
//           },
//         );
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('치과 소견 입력')),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             // 치아 배열 렌더링
//             for (var row in teethArrangement)
//               Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 4.0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: row.map((toothNumber) {
//                     final isSelected = selectedTeeth.contains(toothNumber);
//                     final hasData = toothData.containsKey(toothNumber);
//                     return Flexible(
//                       flex: 1,
//                       child: InkWell(
//                         onTap: () => handleToothTap(toothNumber),
//                         onLongPress: () => handleToothLongPress(toothNumber),
//                         child: Container(
//                           margin: const EdgeInsets.all(4.0),
//                           decoration: BoxDecoration(
//                             color: isSelected
//                                 ? Colors.blue[100]
//                                 : (hasData ? Colors.green[100] : Colors.white),
//                             borderRadius: BorderRadius.circular(12.0),
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Colors.grey.withOpacity(0.5),
//                                 spreadRadius: 1,
//                                 blurRadius: 3,
//                                 offset: Offset(0, 2),
//                               ),
//                             ],
//                           ),
//                           child: Center(
//                             child: Text(
//                               '$toothNumber',
//                               style: TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.bold,
//                                 color: isSelected
//                                     ? Colors.blue[700]
//                                     : (hasData ? Colors.green[700] : Colors.black87),
//                               ),
//                             ),
//                           ),
//                           height: 60,
//                           width: 60,
//                         ),
//                       ),
//                     );
//                   }).toList(),
//                 ),
//               ),
//             SizedBox(height: 16),
//             if (isMultiSelectMode)
//               ElevatedButton(
//                 onPressed: () {
//                   if (selectedTeeth.isNotEmpty) {
//                     showMultiSelectionDialog(); // 다중 선택 다이얼로그 표시
//                   } else {
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(content: Text('선택된 치아가 없습니다.')),
//                     );
//                   }
//                 },
//                 child: Text("다중 선택된 치아 설정"),
//               ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 ElevatedButton(
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                   child: Text("이전"),
//                 ),
//                 ElevatedButton(
//                   onPressed: () {
//                     Navigator.pushNamed(context, '/DentalDataScreen', arguments: toothData);
//                   },
//                   child: Text("다음"),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class ToothSelectionDialog extends StatefulWidget {
//   final int toothNumber;
//   final Map<String, String> initialData;
//   final Function(Map<String, String>) onSave;
//
//   ToothSelectionDialog({
//     required this.toothNumber,
//     required this.initialData,
//     required this.onSave,
//   });
//
//   @override
//   _ToothSelectionDialogState createState() => _ToothSelectionDialogState();
// }
//
// class _ToothSelectionDialogState extends State<ToothSelectionDialog> {
//   final Map<String, dynamic> treeData = {
//     'Crown Pathology': ['N/S', 'ABR', 'ATT', 'ERO', 'FLU'],
//     'Crowns': {
//       'UIC': {
//         'MTC': ['AMC', 'GOC', 'MEC', 'SHC', 'STC'],
//         'TCC': ['ACC', 'MCC', 'POC', 'VEC'],
//         'TEC': [], // 하위 항목 없음
//       },
//     },
//     'Fillings': {
//       'CAR': ['ACA', 'CCA'],
//       'JEW': [],
//       'UIF': {
//         'CAV': [],
//         'MCF': ['AMF', 'GOF'],
//         'TCF': ['CEF', 'COF', 'FIS', 'GIF'],
//         'TEF': [],
//       },
//       'UII': {
//         'INL': [],
//         'MTI': ['GOI'],
//         'TCI': ['CEI', 'POI'],
//       },
//     },
//     'Periodontium': ['APP', 'CAL', 'MAP', 'SMO', 'TAT'],
//     'Root': {
//       'Anomaly': ['DEX', 'DIX'],
//       'FRX': [],
//       'IFX': [],
//       'IPX': [],
//       'PPX': [],
//       'RFX': ['APX', 'COX', 'ODX', 'PEX', 'POX', 'REX'],
//     },
//     'Status': {
//       'Invisible': ['IMX', 'NON', 'RRX', 'UNE'],
//       'Visible': {
//         'CFR': [],
//         'ERU': [],
//         'IMV': [],
//         'NAD': ['INT', 'SOU'],
//         'PRE': [],
//         'REV': [],
//         'ROV': [],
//         'TRE': [],
//       },
//       'MIS': {
//         'MAM': ['APL', 'EXT', 'SOX'],
//         'MJA': [],
//         'MPM': [],
//       }
//     },
//     'Tooth Position': ['CRO', 'DIA', 'DIS', 'FVE', 'IPO', 'LVE', 'MAL', 'MIG', 'ROT', 'SPA', 'SPO', 'TIL'],
//   };
//
//   late Map<String, String> selectedData;
//
//   @override
//   void initState() {
//     super.initState();
//     selectedData = Map<String, String>.from(widget.initialData);
//   }
//
//   Widget buildTree(String title, dynamic options) {
//     if (options is List) {
//       return Column(
//         mainAxisSize: MainAxisSize.min,
//         children: options.map<Widget>((option) {
//           return RadioListTile<String>(
//             title: Text(option),
//             value: option,
//             groupValue: selectedData[title],
//             onChanged: (value) {
//               setState(() {
//                 selectedData[title] = value!;
//               });
//             },
//           );
//         }).toList(),
//       );
//     } else if (options is Map) {
//       return Column(
//         children: options.keys.map<Widget>((key) {
//           final value = options[key];
//           if (value is List && value.isEmpty) {
//             return RadioListTile<String>(
//               title: Text(key),
//               value: key,
//               groupValue: selectedData[title],
//               onChanged: (value) {
//                 setState(() {
//                   selectedData[title] = value!;
//                 });
//               },
//             );
//           } else {
//             return ExpansionTile(
//               title: Text(key),
//               children: [buildTree(key, value)],
//             );
//           }
//         }).toList(),
//       );
//     }
//     return SizedBox.shrink();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: Text('Tooth ${widget.toothNumber} 선택'),
//       content: SingleChildScrollView(
//         child: buildTree('', treeData),
//       ),
//       actions: [
//         TextButton(
//           onPressed: () {
//             widget.onSave(selectedData); // 데이터 저장
//             Navigator.pop(context);
//           },
//           child: Text("완료"),
//         ),
//         TextButton(
//           onPressed: () => Navigator.pop(context),
//           child: Text("닫기"),
//         ),
//       ],
//     );
//   }
// }
//
// class MultiToothSelectionDialog extends StatefulWidget {
//   final List<int> selectedTeeth;
//   final Function(Map<String, String>) onSave;
//
//   MultiToothSelectionDialog({
//     required this.selectedTeeth,
//     required this.onSave,
//   });
//
//   @override
//   _MultiToothSelectionDialogState createState() => _MultiToothSelectionDialogState();
// }
//
// class _MultiToothSelectionDialogState extends State<MultiToothSelectionDialog> {
//   final Map<String, dynamic> treeData = {
//     'Bite and Occlusion': ['CBT', 'DBT', 'DIO', 'EBT', 'HBT', 'MEO', 'NOO', 'OBT', 'RBT', 'SBT'],
//     'Bridges': {
//       'ABU': {
//         'UIB': {
//           'extension bridge': [],
//           'MTB': ['GOB', 'MEB'],
//           'TCB': ['ACB', 'ETB', 'MCB', 'POB'],
//           'TEB': [],
//         }
//       },
//       'CAN': [],
//       'PON': {
//         'UIP': {
//           'MTP': ['GOP', 'MEP'],
//           'TCP': ['ACP', 'MCP', 'POP', 'TEP'],
//         }
//       }
//     },
//     'Dentures and Orthodontic appl.': ['CLA', 'EDE', 'FLD', 'FOA', 'FUD', 'HLD', 'HUD', 'PLD', 'PUD', 'ROA', 'SPL'],
//   };
//
//   Map<String, String> tempData = {};
//
//   Widget buildTree(String title, dynamic options) {
//     if (options is List) {
//       // 값이 List일 때, RadioListTile로 처리
//       return Column(
//         mainAxisSize: MainAxisSize.min,
//         children: options.map<Widget>((option) {
//           return RadioListTile<String>(
//             title: Text(option),
//             value: option,
//             groupValue: tempData[title],
//             onChanged: (value) {
//               setState(() {
//                 tempData[title] = value!;
//               });
//             },
//           );
//         }).toList(),
//       );
//     } else if (options is Map) {
//       // 값이 Map일 때, 하위 데이터 유무를 확인
//       return Column(
//         children: options.keys.map<Widget>((key) {
//           final value = options[key];
//           if (value is List && value.isEmpty) {
//             // 하위 데이터가 없으면 RadioListTile로 표시
//             return RadioListTile<String>(
//               title: Text(key),
//               value: key,
//               groupValue: tempData[title],
//               onChanged: (value) {
//                 setState(() {
//                   tempData[title] = value!;
//                 });
//               },
//             );
//           } else if (value is Map && value.isEmpty) {
//             // Map인데 하위 데이터가 없으면 RadioListTile로 표시
//             return RadioListTile<String>(
//               title: Text(key),
//               value: key,
//               groupValue: tempData[title],
//               onChanged: (value) {
//                 setState(() {
//                   tempData[title] = value!;
//                 });
//               },
//             );
//           } else {
//             // 하위 데이터가 있는 경우 ExpansionTile로 표시
//             return ExpansionTile(
//               title: Text(key),
//               children: [buildTree(key, value)],
//             );
//           }
//         }).toList(),
//       );
//     }
//     return SizedBox.shrink(); // 빈 데이터 처리
// }
//
//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: Text('다중 치아 소견 입력'),
//       content: SingleChildScrollView(
//         child: buildTree('', treeData),
//       ),
//       actions: [
//         TextButton(
//           onPressed: () {
//             widget.onSave(tempData); // 데이터를 저장 후 닫기
//             Navigator.pop(context);
//           },
//           child: Text("적용"),
//         ),
//         TextButton(
//           onPressed: () => Navigator.pop(context),
//           child: Text("취소"),
//         ),
//       ],
//     );
//   }
// }
//
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../providers/dental_data_provider.dart';
//
// class DentalFindingsScreen extends StatefulWidget {
//   @override
//   _DentalFindingsScreenState createState() => _DentalFindingsScreenState();
// }
//
// class _DentalFindingsScreenState extends State<DentalFindingsScreen> {
//   // final Map<int, Map<String, String>> toothData = {}; // 치아별 데이터 저장
//   final provider = Provider.of<DentalDataProvider>(context);
//   final Map<int, Map<String, String>> toothData = provider.fdiToothData;
//
//   final List<List<int>> teethArrangement = [
//     [18, 17, 16, 15, 14, 13, 12, 11],
//     [21, 22, 23, 24, 25, 26, 27, 28],
//     [38, 37, 36, 35, 34, 33, 32, 31],
//     [41, 42, 43, 44, 45, 46, 47, 48],
//   ];
//
//   final Set<int> selectedTeeth = {}; // 다중 선택된 치아
//   bool isMultiSelectMode = false; // 다중 선택 모드 활성화 여부
//   bool showInfoBanner = true;
//
//   void toggleMultiSelectMode() {
//     setState(() {
//       isMultiSelectMode = false;
//       selectedTeeth.clear();
//     });
//   }
//
//   void handleToothTap(int toothNumber) {
//     if (isMultiSelectMode) {
//       setState(() {
//         if (selectedTeeth.contains(toothNumber)) {
//           selectedTeeth.remove(toothNumber);
//         } else {
//           selectedTeeth.add(toothNumber);
//         }
//       });
//     } else {
//       showInputDialog(toothNumber);
//     }
//   }
//
//   void handleToothLongPress(int toothNumber) {
//     if (!isMultiSelectMode) {
//       setState(() {
//         isMultiSelectMode = true;
//         selectedTeeth.add(toothNumber);
//       });
//     }
//   }
//
//   void showMultiSelectionDialog() {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return MultiToothSelectionDialog(
//           selectedTeeth: selectedTeeth.toList(),
//           onSave: (appliedData) {
//             setState(() {
//               for (var tooth in selectedTeeth) {
//                 toothData[tooth] = appliedData;
//               }
//               toggleMultiSelectMode();
//             });
//           },
//         );
//       },
//     );
//   }
//
//   void showInputDialog(int toothNumber) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return ToothSelectionDialog(
//           toothNumber: toothNumber,
//           initialData: toothData[toothNumber] ?? {},
//           onSave: (selectedData) {
//             setState(() {
//               toothData[toothNumber] = selectedData;
//             });
//           },
//         );
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('치과 소견 입력'),
//         automaticallyImplyLeading: false,),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             if (showInfoBanner)
//               Container(
//                 width: double.infinity,
//                 padding: const EdgeInsets.all(12),
//                 margin: const EdgeInsets.only(bottom: 8),
//                 decoration: BoxDecoration(
//                   color: Colors.blue[50],
//                   borderRadius: BorderRadius.circular(8),
//                   border: Border.all(color: Colors.blueAccent),
//                 ),
//                 child: Row(
//                   children: [
//                     Icon(Icons.info_outline, color: Colors.blue),
//                     SizedBox(width: 8),
//                     Expanded(
//                       child: Text(
//                         "💡 치아를 길게 누르면 다중 선택이 가능합니다.\n선택 후 '다중 선택된 치아 설정' 버튼을 눌러주세요.",
//                         style: TextStyle(fontSize: 14),
//                       ),
//                     ),
//                     IconButton(
//                       icon: Icon(Icons.close, color: Colors.blue),
//                       onPressed: () {
//                         setState(() {
//                           showInfoBanner = false;
//                         });
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//
//             for (var row in teethArrangement)
//               Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 4.0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: row.map((toothNumber) {
//                     final isSelected = selectedTeeth.contains(toothNumber);
//                     final hasData = toothData.containsKey(toothNumber);
//                     return Flexible(
//                       flex: 1,
//                       child: InkWell(
//                         onTap: () => handleToothTap(toothNumber),
//                         onLongPress: () => handleToothLongPress(toothNumber),
//                         child: Container(
//                           margin: const EdgeInsets.all(4.0),
//                           decoration: BoxDecoration(
//                             color: isSelected
//                                 ? Colors.blue[100]
//                                 : (hasData ? Colors.green[100] : Colors.white),
//                             borderRadius: BorderRadius.circular(12.0),
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Colors.grey.withOpacity(0.5),
//                                 spreadRadius: 1,
//                                 blurRadius: 3,
//                                 offset: Offset(0, 2),
//                               ),
//                             ],
//                           ),
//                           child: Center(
//                             child: Text(
//                               '$toothNumber',
//                               style: TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.bold,
//                                 color: isSelected
//                                     ? Colors.blue[700]
//                                     : (hasData ? Colors.green[700] : Colors.black87),
//                               ),
//                             ),
//                           ),
//                           height: 60,
//                           width: 60,
//                         ),
//                       ),
//                     );
//                   }).toList(),
//                 ),
//               ),
//
//             SizedBox(height: 16),
//
//             if (isMultiSelectMode)
//               ElevatedButton(
//                 onPressed: () {
//                   if (selectedTeeth.isNotEmpty) {
//                     showMultiSelectionDialog();
//                   } else {
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(content: Text('선택된 치아가 없습니다.')),
//                     );
//                   }
//                 },
//                 child: Text("다중 선택된 치아 설정"),
//               ),
//
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 ElevatedButton(
//                   onPressed: () {
//                     Navigator.pushReplacementNamed(context, '/supplementaryDetails');
//                   },
//                   child: Text("이전"),
//                 ),
//                 ElevatedButton(
//                   onPressed: () {
//                     Navigator.pushNamed(context, '/DentalDataScreen', arguments: toothData);
//                   },
//                   child: Text("다음"),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class ToothSelectionDialog extends StatefulWidget {
//   final int toothNumber;
//   final Map<String, String> initialData;
//   final Function(Map<String, String>) onSave;
//
//   ToothSelectionDialog({
//     required this.toothNumber,
//     required this.initialData,
//     required this.onSave,
//   });
//
//   @override
//   _ToothSelectionDialogState createState() => _ToothSelectionDialogState();
// }
//
// class _ToothSelectionDialogState extends State<ToothSelectionDialog> {
//   final Map<String, dynamic> treeData = {
//     'Crown Pathology': ['N/S', 'ABR', 'ATT', 'ERO', 'FLU'],
//     'Crowns': {
//       'UIC': {
//         'MTC': ['AMC', 'GOC', 'MEC', 'SHC', 'STC'],
//         'TCC': ['ACC', 'MCC', 'POC', 'VEC'],
//         'TEC': [], // 하위 항목 없음
//       },
//     },
//     'Fillings': {
//       'CAR': ['ACA', 'CCA'],
//       'JEW': [],
//       'UIF': {
//         'CAV': [],
//         'MCF': ['AMF', 'GOF'],
//         'TCF': ['CEF', 'COF', 'FIS', 'GIF'],
//         'TEF': [],
//       },
//       'UII': {
//         'INL': [],
//         'MTI': ['GOI'],
//         'TCI': ['CEI', 'POI'],
//       },
//     },
//     'Periodontium': ['APP', 'CAL', 'MAP', 'SMO', 'TAT'],
//     'Root': {
//       'Anomaly': ['DEX', 'DIX'],
//       'FRX': [],
//       'IFX': [],
//       'IPX': [],
//       'PPX': [],
//       'RFX': ['APX', 'COX', 'ODX', 'PEX', 'POX', 'REX'],
//     },
//     'Status': {
//       'Invisible': ['IMX', 'NON', 'RRX', 'UNE'],
//       'Visible': {
//         'CFR': [],
//         'ERU': [],
//         'IMV': [],
//         'NAD': ['INT', 'SOU'],
//         'PRE': [],
//         'REV': [],
//         'ROV': [],
//         'TRE': [],
//       },
//       'MIS': {
//         'MAM': ['APL', 'EXT', 'SOX'],
//         'MJA': [],
//         'MPM': [],
//       }
//     },
//     'Tooth Position': ['CRO', 'DIA', 'DIS', 'FVE', 'IPO', 'LVE', 'MAL', 'MIG', 'ROT', 'SPA', 'SPO', 'TIL'],
//   };
//
//   late Map<String, String> selectedData;
//
//   @override
//   void initState() {
//     super.initState();
//     selectedData = Map<String, String>.from(widget.initialData);
//   }
//
//   Widget buildTree(String title, dynamic options) {
//     if (options is List) {
//       return Column(
//         mainAxisSize: MainAxisSize.min,
//         children: options.map<Widget>((option) {
//           return RadioListTile<String>(
//             title: Text(option),
//             value: option,
//             groupValue: selectedData[title],
//             onChanged: (value) {
//               setState(() {
//                 selectedData[title] = value!;
//               });
//             },
//           );
//         }).toList(),
//       );
//     } else if (options is Map) {
//       return Column(
//         children: options.keys.map<Widget>((key) {
//           final value = options[key];
//           if (value is List && value.isEmpty) {
//             return RadioListTile<String>(
//               title: Text(key),
//               value: key,
//               groupValue: selectedData[title],
//               onChanged: (value) {
//                 setState(() {
//                   selectedData[title] = value!;
//                 });
//               },
//             );
//           } else {
//             return ExpansionTile(
//               title: Text(key),
//               children: [buildTree(key, value)],
//             );
//           }
//         }).toList(),
//       );
//     }
//     return SizedBox.shrink();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: Text('Tooth ${widget.toothNumber} 선택'),
//       content: SingleChildScrollView(
//         child: buildTree('', treeData),
//       ),
//       actions: [
//         TextButton(
//           onPressed: () {
//             widget.onSave(selectedData); // 데이터 저장
//             Navigator.pop(context);
//           },
//           child: Text("완료"),
//         ),
//         TextButton(
//           onPressed: () => Navigator.pop(context),
//           child: Text("닫기"),
//         ),
//       ],
//     );
//   }
// }
//
// class MultiToothSelectionDialog extends StatefulWidget {
//   final List<int> selectedTeeth;
//   final Function(Map<String, String>) onSave;
//
//   MultiToothSelectionDialog({
//     required this.selectedTeeth,
//     required this.onSave,
//   });
//
//   @override
//   _MultiToothSelectionDialogState createState() => _MultiToothSelectionDialogState();
// }
//
// class _MultiToothSelectionDialogState extends State<MultiToothSelectionDialog> {
//   final Map<String, dynamic> treeData = {
//     'Bite and Occlusion': ['CBT', 'DBT', 'DIO', 'EBT', 'HBT', 'MEO', 'NOO', 'OBT', 'RBT', 'SBT'],
//     'Bridges': {
//       'ABU': {
//         'UIB': {
//           'extension bridge': [],
//           'MTB': ['GOB', 'MEB'],
//           'TCB': ['ACB', 'ETB', 'MCB', 'POB'],
//           'TEB': [],
//         }
//       },
//       'CAN': [],
//       'PON': {
//         'UIP': {
//           'MTP': ['GOP', 'MEP'],
//           'TCP': ['ACP', 'MCP', 'POP', 'TEP'],
//         }
//       }
//     },
//     'Dentures and Orthodontic appl.': ['CLA', 'EDE', 'FLD', 'FOA', 'FUD', 'HLD', 'HUD', 'PLD', 'PUD', 'ROA', 'SPL'],
//   };
//
//   Map<String, String> tempData = {};
//
//   Widget buildTree(String title, dynamic options) {
//     if (options is List) {
//       // 값이 List일 때, RadioListTile로 처리
//       return Column(
//         mainAxisSize: MainAxisSize.min,
//         children: options.map<Widget>((option) {
//           return RadioListTile<String>(
//             title: Text(option),
//             value: option,
//             groupValue: tempData[title],
//             onChanged: (value) {
//               setState(() {
//                 tempData[title] = value!;
//               });
//             },
//           );
//         }).toList(),
//       );
//     } else if (options is Map) {
//       // 값이 Map일 때, 하위 데이터 유무를 확인
//       return Column(
//         children: options.keys.map<Widget>((key) {
//           final value = options[key];
//           if (value is List && value.isEmpty) {
//             // 하위 데이터가 없으면 RadioListTile로 표시
//             return RadioListTile<String>(
//               title: Text(key),
//               value: key,
//               groupValue: tempData[title],
//               onChanged: (value) {
//                 setState(() {
//                   tempData[title] = value!;
//                 });
//               },
//             );
//           } else if (value is Map && value.isEmpty) {
//             // Map인데 하위 데이터가 없으면 RadioListTile로 표시
//             return RadioListTile<String>(
//               title: Text(key),
//               value: key,
//               groupValue: tempData[title],
//               onChanged: (value) {
//                 setState(() {
//                   tempData[title] = value!;
//                 });
//               },
//             );
//           } else {
//             // 하위 데이터가 있는 경우 ExpansionTile로 표시
//             return ExpansionTile(
//               title: Text(key),
//               children: [buildTree(key, value)],
//             );
//           }
//         }).toList(),
//       );
//     }
//     return SizedBox.shrink(); // 빈 데이터 처리
// }
//
//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: Text('다중 치아 소견 입력'),
//       content: SingleChildScrollView(
//         child: buildTree('', treeData),
//       ),
//       actions: [
//         TextButton(
//           onPressed: () {
//             widget.onSave(tempData); // 데이터를 저장 후 닫기
//             Navigator.pop(context);
//           },
//           child: Text("적용"),
//         ),
//         TextButton(
//           onPressed: () => Navigator.pop(context),
//           child: Text("취소"),
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/dental_data_provider.dart';
import '../widgets/custom_bottom_nav_bar.dart';

class DentalFindingsScreen extends StatefulWidget {
  @override
  _DentalFindingsScreenState createState() => _DentalFindingsScreenState();
}

class _DentalFindingsScreenState extends State<DentalFindingsScreen> {
  final List<List<int>> teethArrangement = [
    [18, 17, 16, 15, 14, 13, 12, 11],
    [21, 22, 23, 24, 25, 26, 27, 28],
    [38, 37, 36, 35, 34, 33, 32, 31],
    [41, 42, 43, 44, 45, 46, 47, 48],
  ];

  final Set<int> selectedTeeth = {}; // 다중 선택된 치아
  bool isMultiSelectMode = false; // 다중 선택 모드 활성화 여부
  bool showInfoBanner = true;

  void toggleMultiSelectMode() {
    setState(() {
      isMultiSelectMode = false;
      selectedTeeth.clear();
    });
  }

  void handleToothTap(int toothNumber, DentalDataProvider provider) {
    if (isMultiSelectMode) {
      setState(() {
        if (selectedTeeth.contains(toothNumber)) {
          selectedTeeth.remove(toothNumber);
        } else {
          selectedTeeth.add(toothNumber);
        }
      });
    } else {
      showInputDialog(toothNumber, provider);
    }
  }

  void handleToothLongPress(int toothNumber) {
    if (!isMultiSelectMode) {
      setState(() {
        isMultiSelectMode = true;
        selectedTeeth.add(toothNumber);
      });
    }
  }

  void showMultiSelectionDialog(DentalDataProvider provider) {
    showDialog(
      context: context,
      builder: (context) {
        return MultiToothSelectionDialog(
          selectedTeeth: selectedTeeth.toList(),
          onSave: (appliedData) {
            for (var tooth in selectedTeeth) {
              provider.setToothDetail(tooth, appliedData.values.join(", "));
            }
            toggleMultiSelectMode();
          },
        );
      },
    );
  }

  void showInputDialog(int toothNumber, DentalDataProvider provider) {
    showDialog(
      context: context,
      builder: (context) {
        return ToothSelectionDialog(
          toothNumber: toothNumber,
          initialData: Map<String, String>.from(provider.fdiToothData[toothNumber] ?? {}),
          onSave: (selectedData) {
            provider.setToothDetail(toothNumber, selectedData.values.join(", "));
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DentalDataProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('치과 소견 입력'), automaticallyImplyLeading: false),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            if (showInfoBanner)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.only(bottom: 8),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.blueAccent),
                ),
                child: Row(
                  children: [
                    Icon(Icons.info_outline, color: Colors.blue),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        "💡 치아를 길게 누르면 다중 선택이 가능합니다.\n선택 후 '다중 선택된 치아 설정' 버튼을 눌러주세요.",
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.close, color: Colors.blue),
                      onPressed: () {
                        setState(() {
                          showInfoBanner = false;
                        });
                      },
                    ),
                  ],
                ),
              ),

            for (var row in teethArrangement)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: row.map((toothNumber) {
                    final isSelected = selectedTeeth.contains(toothNumber);
                    final hasData = provider.fdiToothData.containsKey(toothNumber);
                    return Flexible(
                      flex: 1,
                      child: InkWell(
                        onTap: () => handleToothTap(toothNumber, provider),
                        onLongPress: () => handleToothLongPress(toothNumber),
                        child: Container(
                          margin: const EdgeInsets.all(4.0),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? Colors.blue[100]
                                : (hasData ? Colors.green[100] : Colors.white),
                            borderRadius: BorderRadius.circular(12.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 3,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              '$toothNumber',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: isSelected
                                    ? Colors.blue[700]
                                    : (hasData ? Colors.green[700] : Colors.black87),
                              ),
                            ),
                          ),
                          height: 60,
                          width: 60,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),

            SizedBox(height: 16),

            if (isMultiSelectMode)
              ElevatedButton(
                onPressed: () {
                  if (selectedTeeth.isNotEmpty) {
                    showMultiSelectionDialog(provider);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('선택된 치아가 없습니다.')),
                    );
                  }
                },
                child: Text("다중 선택된 치아 설정"),
              ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/supplementaryDetails');
                  },
                  child: Text("이전"),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/DentalDataScreen');
                  },
                  child: Text("다음"),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(currentIndex: 0),
    );
  }
}

class ToothSelectionDialog extends StatefulWidget {
  final int toothNumber;
  final Map<String, String> initialData;
  final Function(Map<String, String>) onSave;

  ToothSelectionDialog({
    required this.toothNumber,
    required this.initialData,
    required this.onSave,
  });

  @override
  _ToothSelectionDialogState createState() => _ToothSelectionDialogState();
}

class _ToothSelectionDialogState extends State<ToothSelectionDialog> {
  final Map<String, dynamic> treeData = {
    'Crown Pathology': ['N/S', 'ABR', 'ATT', 'ERO', 'FLU'],
    'Crowns': {
      'UIC': {
        'MTC': ['AMC', 'GOC', 'MEC', 'SHC', 'STC'],
        'TCC': ['ACC', 'MCC', 'POC', 'VEC'],
        'TEC': [], // 하위 항목 없음
      },
    },
    'Fillings': {
      'CAR': ['ACA', 'CCA'],
      'JEW': [],
      'UIF': {
        'CAV': [],
        'MCF': ['AMF', 'GOF'],
        'TCF': ['CEF', 'COF', 'FIS', 'GIF'],
        'TEF': [],
      },
      'UII': {
        'INL': [],
        'MTI': ['GOI'],
        'TCI': ['CEI', 'POI'],
      },
    },
    'Periodontium': ['APP', 'CAL', 'MAP', 'SMO', 'TAT'],
    'Root': {
      'Anomaly': ['DEX', 'DIX'],
      'FRX': [],
      'IFX': [],
      'IPX': [],
      'PPX': [],
      'RFX': ['APX', 'COX', 'ODX', 'PEX', 'POX', 'REX'],
    },
    'Status': {
      'Invisible': ['IMX', 'NON', 'RRX', 'UNE'],
      'Visible': {
        'CFR': [],
        'ERU': [],
        'IMV': [],
        'NAD': ['INT', 'SOU'],
        'PRE': [],
        'REV': [],
        'ROV': [],
        'TRE': [],
      },
      'MIS': {
        'MAM': ['APL', 'EXT', 'SOX'],
        'MJA': [],
        'MPM': [],
      }
    },
    'Tooth Position': ['CRO', 'DIA', 'DIS', 'FVE', 'IPO', 'LVE', 'MAL', 'MIG', 'ROT', 'SPA', 'SPO', 'TIL'],
  };

  late Map<String, String> selectedData;

  @override
  void initState() {
    super.initState();
    selectedData = Map<String, String>.from(widget.initialData);
  }

  Widget buildTree(String title, dynamic options) {
    if (options is List) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: options.map<Widget>((option) {
          return RadioListTile<String>(
            title: Text(option),
            value: option,
            groupValue: selectedData[title],
            onChanged: (value) {
              setState(() {
                selectedData[title] = value!;
              });
            },
          );
        }).toList(),
      );
    } else if (options is Map) {
      return Column(
        children: options.keys.map<Widget>((key) {
          final value = options[key];
          if (value is List && value.isEmpty) {
            return RadioListTile<String>(
              title: Text(key),
              value: key,
              groupValue: selectedData[title],
              onChanged: (value) {
                setState(() {
                  selectedData[title] = value!;
                });
              },
            );
          } else {
            return ExpansionTile(
              title: Text(key),
              children: [buildTree(key, value)],
            );
          }
        }).toList(),
      );
    }
    return SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Tooth ${widget.toothNumber} 선택'),
      content: SingleChildScrollView(
        child: buildTree('', treeData),
      ),
      actions: [
        TextButton(
          onPressed: () {
            widget.onSave(selectedData); // 데이터 저장
            Navigator.pop(context);
          },
          child: Text("완료"),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text("닫기"),
        ),
      ],
    );
  }
}

class MultiToothSelectionDialog extends StatefulWidget {
  final List<int> selectedTeeth;
  final Function(Map<String, String>) onSave;

  MultiToothSelectionDialog({
    required this.selectedTeeth,
    required this.onSave,
  });

  @override
  _MultiToothSelectionDialogState createState() => _MultiToothSelectionDialogState();
}

class _MultiToothSelectionDialogState extends State<MultiToothSelectionDialog> {
  final Map<String, dynamic> treeData = {
    'Bite and Occlusion': ['CBT', 'DBT', 'DIO', 'EBT', 'HBT', 'MEO', 'NOO', 'OBT', 'RBT', 'SBT'],
    'Bridges': {
      'ABU': {
        'UIB': {
          'extension bridge': [],
          'MTB': ['GOB', 'MEB'],
          'TCB': ['ACB', 'ETB', 'MCB', 'POB'],
          'TEB': [],
        }
      },
      'CAN': [],
      'PON': {
        'UIP': {
          'MTP': ['GOP', 'MEP'],
          'TCP': ['ACP', 'MCP', 'POP', 'TEP'],
        }
      }
    },
    'Dentures and Orthodontic appl.': ['CLA', 'EDE', 'FLD', 'FOA', 'FUD', 'HLD', 'HUD', 'PLD', 'PUD', 'ROA', 'SPL'],
  };

  Map<String, String> tempData = {};

  Widget buildTree(String title, dynamic options) {
    if (options is List) {
      // 값이 List일 때, RadioListTile로 처리
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: options.map<Widget>((option) {
          return RadioListTile<String>(
            title: Text(option),
            value: option,
            groupValue: tempData[title],
            onChanged: (value) {
              setState(() {
                tempData[title] = value!;
              });
            },
          );
        }).toList(),
      );
    } else if (options is Map) {
      // 값이 Map일 때, 하위 데이터 유무를 확인
      return Column(
        children: options.keys.map<Widget>((key) {
          final value = options[key];
          if (value is List && value.isEmpty) {
            // 하위 데이터가 없으면 RadioListTile로 표시
            return RadioListTile<String>(
              title: Text(key),
              value: key,
              groupValue: tempData[title],
              onChanged: (value) {
                setState(() {
                  tempData[title] = value!;
                });
              },
            );
          } else if (value is Map && value.isEmpty) {
            // Map인데 하위 데이터가 없으면 RadioListTile로 표시
            return RadioListTile<String>(
              title: Text(key),
              value: key,
              groupValue: tempData[title],
              onChanged: (value) {
                setState(() {
                  tempData[title] = value!;
                });
              },
            );
          } else {
            // 하위 데이터가 있는 경우 ExpansionTile로 표시
            return ExpansionTile(
              title: Text(key),
              children: [buildTree(key, value)],
            );
          }
        }).toList(),
      );
    }
    return SizedBox.shrink(); // 빈 데이터 처리
}

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('다중 치아 소견 입력'),
      content: SingleChildScrollView(
        child: buildTree('', treeData),
      ),
      actions: [
        TextButton(
          onPressed: () {
            widget.onSave(tempData); // 데이터를 저장 후 닫기
            Navigator.pop(context);
          },
          child: Text("적용"),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text("취소"),
        ),
      ],
    );
  }
}