// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import '../widgets/custom_bottom_nav_bar.dart';
//
// class SettingsScreen extends StatelessWidget {
//   const SettingsScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final user = FirebaseAuth.instance.currentUser;
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('설정'),
//         automaticallyImplyLeading: false,
//       ),
//       body: ListView(
//         children: [
//           const SizedBox(height: 20),
//
//           const ListTile(
//             leading: Icon(Icons.person),
//             title: Text("계정 정보", style: TextStyle(fontWeight: FontWeight.bold)),
//           ),
//           ListTile(
//             leading: const Icon(Icons.email),
//             title: const Text("이메일"),
//             subtitle: Text(user?.email ?? "로그인 정보 없음"),
//           ),
//
//           const Divider(),
//
//           const ListTile(
//             leading: Icon(Icons.settings),
//             title: Text("앱 설정", style: TextStyle(fontWeight: FontWeight.bold)),
//           ),
//           ListTile(
//             leading: const Icon(Icons.info_outline),
//             title: const Text("앱 버전"),
//             subtitle: const Text("v1.0.0"),
//           ),
//
//           const Divider(),
//
//           const ListTile(
//             leading: Icon(Icons.lock),
//             title: Text("보안", style: TextStyle(fontWeight: FontWeight.bold)),
//           ),
//           ListTile(
//             leading: const Icon(Icons.logout),
//             title: const Text("로그아웃"),
//             onTap: () async {
//               await FirebaseAuth.instance.signOut();
//               Navigator.pushNamedAndRemoveUntil(context, '/login', (_) => false);
//             },
//           ),
//
//           const Divider(),
//
//           const ListTile(
//             leading: Icon(Icons.policy),
//             title: Text("기타", style: TextStyle(fontWeight: FontWeight.bold)),
//           ),
//           ListTile(
//             leading: const Icon(Icons.contact_support),
//             title: const Text("개발자 연락처"),
//             subtitle: const Text("moon_1673@naver.com"),
//           ),
//         ],
//       ),
//       bottomNavigationBar: const CustomBottomNavBar(currentIndex: 2),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:provider/provider.dart';
//
// import '../providers/dental_data_provider.dart';
// import '../widgets/custom_bottom_nav_bar.dart';
//
// class SettingsScreen extends StatefulWidget {
//   const SettingsScreen({super.key});
//
//   @override
//   State<SettingsScreen> createState() => _SettingsScreenState();
// }
//
// class _SettingsScreenState extends State<SettingsScreen> {
//   // === 개발자 접근 제어 상수 ===
//   static const String kDeveloperEmail = 'moon_1673@naver.com';
//   static const String kDeveloperPin = '1673'; // 🔐 원하는 값으로 변경하세요
//   static const int kTapsToUnlock = 7;
//
//   bool _isDevUnlocked = false;
//   int _versionTapCount = 0;
//
//   @override
//   void initState() {
//     super.initState();
//     final user = FirebaseAuth.instance.currentUser;
//     // 개발자 이메일로 로그인한 경우 자동 해제
//     if (user?.email?.toLowerCase() == kDeveloperEmail.toLowerCase()) {
//       _isDevUnlocked = true;
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final user = FirebaseAuth.instance.currentUser;
//     final provider = context.watch<DentalDataProvider>();
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('설정'),
//         automaticallyImplyLeading: false,
//       ),
//       body: ListView(
//         children: [
//           const SizedBox(height: 20),
//
//           const ListTile(
//             leading: Icon(Icons.person),
//             title: Text("계정 정보", style: TextStyle(fontWeight: FontWeight.bold)),
//           ),
//           ListTile(
//             leading: const Icon(Icons.email),
//             title: const Text("이메일"),
//             subtitle: Text(user?.email ?? "로그인 정보 없음"),
//           ),
//
//           const Divider(),
//
//           const ListTile(
//             leading: Icon(Icons.settings),
//             title: Text("앱 설정", style: TextStyle(fontWeight: FontWeight.bold)),
//           ),
//           // 앱 버전 (여기 7번 탭하면 개발자 PIN 창)
//           ListTile(
//             leading: const Icon(Icons.info_outline),
//             title: const Text("앱 버전"),
//             subtitle: const Text("v1.0.0"),
//             onTap: _handleVersionTileTap,
//           ),
//
//           // --- 개발자 전용 섹션 (잠금 해제 시 표시) ---
//           if (_isDevUnlocked) ...[
//             const Divider(),
//             const ListTile(
//               leading: Icon(Icons.developer_mode),
//               title: Text("개발자 설정", style: TextStyle(fontWeight: FontWeight.bold)),
//             ),
//             // 대형 사건 모드 토글
//             SwitchListTile.adaptive(
//               secondary: const Icon(Icons.warning_amber),
//               title: const Text("대형 사건 모드 (장소/재난유형 고정)"),
//               subtitle: Text(
//                 provider.incidentLockEnabled
//                     ? "ON - Place: Gwangju / Nature: Tsunami"
//                     : "OFF - 자유 입력 가능",
//               ),
//               value: provider.incidentLockEnabled,
//               onChanged: (val) {
//                 if (val) {
//                   provider.enableIncidentLock(
//                     place: 'Gwangju',
//                     nature: 'Tsunami',
//                   );
//                   _toast("대형 사건 모드가 활성화되었습니다.");
//                 } else {
//                   provider.disableIncidentLock();
//                   _toast("대형 사건 모드가 비활성화되었습니다.");
//                 }
//               },
//             ),
//             // 필요 시: 고정값을 바꾸고 싶다면 아래처럼 추가 입력 UI 가능 (지금은 요청사항대로 토글만)
//           ] else ...[
//             // 개발자 미해제 상태에서는 토글을 아예 안 보여주거나,
//             // 회색 비활성 항목으로 힌트만 보여줄 수도 있음. 요청은 "개발자만 건드리게"였으니 안 보이게 처리.
//           ],
//
//           const Divider(),
//
//           const ListTile(
//             leading: Icon(Icons.lock),
//             title: Text("보안", style: TextStyle(fontWeight: FontWeight.bold)),
//           ),
//           ListTile(
//             leading: const Icon(Icons.logout),
//             title: const Text("로그아웃"),
//             onTap: () async {
//               await FirebaseAuth.instance.signOut();
//               if (!mounted) return;
//               Navigator.pushNamedAndRemoveUntil(context, '/login', (_) => false);
//             },
//           ),
//
//           const Divider(),
//
//           const ListTile(
//             leading: Icon(Icons.policy),
//             title: Text("기타", style: TextStyle(fontWeight: FontWeight.bold)),
//           ),
//           const ListTile(
//             leading: Icon(Icons.contact_support),
//             title: Text("개발자 연락처"),
//             subtitle: Text("moon_1673@naver.com"),
//           ),
//         ],
//       ),
//       bottomNavigationBar: const CustomBottomNavBar(currentIndex: 2),
//     );
//   }
//
//   void _handleVersionTileTap() async {
//     if (_isDevUnlocked) {
//       _toast("개발자 설정이 이미 활성화되어 있습니다.");
//       return;
//     }
//     _versionTapCount++;
//     final remain = (kTapsToUnlock - _versionTapCount).clamp(0, kTapsToUnlock);
//     if (remain > 0) {
//       _toast("개발자 모드까지 $remain회 남음");
//     }
//     if (_versionTapCount >= kTapsToUnlock) {
//       _versionTapCount = 0;
//       final ok = await _askDevPin();
//       if (ok == true) {
//         setState(() => _isDevUnlocked = true);
//         _toast("개발자 설정이 활성화되었습니다.");
//       } else {
//         _toast("PIN이 올바르지 않습니다.");
//       }
//     }
//   }
//
//   Future<bool?> _askDevPin() async {
//     final controller = TextEditingController();
//     return showDialog<bool>(
//       context: context,
//       builder: (_) => AlertDialog(
//         title: const Text('개발자 PIN 입력'),
//         content: TextField(
//           controller: controller,
//           autofocus: true,
//           keyboardType: TextInputType.number,
//           obscureText: true,
//           decoration: const InputDecoration(
//             hintText: 'PIN',
//             border: OutlineInputBorder(),
//           ),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context, false),
//             child: const Text('취소'),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               final ok = controller.text.trim() == kDeveloperPin;
//               Navigator.pop(context, ok);
//             },
//             child: const Text('확인'),
//           ),
//         ],
//       ),
//     );
//   }
//
//   void _toast(String msg) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text(msg)),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:provider/provider.dart';
//
// import '../providers/dental_data_provider.dart';
// import '../widgets/custom_bottom_nav_bar.dart';
//
// class SettingsScreen extends StatefulWidget {
//   const SettingsScreen({super.key});
//
//   @override
//   State<SettingsScreen> createState() => _SettingsScreenState();
// }
//
// class _SettingsScreenState extends State<SettingsScreen> {
//   // === 개발자 접근 제어 상수 ===
//   static const String kDeveloperEmail = 'moon_1673@naver.com';
//   static const String kDeveloperPin = '1673'; // 🔐 변경 가능
//   static const int kTapsToUnlock = 7;
//
//   bool _isDevUnlocked = false;
//   int _versionTapCount = 0;
//
//   // === 고정값 입력 컨트롤 ===
//   late TextEditingController _placeCtrl;
//   late TextEditingController _customNatureCtrl;
//   String _natureSelected = 'Tsunami';
//
//   final List<String> _disasterTypes = const [
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
//   @override
//   void initState() {
//     super.initState();
//     final user = FirebaseAuth.instance.currentUser;
//     if (user?.email?.toLowerCase() == kDeveloperEmail.toLowerCase()) {
//       _isDevUnlocked = true;
//     }
//
//     final prov = Provider.of<DentalDataProvider>(context, listen: false);
//     _placeCtrl = TextEditingController(text: prov.lockedPlace);
//     // lockedNature가 목록에 없으면 Other로 잡고 커스텀에 채워줌
//     if (_disasterTypes.contains(prov.lockedNature)) {
//       _natureSelected = prov.lockedNature;
//       _customNatureCtrl = TextEditingController(text: '');
//     } else {
//       _natureSelected = 'Other';
//       _customNatureCtrl = TextEditingController(text: prov.lockedNature);
//     }
//   }
//
//   @override
//   void dispose() {
//     _placeCtrl.dispose();
//     _customNatureCtrl.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final user = FirebaseAuth.instance.currentUser;
//     final provider = context.watch<DentalDataProvider>();
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('설정'),
//         automaticallyImplyLeading: false,
//       ),
//       body: ListView(
//         children: [
//           const SizedBox(height: 20),
//
//           const ListTile(
//             leading: Icon(Icons.person),
//             title: Text("계정 정보", style: TextStyle(fontWeight: FontWeight.bold)),
//           ),
//           ListTile(
//             leading: const Icon(Icons.email),
//             title: const Text("이메일"),
//             subtitle: Text(user?.email ?? "로그인 정보 없음"),
//           ),
//
//           const Divider(),
//
//           const ListTile(
//             leading: Icon(Icons.settings),
//             title: Text("앱 설정", style: TextStyle(fontWeight: FontWeight.bold)),
//           ),
//           ListTile(
//             leading: const Icon(Icons.info_outline),
//             title: const Text("앱 버전"),
//             subtitle: const Text("v1.0.0"),
//             onTap: _handleVersionTileTap,
//           ),
//
//           // === 개발자 전용 섹션 ===
//           if (_isDevUnlocked) ...[
//             const Divider(),
//             const ListTile(
//               leading: Icon(Icons.developer_mode),
//               title: Text("개발자 설정", style: TextStyle(fontWeight: FontWeight.bold)),
//             ),
//
//             // 1) 대형 사건 모드 토글
//             SwitchListTile.adaptive(
//               secondary: const Icon(Icons.warning_amber),
//               title: const Text("대형 사건 모드 (장소/재난유형 고정)"),
//               subtitle: Text(
//                 provider.incidentLockEnabled
//                     ? "ON - 현재 고정값: ${provider.lockedPlace} / ${provider.lockedNature}"
//                     : "OFF - 현재 고정값: ${provider.lockedPlace} / ${provider.lockedNature}",
//               ),
//               value: provider.incidentLockEnabled,
//               onChanged: (val) {
//                 if (val) {
//                   provider.enableIncidentLock();
//                   _toast("대형 사건 모드가 활성화되었습니다.");
//                 } else {
//                   provider.disableIncidentLock();
//                   _toast("대형 사건 모드가 비활성화되었습니다.");
//                 }
//               },
//             ),
//
//             // 2) 고정값 편집 카드
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16.0),
//               child: Card(
//                 child: Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text("고정값 편집",
//                           style: Theme.of(context).textTheme.titleMedium),
//                       const SizedBox(height: 12),
//
//                       // Place of Disaster (텍스트 입력)
//                       TextField(
//                         controller: _placeCtrl,
//                         decoration: const InputDecoration(
//                           labelText: "Place of Disaster (고정값)",
//                           hintText: "예: Seoul",
//                           border: OutlineInputBorder(),
//                         ),
//                       ),
//                       const SizedBox(height: 12),
//
//                       // Nature of Disaster (드롭다운 + 필요시 커스텀)
//                       DropdownButtonFormField<String>(
//                         value: _natureSelected,
//                         decoration: const InputDecoration(
//                           labelText: "Nature of Disaster (고정값)",
//                           border: OutlineInputBorder(),
//                         ),
//                         items: _disasterTypes
//                             .map((e) => DropdownMenuItem(value: e, child: Text(e)))
//                             .toList(),
//                         onChanged: (val) {
//                           if (val == null) return;
//                           setState(() {
//                             _natureSelected = val;
//                             if (_natureSelected != 'Other') {
//                               _customNatureCtrl.text = '';
//                             }
//                           });
//                         },
//                       ),
//                       if (_natureSelected == 'Other') ...[
//                         const SizedBox(height: 8),
//                         TextField(
//                           controller: _customNatureCtrl,
//                           decoration: const InputDecoration(
//                             labelText: "Custom Nature",
//                             hintText: "예: Landslide, Pandemic 등",
//                             border: OutlineInputBorder(),
//                           ),
//                         ),
//                       ],
//
//                       const SizedBox(height: 12),
//                       Row(
//                         children: [
//                           ElevatedButton.icon(
//                             icon: const Icon(Icons.save),
//                             label: const Text("저장"),
//                             onPressed: () {
//                               final place = _placeCtrl.text.trim();
//                               final nature = _natureSelected == 'Other'
//                                   ? _customNatureCtrl.text.trim()
//                                   : _natureSelected;
//
//                               if (place.isEmpty || nature.isEmpty) {
//                                 _toast("Place/Nature를 입력하세요.");
//                                 return;
//                               }
//                               provider.setLockedValues(place: place, nature: nature);
//                               _toast("고정값이 저장되었습니다.");
//                             },
//                           ),
//                           const SizedBox(width: 12),
//                           OutlinedButton.icon(
//                             icon: Icon(
//                               provider.incidentLockEnabled ? Icons.lock_open : Icons.lock,
//                             ),
//                             label: Text(
//                               provider.incidentLockEnabled ? "잠금 해제" : "적용하고 잠그기",
//                             ),
//                             onPressed: () {
//                               final place = _placeCtrl.text.trim();
//                               final nature = _natureSelected == 'Other'
//                                   ? _customNatureCtrl.text.trim()
//                                   : _natureSelected;
//                               if (!provider.incidentLockEnabled) {
//                                 if (place.isEmpty || nature.isEmpty) {
//                                   _toast("Place/Nature를 입력하세요.");
//                                   return;
//                                 }
//                                 provider.setLockedValues(place: place, nature: nature);
//                                 provider.enableIncidentLock();
//                                 _toast("고정값을 적용하고 잠금이 활성화되었습니다.");
//                               } else {
//                                 provider.disableIncidentLock();
//                                 _toast("잠금이 해제되었습니다.");
//                               }
//                             },
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//
//           const Divider(),
//
//           const ListTile(
//             leading: Icon(Icons.lock),
//             title: Text("보안", style: TextStyle(fontWeight: FontWeight.bold)),
//           ),
//           ListTile(
//             leading: const Icon(Icons.refresh),
//             title: const Text("임시 데이터 초기화"),
//             subtitle: const Text("현재까지 입력한 값 전체 초기화"),
//             onTap: () async {
//               final ok = await showDialog<bool>(
//                 context: context,
//                 builder: (_) => AlertDialog(
//                   title: const Text('초기화 확인'),
//                   content: const Text('현재 입력 중인 모든 값을 삭제합니다. 계속할까요?'),
//                   actions: [
//                     TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('취소')),
//                     ElevatedButton(onPressed: () => Navigator.pop(context, true), child: const Text('초기화')),
//                   ],
//                 ),
//               );
//               if (ok == true) {
//                 context.read<DentalDataProvider>().resetAll(); // 🔴 잠금/고정값은 유지
//                 _toast("입력 값이 초기화되었습니다.");
//               }
//             },
//           ),
//           ListTile(
//             leading: const Icon(Icons.logout),
//             title: const Text("로그아웃"),
//             onTap: () async {
//               final ok = await showDialog<bool>(
//                 context: context,
//                 builder: (_) => AlertDialog(
//                   title: const Text('로그아웃'),
//                   content: const Text('정말 로그아웃하시겠습니까?'),
//                   actions: [
//                     TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('취소')),
//                     ElevatedButton(onPressed: () => Navigator.pop(context, true), child: const Text('로그아웃')),
//                   ],
//                 ),
//               );
//               if (ok == true) {
//                 // 🔑 다른 계정으로 로그인했을 때 이전 입력이 남지 않도록, 먼저 초기화
//                 context.read<DentalDataProvider>().resetAll();
//                 await FirebaseAuth.instance.signOut();
//                 if (!mounted) return;
//                 Navigator.pushNamedAndRemoveUntil(context, '/login', (_) => false);
//               }
//             },
//           ),
//
//           const Divider(),
//
//           const ListTile(
//             leading: Icon(Icons.policy),
//             title: Text("기타", style: TextStyle(fontWeight: FontWeight.bold)),
//           ),
//           const ListTile(
//             leading: Icon(Icons.contact_support),
//             title: Text("개발자 연락처"),
//             subtitle: Text("moon_1673@naver.com"),
//           ),
//         ],
//       ),
//       bottomNavigationBar: const CustomBottomNavBar(currentIndex: 2),
//     );
//   }
//
//   void _handleVersionTileTap() async {
//     if (_isDevUnlocked) {
//       _toast("개발자 설정이 이미 활성화되어 있습니다.");
//       return;
//     }
//     _versionTapCount++;
//     final remain = (kTapsToUnlock - _versionTapCount).clamp(0, kTapsToUnlock);
//     if (remain > 0) {
//       _toast("개발자 모드까지 $remain회 남음");
//     }
//     if (_versionTapCount >= kTapsToUnlock) {
//       _versionTapCount = 0;
//       final ok = await _askDevPin();
//       if (ok == true) {
//         setState(() => _isDevUnlocked = true);
//         _toast("개발자 설정이 활성화되었습니다.");
//       } else {
//         _toast("PIN이 올바르지 않습니다.");
//       }
//     }
//   }
//
//   Future<bool?> _askDevPin() async {
//     final controller = TextEditingController();
//     return showDialog<bool>(
//       context: context,
//       builder: (_) => AlertDialog(
//         title: const Text('개발자 PIN 입력'),
//         content: TextField(
//           controller: controller,
//           autofocus: true,
//           keyboardType: TextInputType.number,
//           obscureText: true,
//           decoration: const InputDecoration(
//             hintText: 'PIN',
//             border: OutlineInputBorder(),
//           ),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context, false),
//             child: const Text('취소'),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               final ok = controller.text.trim() == kDeveloperPin;
//               Navigator.pop(context, ok);
//             },
//             child: const Text('확인'),
//           ),
//         ],
//       ),
//     );
//   }
//
//   void _toast(String msg) {
//     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
//   }
// }

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import '../providers/dental_data_provider.dart';
import '../widgets/custom_bottom_nav_bar.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // === 개발자 접근 제어 상수 ===
  static const String kDeveloperEmail = 'moon_1673@naver.com';
  static const String kDeveloperPin = '1673'; // 🔐 변경 가능
  static const int kTapsToUnlock = 7;

  bool _isDevUnlocked = false;
  int _versionTapCount = 0;

  // === 고정값 입력 컨트롤 ===
  late TextEditingController _placeCtrl;
  late TextEditingController _customNatureCtrl;
  String _natureSelected = 'Tsunami';

  final List<String> _disasterTypes = const [
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

  late VoidCallback _provListener;

  @override
  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser;
    if (user?.email?.toLowerCase() == kDeveloperEmail.toLowerCase()) {
      _isDevUnlocked = true;
    }

    final prov = Provider.of<DentalDataProvider>(context, listen: false);
    _placeCtrl = TextEditingController(text: prov.lockedPlace);

    if (_disasterTypes.contains(prov.lockedNature)) {
      _natureSelected = prov.lockedNature;
      _customNatureCtrl = TextEditingController(text: '');
    } else {
      _natureSelected = 'Other';
      _customNatureCtrl = TextEditingController(text: prov.lockedNature);
    }

    // Firestore 구독으로 변경된 값들을 UI에 반영
    _provListener = () {
      final p = Provider.of<DentalDataProvider>(context, listen: false);
      if (_placeCtrl.text != p.lockedPlace) {
        _placeCtrl.text = p.lockedPlace;
      }
      final inList = _disasterTypes.contains(p.lockedNature);
      final desired = inList ? p.lockedNature : 'Other';
      if (_natureSelected != desired) {
        setState(() {
          _natureSelected = desired;
          if (!inList) _customNatureCtrl.text = p.lockedNature;
          if (inList && _customNatureCtrl.text.isNotEmpty) _customNatureCtrl.clear();
        });
      }
    };
    prov.addListener(_provListener);
  }

  @override
  void dispose() {
    Provider.of<DentalDataProvider>(context, listen: false)
        .removeListener(_provListener);
    _placeCtrl.dispose();
    _customNatureCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final provider = context.watch<DentalDataProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('설정'),
        automaticallyImplyLeading: false,
      ),
      body: ListView(
        children: [
          const SizedBox(height: 20),

          const ListTile(
            leading: Icon(Icons.person),
            title: Text("계정 정보", style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          ListTile(
            leading: const Icon(Icons.email),
            title: const Text("이메일"),
            subtitle: Text(user?.email ?? "로그인 정보 없음"),
          ),

          const Divider(),

          const ListTile(
            leading: Icon(Icons.settings),
            title: Text("앱 설정", style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text("앱 버전"),
            subtitle: const Text("v1.0.0"),
            onTap: _handleVersionTileTap,
          ),

          // === 개발자 전용 섹션 ===
          if (_isDevUnlocked) ...[
            const Divider(),
            const ListTile(
              leading: Icon(Icons.developer_mode),
              title: Text("개발자 설정", style: TextStyle(fontWeight: FontWeight.bold)),
            ),

            // 1) 대형 사건 모드 토글 (원격 반영)
            SwitchListTile.adaptive(
              secondary: const Icon(Icons.warning_amber),
              title: const Text("대형 사건 모드 (장소/재난유형 고정)"),
              subtitle: Text(
                provider.incidentLockEnabled
                    ? "ON - 현재 고정값: ${provider.lockedPlace} / ${provider.lockedNature}"
                    : "OFF - 현재 고정값: ${provider.lockedPlace} / ${provider.lockedNature}",
              ),
              value: provider.incidentLockEnabled,
              onChanged: (val) async {
                if (val) {
                  final place = _placeCtrl.text.trim();
                  final nature = _natureSelected == 'Other'
                      ? _customNatureCtrl.text.trim()
                      : _natureSelected;
                  if (place.isEmpty || nature.isEmpty) {
                    _toast("Place/Nature를 입력 후 저장하거나, 값을 채운 뒤 켜세요.");
                    return;
                  }
                  try {
                    await provider.setIncidentLockRemote(
                      enabled: true,
                      place: place,
                      nature: nature,
                    );
                    _toast("대형 사건 모드가 활성화되었습니다.");
                  } catch (e) {
                    _toast("잠금을 켤 수 없습니다: $e");
                  }
                } else {
                  try {
                    await provider.setIncidentLockRemote(
                      enabled: false,
                      place: provider.lockedPlace,
                      nature: provider.lockedNature,
                    );
                    _toast("대형 사건 모드가 비활성화되었습니다.");
                  } catch (e) {
                    _toast("잠금을 해제할 수 없습니다: $e");
                  }
                }
              },
            ),

            // 2) 고정값 편집 카드 (원격 반영)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("고정값 편집",
                          style: Theme.of(context).textTheme.titleMedium),
                      const SizedBox(height: 12),

                      TextField(
                        controller: _placeCtrl,
                        decoration: const InputDecoration(
                          labelText: "Place of Disaster (고정값)",
                          hintText: "예: Seoul",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 12),

                      DropdownButtonFormField<String>(
                        value: _natureSelected,
                        decoration: const InputDecoration(
                          labelText: "Nature of Disaster (고정값)",
                          border: OutlineInputBorder(),
                        ),
                        items: _disasterTypes
                            .map((e) =>
                            DropdownMenuItem(value: e, child: Text(e)))
                            .toList(),
                        onChanged: (val) {
                          if (val == null) return;
                          setState(() {
                            _natureSelected = val;
                            if (_natureSelected != 'Other') {
                              _customNatureCtrl.text = '';
                            }
                          });
                        },
                      ),
                      if (_natureSelected == 'Other') ...[
                        const SizedBox(height: 8),
                        TextField(
                          controller: _customNatureCtrl,
                          decoration: const InputDecoration(
                            labelText: "Custom Nature",
                            hintText: "예: Landslide, Pandemic 등",
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ],

                      const SizedBox(height: 12),
                      Row(
                        children: [
                          ElevatedButton.icon(
                            icon: const Icon(Icons.save),
                            label: const Text("저장"),
                            onPressed: () async {
                              final place = _placeCtrl.text.trim();
                              final nature = _natureSelected == 'Other'
                                  ? _customNatureCtrl.text.trim()
                                  : _natureSelected;

                              if (place.isEmpty || nature.isEmpty) {
                                _toast("Place/Nature를 입력하세요.");
                                return;
                              }
                              try {
                                await provider.setIncidentLockRemote(
                                  enabled: provider.incidentLockEnabled,
                                  place: place,
                                  nature: nature,
                                );
                                _toast("고정값이 저장되었습니다.");
                              } catch (e) {
                                _toast("저장 실패: $e");
                              }
                            },
                          ),
                          const SizedBox(width: 12),
                          OutlinedButton.icon(
                            icon: Icon(
                              provider.incidentLockEnabled
                                  ? Icons.lock_open
                                  : Icons.lock,
                            ),
                            label: Text(
                              provider.incidentLockEnabled
                                  ? "잠금 해제"
                                  : "적용하고 잠그기",
                            ),
                            onPressed: () async {
                              final place = _placeCtrl.text.trim();
                              final nature = _natureSelected == 'Other'
                                  ? _customNatureCtrl.text.trim()
                                  : _natureSelected;

                              if (!provider.incidentLockEnabled) {
                                if (place.isEmpty || nature.isEmpty) {
                                  _toast("Place/Nature를 입력하세요.");
                                  return;
                                }
                                try {
                                  await provider.setIncidentLockRemote(
                                    enabled: true,
                                    place: place,
                                    nature: nature,
                                  );
                                  _toast("고정값을 적용하고 잠금이 활성화되었습니다.");
                                } catch (e) {
                                  _toast("실패: $e");
                                }
                              } else {
                                try {
                                  await provider.setIncidentLockRemote(
                                    enabled: false,
                                    place: provider.lockedPlace,
                                    nature: provider.lockedNature,
                                  );
                                  _toast("잠금이 해제되었습니다.");
                                } catch (e) {
                                  _toast("실패: $e");
                                }
                              }
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],

          const Divider(),

          const ListTile(
            leading: Icon(Icons.lock),
            title: Text("보안", style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          ListTile(
            leading: const Icon(Icons.refresh),
            title: const Text("임시 데이터 초기화"),
            subtitle: const Text("현재까지 입력한 값 전체 초기화"),
            onTap: () async {
              final ok = await showDialog<bool>(
                context: context,
                builder: (_) => AlertDialog(
                  title: const Text('초기화 확인'),
                  content: const Text('현재 입력 중인 모든 값을 삭제합니다. 계속할까요?'),
                  actions: [
                    TextButton(
                        onPressed: () => Navigator.pop(context, false),
                        child: const Text('취소')),
                    ElevatedButton(
                        onPressed: () => Navigator.pop(context, true),
                        child: const Text('초기화')),
                  ],
                ),
              );
              if (ok == true) {
                context.read<DentalDataProvider>().resetAll();
                _toast("입력 값이 초기화되었습니다.");
              }
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text("로그아웃"),
            onTap: () async {
              final ok = await showDialog<bool>(
                context: context,
                builder: (_) => AlertDialog(
                  title: const Text('로그아웃'),
                  content: const Text('정말 로그아웃하시겠습니까?'),
                  actions: [
                    TextButton(
                        onPressed: () => Navigator.pop(context, false),
                        child: const Text('취소')),
                    ElevatedButton(
                        onPressed: () => Navigator.pop(context, true),
                        child: const Text('로그아웃')),
                  ],
                ),
              );
              if (ok == true) {
                context.read<DentalDataProvider>().resetAll();
                await FirebaseAuth.instance.signOut();
                if (!mounted) return;
                Navigator.pushNamedAndRemoveUntil(
                    context, '/login', (_) => false);
              }
            },
          ),

          const Divider(),

          const ListTile(
            leading: Icon(Icons.policy),
            title: Text("기타", style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          const ListTile(
            leading: Icon(Icons.contact_support),
            title: Text("개발자 연락처"),
            subtitle: Text("moon_1673@naver.com"),
          ),
        ],
      ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 2),
    );
  }

  void _handleVersionTileTap() async {
    if (_isDevUnlocked) {
      _toast("개발자 설정이 이미 활성화되어 있습니다.");
      return;
    }
    _versionTapCount++;
    final remain = (kTapsToUnlock - _versionTapCount).clamp(0, kTapsToUnlock);
    if (remain > 0) {
      _toast("개발자 모드까지 $remain회 남음");
    }
    if (_versionTapCount >= kTapsToUnlock) {
      _versionTapCount = 0;
      final ok = await _askDevPin();
      if (ok == true) {
        setState(() => _isDevUnlocked = true);
        _toast("개발자 설정이 활성화되었습니다.");
      } else {
        _toast("PIN이 올바르지 않습니다.");
      }
    }
  }

  Future<bool?> _askDevPin() async {
    final controller = TextEditingController();
    return showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('개발자 PIN 입력'),
        content: TextField(
          controller: controller,
          autofocus: true,
          keyboardType: TextInputType.number,
          obscureText: true,
          decoration: const InputDecoration(
            hintText: 'PIN',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('취소'),
          ),
          ElevatedButton(
            onPressed: () {
              final ok = controller.text.trim() == kDeveloperPin;
              Navigator.pop(context, ok);
            },
            child: const Text('확인'),
          ),
        ],
      ),
    );
  }

  void _toast(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }
}
