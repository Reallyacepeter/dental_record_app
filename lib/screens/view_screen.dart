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

// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:provider/provider.dart';
// import '../providers/dental_data_provider.dart';
// import '../widgets/custom_bottom_nav_bar.dart';
// import 'final_review_screen_readonly.dart';
// import 'address_search_screen.dart';
//
// class ViewScreen extends StatefulWidget {
//   const ViewScreen({super.key});
//
//   @override
//   State<ViewScreen> createState() => _ViewScreenState();
// }
//
// class _ViewScreenState extends State<ViewScreen> {
//   String? selectedPlace;
//   String? selectedNature;
//   String? pmNumber;
//   DateTime? selectedDate;
//   int? ageMin;
//   int? ageMax;
//
//   final List<String> disasterTypes = [
//     "Earthquake",
//     "Flood",
//     "Tsunami",
//     "Wildfire",
//     "Hurricane / Typhoon",
//     "Fire",
//     "Building Collapse",
//     "Transportation Accident",
//     "Industrial / Chemical Accident",
//     "Other"
//   ];
//
//   List<QueryDocumentSnapshot> results = [];
//   bool isLoading = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("데이터 조회")),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             GestureDetector(
//               onTap: () async {
//                 final result = await Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (_) => AddressSearchScreen()),
//                 );
//                 if (result is String) {
//                   setState(() => selectedPlace = result);
//                 }
//               },
//               child: AbsorbPointer(
//                 child: TextField(
//                   controller: TextEditingController(text: selectedPlace),
//                   decoration: const InputDecoration(
//                     labelText: "재난 장소",
//                     suffixIcon: Icon(Icons.search),
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 8),
//             DropdownButtonFormField<String>(
//               value: selectedNature,
//               decoration: const InputDecoration(labelText: "재난 유형"),
//               items: disasterTypes
//                   .map((type) => DropdownMenuItem(value: type, child: Text(type)))
//                   .toList(),
//               onChanged: (value) => setState(() => selectedNature = value),
//             ),
//             const SizedBox(height: 8),
//             TextField(
//               decoration: const InputDecoration(labelText: "PM 번호"),
//               onChanged: (val) => setState(() => pmNumber = val),
//             ),
//             const SizedBox(height: 8),
//             Row(
//               children: [
//                 Text(
//                   selectedDate == null
//                       ? "날짜 선택 안됨"
//                       : "날짜: ${selectedDate!.toLocal().toString().split(' ')[0]}",
//                 ),
//                 const Spacer(),
//                 ElevatedButton(
//                   onPressed: () async {
//                     final picked = await showDatePicker(
//                       context: context,
//                       initialDate: selectedDate ?? DateTime.now(),
//                       firstDate: DateTime(2000),
//                       lastDate: DateTime(2100),
//                     );
//                     if (picked != null) setState(() => selectedDate = picked);
//                   },
//                   child: const Text("날짜 선택"),
//                 )
//               ],
//             ),
//             const SizedBox(height: 8),
//             Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     decoration: const InputDecoration(labelText: "최소 나이"),
//                     keyboardType: TextInputType.number,
//                     onChanged: (val) => setState(() => ageMin = int.tryParse(val)),
//                   ),
//                 ),
//                 const SizedBox(width: 10),
//                 Expanded(
//                   child: TextField(
//                     decoration: const InputDecoration(labelText: "최대 나이"),
//                     keyboardType: TextInputType.number,
//                     onChanged: (val) => setState(() => ageMax = int.tryParse(val)),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: _search,
//               child: const Text("검색"),
//             ),
//             const SizedBox(height: 20),
//             if (isLoading)
//               const CircularProgressIndicator()
//             else if (results.isNotEmpty)
//               ...results.map((doc) {
//                 final data = doc.data() as Map<String, dynamic>;
//                 return Card(
//                   child: ListTile(
//                     title: Text("PM No: ${data['pmNumber'] ?? ''}"),
//                     subtitle: Text(
//                       "장소: ${data['placeOfDisaster'] ?? ''}, 날짜: ${(data['dateOfDisaster'] as String?)?.split('T')[0] ?? ''}",
//                     ),
//                     trailing: const Icon(Icons.arrow_forward_ios),
//                     onTap: () => Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (_) => FinalReviewScreenReadOnly(data: data),
//                       ),
//                     ),
//                   ),
//                 );
//               }),
//             if (!isLoading && results.isEmpty)
//               const Text("검색 결과가 없습니다."),
//           ],
//         ),
//       ),
//       bottomNavigationBar: const CustomBottomNavBar(currentIndex: 1),
//     );
//   }
//
//   Future<void> _search() async {
//     setState(() {
//       isLoading = true;
//       results = [];
//     });
//
//     final querySnapshot =
//     await FirebaseFirestore.instance.collection('dental_data').get();
//
//     final filtered = querySnapshot.docs.where((doc) {
//       final data = doc.data();
//       bool match = true;
//
//       if (selectedPlace != null && selectedPlace!.isNotEmpty) {
//         match &= data['placeOfDisaster'] == selectedPlace;
//       }
//       if (selectedNature != null && selectedNature!.isNotEmpty) {
//         match &= data['natureOfDisaster'] == selectedNature;
//       }
//       if (pmNumber != null && pmNumber!.isNotEmpty) {
//         match &= data['pmNumber'] == pmNumber;
//       }
//       if (selectedDate != null) {
//         final dataDate = DateTime.tryParse(data['dateOfDisaster'] ?? '');
//         match &= dataDate?.toLocal().toString().split(' ')[0] ==
//             selectedDate!.toLocal().toString().split(' ')[0];
//       }
//       if (ageMin != null || ageMax != null) {
//         final int? itemMin = data['ageMin'];
//         final int? itemMax = data['ageMax'];
//         if (itemMin != null && itemMax != null) {
//           match &= (ageMin == null || itemMax >= ageMin!) &&
//               (ageMax == null || itemMin <= ageMax!);
//         } else {
//           match = false;
//         }
//       }
//
//       return match;
//     }).toList();
//
//     setState(() {
//       results = filtered;
//       isLoading = false;
//     });
//   }
// }

