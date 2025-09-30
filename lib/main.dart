// import 'package:dental_record_app/screens/splash_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'screens/login_screen.dart';
// import 'screens/record_screen.dart';
// import 'screens/view_screen.dart';
// import 'screens/materials_available_screen.dart';
// import 'screens/dental_images_screen.dart';
// import 'screens/supplementary_details_screen.dart';
// import 'screens/dental_findings_screen.dart';
// import 'screens/final_review_screen.dart';
// import 'screens/dental_data_screen.dart'; // DentalDataScreen 정의된 파일 import
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       initialRoute: '/splash', // 시작은 스플래시
//       routes: {
//         '/splash': (_) => SplashScreen(),
//         '/login': (context) => LoginScreen(),
//         '/record': (context) => RecordScreen(),
//         '/view': (context) => ViewScreen(),
//         '/materialsAvailable': (context) {
//           return MaterialsAvailableScreen(
//             arguments: ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>? ?? {},
//           );
//         },
//         '/dentalImages': (context) {
//           return DentalImagesScreen(
//             arguments: ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>? ?? {},
//           );
//         },
//         '/supplementaryDetails': (context) {
//           return SupplementaryDetailsScreen(
//             arguments: ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>? ?? {},
//           );
//         },
//         '/dentalFindings': (context) => DentalFindingsScreen(),
//         '/DentalDataScreen': (context) => DentalDataScreen(),
//         '/finalReview': (context) {
//           return FinalReviewScreen(
//             arguments: ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>? ?? {},
//           );
//         },
//       },
//     );
//   }
// }


// class MyApp extends StatelessWidget {
//   final DentalDataProvider dental;
//   const MyApp({super.key, required this.dental});
//
//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (_) => dental),
//         // 향후 RecordDataProvider, AuthProvider 등 추가 가능
//       ],
//       child: MaterialApp(
//         debugShowCheckedModeBanner: false,
//         home: const SplashScreen(),
//         routes: {
//           '/initRetry': (_) => const InitRetryScreen(),
//           '/login': (_) => LoginScreen(),
//           '/recordSetup': (_) => const RecordSetupScreen(),
//           '/record': (_) => RecordScreen(),
//           '/view': (_) => ViewScreen(),
//           '/materialsAvailable': (_) => MaterialsAvailableScreen(),
//           '/dentalImages': (_) => DentalImagesScreen(),
//           '/supplementaryDetails': (_) => SupplementaryDetailsScreen(),
//           '/dentalFindings': (_) => DentalFindingsScreen(),
//           '/DentalDataScreen': (_) => DentalDataScreen(),
//           '/finalReview': (_) => FinalReviewScreen(),
//           '/settings': (context) => SettingsScreen(),
//         },
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: const SplashScreen(), // 시작점
//       routes: {
//         '/login': (_) => const _LoginDummy(),        // 원래 LoginScreen 대신
//         '/recordSetup': (_) => const _RecordDummy(), // 원래 RecordSetupScreen 대신
//         '/initRetry': (_) => const _RetryDummy(),    // 원래 InitRetryScreen 대신
//       },
//     );
//   }
// }
//
// /// 아주 단순한 스플래시 테스트
// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});
//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen> {
//   bool _go = false;
//
//   @override
//   void initState() {
//     super.initState();
//     // 앱 실행 1초 뒤 무조건 /login 으로 이동
//     WidgetsBinding.instance.addPostFrameCallback((_) async {
//       await Future.delayed(const Duration(seconds: 1));
//       if (!mounted || _go) return;
//       _go = true;
//       Navigator.pushReplacementNamed(context, '/login');
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       body: Center(child: Text('SPLASH TEST')),
//     );
//   }
// }
//
// // ==== 더미 화면 3개 ====
// class _LoginDummy extends StatelessWidget {
//   const _LoginDummy({super.key});
//   @override
//   Widget build(BuildContext context) =>
//       const Scaffold(body: Center(child: Text('LOGIN DUMMY')));
// }
//
// class _RecordDummy extends StatelessWidget {
//   const _RecordDummy({super.key});
//   @override
//   Widget build(BuildContext context) =>
//       const Scaffold(body: Center(child: Text('RECORD DUMMY')));
// }
//
// class _RetryDummy extends StatelessWidget {
//   const _RetryDummy({super.key});
//   @override
//   Widget build(BuildContext context) =>
//       const Scaffold(body: Center(child: Text('RETRY DUMMY')));
// }

// import 'package:flutter/material.dart';
//
// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   print('>>> simple main start');
//   runApp(const MaterialApp(home: Scaffold(body: Center(child: Text('Hello!')))));
// }

