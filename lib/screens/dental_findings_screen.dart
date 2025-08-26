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
import '../data/codes_635.dart';
import '../data/surface_fill.dart';


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

  // 같은 치아에 다른 타입(span)이 이미 있는지 검사
  bool _hasTypeConflict(DentalDataProvider p, Iterable<int> teeth, DentalSpanType creating) {
    final set = teeth.toSet();
    return p.spans.any((sp) => sp.type != creating && sp.teeth.any(set.contains));
  }

// 어느 치아가 충돌하는지 수집(스낵바 안내용)
  List<int> _collectTypeConflictTeeth(DentalDataProvider p, Iterable<int> teeth, DentalSpanType creating) {
    final set = teeth.toSet();
    final hit = <int>{};
    for (final sp in p.spans) {
      if (sp.type == creating) continue;
      for (final t in sp.teeth) {
        if (set.contains(t)) hit.add(t);
      }
    }
    final list = hit.toList()..sort();
    return list;
  }


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
            onRemoveSpans: selectedTeeth.isEmpty
                ? null
                : () => _showRemoveSpansDialog(context, p),
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

    final confirmed = await showDialog<bool>(
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
            TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('취소')),
            FilledButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('확인')),
          ],
        ),
      ),
    );

    // ⛔ 취소/백버튼이면 아무것도 하지 않음
    if (confirmed != true) return;
    if (selectedTeeth.isEmpty) return;

    // ✅ 다른 타입(= Bridge)과 충돌 검사
    if (_hasTypeConflict(p, selectedTeeth, DentalSpanType.dentureOrtho)) {
      final clash = _collectTypeConflictTeeth(p, selectedTeeth, DentalSpanType.dentureOrtho);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('다음 치아는 이미 Bridge 스팬에 포함되어 있어 Denture를 만들 수 없습니다: ${clash.join(", ")}')),
      );
      return;
    }

    p.addDentureSpan(selectedTeeth.toList(), code: pick); // pick은 null 가능(선택 안 해도 됨)
    setState(() { selectedTeeth.clear(); multiMode = false; multiArchUpper = null; });
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Denture/Ortho 스팬이 추가되었습니다.')));
  }

  Future<void> _showBridgeDialog(BuildContext context, DentalDataProvider p) async {
    // 선택된 치아들 중에서 Abutment / Pontic 지정
    final teeth = selectedTeeth.toList()..sort();
    final Set<int> abut = {teeth.first, teeth.last};
    final Set<int> pont = teeth.where((t) => !abut.contains(t)).toSet();

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => StatefulBuilder(
        builder: (ctx, setStateDlg) => AlertDialog(
          title: const Text('Bridge 만들기'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '※ 보통 브릿지는 양 끝이 지대치(Abutment)입니다. '
                      '다만 파손/칸틸레버 등 예외 표현을 위해 제한하지 않습니다.',
                  style: TextStyle(color: Colors.black54),
                ),
                const SizedBox(height: 8),
                const Text('지대치(Abutments)'),
                Wrap(
                  spacing: 8, runSpacing: 8,
                  children: teeth.map((t) => FilterChip(
                    label: Text('$t'),
                    selected: abut.contains(t),
                    onSelected: (sel) {
                      setStateDlg(() {
                        if (sel) { abut.add(t); pont.remove(t); }
                        else { abut.remove(t); }
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
                        if (sel) { pont.add(t); abut.remove(t); }
                        else { pont.remove(t); }
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
            TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('취소')),
            FilledButton(
              onPressed: (abut.isEmpty || pont.isEmpty) ? null : () => Navigator.pop(ctx, true),
              child: const Text('확인'),
            ),
          ],
        ),
      ),
    );

    // ⛔ 취소면 생성 안 함
    if (confirmed != true) return;
    if (selectedTeeth.isEmpty) return;
    if (abut.isEmpty || pont.isEmpty) return;

    // ✅ 다른 타입(= Denture)과 충돌 검사 — 브리지는 지대치/pontic 모두 포함해 검사
    final union = {...teeth, ...abut, ...pont};
    if (_hasTypeConflict(p, union, DentalSpanType.bridge)) {
      final clash = _collectTypeConflictTeeth(p, union, DentalSpanType.bridge);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('다음 치아는 이미 Denture/Ortho 스팬에 포함되어 있어 Bridge를 만들 수 없습니다: ${clash.join(", ")}')),
      );
      return;
    }

    p.addBridgeSpan(selectedFdi: teeth, abutments: abut, pontics: pont);
    setState(() { selectedTeeth.clear(); multiMode = false; multiArchUpper = null; });
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Bridge 스팬이 추가되었습니다.')));
  }

  Future<void> _showRemoveSpansDialog(BuildContext context, DentalDataProvider p) async {
    bool rmDent = true;
    bool rmBridge = true;

    final hit = p.spansIntersecting(selectedTeeth);
    if (hit.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('겹치는 스팬이 없습니다.')),
      );
      return;
    }

    final confirmed = await showDialog<bool>(
      context: context,
      barrierDismissible: false, // 바깥 탭으로 닫혀도 삭제되지 않도록
      builder: (_) => StatefulBuilder(
        builder: (ctx, setStateDlg) => AlertDialog(
          title: const Text('스팬 삭제'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('대상 스팬: ${hit.length}개'),
              const SizedBox(height: 8),
              CheckboxListTile(
                value: rmDent,
                onChanged: (v) => setStateDlg(() => rmDent = v ?? true),
                title: const Text('Denture/Ortho'),
                contentPadding: EdgeInsets.zero,
              ),
              CheckboxListTile(
                value: rmBridge,
                onChanged: (v) => setStateDlg(() => rmBridge = v ?? true),
                title: const Text('Bridge'),
                contentPadding: EdgeInsets.zero,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx, false), // ❌ 취소 → false
              child: const Text('취소'),
            ),
            FilledButton(
              onPressed: (!rmDent && !rmBridge) ? null : () => Navigator.pop(ctx, true), // ✅ 삭제 → true
              child: const Text('삭제'),
            ),
          ],
        ),
      ),
    );

