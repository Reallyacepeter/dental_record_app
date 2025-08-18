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

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../providers/dental_data_provider.dart';
// import '../widgets/common_app_bar.dart';
// import '../widgets/custom_bottom_nav_bar.dart';
//
// class DentalFindingsScreen extends StatefulWidget {
//   @override
//   _DentalFindingsScreenState createState() => _DentalFindingsScreenState();
// }
//
// class _DentalFindingsScreenState extends State<DentalFindingsScreen> {
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
//   void handleToothTap(int toothNumber, DentalDataProvider provider) {
//     if (isMultiSelectMode) {
//       setState(() {
//         if (selectedTeeth.contains(toothNumber)) {
//           selectedTeeth.remove(toothNumber);
//         } else {
//           selectedTeeth.add(toothNumber);
//         }
//       });
//     } else {
//       showInputDialog(toothNumber, provider);
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
//   void showMultiSelectionDialog(DentalDataProvider provider) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return MultiToothSelectionDialog(
//           selectedTeeth: selectedTeeth.toList(),
//           onSave: (appliedData) {
//             for (var tooth in selectedTeeth) {
//               provider.setToothDetail(tooth, appliedData.values.join(", "));
//             }
//             toggleMultiSelectMode();
//           },
//         );
//       },
//     );
//   }
//
//   void showInputDialog(int toothNumber, DentalDataProvider provider) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return ToothSelectionDialog(
//           toothNumber: toothNumber,
//           initialData: Map<String, String>.from(provider.fdiToothData[toothNumber] ?? {}),
//           onSave: (selectedData) {
//             provider.setToothDetail(toothNumber, selectedData.values.join(", "));
//           },
//         );
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final provider = Provider.of<DentalDataProvider>(context);
//
//     return Scaffold(
//       appBar: const CommonAppBar(
//         title: "630 : Dental Findings - Odontogram",
//         showRecordBadge: true, // ✅ 켬
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
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
//                     final hasData = provider.fdiToothData.containsKey(toothNumber);
//                     return Flexible(
//                       flex: 1,
//                       child: InkWell(
//                         onTap: () => handleToothTap(toothNumber, provider),
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
//                     showMultiSelectionDialog(provider);
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
//                     Navigator.pushReplacementNamed(context, '/DentalDataScreen');
//                   },
//                   child: Text("다음"),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//       bottomNavigationBar: CustomBottomNavBar(currentIndex: 0),
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

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../providers/dental_data_provider.dart';
// import '../widgets/common_app_bar.dart';
// import '../widgets/custom_bottom_nav_bar.dart';
//

