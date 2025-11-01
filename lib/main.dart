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
// import 'dart:async';
// import 'package:dental_record_app/providers/app_mode_provider.dart';
// import 'package:dental_record_app/services/network_status_service.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// // 상태 관리 클래스
// import 'debug_route_logger.dart';
// import 'firebase_options.dart';
// import 'providers/dental_data_provider.dart';
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
// import 'package:flutter/foundation.dart' show kIsWeb;
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//
//   if (kIsWeb) {
//     // 웹은 미리 초기화(옵션은 네 거 그대로)
//     await Firebase.initializeApp(options: DefaultFirebaseOptions.web);
//   } else {
//     await Firebase.initializeApp();
//   }
//
//   // 네트워크 감시는 화면 뜬 뒤에 천천히 시작해도 됨.
//   final network = NetworkStatus();
//   // 오래 걸려도 UI 먼저 띄우기 위해 await 하지 않음
//   unawaited(network.init());
//
//   final appMode = AppModeProvider(network);
//
//   // DentalDataProvider는 껍데기만 먼저 올리고,
//   // 실제 hydrate는 Splash에서 수행
//   final dental = DentalDataProvider();
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
//   // main.dart, runApp 전에
//   FlutterError.onError = (details) {
//     debugPrint('[ERR] FlutterError: ${details.exception}');
//     debugPrintStack(stackTrace: details.stack);
//     FlutterError.presentError(details);
//   };
//
//   runApp(
//     MultiProvider(
//       providers: [
//         ChangeNotifierProvider.value(value: dental),
//         ChangeNotifierProvider.value(value: network),
//         ChangeNotifierProvider.value(value: appMode),
//       ],
//       child: const MyApp(),
//     ),
//   );
// }
//
// class MyApp extends StatefulWidget {
//   const MyApp({super.key});
//   @override
//   State<MyApp> createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addObserver(this);
//   }
//
//   @override
//   void dispose() {
//     WidgetsBinding.instance.removeObserver(this);
//     super.dispose();
//   }
//
//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     final dental = context.read<DentalDataProvider>();
//     switch (state) {
//       case AppLifecycleState.paused:
//       case AppLifecycleState.inactive:
//         dental.onAppPaused();
//         break;
//       case AppLifecycleState.resumed:
//         dental.onAppResumed();
//         break;
//       default:
//         break;
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       initialRoute: kIsWeb ? '/login' : '/',
//       debugShowCheckedModeBanner: false,
//       navigatorObservers: [RouteLogger()],
//       routes: {
//         '/': (_) => const SplashScreen(),
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
//       builder: (context, child) => child ?? const SizedBox.shrink(),
//     );
//   }
// }
//

// import 'dart:async';
// import 'package:dental_record_app/providers/app_mode_provider.dart';
// import 'package:dental_record_app/services/network_status_service.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// import 'debug_route_logger.dart';
// import 'firebase_options.dart';
// import 'providers/dental_data_provider.dart';
//
// // screens
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
// import 'package:flutter/foundation.dart' show kIsWeb;
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//
//   if (kIsWeb) {
//     await Firebase.initializeApp(options: DefaultFirebaseOptions.web);
//   } else {
//     await Firebase.initializeApp();
//   }
//
//   final network = NetworkStatus();
//   unawaited(network.init());
//
//   runApp(
//     MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (_) => DentalDataProvider()),
//         ChangeNotifierProvider(create: (_) => network),
//         ChangeNotifierProvider(create: (ctx) => AppModeProvider(ctx.read<NetworkStatus>())),
//       ],
//       child: const MyApp(),
//     ),
//   );
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     // 단일 에러 핸들러
//     FlutterError.onError = (details) {
//       debugPrint('[ERR] FlutterError: ${details.exception}');
//       debugPrintStack(stackTrace: details.stack);
//       FlutterError.presentError(details);
//     };
//
//     ErrorWidget.builder = (details) {
//       return Material(
//         color: Colors.white,
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(16),
//           child: Text(
//             '에러 발생:\n${details.exception}\n\n${details.stack}',
//             style: const TextStyle(color: Colors.red),
//           ),
//         ),
//       );
//     };
//
//     return MaterialApp(
//       // 네이티브는 스플래시부터, 웹은 로그인부터
//       initialRoute: kIsWeb ? '/login' : '/',
//       debugShowCheckedModeBanner: false,
//       navigatorObservers: [RouteLogger()],
//       routes: {
//         '/': (_) => const SplashScreen(),
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
//         '/settings': (_) => SettingsScreen(),
//       },
//       // ✅ 앱 전체를 라이프사이클 감시 위젯으로 감싼다 (resume 때 hydrate)
//       builder: (context, child) => _AppLifecycleRehydrator(
//         child: child ?? const SizedBox.shrink(),
//       ),
//     );
//   }
// }
//
// /// ─────────────────────────────────────────────────────────
// /// 간단 라이프사이클 훅:
// ///  - resumed 때 항상 DentalDataProvider.hydrate() 호출
// ///  - 장시간 백그라운드/프로세스 데스 후에도 안전 복귀
// /// ─────────────────────────────────────────────────────────
// class _AppLifecycleRehydrator extends StatefulWidget {
//   final Widget child;
//   const _AppLifecycleRehydrator({required this.child});
//
//   @override
//   State<_AppLifecycleRehydrator> createState() => _ALRState();
// }
//
// class _ALRState extends State<_AppLifecycleRehydrator> with WidgetsBindingObserver {
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addObserver(this);
//   }
//
//   @override
//   void dispose() {
//     WidgetsBinding.instance.removeObserver(this);
//     super.dispose();
//   }
//
//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) async {
//     if (state == AppLifecycleState.resumed) {
//       // 프로세스가 살아있든 죽었다 새로 떴든, 재개 시엔 항상 로컬 상태 복원 시도
//       await context.read<DentalDataProvider>().hydrate();
//       // 필요 시 특정 화면으로 복귀하고 싶다면 아래 주석 해제:
//       // if (!mounted) return;
//       // Navigator.of(context).pushNamedAndRemoveUntil('/record', (r) => false);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) => widget.child;
// }

