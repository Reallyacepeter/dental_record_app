// import 'package:flutter/material.dart';
//
// class SupplementaryDetailsScreen extends StatefulWidget {
//   final Map<String, dynamic> arguments;
//
//   SupplementaryDetailsScreen({required this.arguments});
//
//   @override
//   _SupplementaryDetailsScreenState createState() => _SupplementaryDetailsScreenState();
// }
//
// class _SupplementaryDetailsScreenState extends State<SupplementaryDetailsScreen> {
//   final TextEditingController conditionOfJawsController = TextEditingController();
//   final TextEditingController otherDetailsController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Supplementary Details"),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text(
//               "01 턱 상태",
//               style: TextStyle(fontWeight: FontWeight.bold),
//             ),
//             TextField(
//               controller: conditionOfJawsController,
//               decoration: const InputDecoration(
//                 hintText: "턱 상태를 입력하세요",
//               ),
//             ),
//             const SizedBox(height: 16),
//             const Text(
//               "02 기타 세부 사항",
//               style: TextStyle(fontWeight: FontWeight.bold),
//             ),
//             TextField(
//               controller: otherDetailsController,
//               decoration: const InputDecoration(
//                 hintText: "기타 세부 사항을 입력하세요",
//               ),
//             ),
//             const SizedBox(height: 16),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 ElevatedButton(
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                   child: const Text("이전"),
//                 ),
//                 ElevatedButton(
//                   onPressed: _goToDentalFindingsScreen,
//                   child: const Text("다음"),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   void _goToDentalFindingsScreen() {
//     // 기존 데이터를 유지하면서 새 데이터를 추가
//     final supplementaryDetails = {
//       ...widget.arguments, // 이전 화면에서 전달받은 데이터 유지
//       'conditionOfJaws': conditionOfJawsController.text,
//       'otherDetails': otherDetailsController.text,
//     };
//
//     Navigator.pushNamed(context, '/dentalFindings', arguments: supplementaryDetails);
//   }
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/dental_data_provider.dart';
import '../widgets/common_app_bar.dart';
import '../widgets/custom_bottom_nav_bar.dart';

class SupplementaryDetailsScreen extends StatefulWidget {
  @override
  _SupplementaryDetailsScreenState createState() => _SupplementaryDetailsScreenState();
}

class _SupplementaryDetailsScreenState extends State<SupplementaryDetailsScreen> {
  final TextEditingController conditionOfJawsController = TextEditingController();
  final TextEditingController otherDetailsController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<DentalDataProvider>(context, listen: false);
    conditionOfJawsController.text = provider.conditionOfJaws;
    otherDetailsController.text = provider.otherDetails;
  }

  @override
  void dispose() {
    conditionOfJawsController.dispose();
    otherDetailsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DentalDataProvider>(context);

    return Scaffold(
      appBar: const CommonAppBar(
        title: "625 : Supplementary Details",
        showRecordBadge: true, // ✅ 켬
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "01 턱 상태",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: conditionOfJawsController,
              decoration: const InputDecoration(
                hintText: "턱 상태를 입력하세요",
              ),
              onChanged: provider.setConditionOfJaws,
            ),
            const SizedBox(height: 16),
            const Text(
              "02 기타 세부 사항",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: otherDetailsController,
              decoration: const InputDecoration(
                hintText: "기타 세부 사항을 입력하세요",
              ),
              onChanged: provider.setOtherDetails,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () => Navigator.pushReplacementNamed(context, '/dentalImages'),
                  child: const Text("이전"),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.pushReplacementNamed(context, '/dentalFindings'),
                  child: const Text("다음"),
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
