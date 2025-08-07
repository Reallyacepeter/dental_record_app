// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// class ViewScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("조회"),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: StreamBuilder<QuerySnapshot>(
//           stream: FirebaseFirestore.instance
//               .collection('disasterDetails')
//               .orderBy('savedAt', descending: true)
//               .snapshots(),
//           builder: (context, snapshot) {
//             if (!snapshot.hasData) {
//               return const Center(child: CircularProgressIndicator());
//             }
//
//             final documents = snapshot.data!.docs;
//
//             if (documents.isEmpty) {
//               return const Center(child: Text("No records found."));
//             }
//
//             return ListView.builder(
//               itemCount: documents.length,
//               itemBuilder: (context, index) {
//                 final data = documents[index].data() as Map<String, dynamic>;
//                 return ListTile(
//                   title: Text(data['placeOfDisaster'] ?? 'Unknown'),
//                   subtitle: Text(data['dateOfDisaster'] ?? 'Unknown'),
//                   onTap: () {
//                     // 상세화면 또는 수정화면으로 이동
//                     Navigator.pushNamed(context, '/record', arguments: data);
//                   },
//                 );
//               },
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:provider/provider.dart';
// import '../providers/dental_data_provider.dart';
// import '../widgets/custom_bottom_nav_bar.dart';
//
// class ViewScreen extends StatefulWidget {
//   const ViewScreen({super.key});
//
//   @override
//   State<ViewScreen> createState() => _ViewScreenState();
// }
//
// class _ViewScreenState extends State<ViewScreen> {
//   final TextEditingController pmNumberController = TextEditingController();
//   final TextEditingController placeController = TextEditingController();
//   List<Map<String, dynamic>> searchResults = [];
//   bool isLoading = false;
//
//   void searchDocuments() async {
//     setState(() => isLoading = true);
//
//     Query query = FirebaseFirestore.instance.collection('dental_data');
//
//     if (pmNumberController.text.isNotEmpty) {
//       query = query.where('pmNumber', isEqualTo: pmNumberController.text);
//     }
//
//     if (placeController.text.isNotEmpty) {
//       query = query.where('placeOfDisaster', isEqualTo: placeController.text);
//     }
//
//     try {
//       final snapshot = await query.get();
//       final docs = snapshot.docs.map((e) => e.data() as Map<String, dynamic>).toList();
//       setState(() {
//         searchResults = docs;
//         isLoading = false;
//       });
//     } catch (e) {
//       setState(() => isLoading = false);
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('검색 오류: $e')));
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("기록 조회")),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             TextField(
//               controller: pmNumberController,
//               decoration: const InputDecoration(labelText: "PM 번호"),
//             ),
//             const SizedBox(height: 8),
//             TextField(
//               controller: placeController,
//               decoration: const InputDecoration(labelText: "재난 장소"),
//             ),
//             const SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: searchDocuments,
//               child: const Text("검색"),
//             ),
//             const SizedBox(height: 16),
//             if (isLoading) const CircularProgressIndicator(),
//             if (!isLoading)
//               Expanded(
//                 child: searchResults.isEmpty
//                     ? const Text("결과가 없습니다.")
//                     : ListView.builder(
//                   itemCount: searchResults.length,
//                   itemBuilder: (context, index) {
//                     final data = searchResults[index];
//                     return Card(
//                       child: ListTile(
//                         title: Text("PM 번호: ${data['pmNumber'] ?? '없음'}"),
//                         subtitle: Text("재난 장소: ${data['placeOfDisaster'] ?? '없음'}\n성별: ${data['gender'] ?? '없음'}"),
//                         isThreeLine: true,
//                       ),
//                     );
//                   },
//                 ),
//               ),
//           ],
//         ),
//       ),
//       bottomNavigationBar: const CustomBottomNavBar(currentIndex: 1),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import '../providers/dental_data_provider.dart';
import '../widgets/custom_bottom_nav_bar.dart';
import 'final_review_screen_readonly.dart';
import 'address_search_screen.dart';

class ViewScreen extends StatefulWidget {
  const ViewScreen({super.key});

  @override
  State<ViewScreen> createState() => _ViewScreenState();
}

class _ViewScreenState extends State<ViewScreen> {
  String? selectedPlace;
  String? selectedNature;
  String? pmNumber;
  DateTime? selectedDate;
  int? ageMin;
  int? ageMax;

  final List<String> disasterTypes = [
    "Earthquake",
    "Flood",
    "Tsunami",
    "Wildfire",
    "Hurricane / Typhoon",
    "Fire",
    "Building Collapse",
    "Transportation Accident",
    "Industrial / Chemical Accident",
    "Other"
  ];

  List<QueryDocumentSnapshot> results = [];
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("데이터 조회")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            GestureDetector(
              onTap: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => AddressSearchScreen()),
                );
                if (result is String) {
                  setState(() => selectedPlace = result);
                }
              },
              child: AbsorbPointer(
                child: TextField(
                  controller: TextEditingController(text: selectedPlace),
                  decoration: const InputDecoration(
                    labelText: "재난 장소",
                    suffixIcon: Icon(Icons.search),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: selectedNature,
              decoration: const InputDecoration(labelText: "재난 유형"),
              items: disasterTypes
                  .map((type) => DropdownMenuItem(value: type, child: Text(type)))
                  .toList(),
              onChanged: (value) => setState(() => selectedNature = value),
            ),
            const SizedBox(height: 8),
            TextField(
              decoration: const InputDecoration(labelText: "PM 번호"),
              onChanged: (val) => setState(() => pmNumber = val),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Text(
                  selectedDate == null
                      ? "날짜 선택 안됨"
                      : "날짜: ${selectedDate!.toLocal().toString().split(' ')[0]}",
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: () async {
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: selectedDate ?? DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );
                    if (picked != null) setState(() => selectedDate = picked);
                  },
                  child: const Text("날짜 선택"),
                )
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(labelText: "최소 나이"),
                    keyboardType: TextInputType.number,
                    onChanged: (val) => setState(() => ageMin = int.tryParse(val)),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(labelText: "최대 나이"),
                    keyboardType: TextInputType.number,
                    onChanged: (val) => setState(() => ageMax = int.tryParse(val)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _search,
              child: const Text("검색"),
            ),
            const SizedBox(height: 20),
            if (isLoading)
              const CircularProgressIndicator()
            else if (results.isNotEmpty)
              ...results.map((doc) {
                final data = doc.data() as Map<String, dynamic>;
                return Card(
                  child: ListTile(
                    title: Text("PM No: ${data['pmNumber'] ?? ''}"),
                    subtitle: Text(
                      "장소: ${data['placeOfDisaster'] ?? ''}, 날짜: ${(data['dateOfDisaster'] as String?)?.split('T')[0] ?? ''}",
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => FinalReviewScreenReadOnly(data: data),
                      ),
                    ),
                  ),
                );
              }),
            if (!isLoading && results.isEmpty)
              const Text("검색 결과가 없습니다."),
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 1),
    );
  }

  Future<void> _search() async {
    setState(() {
      isLoading = true;
      results = [];
    });

    final querySnapshot =
    await FirebaseFirestore.instance.collection('dental_data').get();

    final filtered = querySnapshot.docs.where((doc) {
      final data = doc.data();
      bool match = true;

      if (selectedPlace != null && selectedPlace!.isNotEmpty) {
        match &= data['placeOfDisaster'] == selectedPlace;
      }
      if (selectedNature != null && selectedNature!.isNotEmpty) {
        match &= data['natureOfDisaster'] == selectedNature;
      }
      if (pmNumber != null && pmNumber!.isNotEmpty) {
        match &= data['pmNumber'] == pmNumber;
      }
      if (selectedDate != null) {
        final dataDate = DateTime.tryParse(data['dateOfDisaster'] ?? '');
        match &= dataDate?.toLocal().toString().split(' ')[0] ==
            selectedDate!.toLocal().toString().split(' ')[0];
      }
      if (ageMin != null || ageMax != null) {
        final int? itemMin = data['ageMin'];
        final int? itemMax = data['ageMax'];
        if (itemMin != null && itemMax != null) {
          match &= (ageMin == null || itemMax >= ageMin!) &&
              (ageMax == null || itemMin <= ageMax!);
        } else {
          match = false;
        }
      }

      return match;
    }).toList();

    setState(() {
      results = filtered;
      isLoading = false;
    });
  }
}