//
// class DentalFindingsScreen extends StatefulWidget {
//   @override
//   _DentalFindingsScreenState createState() => _DentalFindingsScreenState();
// }
//
// class _DentalFindingsScreenState extends State<DentalFindingsScreen> {
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
//   void handleToothTap(int toothNumber, DentalDataProvider provider) {
//     if (isMultiSelectMode) {
//       setState(() {
//         if (selectedTeeth.contains(toothNumber)) {
//           selectedTeeth.remove(toothNumber);
//         } else {
//           selectedTeeth.add(toothNumber);
//         }
//       });
//     } else {
//       showInputDialog(toothNumber, provider);
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
//   void showMultiSelectionDialog(DentalDataProvider provider) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return MultiToothSelectionDialog(
//           selectedTeeth: selectedTeeth.toList(),
//           onSave: (appliedData) {
//             for (var tooth in selectedTeeth) {
//               provider.setToothDetail(tooth, appliedData.values.join(", "));
//             }
//             toggleMultiSelectMode();
//           },
//         );
//       },
//     );
//   }
//
//   void showInputDialog(int toothNumber, DentalDataProvider provider) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return ToothSelectionDialog(
//           toothNumber: toothNumber,
//           initialData: Map<String, String>.from(provider.fdiToothData[toothNumber] ?? {}),
//           onSave: (selectedData) {
//             provider.setToothDetail(toothNumber, selectedData.values.join(", "));
//           },
//         );
//       },
//     );
//   }
//
//   // ====== 캔버스 표시에 사용할 "소견 있는 치아" 집합들 ======
//   Set<int> _markedUpperPermanent(DentalDataProvider p) =>
//       p.fdiToothData.keys.where((k) => (k ~/ 10) == 1 || (k ~/ 10) == 2).toSet();
//   Set<int> _markedLowerPermanent(DentalDataProvider p) =>
//       p.fdiToothData.keys.where((k) => (k ~/ 10) == 3 || (k ~/ 10) == 4).toSet();
//   Set<int> _markedUpperPrimary(DentalDataProvider p) =>
//       p.fdiToothData.keys.where((k) => (k ~/ 10) == 5 || (k ~/ 10) == 6).toSet();
//   Set<int> _markedLowerPrimary(DentalDataProvider p) =>
//       p.fdiToothData.keys.where((k) => (k ~/ 10) == 7 || (k ~/ 10) == 8).toSet();
//
//   @override
//   Widget build(BuildContext context) {
//     final provider = Provider.of<DentalDataProvider>(context);
//
//     return Scaffold(
//       appBar: const CommonAppBar(
//         title: "630 : Dental Findings - Odontogram",
//         showRecordBadge: true, // ✅ 켬
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: ListView(
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
//                     const Icon(Icons.info_outline, color: Colors.blue),
//                     const SizedBox(width: 8),
//                     const Expanded(
//                       child: Text(
//                         "💡 치아를 길게 누르면 다중 선택이 가능합니다.\n선택 후 '다중 선택된 치아 설정' 버튼을 눌러주세요.",
//                         style: TextStyle(fontSize: 14),
//                       ),
//                     ),
//                     IconButton(
//                       icon: const Icon(Icons.close, color: Colors.blue),
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
//             // ====== 벡터 확대 선택(캔버스) 카드 4개 ======
//             const Padding(
//               padding: EdgeInsets.fromLTRB(4, 4, 4, 8),
//               child: Text(
//                 "확대 선택 (벡터 캔버스)",
//                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
//               ),
//             ),
//             Card(
//               child: ListTile(
//                 leading: const Icon(Icons.architecture),
//                 title: const Text('상악(영구치) 18–11, 21–28 확대 선택'),
//                 subtitle: const Text('좌/우는 캔버스 상단 메뉴에서 선택'),
//                 trailing: const Icon(Icons.chevron_right),
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (_) => DentalArchCanvas(
//                         arch: ArchType.upper,
//                         dentition: Dentition.permanent,
//                         title: '상악(영구치) 확대',
//                         initiallySelected: selectedTeeth
//                             .where((t) => (t ~/ 10) == 1 || (t ~/ 10) == 2)
//                             .toSet(),
//                         markedTeeth: _markedUpperPermanent(provider),
//                         initialQuadrant: QuadrantFilter.both,
//                         onSelectionChanged: (sel) {
//                           setState(() {
//                             // 상악(영구치) 범위의 선택을 새로 반영
//                             selectedTeeth.removeWhere((t) => (t ~/ 10) == 1 || (t ~/ 10) == 2);
//                             selectedTeeth.addAll(sel);
//                           });
//                         },
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//             Card(
//               child: ListTile(
//                 leading: const Icon(Icons.architecture),
//                 title: const Text('하악(영구치) 48–41, 31–38 확대 선택'),
//                 subtitle: const Text('좌/우는 캔버스 상단 메뉴에서 선택'),
//                 trailing: const Icon(Icons.chevron_right),
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (_) => DentalArchCanvas(
//                         arch: ArchType.lower,
//                         dentition: Dentition.permanent,
//                         title: '하악(영구치) 확대',
//                         initiallySelected: selectedTeeth
//                             .where((t) => (t ~/ 10) == 3 || (t ~/ 10) == 4)
//                             .toSet(),
//                         markedTeeth: _markedLowerPermanent(provider),
//                         initialQuadrant: QuadrantFilter.both,
//                         onSelectionChanged: (sel) {
//                           setState(() {
//                             selectedTeeth.removeWhere((t) => (t ~/ 10) == 3 || (t ~/ 10) == 4);
//                             selectedTeeth.addAll(sel);
//                           });
//                         },
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//             Card(
//               child: ListTile(
//                 leading: const Icon(Icons.child_care),
//                 title: const Text('상악(소아치) 55–51, 61–65 확대 선택'),
//                 subtitle: const Text('좌/우는 캔버스 상단 메뉴에서 선택'),
//                 trailing: const Icon(Icons.chevron_right),
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (_) => DentalArchCanvas(
//                         arch: ArchType.upper,
//                         dentition: Dentition.primary,
//                         title: '상악(소아치) 확대',
//                         initiallySelected: selectedTeeth
//                             .where((t) => (t ~/ 10) == 5 || (t ~/ 10) == 6)
//                             .toSet(),
//                         markedTeeth: _markedUpperPrimary(provider),
//                         initialQuadrant: QuadrantFilter.both,
//                         onSelectionChanged: (sel) {
//                           setState(() {
//                             selectedTeeth.removeWhere((t) => (t ~/ 10) == 5 || (t ~/ 10) == 6);
//                             selectedTeeth.addAll(sel);
//                           });
//                         },
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//             Card(
//               child: ListTile(
//                 leading: const Icon(Icons.child_friendly),
//                 title: const Text('하악(소아치) 85–81, 71–75 확대 선택'),
//                 subtitle: const Text('좌/우는 캔버스 상단 메뉴에서 선택'),
//                 trailing: const Icon(Icons.chevron_right),
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (_) => DentalArchCanvas(
//                         arch: ArchType.lower,
//                         dentition: Dentition.primary,
//                         title: '하악(소아치) 확대',
//                         initiallySelected: selectedTeeth
//                             .where((t) => (t ~/ 10) == 7 || (t ~/ 10) == 8)
//                             .toSet(),
//                         markedTeeth: _markedLowerPrimary(provider),
//                         initialQuadrant: QuadrantFilter.both,
//                         onSelectionChanged: (sel) {
//                           setState(() {
//                             selectedTeeth.removeWhere((t) => (t ~/ 10) == 7 || (t ~/ 10) == 8);
//                             selectedTeeth.addAll(sel);
//                           });
//                         },
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//
//             const SizedBox(height: 12),
//             const Divider(),
//             const Padding(
//               padding: EdgeInsets.fromLTRB(4, 8, 4, 8),
//               child: Text(
//                 "빠른 선택 (그리드)",
//                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
//               ),
//             ),
//
//             // ====== 기존 그리드 ======
//             for (var row in teethArrangement)
//               Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 4.0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: row.map((toothNumber) {
//                     final isSelected = selectedTeeth.contains(toothNumber);
//                     final hasData = provider.fdiToothData.containsKey(toothNumber);
//                     return Flexible(
//                       flex: 1,
//                       child: InkWell(
//                         onTap: () => handleToothTap(toothNumber, provider),
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
//                                 offset: const Offset(0, 2),
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
//             const SizedBox(height: 16),
//
//             if (isMultiSelectMode)
//               ElevatedButton(
//                 onPressed: () {
//                   if (selectedTeeth.isNotEmpty) {
//                     showMultiSelectionDialog(provider);
//                   } else {
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       const SnackBar(content: Text('선택된 치아가 없습니다.')),
//                     );
//                   }
//                 },
//                 child: const Text("다중 선택된 치아 설정"),
//               ),
//
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 ElevatedButton(
//                   onPressed: () {
//                     Navigator.pushReplacementNamed(context, '/supplementaryDetails');
//                   },
//                   child: const Text("이전"),
//                 ),
//                 ElevatedButton(
//                   onPressed: () {
//                     Navigator.pushReplacementNamed(context, '/DentalDataScreen');
//                   },
//                   child: const Text("다음"),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//       bottomNavigationBar: CustomBottomNavBar(currentIndex: 0),
//     );
//   }
// }
//
// // ====== 단일 치아 입력 다이얼로그 ======
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
//         'TEC': [],
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
//     return const SizedBox.shrink();
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
//             widget.onSave(selectedData);
//             Navigator.pop(context);
//           },
//           child: const Text("완료"),
//         ),
//         TextButton(
//           onPressed: () => Navigator.pop(context),
//           child: const Text("닫기"),
//         ),
//       ],
//     );
//   }
// }
//
// // ====== 다중 치아 공통 입력 다이얼로그 ======
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
//       return Column(
//         children: options.keys.map<Widget>((key) {
//           final value = options[key];
//           if (value is List && value.isEmpty) {
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
//             return ExpansionTile(
//               title: Text(key),
//               children: [buildTree(key, value)],
//             );
//           }
//         }).toList(),
//       );
//     }
//     return const SizedBox.shrink();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: const Text('다중 치아 소견 입력'),
//       content: SingleChildScrollView(
//         child: buildTree('', treeData),
//       ),
//       actions: [
//         TextButton(
//           onPressed: () {
//             widget.onSave(tempData);
//             Navigator.pop(context);
//           },
//           child: const Text("적용"),
//         ),
//         TextButton(
//           onPressed: () => Navigator.pop(context),
//           child: const Text("취소"),
//         ),
//       ],
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// import '../providers/dental_data_provider.dart';
// import '../widgets/common_app_bar.dart';
// import '../widgets/custom_bottom_nav_bar.dart';
//

//
// class DentalFindingsScreen extends StatefulWidget {
//   @override
//   _DentalFindingsScreenState createState() => _DentalFindingsScreenState();
// }
//
// class _DentalFindingsScreenState extends State<DentalFindingsScreen> {
//   // 영구치 FDI 표준 배열
//   final List<List<int>> teethArrangement = const [
//     [18, 17, 16, 15, 14, 13, 12, 11],
//     [21, 22, 23, 24, 25, 26, 27, 28],
//     [38, 37, 36, 35, 34, 33, 32, 31],
//     [41, 42, 43, 44, 45, 46, 47, 48],
//   ];
//
//   final Set<int> selectedTeeth = <int>{}; // 화면 내 선택 상태(하이라이트)
//   bool isMultiSelectMode = false;
//   bool showInfoBanner = true;
//
//   // ===== Helpers: 캔버스에 표시할 “소견 있음” 치아 집합 =====
//   Set<int> _markedUpperPermanent(DentalDataProvider p) =>
//       p.fdiToothData.keys.where((k) => (k ~/ 10) == 1 || (k ~/ 10) == 2).toSet();
//   Set<int> _markedLowerPermanent(DentalDataProvider p) =>
//       p.fdiToothData.keys.where((k) => (k ~/ 10) == 3 || (k ~/ 10) == 4).toSet();
//   Set<int> _markedUpperPrimary(DentalDataProvider p) =>
//       p.fdiToothData.keys.where((k) => (k ~/ 10) == 5 || (k ~/ 10) == 6).toSet();
//   Set<int> _markedLowerPrimary(DentalDataProvider p) =>
//       p.fdiToothData.keys.where((k) => (k ~/ 10) == 7 || (k ~/ 10) == 8).toSet();
//
//   // ===== 이벤트 핸들러 =====
//   void _toggleMultiSelectOff() {
//     setState(() {
//       isMultiSelectMode = false;
//       selectedTeeth.clear();
//     });
//   }
//
//   void _onToothTap(int toothNumber, DentalDataProvider provider) {
//     if (isMultiSelectMode) {
//       setState(() {
//         if (selectedTeeth.contains(toothNumber)) {
//           selectedTeeth.remove(toothNumber);
//         } else {
//           selectedTeeth.add(toothNumber);
//         }
//       });
//     } else {
//       _showSingleToothDialog(toothNumber, provider);
//     }
//   }
//
//   void _onToothLongPress(int toothNumber) {
//     if (!isMultiSelectMode) {
//       setState(() {
//         isMultiSelectMode = true;
//         selectedTeeth.add(toothNumber);
//       });
//     }
//   }
//
//   void _showMultiSelectionDialog(DentalDataProvider provider) {
//     showDialog(
//       context: context,
//       builder: (_) => MultiToothSelectionDialog(
//         selectedTeeth: selectedTeeth.toList(),
//         onSave: (appliedData) {
//           for (final t in selectedTeeth) {
//             provider.setToothDetail(t, appliedData.values.join(', '));
//           }
//           _toggleMultiSelectOff();
//         },
//       ),
//     );
//   }
//
//   void _showSingleToothDialog(int toothNumber, DentalDataProvider provider) {
//     showDialog(
//       context: context,
//       builder: (_) => ToothSelectionDialog(
//         toothNumber: toothNumber,
//         initialData: Map<String, String>.from(provider.fdiToothData[toothNumber] ?? {}),
//         onSave: (selectedData) {
//           provider.setToothDetail(toothNumber, selectedData.values.join(', '));
//           setState(() {
//             selectedTeeth
//               ..clear()
//               ..add(toothNumber);
//           });
//         },
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final provider = context.watch<DentalDataProvider>();
//
//     return Scaffold(
//       appBar: const CommonAppBar(
//         title: '630 : Dental Findings - Odontogram',
//         showRecordBadge: true,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8),
//         child: ListView(
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
//                     const Icon(Icons.info_outline, color: Colors.blue),
//                     const SizedBox(width: 8),
//                     const Expanded(
//                       child: Text(
//                         '💡 치아를 길게 누르면 다중 선택이 가능합니다.\n선택 후 “다중 선택된 치아 설정” 버튼으로 공통 소견을 적용하세요.',
//                         style: TextStyle(fontSize: 14),
//                       ),
//                     ),
//                     IconButton(
//                       icon: const Icon(Icons.close, color: Colors.blue),
//                       onPressed: () => setState(() => showInfoBanner = false),
//                     ),
//                   ],
//                 ),
//               ),
//
//             // ===== 벡터 확대(캔버스) 섹션 =====
//             const Padding(
//               padding: EdgeInsets.fromLTRB(4, 4, 4, 8),
//               child: Text('확대 선택 (벡터 캔버스)',
//                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
//             ),
//             _CanvasCard(
//               icon: Icons.architecture,
//               title: '상악(영구치) 18–11, 21–28 확대 선택',
//               subtitle: '좌/우는 캔버스 상단에서 전환',
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (_) => DentalArchCanvas(
//                       arch: ArchType.upper,
//                       dentition: Dentition.permanent,
//                       title: '상악(영구치) 확대',
//                       // 현재 화면 선택 상태 중 상악(영구치)만 초기 선택으로
//                       initiallySelected: selectedTeeth
//                           .where((t) => (t ~/ 10) == 1 || (t ~/ 10) == 2)
//                           .toSet(),
//                       // 소견 있는 치아를 점 표시 등으로 보여줄 때
//                       markedTeeth: _markedUpperPermanent(provider),
//                       initialQuadrant: QuadrantFilter.both,
//                       onSelectionChanged: (sel) {
//                         setState(() {
//                           selectedTeeth.removeWhere((t) => (t ~/ 10) == 1 || (t ~/ 10) == 2);
//                           selectedTeeth.addAll(sel);
//                         });
//                       },
//                     ),
//                   ),
//                 );
//               },
//             ),
//             _CanvasCard(
//               icon: Icons.architecture,
//               title: '하악(영구치) 48–41, 31–38 확대 선택',
//               subtitle: '좌/우는 캔버스 상단에서 전환',
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (_) => DentalArchCanvas(
//                       arch: ArchType.lower,
//                       dentition: Dentition.permanent,
//                       title: '하악(영구치) 확대',
//                       initiallySelected: selectedTeeth
//                           .where((t) => (t ~/ 10) == 3 || (t ~/ 10) == 4)
//                           .toSet(),
//                       markedTeeth: _markedLowerPermanent(provider),
//                       initialQuadrant: QuadrantFilter.both,
//                       onSelectionChanged: (sel) {
//                         setState(() {
//                           selectedTeeth.removeWhere((t) => (t ~/ 10) == 3 || (t ~/ 10) == 4);
//                           selectedTeeth.addAll(sel);
//                         });
//                       },
//                     ),
//                   ),
//                 );
//               },
//             ),
//             _CanvasCard(
//               icon: Icons.child_care,
//               title: '상악(소아치) 55–51, 61–65 확대 선택',
//               subtitle: '좌/우는 캔버스 상단에서 전환',
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (_) => DentalArchCanvas(
//                       arch: ArchType.upper,
//                       dentition: Dentition.primary,
//                       title: '상악(소아치) 확대',
//                       initiallySelected: selectedTeeth
//                           .where((t) => (t ~/ 10) == 5 || (t ~/ 10) == 6)
//                           .toSet(),
//                       markedTeeth: _markedUpperPrimary(provider),
//                       initialQuadrant: QuadrantFilter.both,
//                       onSelectionChanged: (sel) {
//                         setState(() {
//                           selectedTeeth.removeWhere((t) => (t ~/ 10) == 5 || (t ~/ 10) == 6);
//                           selectedTeeth.addAll(sel);
//                         });
//                       },
//                     ),
//                   ),
//                 );
//               },
//             ),
//             _CanvasCard(
//               icon: Icons.child_friendly,
//               title: '하악(소아치) 85–81, 71–75 확대 선택',
//               subtitle: '좌/우는 캔버스 상단에서 전환',
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (_) => DentalArchCanvas(
//                       arch: ArchType.lower,
//                       dentition: Dentition.primary,
//                       title: '하악(소아치) 확대',
//                       initiallySelected: selectedTeeth
//                           .where((t) => (t ~/ 10) == 7 || (t ~/ 10) == 8)
//                           .toSet(),
//                       markedTeeth: _markedLowerPrimary(provider),
//                       initialQuadrant: QuadrantFilter.both,
//                       onSelectionChanged: (sel) {
//                         setState(() {
//                           selectedTeeth.removeWhere((t) => (t ~/ 10) == 7 || (t ~/ 10) == 8);
//                           selectedTeeth.addAll(sel);
//                         });
//                       },
//                     ),
//                   ),
//                 );
//               },
//             ),
//
//             const SizedBox(height: 12),
//             const Divider(),
//             const Padding(
//               padding: EdgeInsets.fromLTRB(4, 8, 4, 8),
//               child: Text('빠른 선택 (그리드)',
//                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
//             ),
//
//             // ===== 숫자 그리드(터치/롱프레스) =====
//             for (final row in teethArrangement)
//               Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 4),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: row.map((toothNumber) {
//                     final isSelected = selectedTeeth.contains(toothNumber);
//                     final hasData = provider.fdiToothData.containsKey(toothNumber);
//                     return Flexible(
//                       child: InkWell(
//                         onTap: () => _onToothTap(toothNumber, provider),
//                         onLongPress: () => _onToothLongPress(toothNumber),
//                         child: Container(
//                           height: 60,
//                           width: 60,
//                           margin: const EdgeInsets.all(4),
//                           decoration: BoxDecoration(
//                             color: isSelected
//                                 ? Colors.blue[100]
//                                 : (hasData ? Colors.green[100] : Colors.white),
//                             borderRadius: BorderRadius.circular(12),
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Colors.black.withOpacity(.08),
//                                 blurRadius: 6,
//                                 offset: const Offset(0, 2),
//                               ),
//                             ],
//                             border: Border.all(
//                               color: isSelected
//                                   ? Colors.blue.shade600
//                                   : (hasData ? Colors.green.shade600 : Colors.grey.shade300),
//                               width: 1.2,
//                             ),
//                           ),
//                           alignment: Alignment.center,
//                           child: Text(
//                             '$toothNumber',
//                             style: TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.bold,
//                               color: isSelected
//                                   ? Colors.blue[800]
//                                   : (hasData ? Colors.green[800] : Colors.black87),
//                             ),
//                           ),
//                         ),
//                       ),
//                     );
//                   }).toList(),
//                 ),
//               ),
//
//             const SizedBox(height: 16),
//
//             if (isMultiSelectMode)
//               ElevatedButton(
//                 onPressed: () {
//                   if (selectedTeeth.isEmpty) {
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       const SnackBar(content: Text('선택된 치아가 없습니다.')),
//                     );
//                     return;
//                   }
//                   _showMultiSelectionDialog(provider);
//                 },
//                 child: const Text('다중 선택된 치아 설정'),
//               ),
//
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 ElevatedButton(
//                   onPressed: () => Navigator.pushReplacementNamed(context, '/supplementaryDetails'),
//                   child: const Text('이전'),
//                 ),
//                 ElevatedButton(
//                   onPressed: () => Navigator.pushReplacementNamed(context, '/DentalDataScreen'),
//                   child: const Text('다음'),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//       bottomNavigationBar: const CustomBottomNavBar(currentIndex: 0),
//     );
//   }
// }
//
// // ===== 단일 치아 입력 다이얼로그 =====
// class ToothSelectionDialog extends StatefulWidget {
//   final int toothNumber;
//   final Map<String, String> initialData;
//   final Function(Map<String, String>) onSave;
//
//   const ToothSelectionDialog({
//     super.key,
//     required this.toothNumber,
//     required this.initialData,
//     required this.onSave,
//   });
//
//   @override
//   State<ToothSelectionDialog> createState() => _ToothSelectionDialogState();
// }
//
// class _ToothSelectionDialogState extends State<ToothSelectionDialog> {
//   final Map<String, dynamic> treeData = const {
//     'Crown Pathology': ['N/S', 'ABR', 'ATT', 'ERO', 'FLU'],
//     'Crowns': {
//       'UIC': {
//         'MTC': ['AMC', 'GOC', 'MEC', 'SHC', 'STC'],
//         'TCC': ['ACC', 'MCC', 'POC', 'VEC'],
//         'TEC': [],
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
//   Widget _buildTree(String title, dynamic options) {
//     if (options is List) {
//       return Column(
//         mainAxisSize: MainAxisSize.min,
//         children: options.map<Widget>((opt) {
//           return RadioListTile<String>(
//             title: Text(opt),
//             value: opt,
//             groupValue: selectedData[title],
//             onChanged: (v) => setState(() => selectedData[title] = v!),
//           );
//         }).toList(),
//       );
//     } else if (options is Map) {
//       return Column(
//         children: options.keys.map<Widget>((key) {
//           final val = options[key];
//           if (val is List && val.isEmpty) {
//             return RadioListTile<String>(
//               title: Text(key),
//               value: key,
//               groupValue: selectedData[title],
//               onChanged: (v) => setState(() => selectedData[title] = v!),
//             );
//           } else {
//             return ExpansionTile(title: Text(key), children: [_buildTree(key, val)]);
//           }
//         }).toList(),
//       );
//     }
//     return const SizedBox.shrink();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: Text('Tooth ${widget.toothNumber} 선택'),
//       content: SingleChildScrollView(child: _buildTree('', treeData)),
//       actions: [
//         TextButton(
//           onPressed: () {
//             widget.onSave(selectedData);
//             Navigator.pop(context);
//           },
//           child: const Text('완료'),
//         ),
//         TextButton(
//           onPressed: () => Navigator.pop(context),
//           child: const Text('닫기'),
//         ),
//       ],
//     );
//   }
// }
//
// // ===== 다중 치아 공통 입력 다이얼로그 =====
// class MultiToothSelectionDialog extends StatefulWidget {
//   final List<int> selectedTeeth;
//   final Function(Map<String, String>) onSave;
//
//   const MultiToothSelectionDialog({
//     super.key,
//     required this.selectedTeeth,
//     required this.onSave,
//   });
//
//   @override
//   State<MultiToothSelectionDialog> createState() => _MultiToothSelectionDialogState();
// }
//
// class _MultiToothSelectionDialogState extends State<MultiToothSelectionDialog> {
//   final Map<String, dynamic> treeData = const {
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
//   final Map<String, String> tempData = <String, String>{};
//
//   Widget _buildTree(String title, dynamic options) {
//     if (options is List) {
//       return Column(
//         mainAxisSize: MainAxisSize.min,
//         children: options.map<Widget>((opt) {
//           return RadioListTile<String>(
//             title: Text(opt),
//             value: opt,
//             groupValue: tempData[title],
//             onChanged: (v) => setState(() => tempData[title] = v!),
//           );
//         }).toList(),
//       );
//     } else if (options is Map) {
//       return Column(
//         children: options.keys.map<Widget>((key) {
//           final val = options[key];
//           if (val is List && val.isEmpty) {
//             return RadioListTile<String>(
//               title: Text(key),
//               value: key,
//               groupValue: tempData[title],
//               onChanged: (v) => setState(() => tempData[title] = v!),
//             );
//           } else {
//             return ExpansionTile(title: Text(key), children: [_buildTree(key, val)]);
//           }
//         }).toList(),
//       );
//     }
//     return const SizedBox.shrink();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: const Text('다중 치아 소견 입력'),
//       content: SingleChildScrollView(child: _buildTree('', treeData)),
//       actions: [
//         TextButton(
//           onPressed: () {
//             widget.onSave(tempData);
//             Navigator.pop(context);
//           },
//           child: const Text('적용'),
//         ),
//         TextButton(
//           onPressed: () => Navigator.pop(context),
//           child: const Text('취소'),
//         ),
//       ],
//     );
//   }
// }
//
// // ===== 작은 재사용 카드 위젯 =====
// class _CanvasCard extends StatelessWidget {
//   final IconData icon;
//   final String title;
//   final String subtitle;
//   final VoidCallback onTap;
//
//   const _CanvasCard({
//     required this.icon,
//     required this.title,
//     required this.subtitle,
//     required this.onTap,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       child: ListTile(
//         leading: Icon(icon),
//         title: Text(title),
//         subtitle: Text(subtitle),
//         trailing: const Icon(Icons.chevron_right),
//         onTap: onTap,
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// import '../providers/dental_data_provider.dart';
// import '../widgets/common_app_bar.dart';
// import '../widgets/custom_bottom_nav_bar.dart';
//
// class DentalFindingsScreen extends StatefulWidget {
//   @override
//   _DentalFindingsScreenState createState() => _DentalFindingsScreenState();
// }
//
// class _DentalFindingsScreenState extends State<DentalFindingsScreen> {
//   // 영구치 FDI 배열
//   final List<List<int>> teethArrangement = const [
//     [18, 17, 16, 15, 14, 13, 12, 11],
//     [21, 22, 23, 24, 25, 26, 27, 28],
//     [38, 37, 36, 35, 34, 33, 32, 31],
//     [41, 42, 43, 44, 45, 46, 47, 48],
//   ];
//
//   final Set<int> selectedTeeth = <int>{};
//   bool isMultiSelectMode = false;
//   bool showInfoBanner = true;
//
//   void _toggleMultiSelectOff() {
//     setState(() {
//       isMultiSelectMode = false;
//       selectedTeeth.clear();
//     });
//   }
//
//   void _onToothTap(int toothNumber, DentalDataProvider provider) {
//     if (isMultiSelectMode) {
//       setState(() {
//         if (selectedTeeth.contains(toothNumber)) {
//           selectedTeeth.remove(toothNumber);
//         } else {
//           selectedTeeth.add(toothNumber);
//         }
//       });
//     } else {
//       _showSingleToothDialog(toothNumber, provider);
//     }
//   }
//
//   void _onToothLongPress(int toothNumber) {
//     if (!isMultiSelectMode) {
//       setState(() {
//         isMultiSelectMode = true;
//         selectedTeeth.add(toothNumber);
//       });
//     }
//   }
//
//   void _showSingleToothDialog(int toothNumber, DentalDataProvider provider) {
//     showDialog(
//       context: context,
//       builder: (_) => ToothSelectionDialog(
//         toothNumber: toothNumber,
//         initialData: Map<String, String>.from(provider.fdiToothData[toothNumber] ?? {}),
//         onSave: (selectedData) {
//           provider.setToothDetail(toothNumber, selectedData.values.join(', '));
//           setState(() {
//             selectedTeeth
//               ..clear()
//               ..add(toothNumber);
//           });
//         },
//       ),
//     );
//   }
//
//   void _showMultiSelectionDialog(DentalDataProvider provider) {
//     showDialog(
//       context: context,
//       builder: (_) => MultiToothSelectionDialog(
//         selectedTeeth: selectedTeeth.toList(),
//         onSave: (appliedData) {
//           for (final t in selectedTeeth) {
//             provider.setToothDetail(t, appliedData.values.join(', '));
//           }
//           _toggleMultiSelectOff();
//         },
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final provider = context.watch<DentalDataProvider>();
//
//     return Scaffold(
//       appBar: const CommonAppBar(
//         title: '630 : Dental Findings - Odontogram',
//         showRecordBadge: true,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8),
//         child: ListView(
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
//                     const Icon(Icons.info_outline, color: Colors.blue),
//                     const SizedBox(width: 8),
//                     const Expanded(
//                       child: Text(
//                         '💡 치아를 길게 누르면 다중 선택이 가능합니다.\n선택 후 “다중 선택된 치아 설정” 버튼으로 공통 소견을 적용하세요.',
//                         style: TextStyle(fontSize: 14),
//                       ),
//                     ),
//                     IconButton(
//                       icon: const Icon(Icons.close, color: Colors.blue),
//                       onPressed: () => setState(() => showInfoBanner = false),
//                     ),
//                   ],
//                 ),
//               ),
//
//             // ===== 숫자 그리드만 남김 =====
//             for (final row in teethArrangement)
//               Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 4),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: row.map((toothNumber) {
//                     final isSelected = selectedTeeth.contains(toothNumber);
//                     final hasData = provider.fdiToothData.containsKey(toothNumber);
//                     return Flexible(
//                       child: InkWell(
//                         onTap: () => _onToothTap(toothNumber, provider),
//                         onLongPress: () => _onToothLongPress(toothNumber),
//                         child: Container(
//                           height: 60,
//                           width: 60,
//                           margin: const EdgeInsets.all(4),
//                           decoration: BoxDecoration(
//                             color: isSelected
//                                 ? Colors.blue[100]
//                                 : (hasData ? Colors.green[100] : Colors.white),
//                             borderRadius: BorderRadius.circular(12),
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Colors.black.withOpacity(.08),
//                                 blurRadius: 6,
//                                 offset: const Offset(0, 2),
//                               ),
//                             ],
//                             border: Border.all(
//                               color: isSelected
//                                   ? Colors.blue.shade600
//                                   : (hasData ? Colors.green.shade600 : Colors.grey.shade300),
//                               width: 1.2,
//                             ),
//                           ),
//                           alignment: Alignment.center,
//                           child: Text(
//                             '$toothNumber',
//                             style: TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.bold,
//                               color: isSelected
//                                   ? Colors.blue[800]
//                                   : (hasData ? Colors.green[800] : Colors.black87),
//                             ),
//                           ),
//                         ),
//                       ),
//                     );
//                   }).toList(),
//                 ),
//               ),
//
//             const SizedBox(height: 16),
//
//             if (isMultiSelectMode)
//               ElevatedButton(
//                 onPressed: () {
//                   if (selectedTeeth.isEmpty) {
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       const SnackBar(content: Text('선택된 치아가 없습니다.')),
//                     );
//                     return;
//                   }
//                   _showMultiSelectionDialog(provider);
//                 },
//                 child: const Text('다중 선택된 치아 설정'),
//               ),
//
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 ElevatedButton(
//                   onPressed: () => Navigator.pushReplacementNamed(context, '/supplementaryDetails'),
//                   child: const Text('이전'),
//                 ),
//                 ElevatedButton(
//                   onPressed: () => Navigator.pushReplacementNamed(context, '/DentalDataScreen'),
//                   child: const Text('다음'),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//       bottomNavigationBar: const CustomBottomNavBar(currentIndex: 0),
//     );
//   }
// }
//
// // ===== 단일 치아 입력 다이얼로그 =====
// class ToothSelectionDialog extends StatefulWidget {
//   final int toothNumber;
//   final Map<String, String> initialData;
//   final Function(Map<String, String>) onSave;
//
//   const ToothSelectionDialog({
//     super.key,
//     required this.toothNumber,
//     required this.initialData,
//     required this.onSave,
//   });
//
//   @override
//   State<ToothSelectionDialog> createState() => _ToothSelectionDialogState();
// }
//
// class _ToothSelectionDialogState extends State<ToothSelectionDialog> {
//   final Map<String, dynamic> treeData = const {
//     'Crown Pathology': ['N/S', 'ABR', 'ATT', 'ERO', 'FLU'],
//     'Crowns': {
//       'UIC': {
//         'MTC': ['AMC', 'GOC', 'MEC', 'SHC', 'STC'],
//         'TCC': ['ACC', 'MCC', 'POC', 'VEC'],
//         'TEC': [],
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
//   Widget _buildTree(String title, dynamic options) {
//     if (options is List) {
//       return Column(
//         mainAxisSize: MainAxisSize.min,
//         children: options.map<Widget>((opt) {
//           return RadioListTile<String>(
//             title: Text(opt),
//             value: opt,
//             groupValue: selectedData[title],
//             onChanged: (v) => setState(() => selectedData[title] = v!),
//           );
//         }).toList(),
//       );
//     } else if (options is Map) {
//       return Column(
//         children: options.keys.map<Widget>((key) {
//           final val = options[key];
//           if (val is List && val.isEmpty) {
//             return RadioListTile<String>(
//               title: Text(key),
//               value: key,
//               groupValue: selectedData[title],
//               onChanged: (v) => setState(() => selectedData[title] = v!),
//             );
//           } else {
//             return ExpansionTile(title: Text(key), children: [_buildTree(key, val)]);
//           }
//         }).toList(),
//       );
//     }
//     return const SizedBox.shrink();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: Text('Tooth ${widget.toothNumber} 선택'),
//       content: SingleChildScrollView(child: _buildTree('', treeData)),
//       actions: [
//         TextButton(
//           onPressed: () {
//             widget.onSave(selectedData);
//             Navigator.pop(context);
//           },
//           child: const Text('완료'),
//         ),
//         TextButton(
//           onPressed: () => Navigator.pop(context),
//           child: const Text('닫기'),
//         ),
//       ],
//     );
//   }
// }
//
// // ===== 다중 치아 공통 입력 다이얼로그 =====
// class MultiToothSelectionDialog extends StatefulWidget {
//   final List<int> selectedTeeth;
//   final Function(Map<String, String>) onSave;
//
//   const MultiToothSelectionDialog({
//     super.key,
//     required this.selectedTeeth,
//     required this.onSave,
//   });
//
//   @override
//   State<MultiToothSelectionDialog> createState() => _MultiToothSelectionDialogState();
// }
//
// class _MultiToothSelectionDialogState extends State<MultiToothSelectionDialog> {
//   final Map<String, dynamic> treeData = const {
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
//   final Map<String, String> tempData = <String, String>{};
//
//   Widget _buildTree(String title, dynamic options) {
//     if (options is List) {
//       return Column(
//         mainAxisSize: MainAxisSize.min,
//         children: options.map<Widget>((opt) {
//           return RadioListTile<String>(
//             title: Text(opt),
//             value: opt,
//             groupValue: tempData[title],
//             onChanged: (v) => setState(() => tempData[title] = v!),
//           );
//         }).toList(),
//       );
//     } else if (options is Map) {
//       return Column(
//         children: options.keys.map<Widget>((key) {
//           final val = options[key];
//           if (val is List && val.isEmpty) {
//             return RadioListTile<String>(
//               title: Text(key),
//               value: key,
//               groupValue: tempData[title],
//               onChanged: (v) => setState(() => tempData[title] = v!),
//             );
//           } else {
//             return ExpansionTile(title: Text(key), children: [_buildTree(key, val)]);
//           }
//         }).toList(),
//       );
//     }
//     return const SizedBox.shrink();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: const Text('다중 치아 소견 입력'),
//       content: SingleChildScrollView(child: _buildTree('', treeData)),
//       actions: [
//         TextButton(
//           onPressed: () {
//             widget.onSave(tempData);
//             Navigator.pop(context);
//           },
//           child: const Text('적용'),
//         ),
//         TextButton(
//           onPressed: () => Navigator.pop(context),
//           child: const Text('취소'),
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/dental_data_provider.dart';
import '../widgets/common_app_bar.dart';
import '../widgets/custom_bottom_nav_bar.dart';
import 'quadrant_zoom_screen.dart';

class DentalFindingsScreen extends StatefulWidget {
  @override
  State<DentalFindingsScreen> createState() => _DentalFindingsScreenState();
}

class _DentalFindingsScreenState extends State<DentalFindingsScreen> {
  bool showInfoBanner = true;

  // 다중 선택 모드 / 선택된 치아
  bool multiMode = false;
  final Set<int> selectedTeeth = <int>{};

  // ✅ 아치 락: 첫 선택으로 상악(true)/하악(false) 고정, null이면 해제
  bool? multiArchUpper;

  // FDI 배열
  static const upperRightPerm = [18, 17, 16, 15, 14, 13, 12, 11];
  static const upperLeftPerm  = [21, 22, 23, 24, 25, 26, 27, 28];
  static const lowerRightPerm = [48, 47, 46, 45, 44, 43, 42, 41];
  static const lowerLeftPerm  = [31, 32, 33, 34, 35, 36, 37, 38];

  static const upperRightPrim = [55, 54, 53, 52, 51];
  static const upperLeftPrim  = [61, 62, 63, 64, 65];
  static const lowerRightPrim = [85, 84, 83, 82, 81];
  static const lowerLeftPrim  = [71, 72, 73, 74, 75];

  @override
  Widget build(BuildContext context) {
    final p = context.watch<DentalDataProvider>();

    return Scaffold(
      appBar: const CommonAppBar(
        title: "630 : Odontogram",
        showRecordBadge: true,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
        children: [
          if (showInfoBanner)
            _InfoBanner(onClose: () => setState(() => showInfoBanner = false)),

          // 상단 컨트롤: 다중 선택 토글 + 액션들
          _MultiSelectToolbar(
            multiMode: multiMode,
            selectedCount: selectedTeeth.length,
            lockHint: multiArchUpper == null ? null : (multiArchUpper! ? '상악만' : '하악만'),
            onToggle: () => setState(() {
              multiMode = !multiMode;
              if (!multiMode) {
                selectedTeeth.clear();
                multiArchUpper = null; // ✅ 락 해제
              }
            }),
            onClear: selectedTeeth.isEmpty
                ? null
                : () => setState(() {
              selectedTeeth.clear();
              multiArchUpper = null; // ✅ 락 해제
            }),
            onMakeDenture: selectedTeeth.isEmpty
                ? null
                : () => _showDentureDialog(context, p),
            onMakeBridge: selectedTeeth.length < 2
                ? null
                : () => _showBridgeDialog(context, p),
          ),

          // ===== 영구치 =====
          const SizedBox(height: 8),
          _SectionTitle("영구치 (Permanent)"),
          _ArchBlock(
            topNumbers: true,
            teeth: [upperRightPerm, upperLeftPerm],
            multiMode: multiMode,
            archLockUpper: multiArchUpper,
            selectedSet: selectedTeeth,
            onTapArch: (archTeeth) => _openQuadrant(context, _titleFor(archTeeth), true, true, archTeeth),
            onTapTooth: (fdi) => _handleToothTap(fdi),
            onLongPressTooth: (fdi) => _handleToothLong(fdi),
          ),
          const SizedBox(height: 8),
          _ArchBlock(
            topNumbers: false,
            teeth: [lowerRightPerm, lowerLeftPerm],
            multiMode: multiMode,
            archLockUpper: multiArchUpper,
            selectedSet: selectedTeeth,
            onTapArch: (archTeeth) => _openQuadrant(context, _titleFor(archTeeth), false, true, archTeeth),
            onTapTooth: (fdi) => _handleToothTap(fdi),
            onLongPressTooth: (fdi) => _handleToothLong(fdi),
          ),

          const Divider(height: 32),

          // ===== 유치 =====
          _SectionTitle("유치 (Primary)"),
          _ArchBlock(
            topNumbers: true,
            teeth: [upperRightPrim, upperLeftPrim],
            multiMode: multiMode,
            archLockUpper: multiArchUpper,
            selectedSet: selectedTeeth,
            onTapArch: (archTeeth) => _openQuadrant(context, _titleFor(archTeeth), true, false, archTeeth),
            onTapTooth: (fdi) => _handleToothTap(fdi),
            onLongPressTooth: (fdi) => _handleToothLong(fdi),
          ),
          const SizedBox(height: 8),
          _ArchBlock(
            topNumbers: false,
            teeth: [lowerRightPrim, lowerLeftPrim],
            multiMode: multiMode,
            archLockUpper: multiArchUpper,
            selectedSet: selectedTeeth,
            onTapArch: (archTeeth) => _openQuadrant(context, _titleFor(archTeeth), false, false, archTeeth),
            onTapTooth: (fdi) => _handleToothTap(fdi),
            onLongPressTooth: (fdi) => _handleToothLong(fdi),
          ),

          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              OutlinedButton(
                onPressed: () => Navigator.pushReplacementNamed(context, '/supplementaryDetails'),
                child: const Text("이전"),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pushReplacementNamed(context, '/DentalDataScreen'),
                child: const Text("다음"),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 0),
    );
  }

  // === interactions ===
  void _handleToothTap(int fdi) {
    if (multiMode) {
      final isUp = _isUpper(fdi);
      setState(() {
        if (selectedTeeth.isEmpty) {
          // 첫 선택 → 아치 락
          multiArchUpper = isUp;
          selectedTeeth.add(fdi);
        } else {
          if (multiArchUpper != isUp) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('상·하악을 함께 선택할 수 없습니다. 현재 ${multiArchUpper! ? '상악' : '하악'}만 선택 중.')),
            );
          } else {
            if (!selectedTeeth.add(fdi)) selectedTeeth.remove(fdi);
          }
        }
      });
    } else {
      // 단일 모드에선 해당 치아가 포함된 아치로 확대
      final arch = _archForFdi(fdi);
      final isUpper = _isUpper(fdi);
      final isPermanent = _isPermanent(fdi);
      _openQuadrant(context, _titleFor(arch), isUpper, isPermanent, arch);
    }
  }

  void _handleToothLong(int fdi) {
    final isUp = _isUpper(fdi);
    setState(() {
      if (!multiMode) {
        multiMode = true;
        multiArchUpper = isUp; // 락 설정
        selectedTeeth.add(fdi);
        return;
      }
      if (selectedTeeth.isEmpty) {
        multiArchUpper = isUp;
        selectedTeeth.add(fdi);
      } else {
        if (multiArchUpper != isUp) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('상·하악을 함께 선택할 수 없습니다. 현재 ${multiArchUpper! ? '상악' : '하악'}만 선택 중.')),
          );
        } else {
          if (!selectedTeeth.add(fdi)) selectedTeeth.remove(fdi);
        }
      }
    });
  }

  // === helpers ===
  bool _isUpper(int fdi) {
    final q = fdi ~/ 10;
    return q == 1 || q == 2 || q == 5 || q == 6;
  }

  bool _isPermanent(int fdi) {
    final q = fdi ~/ 10;
    return q >= 1 && q <= 4;
  }

  List<int> _archForFdi(int fdi) {
    const arches = [
      upperRightPerm, upperLeftPerm, lowerLeftPerm, lowerRightPerm,
      upperRightPrim, upperLeftPrim, lowerLeftPrim, lowerRightPrim,
    ];
    return arches.firstWhere((a) => a.contains(fdi), orElse: () => const <int>[]);
  }

  String _titleFor(List<int> arch) {
    if (arch.isEmpty) return 'Odontogram';
    final isPrimary = arch.first ~/ 10 >= 5;
    final isUpper = arch == upperRightPerm || arch == upperLeftPerm || arch == upperRightPrim || arch == upperLeftPrim;
    final side = (arch == upperRightPerm || arch == lowerRightPerm || arch == upperRightPrim || arch == lowerRightPrim)
        ? '우측'
        : '좌측';
    final jaw = isUpper ? '상악' : '하악';
    final range = '${arch.first}–${arch.last}';
    return '$jaw·$side ${isPrimary ? "유치" : ""} ($range)';
  }

  void _openQuadrant(
      BuildContext context,
      String title,
      bool isUpper,
      bool isPermanent,
      List<int> fdi,
      ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => QuadrantZoomScreen(
          title: title,
          isUpper: isUpper,
          isPermanent: isPermanent,
          teeth: fdi,
        ),
      ),
    );
  }

  // === span dialogs ===
  Future<void> _showDentureDialog(BuildContext context, DentalDataProvider p) async {
    // 간단한 코드 선택(선택 사항)
    const codes = ['FUD','HUD','PLD','PUD','CLA','FOA','SPL','ROA','EDE','HLD','FLD'];
    String? pick;
    await showDialog(
      context: context,
      builder: (_) => StatefulBuilder(
        builder: (ctx, setStateDlg) => AlertDialog(
          title: const Text('Denture / Ortho 만들기'),
          content: Wrap(
            spacing: 8, runSpacing: 8,
            children: codes.map((c) => ChoiceChip(
              label: Text(c),
              selected: pick == c,
              onSelected: (_) { setStateDlg(() => pick = c); },
            )).toList(),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('취소')),
            FilledButton(
              onPressed: () { Navigator.pop(ctx); },
              child: const Text('확인'),
            ),
          ],
        ),
      ),
    );
    if (selectedTeeth.isEmpty) return;
    p.addDentureSpan(selectedTeeth.toList(), code: pick);
    setState(() { selectedTeeth.clear(); multiMode = false; multiArchUpper = null; });
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Denture/Ortho 스팬이 추가되었습니다.')));
  }

  Future<void> _showBridgeDialog(BuildContext context, DentalDataProvider p) async {
    // 선택된 치아들 중에서 Abutment / Pontic 지정
    final teeth = selectedTeeth.toList()..sort();
    final Set<int> abut = {teeth.first, teeth.last};
    final Set<int> pont = teeth.where((t) => !abut.contains(t)).toSet();

    await showDialog(
      context: context,
      builder: (_) => StatefulBuilder(
        builder: (ctx, setStateDlg) => AlertDialog(
          title: const Text('Bridge 만들기'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('지대치(Abutments)'),
                Wrap(
                  spacing: 8, runSpacing: 8,
                  children: teeth.map((t) => FilterChip(
                    label: Text('$t'),
                    selected: abut.contains(t),
                    onSelected: (sel) {
                      setStateDlg(() {
                        if (sel) {
                          abut.add(t);
                          pont.remove(t);
                        } else {
                          abut.remove(t);
                        }
                      });
                    },
                  )).toList(),
                ),
                const SizedBox(height: 12),
                const Text('Pontics'),
                Wrap(
                  spacing: 8, runSpacing: 8,
                  children: teeth.map((t) => FilterChip(
                    label: Text('$t'),
                    selected: pont.contains(t),
                    onSelected: (sel) {
                      setStateDlg(() {
                        if (sel) {
                          pont.add(t);
                          abut.remove(t);
                        } else {
                          pont.remove(t);
                        }
                      });
                    },
                  )).toList(),
                ),
                const SizedBox(height: 8),
                const Text('※ 최소 1개 이상 Abutment / Pontic 필요'),
              ],
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('취소')),
            FilledButton(
              onPressed: (abut.isEmpty || pont.isEmpty)
                  ? null
                  : () {
                Navigator.pop(ctx);
              },
              child: const Text('확인'),
            ),
          ],
        ),
      ),
    );

    if (selectedTeeth.isEmpty) return;
    if (abut.isEmpty || pont.isEmpty) return;

    p.addBridgeSpan(
      selectedFdi: teeth,
      abutments: abut,
      pontics: pont,
    );
    setState(() { selectedTeeth.clear(); multiMode = false; multiArchUpper = null; });
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Bridge 스팬이 추가되었습니다.')));
  }
}

// ============== 위젯들 ==============

class _InfoBanner extends StatelessWidget {
  final VoidCallback onClose;
  const _InfoBanner({required this.onClose});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue[50],
        border: Border.all(color: Colors.blueAccent),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          const Icon(Icons.info_outline, color: Colors.blue),
          const SizedBox(width: 8),
          const Expanded(
            child: Text(
              "💡 각 악궁을 탭하면 확대 화면으로 이동합니다.\n"
                  "확대 화면: 두 손가락으로 확대/축소, 한 번 탭=5면 토글, 길게=초기화\n"
                  "여기(축소 보기)에서 길게 눌러 다중 선택 후 Denture/Bridge를 생성할 수 있어요.\n"
                  "다중 선택 중에는 첫 선택한 악궁만 선택 가능합니다.",
            ),
          ),
          IconButton(onPressed: onClose, icon: const Icon(Icons.close, color: Colors.blue)),
        ],
      ),
    );
  }
}

