import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/dental_data_provider.dart';
import '../widgets/common_app_bar.dart';
import 'address_search_screen.dart';
import '../widgets/custom_bottom_nav_bar.dart';

class RecordSetupScreen extends StatefulWidget {
  const RecordSetupScreen({super.key});

  @override
  State<RecordSetupScreen> createState() => _RecordSetupScreenState();
}

class _RecordSetupScreenState extends State<RecordSetupScreen> {
  final TextEditingController _placeCtrl = TextEditingController();

  final List<String> disasterTypes = const [
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

  @override
  void dispose() {
    _placeCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<DentalDataProvider>();
    final locked = provider.incidentLockEnabled;

    // 잠금 시 고정값, 아니면 입력값
    _placeCtrl.text = provider.placeForUi;

    return Scaffold(
      appBar: const CommonAppBar(title: "기록 설정"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (locked)
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.amber.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.amber),
                ),
                child: Text(
                  "대형 사건 모드: Place='${provider.lockedPlace}', Nature='${provider.lockedNature}' 로 고정.",
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ),

            // 1) Record Type (PM/AM) 선택
            Text("Record Type", style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(height: 6),
            SegmentedButton<String>(
              segments: const [
                ButtonSegment(value: 'PM', label: Text('Post-mortem (PM)'), icon: Icon(Icons.person_off)),
                ButtonSegment(value: 'AM', label: Text('Ante-mortem (AM)'), icon: Icon(Icons.person)),
              ],
              selected: {provider.recordType},
              onSelectionChanged: (sel) => provider.updateRecordType(sel.first),
            ),
            const SizedBox(height: 16),

            // 2) Place of Disaster
            GestureDetector(
              onTap: locked ? null : () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => AddressSearchScreen()),
                );
                if (result is String) provider.updatePlace(result);
              },
              child: AbsorbPointer(
                child: TextField(
                  controller: _placeCtrl,
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: "Place of Disaster",
                    suffixIcon: Icon(locked ? Icons.lock : Icons.search),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),

            // 3) Nature of Disaster
            DropdownButtonFormField<String>(
              value: provider.natureForUi.isEmpty ? null : provider.natureForUi,
              decoration: InputDecoration(
                labelText: "Nature of Disaster",
                suffixIcon: Icon(locked ? Icons.lock : Icons.arrow_drop_down),
              ),
              items: disasterTypes.map((t) => DropdownMenuItem(value: t, child: Text(t))).toList(),
              onChanged: locked ? null : (val) => provider.updateNature(val ?? ''),
            ),

            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.arrow_forward),
                label: const Text("다음"),
                onPressed: () {
                  // 여기서는 검증 없이 다음 단계로
                  Navigator.pushReplacementNamed(context, '/record');
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 0),
    );
  }
}