import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/custom_bottom_nav_bar.dart';
import 'final_review_screen_readonly.dart';
import 'address_search_screen.dart';

import 'package:firebase_auth/firebase_auth.dart';
import '../services/local_store.dart';

class ViewScreen extends StatefulWidget {
  const ViewScreen({super.key});

  @override
  State<ViewScreen> createState() => _ViewScreenState();
}

class _ViewScreenState extends State<ViewScreen> {

  List<Map<String, dynamic>> _pending = [];
  bool _syncing = false;

  final int _pageSize = 50; // 페이지 크기(원하면 30~100 사이로 조정)
  DocumentSnapshot<Map<String, dynamic>>? _lastDoc;
  bool _hasMore = true;
  bool _isLoadingMore = false;

  // --------------------------
  // Filters (UI state)
  // --------------------------
  String? selectedPlace;                 // 자유 입력(주소 검색 결과)
  final Set<String> selectedNatures = {}; // 다중 선택(고정 목록)
  String? pmNumber;

  DateTime? startDate; // 날짜 범위
  DateTime? endDate;

  int? ageMin;
  int? ageMax;

  String? selectedGender;     // "Male", "Female", "Unknown"
  String? selectedRecordType; // "PM" | "AM" | null

  bool requireCT = false;
  bool requireOPG = false;
  bool requirePA = false;
  bool requireBW = false;
  bool requireHasFiles = false;

  // Sorting
  String sortKey = 'date'; // 'date'|'pm'|'place'|'nature'|'ageMin'|'ageMax'
  bool sortDesc = true;

  // Expansion state
  bool filterExpanded = true;
  bool sortExpanded = false;
  bool recentExpanded = false;

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

  final List<String> genders = const ['Male', 'Female', 'Unknown'];
  final List<String> recordTypes = const ['PM', 'AM'];

  List<QueryDocumentSnapshot<Map<String, dynamic>>> results = [];
  bool isLoading = false;

  // Recent searches (presets)
  static const _prefsKeyRecent = 'view_recent_searches_v2';
  List<_SearchPreset> recentPresets = []; // latest first

  // --------------------------
  // Helpers
  // --------------------------
  String _norm(String? s) => (s ?? '').trim().toLowerCase();