import 'dart:async';
import 'package:dental_record_app/providers/app_mode_provider.dart';
import 'package:dental_record_app/services/network_status_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'debug_route_logger.dart';
import 'firebase_options.dart';
import 'providers/dental_data_provider.dart';

// screens
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
import 'package:shared_preferences/shared_preferences.dart';

Future<void> _ensureFirebase() async {
  if (Firebase.apps.isEmpty) {
    if (kIsWeb) {
      await Firebase.initializeApp(options: DefaultFirebaseOptions.web);
    } else {
      await Firebase.initializeApp();
    }
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _ensureFirebase();

  final network = NetworkStatus();
  unawaited(network.init());

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DentalDataProvider()),
        ChangeNotifierProvider(create: (_) => network),
        ChangeNotifierProvider(create: (ctx) => AppModeProvider(ctx.read<NetworkStatus>())),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    FlutterError.onError = (details) {
      debugPrint('[ERR] FlutterError: ${details.exception}');
      debugPrintStack(stackTrace: details.stack);
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

    return MaterialApp(
      initialRoute: kIsWeb ? '/login' : '/',
      debugShowCheckedModeBanner: false,
      navigatorObservers: [RouteLogger()],
      routes: {
        '/': (_) => const SplashScreen(),
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
        '/settings': (_) => SettingsScreen(),
      },
      builder: (context, child) => _AppLifecycleGuard(
        child: child ?? const SizedBox.shrink(),
      ),
    );
  }
}

/// 앱 재개 시 process death 여부 판별 + 안전 복구
class _AppLifecycleGuard extends StatefulWidget {
  final Widget child;
  const _AppLifecycleGuard({required this.child});

  @override
  State<_AppLifecycleGuard> createState() => _AppLifecycleGuardState();
}

class _AppLifecycleGuardState extends State<_AppLifecycleGuard>
    with WidgetsBindingObserver {
  static const _kSessionKey = 'app_session_id';
  static const _kLastPauseAt = 'last_pause_at';
  late String _sessionId;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _sessionId = DateTime.now().microsecondsSinceEpoch.toString();
    // 세션 기록 (이 값은 프로세스 단위로만 유지됨)
    _savePrefs((_prefs) async {
      await _prefs.setString(_kSessionKey, _sessionId);
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.inactive || state == AppLifecycleState.paused) {
      // 백그라운드로 나갈 때 타임스탬프 저장
      await _savePrefs((p) async {
        await p.setInt(_kLastPauseAt, DateTime.now().millisecondsSinceEpoch);
      });
      return;
    }

    if (state == AppLifecycleState.resumed) {
      // 1) Firebase 보장
      await _ensureFirebase();

      // 2) process death / 장시간 백그라운드 여부 판단
      final decision = await _shouldColdRestore();

      // 3) 항상 상태 복원 시도 (가벼움)
      await context.read<DentalDataProvider>().hydrate();

      // 4) 필요 시 안전 라우트로 강제 복귀 (스플래시 or 기록 화면)
      if (!mounted) return;
      if (decision == _RestoreDecision.fullResetToSplash) {
        Navigator.of(context).pushNamedAndRemoveUntil('/', (r) => false);
      } else if (decision == _RestoreDecision.resetToRecord) {
        Navigator.of(context).pushNamedAndRemoveUntil('/record', (r) => false);
      }
    }
  }

  /// 의사결정: 프로세스가 새로 떴거나, 백그라운드가 너무 길면 안전 복귀
  Future<_RestoreDecision> _shouldColdRestore() async {
    final prefs = await SharedPreferences.getInstance();

    final stored = prefs.getString(_kSessionKey);
    final lastPauseMs = prefs.getInt(_kLastPauseAt) ?? 0;
    final elapsedMin = lastPauseMs == 0
        ? 0
        : DateTime.now()
        .difference(DateTime.fromMillisecondsSinceEpoch(lastPauseMs))
        .inMinutes;

    // 프로세스가 죽었다(세션이 바뀌었다) → 스플래시로 완전 복구
    if (stored != _sessionId) {
      // 새 세션 ID로 갱신
      await prefs.setString(_kSessionKey, _sessionId);
      return _RestoreDecision.fullResetToSplash;
    }

    // 장시간(>=8분 등) 백그라운드 → 기록 화면으로 안전 복귀
    if (elapsedMin >= 8) {
      return _RestoreDecision.resetToRecord;
    }

    return _RestoreDecision.noReset;
  }

  Future<void> _savePrefs(Future<void> Function(SharedPreferences) run) async {
    final p = await SharedPreferences.getInstance();
    await run(p);
  }

  @override
  Widget build(BuildContext context) => widget.child;
}

enum _RestoreDecision { noReset, resetToRecord, fullResetToSplash }