// ❗ 사용자가 취소했으면 삭제 로직 진입 금지
    if (confirmed != true) return;

// 여기서부터 실제 삭제
    final removed = p.removeSpansIntersecting(
      selectedTeeth,
      removeDenture: rmDent,
      removeBridge: rmBridge,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('삭제된 스팬: $removed개')),
    );

    setState(() {
      selectedTeeth.clear();
      multiMode = false;
      multiArchUpper = null;
    });
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
              "💡 사용법\n"
                  "• 축소 보기에서 치아를 탭하면 확대 화면으로 이동합니다.\n"
                  "• 축소 보기에서 길게 눌러 다중선택 모드를 켜고, 같은 악궁(상/하)만 묶어서 Denture/Bridge를 만들 수 있어요.\n"
                  "  (첫 선택으로 상/하악이 고정됩니다)\n"
                  "• 이미 생성된 스팬은 축소 보기 타일에 파란 마킹으로 표시됩니다.",
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
  final VoidCallback? onRemoveSpans;

  const _MultiSelectToolbar({
    required this.multiMode,
    required this.selectedCount,
    required this.onToggle,
    this.lockHint,
    this.onClear,
    this.onMakeDenture,
    this.onMakeBridge,
    this.onRemoveSpans,
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
              ],
            );

            final rightCluster = compact
                ? Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: onMakeDenture,
                  icon: const Icon(Icons.all_out),
                  tooltip: 'Denture/Ortho',
                ),
                IconButton(
                  onPressed: onMakeBridge,
                  icon: const Icon(Icons.linear_scale),
                  tooltip: 'Bridge',
                ),
                IconButton(
                  onPressed: onClear,
                  icon: const Icon(Icons.backspace),
                  tooltip: '선택 해제',
                ),
                IconButton(
                  onPressed: onRemoveSpans,
                  icon: const Icon(Icons.delete_sweep),
                  tooltip: '스팬 삭제',
                ),
              ],
            )
                : Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                FilledButton.tonalIcon(
                  onPressed: onMakeDenture,
                  icon: const Icon(Icons.all_out),
                  label: const Text('Denture/Ortho'),
                ),
                const SizedBox(width: 8),
                FilledButton.icon(
                  onPressed: onMakeBridge,
                  icon: const Icon(Icons.linear_scale),
                  label: const Text('Bridge'),
                ),
                const SizedBox(width: 8),
                // ✅ 넓은 화면에도 '선택 해제' 추가 — 순서 동일 유지
                OutlinedButton.icon(
                  onPressed: onClear,
                  icon: const Icon(Icons.clear_all),
                  label: const Text('선택 해제'),
                ),
                const SizedBox(width: 8),
                OutlinedButton.icon(
                  onPressed: onRemoveSpans,
                  icon: const Icon(Icons.delete_sweep),
                  label: const Text('스팬 삭제'),
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
        final n = teeth.first.length; // 8 or 5
        final tile = ((c.maxWidth - gap) / (n * 2)).clamp(20.0, 44.0);

        // 각 사이드 실제 폭(Expanded가 차지하는 폭)
        final sideAvail = (c.maxWidth - gap) / 2;
        final perSideSpacing = n > 1 ? (sideAvail - n * tile) / (n - 1) : 0.0;

        return Stack(
          children: [
            // 덴쳐 오버레이 (좌/우 합쳐서 하나의 큰 타원 가능)
            Positioned.fill(
              child: _ArchDentureOverlay(
                topNumbers: topNumbers,
                leftTeeth: teeth[0],
                rightTeeth: teeth[1],
                tile: tile,
                sideWidth: sideAvail,
                perSideSpacing: perSideSpacing,
                gap: gap,
              ),
            ),
            Column(
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
            ),
          ],
        );
      },
    );
  }
}