class _MultiSelectToolbar extends StatelessWidget {
  final bool multiMode;
  final int selectedCount;
  final String? lockHint;             // ✅ 추가
  final VoidCallback onToggle;
  final VoidCallback? onClear;
  final VoidCallback? onMakeDenture;
  final VoidCallback? onMakeBridge;

  const _MultiSelectToolbar({
    required this.multiMode,
    required this.selectedCount,
    required this.onToggle,
    this.lockHint,
    this.onClear,
    this.onMakeDenture,
    this.onMakeBridge,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: LayoutBuilder(
          builder: (ctx, c) {
            final compact = c.maxWidth < 380; // 좁은 화면 감지

            final leftCluster = Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Switch(value: multiMode, onChanged: (_) => onToggle()),
                const SizedBox(width: 6),
                Text(compact ? '다중' : '다중 선택'),
                if (selectedCount > 0) ...[
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(.08),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Text('선택 $selectedCount', style: const TextStyle(fontSize: 12)),
                  ),
                ],
                if (lockHint != null) ...[
                  const SizedBox(width: 6),
                  Chip(
                    label: Text(lockHint!),
                    visualDensity: VisualDensity.compact,
                  ),
                ],
                if (!compact) ...[
                  const SizedBox(width: 8),
                  TextButton.icon(
                    onPressed: onClear,
                    icon: const Icon(Icons.clear_all),
                    label: const Text('선택 해제'),
                  ),
                ],
              ],
            );

            final rightCluster = compact
                ? Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: onMakeDenture,
                  icon: const Icon(Icons.circle_outlined),
                  tooltip: 'Denture/Ortho',
                ),
                IconButton(
                  onPressed: onMakeBridge,
                  icon: const Icon(Icons.horizontal_rule),
                  tooltip: 'Bridge',
                ),
                IconButton(
                  onPressed: onClear,
                  icon: const Icon(Icons.clear_all),
                  tooltip: '선택 해제',
                ),
              ],
            )
                : Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                FilledButton.tonalIcon(
                  onPressed: onMakeDenture,
                  icon: const Icon(Icons.circle_outlined),
                  label: const Text('Denture/Ortho'),
                ),
                const SizedBox(width: 8),
                FilledButton.icon(
                  onPressed: onMakeBridge,
                  icon: const Icon(Icons.horizontal_rule),
                  label: const Text('Bridge'),
                ),
              ],
            );

            return Wrap(
              spacing: 8,
              runSpacing: 6,
              alignment: WrapAlignment.spaceBetween,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                leftCluster,
                rightCluster,
              ],
            );
          },
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String text;
  const _SectionTitle(this.text);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Text(
        text,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
      ),
    );
  }
}