  /// YYYY-MM-DD 문자열로 변환 (Firestore Timestamp/ISO String 모두 대응)
  String? _toDateYMD(dynamic raw) {
    if (raw == null) return null;
    DateTime? dt;
    if (raw is Timestamp) {
      dt = raw.toDate();
    } else if (raw is String && raw.isNotEmpty) {
      dt = DateTime.tryParse(raw);
    }
    if (dt == null) return null;
    return dt.toLocal().toString().split(' ').first; // YYYY-MM-DD
  }

  int? _asInt(dynamic v) {
    if (v == null) return null;
    if (v is int) return v;
    if (v is double) return v.toInt();
    if (v is String) return int.tryParse(v);
    return null;
  }

  bool _asBool(dynamic v) {
    if (v is bool) return v;
    if (v is num) return v != 0;
    if (v is String) {
      final t = v.toLowerCase();
      return t == 'true' || t == '1' || t == 'yes';
    }
    return false;
  }

  bool _hasAnyFiles(dynamic val) {
    if (val == null) return false;
    if (val is List) return val.isNotEmpty; // List<String> or List<Map>
    return false;
  }

  @override
  void initState() {
    super.initState();
    _loadRecentPresets();
    _refreshPending(); // 시작 시 대기 건수 로드
  }

  Future<void> _refreshPending() async {
    _pending = await LocalStore.loadPendingSubmissions();
    if (mounted) setState(() {});
  }

  bool get _onlineAndAuthed {
    try {
      return Firebase.apps.isNotEmpty && FirebaseAuth.instance.currentUser != null;
    } catch (_) {
      return false;
    }
  }