// import 'dart:async';
// import 'package:dental_record_app/providers/app_mode_provider.dart';
// import 'package:dental_record_app/services/network_status_service.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:provider/provider.dart';
//
// // 상태 관리 클래스
// import 'providers/dental_data_provider.dart';
//
// // LocalStore 추가
// import 'services/local_store.dart';
//
// // 스크린들
// import 'screens/splash_screen.dart';
// import 'screens/initretry_screen.dart';
// import 'screens/login_screen.dart';
// import 'screens/record_setup_screen.dart';
// import 'screens/record_screen.dart';
// import 'screens/view_screen.dart';
// import 'screens/materials_available_screen.dart';
// import 'screens/dental_images_screen.dart';
// import 'screens/supplementary_details_screen.dart';
// import 'screens/dental_findings_screen.dart';
// import 'screens/final_review_screen.dart';
// import 'screens/dental_data_screen.dart';
// import 'screens/settings_screen.dart';
//
// void main() async {
//
//   WidgetsFlutterBinding.ensureInitialized();
//
//   final network = NetworkStatus();
//   await network.init();
//   final appMode = AppModeProvider(network);
//
//   // 전역 에러 -> 화면에 표시
//   FlutterError.onError = (details) {
//     FlutterError.presentError(details);
//   };
//   ErrorWidget.builder = (details) {
//     return Material(
//       color: Colors.white,
//       child: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Text(
//           '에러 발생:\n${details.exception}\n\n${details.stack}',
//           style: const TextStyle(color: Colors.red),
//         ),
//       ),
//     );
//   };
//
//   // // 1) Firebase 초기화 (최대 5초)
//   // try {
//   //   await Firebase.initializeApp(
//   //     // options: DefaultFirebaseOptions.currentPlatform,
//   //   ).timeout(const Duration(seconds: 5));
//   // } catch (e) {
//   //   debugPrint('Firebase init 실패: $e');
//   // }
//   //
//   // // 2) 익명 로그인 (최대 3초)
//   // try {
//   //   if (FirebaseAuth.instance.currentUser == null) {
//   //     await FirebaseAuth.instance
//   //         .signInAnonymously()
//   //         .timeout(const Duration(seconds: 3));
//   //   }
//   // } catch (e) {
//   //   debugPrint('Firebase 익명 로그인 실패: $e');
//   // }
//   //
//   // // 3) 로컬 저장 초기화
//   // try {
//   //   await LocalStore.init(inMemory: false);
//   // } catch (e) {
//   //   debugPrint('LocalStore init 실패: $e');
//   // }
//   //
//   // // 4) Provider 준비
//   // final dental = DentalDataProvider();
//   // try {
//   //   await dental.hydrate();
//   // } catch (e) {
//   //   debugPrint('DentalDataProvider hydrate 실패: $e');
//   // }
//
//   // 로컬 저장 초기화
//   await LocalStore.init(inMemory: false);
//
//   // DentalDataProvider (오프라인 선 하이드레이트)
//   final dental = DentalDataProvider();
//   await dental.hydrate();
//
//   // 5) 앱 실행
//   runApp(
//     MultiProvider(
//       providers: [
//         ChangeNotifierProvider.value(value: dental),
//         ChangeNotifierProvider.value(value: network),
//         ChangeNotifierProvider.value(value: appMode),
//       ],
//       child: const MyApp(), // dental을 굳이 prop으로 넘기지 않아도 됩니다.
//     ),
//   );
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: const SplashScreen(),
//       routes: {
//         '/initRetry': (_) => const InitRetryScreen(),
//         '/login': (_) => LoginScreen(),
//         '/recordSetup': (_) => const RecordSetupScreen(),
//         '/record': (_) => RecordScreen(),
//         '/view': (_) => ViewScreen(),
//         '/materialsAvailable': (_) => MaterialsAvailableScreen(),
//         '/dentalImages': (_) => DentalImagesScreen(),
//         '/supplementaryDetails': (_) => SupplementaryDetailsScreen(),
//         '/dentalFindings': (_) => DentalFindingsScreen(),
//         '/DentalDataScreen': (_) => DentalDataScreen(),
//         '/finalReview': (_) => FinalReviewScreen(),
//         '/settings': (context) => SettingsScreen(),
//       },
//       builder: (context, child) {
//         final offline = context.watch<AppModeProvider>().isOfflineMode;
//         final content = child ?? const SizedBox.shrink(); // ✅ 항상 child 렌더
//
//         return Stack(
//           children: [
//             content,
//             if (offline)
//               IgnorePointer( // ✅ 터치 방해 방지
//                 ignoring: true,
//                 child: Positioned(
//                   top: MediaQuery.of(context).padding.top + 8,
//                   right: 8,
//                   child: DecoratedBox(
//                     decoration: BoxDecoration(
//                       color: Colors.orange.shade800,
//                       borderRadius: BorderRadius.circular(999),
//                     ),
//                     child: const Padding(
//                       padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
//                       child: Row(
//                         children: [
//                           Icon(Icons.cloud_off, size: 14, color: Colors.white),
//                           SizedBox(width: 6),
//                           Text('OFFLINE',
//                               style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//           ],
//         );
//       },
//     );
//   }
// }