class _ArchDentureOverlay extends StatelessWidget {
  final bool topNumbers;
  final List<int> leftTeeth;
  final List<int> rightTeeth;
  final double tile;
  final double sideWidth;
  final double perSideSpacing;
  final double gap;
  const _ArchDentureOverlay({
    required this.topNumbers,
    required this.leftTeeth,
    required this.rightTeeth,
    required this.tile,
    required this.sideWidth,
    required this.perSideSpacing,
    required this.gap,
  });

  @override
  Widget build(BuildContext context) {
    final p = context.watch<DentalDataProvider>();
    final spans = p.spans.where((sp) => sp.type == DentalSpanType.dentureOrtho).toList();

    // 타일 y 위치(숫자 라벨*0.6 높이만큼 오프셋)
    final tileTop = topNumbers ? tile * .6 : 0.0;

    return CustomPaint(
      painter: _ArchDentureOverlayPainter(
        leftTeeth: leftTeeth,
        rightTeeth: rightTeeth,
        tile: tile,
        sideWidth: sideWidth,
        perSideSpacing: perSideSpacing,
        gap: gap,
        tileTop: tileTop,
        spans: spans,
      ),
    );
  }
}

class _ArchDentureOverlayPainter extends CustomPainter {
  final List<int> leftTeeth;
  final List<int> rightTeeth;
  final double tile;
  final double sideWidth;
  final double perSideSpacing;
  final double gap;
  final double tileTop;
  final List<DentalSpan> spans;