  Future<void> _syncPendingNow() async {
    if (!_onlineAndAuthed) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('온라인/로그인 상태에서만 동기화됩니다.')),
      );
      return;
    }
    setState(() => _syncing = true);
    final list = List<Map<String, dynamic>>.from(_pending);
    int ok = 0;
    for (final e in list) {
      final id = (e['id'] ?? '').toString();
      final data = Map<String, dynamic>.from(e['data'] as Map);
      try {
        await FirebaseFirestore.instance.collection('dental_data').add(data);
        await LocalStore.removePendingSubmission(id);
        ok++;
      } catch (_) {
        // 실패 항목은 남겨둠
      }
    }
    await _refreshPending();
    setState(() => _syncing = false);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('동기화 완료: $ok/${list.length}건')),
    );
  }

  Future<void> _loadRecentPresets() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getStringList(_prefsKeyRecent) ?? const [];
    final list = <_SearchPreset>[];
    for (final s in raw) {
      try {
        final map = jsonDecode(s) as Map<String, dynamic>;
        list.add(_SearchPreset.fromMap(map));
      } catch (_) {}
    }
    setState(() => recentPresets = list);
  }

  Future<void> _saveCurrentAsPreset() async {
    final preset = _SearchPreset(
      createdAt: DateTime.now(),
      state: _currentStateToMap(),
    );

    final jsonStr = jsonEncode(preset.toMap());
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(_prefsKeyRecent) ?? <String>[];

    // de-dup by content
    final filtered = list.where((e) {
      try {
        final m = jsonDecode(e) as Map<String, dynamic>;
        final exist = _SearchPreset.fromMap(m);
        return jsonEncode(exist.state) != jsonEncode(preset.state);
      } catch (_) {
        return true;
      }
    }).toList();

    filtered.insert(0, jsonStr);
    while (filtered.length > 10) filtered.removeLast();

    await prefs.setStringList(_prefsKeyRecent, filtered);
    await _loadRecentPresets();
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('현재 조건을 최근 검색에 저장했습니다.')),
    );
  }

  Future<void> _applyPreset(_SearchPreset p) async {
    final s = p.state;
    setState(() {
      selectedPlace       = s['selectedPlace'] as String?;
      selectedNatures
        ..clear()
        ..addAll(List<String>.from(s['selectedNatures'] as List? ?? const []));
      pmNumber            = s['pmNumber'] as String?;
      startDate           = (s['startDate'] == null) ? null : DateTime.tryParse(s['startDate'] as String);
      endDate             = (s['endDate'] == null) ? null : DateTime.tryParse(s['endDate'] as String);
      ageMin              = s['ageMin'] as int?;
      ageMax              = s['ageMax'] as int?;
      selectedGender      = s['selectedGender'] as String?;
      selectedRecordType  = s['selectedRecordType'] as String?;
      requireCT           = s['requireCT'] as bool? ?? false;
      requireOPG          = s['requireOPG'] as bool? ?? false;
      requirePA           = s['requirePA'] as bool? ?? false;
      requireBW           = s['requireBW'] as bool? ?? false;
      requireHasFiles     = s['requireHasFiles'] as bool? ?? false;
      sortKey             = s['sortKey'] as String? ?? 'date';
      sortDesc            = s['sortDesc'] as bool? ?? true;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('최근 검색 조건을 불러왔습니다.')),
    );
  }

  Future<void> _deletePresetAt(int index) async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(_prefsKeyRecent) ?? <String>[];
    if (index >= 0 && index < list.length) {
      list.removeAt(index);
      await prefs.setStringList(_prefsKeyRecent, list);
      await _loadRecentPresets();
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('최근 검색을 삭제했습니다.')),
      );
    }
  }

  Map<String, dynamic> _currentStateToMap() {
    return {
      'selectedPlace': selectedPlace,
      'selectedNatures': selectedNatures.toList(),
      'pmNumber': pmNumber,
      'startDate': startDate?.toIso8601String(),
      'endDate': endDate?.toIso8601String(),
      'ageMin': ageMin,
      'ageMax': ageMax,
      'selectedGender': selectedGender,
      'selectedRecordType': selectedRecordType,
      'requireCT': requireCT,
      'requireOPG': requireOPG,
      'requirePA': requirePA,
      'requireBW': requireBW,
      'requireHasFiles': requireHasFiles,
      'sortKey': sortKey,
      'sortDesc': sortDesc,
    };
  }

  Future<void> _pickDateRange() async {
    final now = DateTime.now();
    final first = DateTime(now.year - 20, 1, 1);
    final last = DateTime(now.year + 5, 12, 31);
    final range = await showDateRangePicker(
      context: context,
      firstDate: first,
      lastDate: last,
      initialDateRange: (startDate != null && endDate != null)
          ? DateTimeRange(start: startDate!, end: endDate!)
          : null,
    );
    if (range != null) {
      setState(() {
        startDate = DateTime(range.start.year, range.start.month, range.start.day);
        endDate   = DateTime(range.end.year, range.end.month, range.end.day);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final onlineAndAuthed = _onlineAndAuthed;

    final dateRangeLabel = () {
      if (startDate == null && endDate == null) return '날짜 범위 선택 안됨';
      final s = startDate?.toLocal().toString().split(' ').first ?? '...';
      final e = endDate?.toLocal().toString().split(' ').first ?? '...';
      return '$s ~ $e';
    }();

    return Scaffold(
      appBar: AppBar(
        title: const Text("데이터 조회"),
        actions: [
          IconButton(
            tooltip: '현재 조건 저장',
            onPressed: _saveCurrentAsPreset,
            icon: const Icon(Icons.bookmark_add_outlined),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // 최근 검색 섹션
            ExpansionTile(
              initiallyExpanded: recentExpanded,
              onExpansionChanged: (v) => setState(() => recentExpanded = v),
              leading: const Icon(Icons.history),
              title: const Text('최근 검색 불러오기'),
              subtitle: Text(recentPresets.isEmpty ? '저장된 최근 검색 없음' : '${recentPresets.length}개 저장됨'),
              children: [
                if (recentPresets.isEmpty)
                  const Padding(
                    padding: EdgeInsets.only(bottom: 12),
                    child: Text('상단 북마크 아이콘으로 현재 조건을 저장할 수 있습니다.'),
                  )
                else
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: recentPresets.length,
                    separatorBuilder: (_, __) => const Divider(height: 1),
                    itemBuilder: (context, index) {
                      final p = recentPresets[index];
                      return ListTile(
                        dense: true,
                        title: Text(p.shortLabel, maxLines: 1, overflow: TextOverflow.ellipsis),
                        subtitle: Text(p.createdAtLabel),
                        leading: const Icon(Icons.bookmark_outlined),
                        trailing: IconButton(
                          tooltip: '삭제',
                          onPressed: () => _deletePresetAt(index),
                          icon: const Icon(Icons.delete_outline),
                        ),
                        onTap: () => _applyPreset(p),
                      );
                    },
                  ),
                const SizedBox(height: 8),
              ],
            ),

            // body 컬럼 안, 필터 섹션 위쪽에 넣기 예시
            Card(
              color: Theme.of(context).colorScheme.surfaceVariant,
              child: ListTile(
                leading: const Icon(Icons.cloud_upload_outlined),
                title: Text('제출 대기: ${_pending.length}건'),
                subtitle: Text(_onlineAndAuthed
                    ? '온라인/로그인 상태입니다. 지금 동기화할 수 있습니다.'
                    : '오프라인 또는 미인증 상태입니다. 온라인이 되면 동기화하세요.'),
                trailing: _syncing
                    ? const SizedBox(
                    width: 24, height: 24, child: CircularProgressIndicator(strokeWidth: 2))
                    : ElevatedButton(
                  onPressed: _onlineAndAuthed && _pending.isNotEmpty ? _syncPendingNow : null,
                  child: const Text('지금 동기화'),
                ),
              ),
            ),

            // 필터 섹션
            ExpansionTile(
              initiallyExpanded: filterExpanded,
              onExpansionChanged: (v) => setState(() => filterExpanded = v),
              leading: const Icon(Icons.filter_list),
              title: const Text('필터'),
              children: [
                const SizedBox(height: 8),

                // 장소 선택 (주소 검색 화면 이동)
                GestureDetector(
                  onTap: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => AddressSearchScreen()),
                    );
                    if (!mounted) return;
                    if (result is String) setState(() => selectedPlace = result);
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

                // 재난 유형: 다중 선택
                Align(
                  alignment: Alignment.centerLeft,
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 4,
                    children: disasterTypes.map((t) {
                      final sel = selectedNatures.contains(t);
                      return FilterChip(
                        label: Text(t),
                        selected: sel,
                        onSelected: (v) => setState(() {
                          if (v) {
                            selectedNatures.add(t);
                          } else {
                            selectedNatures.remove(t);
                          }
                        }),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 8),

                // PM 번호
                TextField(
                  decoration: const InputDecoration(labelText: "PM 번호"),
                  onChanged: (val) => setState(() => pmNumber = val),
                ),
                const SizedBox(height: 12),

                // 날짜 범위
                Row(
                  children: [
                    Expanded(child: Text(dateRangeLabel)),
                    ElevatedButton(
                      onPressed: _pickDateRange,
                      child: const Text("날짜 범위 선택"),
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                // 성별 / 기록 타입
                Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: selectedGender,
                        hint: const Text('성별(선택)'),
                        decoration: const InputDecoration(labelText: "성별"),
                        items: [null, ...genders].map((g) {
                          return DropdownMenuItem(
                            value: g,
                            child: Text(g ?? '전체'),
                          );
                        }).toList(),
                        onChanged: (v) => setState(() => selectedGender = v),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: selectedRecordType,
                        hint: const Text('기록 타입'),
                        decoration: const InputDecoration(labelText: "기록 타입"),
                        items: [null, ...recordTypes].map((rt) {
                          return DropdownMenuItem(
                            value: rt,
                            child: Text(rt ?? '전체'),
                          );
                        }).toList(),
                        onChanged: (v) => setState(() => selectedRecordType = v),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                // 나이 범위
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

                const SizedBox(height: 12),

                // 영상/파일 보유 토글
                Wrap(
                  spacing: 8,
                  runSpacing: 0,
                  children: [
                    FilterChip(
                      label: const Text('CT 있음'),
                      selected: requireCT,
                      onSelected: (v) => setState(() => requireCT = v),
                    ),
                    FilterChip(
                      label: const Text('OPG 있음'),
                      selected: requireOPG,
                      onSelected: (v) => setState(() => requireOPG = v),
                    ),
                    FilterChip(
                      label: const Text('PA 있음'),
                      selected: requirePA,
                      onSelected: (v) => setState(() => requirePA = v),
                    ),
                    FilterChip(
                      label: const Text('BW 있음'),
                      selected: requireBW,
                      onSelected: (v) => setState(() => requireBW = v),
                    ),
                    FilterChip(
                      label: const Text('첨부파일 있음'),
                      selected: requireHasFiles,
                      onSelected: (v) => setState(() => requireHasFiles = v),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
              ],
            ),

            // 정렬 섹션
            ExpansionTile(
              initiallyExpanded: sortExpanded,
              onExpansionChanged: (v) => setState(() => sortExpanded = v),
              leading: const Icon(Icons.sort),
              title: const Text('정렬'),
              children: [
                Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: sortKey,
                        decoration: const InputDecoration(labelText: "정렬 기준"),
                        items: const [
                          DropdownMenuItem(value: 'date',    child: Text('날짜')),
                          DropdownMenuItem(value: 'pm',      child: Text('PM 번호')),
                          DropdownMenuItem(value: 'place',   child: Text('장소')),
                          DropdownMenuItem(value: 'nature',  child: Text('재난 유형')),
                          DropdownMenuItem(value: 'ageMin',  child: Text('최소 나이')),
                          DropdownMenuItem(value: 'ageMax',  child: Text('최대 나이')),
                        ],
                        onChanged: (v) => setState(() => sortKey = v ?? 'date'),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Row(
                      children: [
                        const Text('내림차순'),
                        Switch(
                          value: sortDesc,
                          onChanged: (v) => setState(() => sortDesc = v),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 12),
              ],
            ),

            const SizedBox(height: 8),

            // 검색 버튼
            Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: onlineAndAuthed ? _search : null,
                        icon: const Icon(Icons.search),
                        label: const Text("검색"),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                if (!onlineAndAuthed)
                  const Text(
                    "오프라인 상태에서는 검색할 수 없습니다.",
                    style: TextStyle(color: Colors.orange),
                  ),
              ],
            ),


            if (isLoading)
              const CircularProgressIndicator()
            else if (results.isNotEmpty)
              ...results.map((doc) {
                final data = doc.data();
                final place  = (data['placeOfDisaster'] as String?) ?? '';
                final nature = (data['natureOfDisaster'] as String?) ?? '';
                final dateStr = _toDateYMD(data['dateOfDisaster']) ?? '';

                return Card(
                  child: ListTile(
                    title: Text("PM No: ${(data['pmNumber'] as String?) ?? ''}"),
                    subtitle: Text("장소: $place, 유형: $nature, 날짜: $dateStr"),
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
            
            if (!isLoading && results.isNotEmpty) ...[
              const SizedBox(height: 8),
              if (_isLoadingMore)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: CircularProgressIndicator(),
                )
              else if (_hasMore)
                OutlinedButton.icon(
                  onPressed: () => _search(loadMore: true),
                  icon: const Icon(Icons.expand_more),
                  label: const Text('더 보기'),
                )
              else
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Text('마지막 페이지입니다.', style: TextStyle(fontSize: 12, color: Colors.grey)),
                ),
            ],
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 1),
    );
  }

  Future<void> _search({bool loadMore = false}) async {
    // 첫 검색이면 초기화
    if (!loadMore) {
      setState(() {
        isLoading = true;
        _isLoadingMore = false;
        results = [];
        _lastDoc = null;
        _hasMore = true;
      });
    } else {
      if (!_hasMore || _isLoadingMore) return; // 중복 호출 방지
      setState(() => _isLoadingMore = true);
    }

    try {
      Query<Map<String, dynamic>> q = _buildBaseQuery()
          .limit(_pageSize);

      if (_lastDoc != null) {
        q = q.startAfterDocument(_lastDoc!);
      }

      final snap = await q.get();

      // 누적
      final newDocs = snap.docs;
      if (newDocs.isNotEmpty) {
        _lastDoc = newDocs.last;
        // 🔽 여기서는 서버 결과만 먼저 넣고,
        //    아래에서 기존의 클라이언트 보정/정렬을 한 번에 적용
        results = [...results, ...newDocs];
      }

      if (newDocs.length < _pageSize) {
        _hasMore = false; // 더 이상 페이지 없음
      }

      // ===== 클라이언트 보정 + 정렬 (기존 코드 유지/적용) =====
      // (서버에서 못 걸린 contains, 타입 혼합, 나이/영상/첨부파일 조건 등)
      final selPlaceNorm   = _norm(selectedPlace);
      final selDateStartYMD = startDate?.toLocal().toString().split(' ').first;
      final selDateEndYMD   = endDate?.toLocal().toString().split(' ').first;

      // 보정 필터
      var filtered = results.where((doc) {
        final data = doc.data();
        bool match = true;

        // 장소 contains 보정 (placeNorm 없는 과거 문서 대비)
        if (selPlaceNorm.isNotEmpty) {
          final item = _norm(data['placeOfDisaster'] as String?);
          // 서버에서 prefix를 이미 건 경우라도 과거 데이터에 대해서는 보정
          if (!item.contains(selPlaceNorm)) {
            // 단, 서버에서 placeNorm+커서로 걸었으면 대부분 통과할 것
            // contains 미일치면 제외
            match = false;
          }
        }

        // 날짜 보정 (string/Timestamp 혼합 대비)
        if (selDateStartYMD != null || selDateEndYMD != null) {
          final ymd = _toDateYMD(data['dateOfDisaster']);
          if (ymd != null) {
            if (selDateStartYMD != null && ymd.compareTo(selDateStartYMD) < 0) match = false;
            if (selDateEndYMD != null && ymd.compareTo(selDateEndYMD) > 0) match = false;
          }
        }

        // 영상/파일 보유
        if (requireCT) {
          final has = _asBool(data['ctDigital']) || _asBool(data['ctNonDigital']);
          match &= has;
        }
        if (requireOPG) {
          final has = _asBool(data['opgDigital']) || _asBool(data['opgNonDigital']);
          match &= has;
        }
        if (requirePA) {
          final has = _asBool(data['paDigital']) || _asBool(data['paNonDigital']);
          match &= has;
        }
        if (requireBW) {
          final has = _asBool(data['bwDigital']) || _asBool(data['bwNonDigital']);
          match &= has;
        }
        if (requireHasFiles) {
          match &= _hasAnyFiles(data['uploadedFiles']);
        }

        // 나이 범위(정보 있으면만 비교)
        if (ageMin != null || ageMax != null) {
          final int? itemMin = _asInt(data['ageMin']);
          final int? itemMax = _asInt(data['ageMax']);
          if (itemMin != null || itemMax != null) {
            final lowerOK = (ageMin == null) || ((itemMax ?? itemMin!) >= ageMin!);
            final upperOK = (ageMax == null) || ((itemMin ?? itemMax!) <= ageMax!);
            match &= lowerOK && upperOK;
          }
        }

        return match;
      }).toList();

      // 정렬 (기존 switch 유지)
      filtered.sort((a, b) {
        final da = a.data();
        final db = b.data();
        int cmp;
        switch (sortKey) {
          case 'pm':
            cmp = _compareString(da['pmNumber'], db['pmNumber']);
            break;
          case 'place':
            cmp = _compareString(da['placeOfDisaster'], db['placeOfDisaster']);
            break;
          case 'nature':
            cmp = _compareString(da['natureOfDisaster'], db['natureOfDisaster']);
            break;
          case 'ageMin':
            cmp = _compareInt(_asInt(da['ageMin']), _asInt(db['ageMin']));
            break;
          case 'ageMax':
            cmp = _compareInt(_asInt(da['ageMax']), _asInt(db['ageMax']));
            break;
          case 'date':
          default:
            final aY = _toDateYMD(da['dateOfDisaster']);
            final bY = _toDateYMD(db['dateOfDisaster']);
            cmp = _compareString(aY, bY);
            break;
        }
        return sortDesc ? -cmp : cmp;
      });

      setState(() {
        results = filtered;
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('검색 중 오류: $e')),
        );
      }
    } finally {
      if (mounted) {
        if (!loadMore) isLoading = false;
        _isLoadingMore = false;
        setState(() {});
      }
    }
  }


  Query<Map<String, dynamic>> _buildBaseQuery() {
    Query<Map<String, dynamic>> q =
    FirebaseFirestore.instance.collection('dental_data');

    // === 기존 필터 그대로 반영 ===
    // PM, RecordType, Gender
    final pmTrim = pmNumber?.trim() ?? '';
    if (pmTrim.isNotEmpty) q = q.where('pmNumber', isEqualTo: pmTrim);
    if (selectedRecordType?.isNotEmpty == true) {
      q = q.where('recordType', isEqualTo: selectedRecordType);
    }
    if (selectedGender?.isNotEmpty == true) {
      q = q.where('gender', isEqualTo: selectedGender);
    }

    // 재난유형: whereIn (최대 10개)
    if (selectedNatures.isNotEmpty) {
      final list = selectedNatures.take(10).toList();
      q = q.where('natureOfDisaster', whereIn: list);
    }

    // 날짜/장소 조합 처리
    final hasStart = startDate != null;
    final hasEnd   = endDate != null;

    final tsStart = Timestamp.fromDate(
      hasStart
          ? DateTime(startDate!.year, startDate!.month, startDate!.day)
          : DateTime(1900, 1, 1),
    );
    final tsEnd = Timestamp.fromDate(
      hasEnd
          ? DateTime(endDate!.year, endDate!.month, endDate!.day, 23, 59, 59, 999)
          : DateTime(9999, 12, 31, 23, 59, 59, 999),
    );

    final placePrefix = _norm(selectedPlace);
    bool usedServerSidePlace = false;

    if (placePrefix.isNotEmpty && (hasStart || hasEnd)) {
      // 장소 + 날짜 → 다중 orderBy + 다중 커서
      q = q.orderBy('placeNorm').orderBy('dateOfDisaster');
      q = q.startAt([placePrefix, tsStart]).endAt(['$placePrefix\uf8ff', tsEnd]);
      usedServerSidePlace = true;
    } else {
      if (hasStart) q = q.where('dateOfDisaster', isGreaterThanOrEqualTo: tsStart);
      if (hasEnd)   q = q.where('dateOfDisaster', isLessThanOrEqualTo: tsEnd);

      if (placePrefix.isNotEmpty) {
        q = q.orderBy('placeNorm')
            .startAt([placePrefix]).endAt(['$placePrefix\uf8ff']);
        usedServerSidePlace = true;
      }
    }

    // ▲ 서버에서 못 걸린 예외(과거 데이터 placeNorm 없음 등)는
    //    아래 클라이언트 필터에서 보정 (기존 코드 유지)

    return q;
  }


  int _compareString(dynamic a, dynamic b) {
    final sa = (a is String) ? a : (a?.toString() ?? '');
    final sb = (b is String) ? b : (b?.toString() ?? '');
    // 빈값/NULL은 항상 뒤로
    if (sa.isEmpty && sb.isEmpty) return 0;
    if (sa.isEmpty) return 1;
    if (sb.isEmpty) return -1;
    return sa.toLowerCase().compareTo(sb.toLowerCase());
  }

  int _compareInt(int? a, int? b) {
    if (a == null && b == null) return 0;
    if (a == null) return 1;
    if (b == null) return -1;
    return a.compareTo(b);
  }
}

// --------------------------
// Recent search preset model
// --------------------------
class _SearchPreset {
  final DateTime createdAt;
  final Map<String, dynamic> state;

  _SearchPreset({required this.createdAt, required this.state});

  Map<String, dynamic> toMap() => {
    'createdAt': createdAt.toIso8601String(),
    'state': state,
  };

  static _SearchPreset fromMap(Map<String, dynamic> m) {
    final created = DateTime.tryParse((m['createdAt'] as String?) ?? '') ?? DateTime.now();
    final state = Map<String, dynamic>.from(m['state'] as Map? ?? const {});
    return _SearchPreset(createdAt: created, state: state);
  }

  String get createdAtLabel {
    final d = createdAt.toLocal().toString().split('.').first.replaceFirst(' ', '  ');
    return '저장: $d';
  }

  String get shortLabel {
    // 간단 요약
    final p   = (state['selectedPlace'] as String?) ?? '';
    final ns  = List<String>.from(state['selectedNatures'] as List? ?? const []);
    final pm  = (state['pmNumber'] as String?) ?? '';
    final g   = (state['selectedGender'] as String?) ?? '';
    final rt  = (state['selectedRecordType'] as String?) ?? '';
    final sd  = (state['startDate'] as String?) ?? '';
    final ed  = (state['endDate'] as String?) ?? '';

    final parts = <String>[];
    if (pm.isNotEmpty) parts.add('PM:$pm');
    if (p.isNotEmpty)  parts.add('장소:$p');
    if (ns.isNotEmpty) parts.add('유형:${ns.join(",")}');
    if (g.isNotEmpty)  parts.add('성별:$g');
    if (rt.isNotEmpty) parts.add('타입:$rt');
    if (sd.isNotEmpty || ed.isNotEmpty) {
      parts.add('날짜:${(sd.isNotEmpty)? sd.split("T").first : "..."}~${(ed.isNotEmpty)? ed.split("T").first : "..."}');
    }
    if (parts.isEmpty) return '조건 없음';
    return parts.join(' · ');
  }
}
