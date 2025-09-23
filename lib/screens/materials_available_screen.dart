// import 'package:flutter/material.dart';
//
// class MaterialsAvailableScreen extends StatefulWidget {
//   final Map<String, dynamic> arguments;
//
//   MaterialsAvailableScreen({required this.arguments});
//
//   @override
//   _MaterialsAvailableScreenState createState() =>
//       _MaterialsAvailableScreenState();
// }
//
// class _MaterialsAvailableScreenState extends State<MaterialsAvailableScreen> {
//   // Jaws with teeth
//   bool upperJawWithTeeth = false;
//   bool lowerJawWithTeeth = false;
//
//   // Jaws without teeth
//   bool upperJawWithoutTeeth = false;
//   bool lowerJawWithoutTeeth = false;
//
//   // Teeth only (FDI Numbers)
//   final TextEditingController teethOnlyController = TextEditingController();
//
//   // Fragments
//   bool fragments = false;
//
//   // Other
//   final TextEditingController otherMaterialsController =
//   TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("610: Materials Available"),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Jaws with Teeth
//               const Text(
//                 "Jaws with Teeth",
//                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
//               ),
//               Row(
//                 children: [
//                   Checkbox(
//                     value: upperJawWithTeeth,
//                     onChanged: (value) {
//                       setState(() {
//                         upperJawWithTeeth = value ?? false;
//                       });
//                     },
//                   ),
//                   const Text("Upper Jaw"),
//                   const SizedBox(width: 20),
//                   Checkbox(
//                     value: lowerJawWithTeeth,
//                     onChanged: (value) {
//                       setState(() {
//                         lowerJawWithTeeth = value ?? false;
//                       });
//                     },
//                   ),
//                   const Text("Lower Jaw"),
//                 ],
//               ),
//               const SizedBox(height: 20),
//
//               // Jaws without Teeth
//               const Text(
//                 "Jaws without Teeth",
//                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
//               ),
//               Row(
//                 children: [
//                   Checkbox(
//                     value: upperJawWithoutTeeth,
//                     onChanged: (value) {
//                       setState(() {
//                         upperJawWithoutTeeth = value ?? false;
//                       });
//                     },
//                   ),
//                   const Text("Upper Jaw"),
//                   const SizedBox(width: 20),
//                   Checkbox(
//                     value: lowerJawWithoutTeeth,
//                     onChanged: (value) {
//                       setState(() {
//                         lowerJawWithoutTeeth = value ?? false;
//                       });
//                     },
//                   ),
//                   const Text("Lower Jaw"),
//                 ],
//               ),
//               const SizedBox(height: 20),
//
//               // Teeth only
//               const Text(
//                 "Teeth Only",
//                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
//               ),
//               TextField(
//                 controller: teethOnlyController,
//                 keyboardType: TextInputType.number,
//                 decoration: const InputDecoration(
//                   labelText: "Enter FDI Numbers (e.g., 11, 12, 13)",
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//               const SizedBox(height: 20),
//
//               // Fragments
//               const Text(
//                 "Fragments",
//                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
//               ),
//               Row(
//                 children: [
//                   Checkbox(
//                     value: fragments,
//                     onChanged: (value) {
//                       setState(() {
//                         fragments = value ?? false;
//                       });
//                     },
//                   ),
//                   const Text("Available"),
//                 ],
//               ),
//               const SizedBox(height: 20),
//
//               // Other
//               const Text(
//                 "Other",
//                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
//               ),
//               TextField(
//                 controller: otherMaterialsController,
//                 decoration: const InputDecoration(
//                   labelText: "Specify Other Materials",
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//               const SizedBox(height: 40),
//
//               // Navigation buttons
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   ElevatedButton(
//                     onPressed: _goToPreviousScreen,
//                     child: const Text("이전"),
//                   ),
//                   ElevatedButton(
//                     onPressed: _goToNextScreen,
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
//   void _goToPreviousScreen() {
//     Navigator.pop(context); // RecordScreen으로 돌아가기
//   }
//
//   void _goToNextScreen() {
//     final selectedData = {
//       'upperJawWithTeeth': upperJawWithTeeth,
//       'lowerJawWithTeeth': lowerJawWithTeeth,
//       'upperJawWithoutTeeth': upperJawWithoutTeeth,
//       'lowerJawWithoutTeeth': lowerJawWithoutTeeth,
//       'teethOnly': teethOnlyController.text.trim(),
//       'fragments': fragments,
//       'other': otherMaterialsController.text.trim(),
//     };
//
//     Navigator.pushNamed(context, '/dentalImages', arguments: selectedData);
//   }
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/dental_data_provider.dart';
import '../widgets/custom_bottom_nav_bar.dart';
import '../widgets/common_app_bar.dart';

class MaterialsAvailableScreen extends StatefulWidget {
  @override
  _MaterialsAvailableScreenState createState() => _MaterialsAvailableScreenState();
}

class _MaterialsAvailableScreenState extends State<MaterialsAvailableScreen> {
  final TextEditingController teethOnlyController = TextEditingController();
  final TextEditingController otherMaterialsController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<DentalDataProvider>(context, listen: false);
    teethOnlyController.text = provider.teethOnly;
    otherMaterialsController.text = provider.otherMaterials;
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DentalDataProvider>(context);

    return Scaffold(
      appBar: const CommonAppBar(
        title: "610 : Materials Available",
        showRecordBadge: true, // ✅ 켬
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Jaws with Teeth", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              Row(
                children: [
                  Checkbox(
                    value: provider.upperJawWithTeeth,
                    onChanged: (value) => provider.setEachMaterial(upperWith: value),
                  ),
                  const Text("Upper Jaw"),
                  const SizedBox(width: 20),
                  Checkbox(
                    value: provider.lowerJawWithTeeth,
                    onChanged: (value) => provider.setEachMaterial(lowerWith: value),
                  ),
                  const Text("Lower Jaw"),
                ],
              ),
              const SizedBox(height: 20),

              const Text("Jaws without Teeth", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              Row(
                children: [
                  Checkbox(
                    value: provider.upperJawWithoutTeeth,
                    onChanged: (value) => provider.setEachMaterial(upperWithout: value),
                  ),
                  const Text("Upper Jaw"),
                  const SizedBox(width: 20),
                  Checkbox(
                    value: provider.lowerJawWithoutTeeth,
                    onChanged: (value) => provider.setEachMaterial(lowerWithout: value),
                  ),
                  const Text("Lower Jaw"),
                ],
              ),
              const SizedBox(height: 20),

              const Text("Teeth Only", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              TextField(
                controller: teethOnlyController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  labelText: "Enter FDI Numbers (e.g., 11, 12, 13)",
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) => provider.setEachMaterial(teethText: value),
              ),
              const SizedBox(height: 20),

              const Text("Fragments", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              Row(
                children: [
                  Checkbox(
                    value: provider.fragments,
                    onChanged: (value) => provider.setEachMaterial(hasFragments: value),
                  ),
                  const Text("Available"),
                ],
              ),
              const SizedBox(height: 20),

              const Text("Other", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              TextField(
                controller: otherMaterialsController,
                decoration: const InputDecoration(
                  labelText: "Specify Other Materials",
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) => provider.setEachMaterial(otherText: value),
              ),
              const SizedBox(height: 40),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () => Navigator.pushReplacementNamed(context, '/record'),
                    child: const Text("이전"),
                  ),
                  ElevatedButton(
                    onPressed: () => Navigator.pushReplacementNamed(context, '/dentalImages'),
                    child: const Text("다음"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(currentIndex: 0),
    );
  }
}