  _ArchDentureOverlayPainter({
    required this.leftTeeth,
    required this.rightTeeth,
    required this.tile,
    required this.sideWidth,
    required this.perSideSpacing,
    required this.gap,
    required this.tileTop,
    required this.spans,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // FDI -> 타일 rect 매핑 (아치 전체 좌표)
    final rectMap = <int, Rect>{};

    // 왼쪽 사이드
    for (int i = 0; i < leftTeeth.length; i++) {
      final x = i * (tile + perSideSpacing);
      rectMap[leftTeeth[i]] = Rect.fromLTWH(x, tileTop, tile, tile);
    }
    // 오른쪽 사이드
    final baseX = sideWidth + gap;
    for (int i = 0; i < rightTeeth.length; i++) {
      final x = baseX + i * (tile + perSideSpacing);
      rectMap[rightTeeth[i]] = Rect.fromLTWH(x, tileTop, tile, tile);
    }

    final paintBlue = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = (tile * .12).clamp(1.4, 2.8)
      ..color = Colors.blueAccent;

    for (final sp in spans) {
      final inArch = [...leftTeeth, ...rightTeeth].where(sp.teeth.contains).toList();
      if (inArch.isEmpty) continue;

      // 전체 bounding box (좌/우를 가로질러 한 번에)
      double minL = double.infinity, minT = double.infinity, maxR = -1e9, maxB = -1e9;
      for (final t in inArch) {
        final r = rectMap[t]!;
        if (r.left < minL) minL = r.left;
        if (r.top < minT) minT = r.top;
        if (r.right > maxR) maxR = r.right;
        if (r.bottom > maxB) maxB = r.bottom;
      }
      var union = Rect.fromLTRB(minL, minT, maxR, maxB);

      // 여백 추가 + 캡슐 형태
      final rr = RRect.fromRectAndRadius(
        union.inflate(tile * .2),
        Radius.circular(union.height),
      );
      canvas.drawRRect(rr, paintBlue);
    }
  }

  @override
  bool shouldRepaint(covariant _ArchDentureOverlayPainter old) =>
      old.leftTeeth != leftTeeth ||
          old.rightTeeth != rightTeeth ||
          old.tile != tile ||
          old.sideWidth != sideWidth ||
          old.perSideSpacing != perSideSpacing ||
          old.gap != gap ||
          old.tileTop != tileTop ||
          old.spans != spans;
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
        final spec = p.getSpecRead(fdi);

        // 잠금/투명도/선택 상태
        final bool lockedOut = multiMode && archLockUpper != null && (_isUpperLocal(fdi) != archLockUpper);
        final double opacity = lockedOut ? 0.35 : 1.0;
        final bool isSelectedNow = selectedSet.contains(fdi);

        // 축소뷰 요약 색 (빨강/파랑)
        final bool hasCariesAny = (spec?.surface.values.any((m) {
          final list = (m['fillings'] ?? const <String>[]) as List<String>;
          return list.any(isCariesCode);
        }) ?? false);

        final bool hasFillingAny = (spec?.surface.values.any((m) {
          final list = (m['fillings'] ?? const <String>[]) as List<String>;
          return list.isNotEmpty;
        }) ?? false);

        // 축소뷰에서 보조 하이라이트: 뭔가라도 데이터가 있으면 보라 테두리
        bool hasAnyDetail = false;
        if (spec != null) {
          // 표면 코드 존재?
          if (!hasAnyDetail) {
            for (final m in spec.surface.values) {
              final f = (m['fillings'] ?? const <String>[]) as List<String>;
              final p = (m['periodontium'] ?? const <String>[]) as List<String>;
              if (f.isNotEmpty || p.isNotEmpty) { hasAnyDetail = true; break; }
            }
          }
          // 전역 코드 존재?
          if (!hasAnyDetail) {
            for (final g in const ['bite','crown','root','status','position']) {
              if ((spec.global[g] ?? const <String>[]).isNotEmpty) { hasAnyDetail = true; break; }
            }
          }
          // 노트 존재?
          if (!hasAnyDetail) {
            if ((spec.toothNote ?? '').trim().isNotEmpty ||
                spec.surfaceNote.values.any((v) => (v).toString().trim().isNotEmpty)) {
              hasAnyDetail = true;
            }
          }
        }

        // 전역코드 → 축소뷰 마킹
        final crownCodes = (spec?.global['crown'] ?? const <String>[]) as List<String>;
        final statusCodes = (spec?.global['status'] ?? const <String>[]) as List<String>;
        final rootCodes   = (spec?.global['root']   ?? const <String>[]) as List<String>;

        final bool ringCrown = crownCodes.isNotEmpty; // crown 있으면 링
        final bool twoHorizontal = statusCodes
            .map((e) => e.toUpperCase())
            .any((c) => c == 'MIS' || c.startsWith('MIS')); // MIS*
        final bool oneVertical = rootCodes
            .map((e) => e.toUpperCase())
            .any((c) => c == 'IPX' || c.startsWith('IPX')); // IPX*

// 스팬 마커(브릿지/덴쳐)
        final m = markers[fdi]!;
        final bool ringAbutOrCrown = m.abut || ringCrown;
        final bool ponticOrMissing = m.pontic || twoHorizontal;
        const bool drawDentureSmall = false;

// ✅ 축소뷰용 “각 면별” fill 계산
        final Map<String, SurfaceFill> miniFill = {
          for (final s in kToothSurfaces) s: SurfaceFill.none,
        };
        if (spec != null) {
          for (final s in kToothSurfaces) {
            final list = (spec.surface[s]?['fillings'] ?? const <String>[]) as List<String>;
            final hasCaries = list.any(isCariesCode);
            if (hasCaries) {
              miniFill[s] = SurfaceFill.cariesRed;
            } else if (list.isNotEmpty) {
              miniFill[s] = SurfaceFill.fillingBlue;
            }
          }
        }

// FDI → mesialOnRight (1,4,5,8군 true)
        bool mesialOnRightLocal(int f) {
          final q = f ~/ 10;
          return q == 1 || q == 4 || q == 5 || q == 8;
        }

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
                  onTap: () { if (!lockedOut) onTapTooth(fdi); },
                  onLongPress: () { if (!lockedOut) onLongPressTooth(fdi); },
                  child: _MiniToothTile(
                    fdi: fdi,
                    size: tile,
                    highlighted: hasAnyDetail,
                    isSelected: isSelectedNow,
                    // ✅ 면별 채우기 & 방향
                    miniFill: miniFill,
                    mesialOnRight: mesialOnRightLocal(fdi),

                    // 파란 마킹
                    markDenture: drawDentureSmall,
                    markAbut: ringAbutOrCrown,
                    markPontic: ponticOrMissing,

                    // 전역코드 마킹
                    ringCrown: ringCrown,
                    twoHorizontal: twoHorizontal,
                    oneVertical: oneVertical,
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
  final bool isSelected;

  // ✅ 각 면별 채우기 + 방향
  final Map<String, SurfaceFill> miniFill;
  final bool mesialOnRight;

  // 스팬/전역 마킹
  final bool markDenture;
  final bool markAbut;
  final bool markPontic;
  final bool ringCrown;
  final bool twoHorizontal;
  final bool oneVertical;

  const _MiniToothTile({
    required this.fdi,
    required this.size,
    this.highlighted = false,
    this.isSelected = false,
    required this.miniFill,
    required this.mesialOnRight,
    this.markDenture = false,
    this.markAbut = false,
    this.markPontic = false,
    this.ringCrown = false,
    this.twoHorizontal = false,
    this.oneVertical = false,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size.square(size),
      painter: _MiniFiveSurfacePainter(
        mesialOnRight: mesialOnRight,
        fill: miniFill,
        selected: isSelected,
        highlighted: highlighted,
        // 스팬/전역 마킹 전달
        abut: markAbut,
        pontic: markPontic,
        ringCrown: ringCrown,
        twoHorizontal: twoHorizontal,
        oneVertical: oneVertical,
      ),
    );
  }
}

class _MiniFiveSurfacePainter extends CustomPainter {
  final bool mesialOnRight;
  final Map<String, SurfaceFill> fill;
  final bool selected;
  final bool highlighted;
  final bool abut;
  final bool pontic;

  final bool ringCrown;     // crown → 링
  final bool twoHorizontal; // MIS* → 수평 2줄
  final bool oneVertical;   // IPX* → 수직 1줄

  _MiniFiveSurfacePainter({
    required this.mesialOnRight,
    required this.fill,
    required this.selected,
    required this.highlighted,
    this.abut = false,
    this.pontic = false,
    this.ringCrown = false,
    this.twoHorizontal = false,
    this.oneVertical = false,
  });

  @override
  void paint(Canvas canvas, Size s) {
    final g = _Geom(s);

    // 테두리/내부선
    final outerStroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = (s.width * .04).clamp(1.0, 2.0)
      ..color = highlighted ? Colors.deepPurple : Colors.black87;

    final innerStroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = (s.width * .032).clamp(0.8, 1.6)
      ..color = Colors.black54;

    // 선택 강조(초록)
    if (selected) {
      final selStroke = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = (s.width * .08).clamp(1.6, 3.2)
        ..color = Colors.green;
      canvas.drawRRect(g.outerRRect.deflate(1), selStroke);
    }

    Paint paintOf(SurfaceFill f) {
      switch (f) {
        case SurfaceFill.cariesRed:
          return Paint()..style = PaintingStyle.fill..color = Colors.red.withOpacity(.35);
        case SurfaceFill.fillingBlue:
          return Paint()..style = PaintingStyle.fill..color = Colors.blue.withOpacity(.28);
        case SurfaceFill.toggleAmber:
          return Paint()..style = PaintingStyle.fill..color = Colors.amber.withOpacity(.35);
        case SurfaceFill.none:
          return Paint()..style = PaintingStyle.stroke..color = Colors.transparent;
      }
    }

    // 면 채우기
    final l = fill['L'] ?? SurfaceFill.none;
    final b = fill['B'] ?? SurfaceFill.none;
    final o = fill['O'] ?? SurfaceFill.none;
    final m = fill['M'] ?? SurfaceFill.none;
    final d = fill['D'] ?? SurfaceFill.none;

    if (l != SurfaceFill.none) canvas.drawPath(g.pathL, paintOf(l));
    if (b != SurfaceFill.none) canvas.drawPath(g.pathB, paintOf(b));
    if (o != SurfaceFill.none) canvas.drawRect(g.rectO, paintOf(o));

    final leftFill  = mesialOnRight ? d : m;
    final rightFill = mesialOnRight ? m : d;
    if (leftFill  != SurfaceFill.none) canvas.drawPath(g.pathLeft,  paintOf(leftFill));
    if (rightFill != SurfaceFill.none) canvas.drawPath(g.pathRight, paintOf(rightFill));

    // 윤곽/내부선
    canvas.drawRRect(g.outerRRect, outerStroke);
    canvas.drawRect(g.rectO, innerStroke);

    final oc = [g.outerRect.topLeft, g.outerRect.topRight, g.outerRect.bottomRight, g.outerRect.bottomLeft];
    final ic = [g.rectO.topLeft, g.rectO.topRight, g.rectO.bottomRight, g.rectO.bottomLeft];
    for (int i = 0; i < 4; i++) {
      canvas.drawLine(ic[i], oc[i], innerStroke);
    }

    final blue = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = (s.width * .06).clamp(1.2, 2.4)
      ..color = Colors.blueAccent;

    // bridge 지대치 링
    if (abut) {
      final ring = g.outerRect.deflate(s.width * .22);
      canvas.drawRRect(RRect.fromRectAndRadius(ring, Radius.circular(ring.width * .2)), blue);
    }
    // bridge Pontic 수평 2줄
    if (pontic) {
      final y1 = s.height * .40, y2 = s.height * .60;
      canvas.drawLine(Offset(s.width * .18, y1), Offset(s.width * .82, y1), blue);
      canvas.drawLine(Offset(s.width * .18, y2), Offset(s.width * .82, y2), blue);
    }

    // ✅ 전역코드 마킹 3종
    if (ringCrown) {
      final ring = g.outerRect.deflate(s.width * .22);
      canvas.drawRRect(RRect.fromRectAndRadius(ring, Radius.circular(ring.width * .20)), blue);
    }
    if (twoHorizontal) {
      final y1 = s.height * .40, y2 = s.height * .60;
      canvas.drawLine(Offset(s.width * .18, y1), Offset(s.width * .82, y1), blue);
      canvas.drawLine(Offset(s.width * .18, y2), Offset(s.width * .82, y2), blue);
    }
    if (oneVertical) {
      final x = s.width * .50;
      canvas.drawLine(Offset(x, s.height * .20), Offset(x, s.height * .80), blue);
    }

    //브릿지 마킹
    if (abut) {
      final ring = g.outerRect.deflate(s.width * .22);
      canvas.drawRRect(RRect.fromRectAndRadius(ring, Radius.circular(ring.width * .2)), blue);
    }
    if (pontic) {
      final y1 = s.height * .40, y2 = s.height * .60;
      canvas.drawLine(Offset(s.width * .18, y1), Offset(s.width * .82, y1), blue);
      canvas.drawLine(Offset(s.width * .18, y2), Offset(s.width * .82, y2), blue);
    }
  }

  @override
  bool shouldRepaint(covariant _MiniFiveSurfacePainter old) {
    if (old.mesialOnRight != mesialOnRight ||
        old.selected != selected ||
        old.highlighted != highlighted ||
        old.abut != abut ||
        old.pontic != pontic ||
        old.ringCrown != ringCrown ||
        old.twoHorizontal != twoHorizontal ||
        old.oneVertical != oneVertical) return true;
    for (final k in kToothSurfaces) {
      if ((old.fill[k] ?? SurfaceFill.none) != (fill[k] ?? SurfaceFill.none)) return true;
    }
    return false;
  }
}

// 로컬 전용 지오메트리 헬퍼
class _Geom {
  late final Rect outerRect;
  late final RRect outerRRect;
  late final Rect rectO;
  late final Path pathL, pathB, pathLeft, pathRight;

  _Geom(Size s) {
    outerRect  = Offset.zero & s;
    outerRRect = RRect.fromRectAndRadius(
      outerRect.deflate(1),
      Radius.circular(s.width * .12),
    );

    final w = s.width, h = s.height;
    final rectW = w * .66;  // 중앙 가로 직사각형 비율(방패형)
    final rectH = h * .46;
    rectO = Rect.fromCenter(center: outerRect.center, width: rectW, height: rectH);

    pathL = Path()
      ..moveTo(outerRect.left, outerRect.top)
      ..lineTo(outerRect.right, outerRect.top)
      ..lineTo(rectO.right, rectO.top)
      ..lineTo(rectO.left,  rectO.top)
      ..close();

    pathB = Path()
      ..moveTo(outerRect.left,  outerRect.bottom)
      ..lineTo(outerRect.right, outerRect.bottom)
      ..lineTo(rectO.right,     rectO.bottom)
      ..lineTo(rectO.left,      rectO.bottom)
      ..close();

    pathLeft = Path()
      ..moveTo(outerRect.left,  outerRect.top)
      ..lineTo(rectO.left,      rectO.top)
      ..lineTo(rectO.left,      rectO.bottom)
      ..lineTo(outerRect.left,  outerRect.bottom)
      ..close();

    pathRight = Path()
      ..moveTo(outerRect.right, outerRect.top)
      ..lineTo(rectO.right,     rectO.top)
      ..lineTo(rectO.right,     rectO.bottom)
      ..lineTo(outerRect.right, outerRect.bottom)
      ..close();
  }
}

/// 방패연 + 스팬 미니 마킹(개별 타일 버전)
class _ShieldToothPainter extends CustomPainter {
  final bool highlighted;
  final bool selected;
  final bool denture;  // (지금은 항상 false로 넘어옴)
  final bool abut;     // 지대치
  final bool pontic;   // Pontic(수평 2줄)
  final bool fillRed;
  final bool fillBlue;

  // ▼ 전역코드 마킹
  final bool ringCrown;     // crown → 파란 링
  final bool twoHorizontal; // status(MIS*) → 수평 2줄
  final bool oneVertical;   // root(IPX*) → 수직 1줄

  _ShieldToothPainter({
    required this.highlighted,
    required this.selected,
    required this.denture,
    required this.abut,
    required this.pontic,
    this.fillRed = false,
    this.fillBlue = false,
    this.ringCrown = false,
    this.twoHorizontal = false,
    this.oneVertical = false,
  });

  @override
  void paint(Canvas canvas, Size s) {
    final outerRect = Offset.zero & s;
    final rrect = RRect.fromRectAndRadius(
      outerRect.deflate(1),
      Radius.circular(s.width * .12),
    );

    final strokeW = (s.width * .04).clamp(1.0, 2.0);
    final stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeW
      ..color = highlighted ? Colors.deepPurple : Colors.black87;

    final innerStroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = (s.width * .032).clamp(0.8, 1.6)
      ..color = Colors.black54;

    // 선택 강조
    if (selected) {
      final selStroke = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = (s.width * .08).clamp(1.6, 3.2)
        ..color = Colors.green;
      canvas.drawRRect(rrect.deflate(1), selStroke);
    }

    // 외곽 방패
    canvas.drawRRect(rrect, stroke);

    // 중앙 직사각 & 요약 면 칠
    final w = s.width, h = s.height;
    final rectW = w * .66;
    final rectH = h * .46;
    final mid = Rect.fromCenter(center: outerRect.center, width: rectW, height: rectH);

    if (fillRed || fillBlue) {
      final fillPaint = Paint()
        ..style = PaintingStyle.fill
        ..color = (fillRed ? Colors.red : Colors.blue).withOpacity(.28);
      canvas.drawRect(mid, fillPaint);
    }
    canvas.drawRect(mid, innerStroke);

    // 대각선
    final oc = [outerRect.topLeft, outerRect.topRight, outerRect.bottomRight, outerRect.bottomLeft];
    final ic = [mid.topLeft, mid.topRight, mid.bottomRight, mid.bottomLeft];
    for (int i = 0; i < 4; i++) {
      canvas.drawLine(ic[i], oc[i], innerStroke);
    }

    // ── 파란 마킹(스팬/전역) ───────────────────
    final blue = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = (s.width * .06).clamp(1.2, 2.4)
      ..color = Colors.blueAccent;

    // denture(미니 링은 현재 미사용) — denture는 아치 오버레이로만
    if (denture) {
      final oval = outerRect.deflate(s.width * .18);
      canvas.drawOval(oval, blue);
    }

    // bridge 지대치 링
    if (abut) {
      final ring = outerRect.deflate(s.width * .22);
      canvas.drawRRect(RRect.fromRectAndRadius(ring, Radius.circular(ring.width * .2)), blue);
    }

    // bridge Pontic 수평 2줄
    if (pontic) {
      final y1 = s.height * .40, y2 = s.height * .60;
      canvas.drawLine(Offset(s.width * .18, y1), Offset(s.width * .82, y1), blue);
      canvas.drawLine(Offset(s.width * .18, y2), Offset(s.width * .82, y2), blue);
    }

    // ▼ 전역코드 마킹 3종
    // crown → 파란 링
    if (ringCrown) {
      final ring = outerRect.deflate(s.width * .22);
      canvas.drawRRect(RRect.fromRectAndRadius(ring, Radius.circular(ring.width * .20)), blue);
    }

    // status(MIS*) → 수평 2줄
    if (twoHorizontal) {
      final y1 = s.height * .40, y2 = s.height * .60;
      canvas.drawLine(Offset(s.width * .18, y1), Offset(s.width * .82, y1), blue);
      canvas.drawLine(Offset(s.width * .18, y2), Offset(s.width * .82, y2), blue);
    }

    // root(IPX*) → 수직 1줄
    if (oneVertical) {
      final x = s.width * .50;
      canvas.drawLine(Offset(x, s.height * .20), Offset(x, s.height * .80), blue);
    }
  }

  @override
  bool shouldRepaint(covariant _ShieldToothPainter old) =>
      old.highlighted != highlighted ||
          old.selected != selected ||
          old.denture != denture ||
          old.abut != abut ||
          old.pontic != pontic ||
          old.fillRed != fillRed ||
          old.fillBlue != fillBlue ||
          old.ringCrown != ringCrown ||
          old.twoHorizontal != twoHorizontal ||
          old.oneVertical != oneVertical;
}