/// 한 줄(좌/우)을 한 번에 표시. `teeth`는 [leftRow, rightRow] 형태.
class _ArchBlock extends StatelessWidget {
  final bool topNumbers;
  final List<List<int>> teeth;
  final bool multiMode;                 // ✅
  final bool? archLockUpper;            // ✅
  final Set<int> selectedSet;           // ✅
  final void Function(List<int> archTeeth) onTapArch;
  final void Function(int fdi) onTapTooth;
  final void Function(int fdi) onLongPressTooth;

  const _ArchBlock({
    required this.topNumbers,
    required this.teeth,
    required this.multiMode,
    required this.archLockUpper,
    required this.selectedSet,
    required this.onTapArch,
    required this.onTapTooth,
    required this.onLongPressTooth,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, c) {
        const gap = 8.0;
        final n = teeth.first.length;              // 8 또는 5 (좌/우 동일)
        final tile = ((c.maxWidth - gap) / (n * 2)).clamp(20.0, 44.0);

        return Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => onTapArch(teeth[0]),
                    child: _TeethRow(
                      numbersOnTop: topNumbers,
                      teeth: teeth[0],
                      tile: tile,
                      multiMode: multiMode,
                      archLockUpper: archLockUpper,
                      selectedSet: selectedSet,
                      onTapTooth: onTapTooth,
                      onLongPressTooth: onLongPressTooth,
                    ),
                  ),
                ),
                const SizedBox(width: gap),
                Expanded(
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => onTapArch(teeth[1]),
                    child: _TeethRow(
                      numbersOnTop: topNumbers,
                      teeth: teeth[1],
                      tile: tile,
                      multiMode: multiMode,
                      archLockUpper: archLockUpper,
                      selectedSet: selectedSet,
                      onTapTooth: onTapTooth,
                      onLongPressTooth: onLongPressTooth,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
          ],
        );
      },
    );
  }
}