// main.dart
import 'dart:async';
import 'package:dental_record_app/providers/app_mode_provider.dart';
import 'package:dental_record_app/services/network_status_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// 상태 관리 클래스
import 'debug_route_logger.dart';
import 'firebase_options.dart';
import 'providers/dental_data_provider.dart';

// 스크린들
import 'screens/splash_screen.dart';
import 'screens/initretry_screen.dart';
import 'screens/login_screen.dart';
import 'screens/record_setup_screen.dart';
import 'screens/record_screen.dart';
import 'screens/view_screen.dart';
import 'screens/materials_available_screen.dart';
import 'screens/dental_images_screen.dart';
import 'screens/supplementary_details_screen.dart';
import 'screens/dental_findings_screen.dart';
import 'screens/final_review_screen.dart';
import 'screens/dental_data_screen.dart';
import 'screens/settings_screen.dart';

import 'package:flutter/foundation.dart' show kIsWeb;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    // 웹은 미리 초기화(옵션은 네 거 그대로)
    await Firebase.initializeApp(options: DefaultFirebaseOptions.web);
  } else {
    await Firebase.initializeApp();
  }

  // 네트워크 감시는 화면 뜬 뒤에 천천히 시작해도 됨.
  final network = NetworkStatus();
  // 오래 걸려도 UI 먼저 띄우기 위해 await 하지 않음
  unawaited(network.init());

  final appMode = AppModeProvider(network);

  // DentalDataProvider는 껍데기만 먼저 올리고,
  // 실제 hydrate는 Splash에서 수행
  final dental = DentalDataProvider();

  // 전역 에러 -> 화면에 표시
  FlutterError.onError = (details) {
    FlutterError.presentError(details);
  };
  ErrorWidget.builder = (details) {
    return Material(
      color: Colors.white,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Text(
          '에러 발생:\n${details.exception}\n\n${details.stack}',
          style: const TextStyle(color: Colors.red),
        ),
      ),
    );
  };

  // main.dart, runApp 전에
  FlutterError.onError = (details) {
    debugPrint('[ERR] FlutterError: ${details.exception}');
    debugPrintStack(stackTrace: details.stack);
    FlutterError.presentError(details);
  };

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: dental),
        ChangeNotifierProvider.value(value: network),
        ChangeNotifierProvider.value(value: appMode),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // 👇 웹이면 바로 로그인으로 진입
      initialRoute: kIsWeb ? '/login' : '/',
      debugShowCheckedModeBanner: false,
      // home: const SplashScreen(),
      navigatorObservers: [RouteLogger()],   // 👈 추가
      routes: {
        '/': (_) => const SplashScreen(),      // 네이티브는 스플래시로 시작
        '/initRetry': (_) => const InitRetryScreen(),
        '/login': (_) => LoginScreen(),
        '/recordSetup': (_) => const RecordSetupScreen(),
        '/record': (_) => RecordScreen(),
        '/view': (_) => ViewScreen(),
        '/materialsAvailable': (_) => MaterialsAvailableScreen(),
        '/dentalImages': (_) => DentalImagesScreen(),
        '/supplementaryDetails': (_) => SupplementaryDetailsScreen(),
        '/dentalFindings': (_) => DentalFindingsScreen(),
        '/DentalDataScreen': (_) => DentalDataScreen(),
        '/finalReview': (_) => FinalReviewScreen(),
        '/settings': (context) => SettingsScreen(),
      },
      // builder: (context, child) {
      //   final offline = context.watch<AppModeProvider>().isOfflineMode;
      //   final content = child ?? const SizedBox.shrink(); // 항상 child 렌더
      //
      //   return Stack(
      //     children: [
      //       content,
      //       if (offline)
      //         IgnorePointer( // 터치 방해 방지
      //           ignoring: true,
      //           child: Positioned(
      //             top: MediaQuery.of(context).padding.top + 8,
      //             right: 8,
      //             child: DecoratedBox(
      //               decoration: BoxDecoration(
      //                 color: Colors.orange.shade800,
      //                 borderRadius: BorderRadius.circular(999),
      //               ),
      //               child: const Padding(
      //                 padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      //                 child: Row(
      //                   children: [
      //                     Icon(Icons.cloud_off, size: 14, color: Colors.white),
      //                     SizedBox(width: 6),
      //                     Text('OFFLINE',
      //                         style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      //                   ],
      //                 ),
      //               ),
      //             ),
      //           ),
      //         ),
      //     ],
      //   );
      // },
      // 🔴 디버깅 중에는 오버레이 비활성화 (원인 분리)
      builder: (context, child) => child ?? const SizedBox.shrink(),
    );
  }
}