class _TeethRow extends StatelessWidget {
  final bool numbersOnTop;
  final List<int> teeth;
  final double tile;
  final bool multiMode;                // ✅
  final bool? archLockUpper;          // ✅
  final Set<int> selectedSet;         // ✅
  final void Function(int fdi) onTapTooth;
  final void Function(int fdi) onLongPressTooth;

  const _TeethRow({
    required this.numbersOnTop,
    required this.teeth,
    required this.tile,
    required this.multiMode,
    required this.archLockUpper,
    required this.selectedSet,
    required this.onTapTooth,
    required this.onLongPressTooth,
  });

  bool _isUpperLocal(int fdi) {
    final q = fdi ~/ 10;
    return q == 1 || q == 2 || q == 5 || q == 6;
  }

  @override
  Widget build(BuildContext context) {
    final p = context.watch<DentalDataProvider>();

    // 스팬 정보 → 각 치아별 마커
    Map<int, ({bool denture, bool abut, bool pontic})> markers = {
      for (final f in teeth) f: (denture: false, abut: false, pontic: false)
    };
    for (final sp in p.spans) {
      for (final f in teeth) {
        if (!sp.teeth.contains(f)) continue;
        if (sp.type == DentalSpanType.dentureOrtho) {
          markers[f] = (denture: true, abut: markers[f]!.abut, pontic: markers[f]!.pontic);
        } else {
          final isAb = sp.abutments.contains(f);
          final isPo = sp.pontics.contains(f);
          markers[f] = (
          denture: markers[f]!.denture,
          abut: markers[f]!.abut || isAb,
          pontic: markers[f]!.pontic || isPo
          );
        }
      }
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: teeth.map((fdi) {
        final selectedSurfaces = p.getSelectedSurfaces(fdi);
        final hasAnyDetail = (p.fdiToothData[fdi]?['detail'] != null) || selectedSurfaces.isNotEmpty;

        final lockedOut = multiMode && archLockUpper != null && (_isUpperLocal(fdi) != archLockUpper);
        final opacity = lockedOut ? 0.35 : 1.0;
        final isSelectedNow = selectedSet.contains(fdi); // ✅ 선택 강조

        return Opacity(
          opacity: opacity,
          child: SizedBox(
            width: tile,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (numbersOnTop) _ToothNumber(fdi, tile),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    if (!lockedOut) onTapTooth(fdi);
                  },
                  onLongPress: () {
                    if (!lockedOut) onLongPressTooth(fdi);
                  },
                  child: _MiniToothTile(
                    fdi: fdi,
                    size: tile,
                    highlighted: hasAnyDetail,
                    isSelected: isSelectedNow, // ✅
                    markDenture: markers[fdi]!.denture,
                    markAbut: markers[fdi]!.abut,
                    markPontic: markers[fdi]!.pontic,
                  ),
                ),
                if (!numbersOnTop) _ToothNumber(fdi, tile),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}

class _ToothNumber extends StatelessWidget {
  final int fdi;
  final double tile;
  const _ToothNumber(this.fdi, this.tile);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: tile * .6,
      child: Center(
        child: Text('$fdi', style: const TextStyle(fontWeight: FontWeight.w700)),
      ),
    );
  }
}

class _MiniToothTile extends StatelessWidget {
  final int fdi;
  final double size;
  final bool highlighted;
  final bool isSelected;   // ✅ 다중선택 강조
  final bool markDenture;
  final bool markAbut;
  final bool markPontic;

  const _MiniToothTile({
    required this.fdi,
    required this.size,
    this.highlighted = false,
    this.isSelected = false,
    this.markDenture = false,
    this.markAbut = false,
    this.markPontic = false,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size.square(size),
      painter: _ShieldToothPainter(
        highlighted: highlighted,
        selected: isSelected,     // ✅
        denture: markDenture,
        abut: markAbut,
        pontic: markPontic,
      ),
    );
  }
}

/// 방패연 + 스팬 미니 마킹(개별 타일 버전)
class _ShieldToothPainter extends CustomPainter {
  final bool highlighted;
  final bool selected; // ✅ 선택 강조
  final bool denture;  // 파란 타원
  final bool abut;     // 파란 원(지대치)
  final bool pontic;   // 파란 수평 2줄

  _ShieldToothPainter({
    required this.highlighted,
    required this.selected,
    required this.denture,
    required this.abut,
    required this.pontic,
  });

  @override
  void paint(Canvas canvas, Size s) {
    final outerRect = Offset.zero & s;
    final rrect = RRect.fromRectAndRadius(outerRect.deflate(1), Radius.circular(s.width * .12));

    final strokeW = (s.width * .04).clamp(1.0, 2.0);
    final stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeW
      ..color = highlighted ? Colors.deepPurple : Colors.black87;

    final innerStroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = (s.width * .032).clamp(0.8, 1.6)
      ..color = Colors.black54;

    // 선택 강조(초록 테두리) 먼저 깔기
    if (selected) {
      final selStroke = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = (s.width * .08).clamp(1.6, 3.2)
        ..color = Colors.green;
      canvas.drawRRect(rrect.deflate(1), selStroke);
    }

    // 바깥 사각형
    canvas.drawRRect(rrect, stroke);

    // 중앙 가로 직사각형
    final w = s.width, h = s.height;
    final rectW = w * .66;
    final rectH = h * .46;
    final mid = Rect.fromCenter(center: outerRect.center, width: rectW, height: rectH);
    canvas.drawRect(mid, innerStroke);

    // 대각선
    final cornersOuter = [outerRect.topLeft, outerRect.topRight, outerRect.bottomRight, outerRect.bottomLeft];
    final cornersInner = [mid.topLeft, mid.topRight, mid.bottomRight, mid.bottomLeft];
    for (int i = 0; i < 4; i++) {
      canvas.drawLine(cornersInner[i], cornersOuter[i], innerStroke);
    }

    // ===== 미니 스팬 마킹 =====
    final blue = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = (s.width * .06).clamp(1.2, 2.4)
      ..color = Colors.blueAccent;

    if (denture) {
      // 타원(살짝 안쪽)
      final oval = outerRect.deflate(s.width * .18);
      canvas.drawOval(oval, blue);
    }
    if (abut) {
      // 원(링)
      final ring = outerRect.deflate(s.width * .22);
      canvas.drawRRect(RRect.fromRectAndRadius(ring, Radius.circular(ring.width * .2)), blue);
    }
    if (pontic) {
      // 수평 2줄
      final y1 = s.height * .40, y2 = s.height * .60;
      canvas.drawLine(Offset(s.width * .18, y1), Offset(s.width * .82, y1), blue);
      canvas.drawLine(Offset(s.width * .18, y2), Offset(s.width * .82, y2), blue);
    }
  }

  @override
  bool shouldRepaint(covariant _ShieldToothPainter old) =>
      old.highlighted != highlighted ||
          old.selected != selected ||
          old.denture != denture ||
          old.abut != abut ||
          old.pontic != pontic;
}



