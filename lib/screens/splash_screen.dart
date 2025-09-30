// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class SplashScreen extends StatefulWidget {
//   @override
//   _SplashScreenState createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();
//     _checkLoginState();
//   }
//
//   Future<void> _checkLoginState() async {
//     final prefs = await SharedPreferences.getInstance();
//     final user = FirebaseAuth.instance.currentUser;
//
//     final lastLoginTime = prefs.getInt('last_login_time');
//     final now = DateTime.now().millisecondsSinceEpoch;
//     final expired = lastLoginTime == null || (now - lastLoginTime) > 3600 * 1000;
//
//     if (user != null && !expired) {
//       Navigator.pushReplacementNamed(context, '/recordSetup');
//     } else {
//       await FirebaseAuth.instance.signOut();
//       await prefs.remove('last_login_time');
//       Navigator.pushReplacementNamed(context, '/login');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       body: Center(child: CircularProgressIndicator()),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class SplashScreen extends StatefulWidget {
//   @override
//   _SplashScreenState createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen> {
//   bool _navigated = false;
//
//   @override
//   void initState() {
//     super.initState();
//     // ✅ 첫 프레임 이후에 부팅 로직 실행 (초기 네비게이션 충돌 방지)
//     WidgetsBinding.instance.addPostFrameCallback((_) => _boot());
//   }
//
//   Future<void> _boot() async {
//     try {
//       // (선택) 살짝 딜레이로 로고가 보이도록
//       await Future.delayed(const Duration(milliseconds: 300));
//
//       // ✅ 인증 세션 복원 신호를 1회 기다림 (최대 3초)
//       await FirebaseAuth.instance.authStateChanges().first.timeout(
//         const Duration(seconds: 3),
//         onTimeout: () => null,
//       );
//
//       final prefs = await SharedPreferences.getInstance();
//       final user = FirebaseAuth.instance.currentUser;
//
//       // 🔒 1시간 TTL 체크 (원하면 제거 가능)
//       final lastLoginTime = prefs.getInt('last_login_time');
//       final now = DateTime.now().millisecondsSinceEpoch;
//       final expired = lastLoginTime == null || (now - lastLoginTime) > 3600 * 1000;
//
//       if (!mounted || _navigated) return;
//
//       if (user != null && !expired) {
//         _navigated = true;
//         Navigator.pushReplacementNamed(context, '/recordSetup');
//       } else {
//         await FirebaseAuth.instance.signOut();
//         await prefs.remove('last_login_time');
//         _navigated = true;
//         Navigator.pushReplacementNamed(context, '/login');
//       }
//     } catch (e) {
//       // 에러 시 안전하게 로그인 화면으로
//       if (!mounted || _navigated) return;
//       _navigated = true;
//       Navigator.pushReplacementNamed(context, '/login');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       body: Center(child: CircularProgressIndicator()),
//     );
//   }
// }

// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});
//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen> {
//   bool _navigated = false;
//   Timer? _watchdog;
//
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) => _boot());
//   }
//
//   Future<void> _boot() async {
//     // 최후 안전장치: 6초 내 못 넘기면 재시도 화면으로
//     _watchdog = Timer(const Duration(seconds: 6), () {
//       _goInitRetry();
//     });
//
//     try {
//       await Future.delayed(const Duration(milliseconds: 200)); // 로고 살짝 보여주기
//
//       // (1) Firebase 초기화 시도 (최대 3초)
//       bool firebaseReady = false;
//       try {
//         await Firebase.initializeApp().timeout(const Duration(seconds: 3));
//         firebaseReady = true;
//       } catch (_) {
//         firebaseReady = false; // 타임아웃/실패
//       }
//
//       // (2) SharedPreferences 준비 + 기본값 시드(Null 가드)
//       final prefs = await SharedPreferences.getInstance();
//       await _seedDefaults(prefs);
//
//       // (3) 인증 세션 신호 기다림 (최대 2초) — Firebase OK일 때만 의미 있음
//       if (firebaseReady) {
//         try {
//           await FirebaseAuth.instance.authStateChanges().first
//               .timeout(const Duration(seconds: 2));
//         } catch (_) {}
//       }
//
//       if (!mounted || _navigated) return;
//
//       if (firebaseReady) {
//         // Firebase 성공 → 정상 흐름
//         final user = FirebaseAuth.instance.currentUser;
//         _safeGo(user != null ? '/recordSetup' : '/login');
//       } else {
//         // Firebase 아직 준비 안 됨 → 재시도 화면으로 이동(여기서 백그라운드 계속 시도)
//         _goInitRetry();
//       }
//     } catch (_) {
//       _goInitRetry(); // 어떤 예외든 재시도 화면으로
//     }
//   }
//
//   Future<void> _seedDefaults(SharedPreferences prefs) async {
//     const defaults = {
//       'schemaVersion': 1,
//       'recordType': 'PM',
//       'amNumber': '',
//       'pmNumber': '',
//     };
//     for (final entry in defaults.entries) {
//       if (!prefs.containsKey(entry.key)) {
//         final v = entry.value;
//         if (v is int) await prefs.setInt(entry.key, v);
//         if (v is String) await prefs.setString(entry.key, v);
//         if (v is bool) await prefs.setBool(entry.key, v);
//       }
//     }
//   }
//
//   void _goInitRetry() {
//     _safeGo('/initRetry');
//   }
//
//   void _safeGo(String route) {
//     if (!mounted || _navigated) return;
//     _navigated = true;
//     _watchdog?.cancel();
//     Navigator.pushReplacementNamed(context, route);
//   }
//
//   @override
//   void dispose() {
//     _watchdog?.cancel();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       body: Center(child: CircularProgressIndicator()),
//     );
//   }
// }

// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});
//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen> with WidgetsBindingObserver {
//   // ---- Configurable timeouts ----
//   static const _kLogoDelay = Duration(milliseconds: 200);
//   static const _kInitTimeout = Duration(seconds: 10);   // Firebase init
//   static const _kSignInTimeout = Duration(seconds: 8);  // Anonymous sign-in
//   static const _kHydrateTimeout = Duration(seconds: 5); // (있다면) hydrate 용
//   static const _kWatchdog = Duration(seconds: 12);      // 최후 안전장치
//
//   bool _navigated = false;   // 중복 네비 방지
//   bool _booting = false;     // 동시 부팅 방지
//   Timer? _watchdog;
//
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addObserver(this);
//     // 첫 프레임 이후 부팅 시작 (Navigator 안전)
//     WidgetsBinding.instance.addPostFrameCallback((_) => _boot());
//   }
//
//   @override
//   void dispose() {
//     WidgetsBinding.instance.removeObserver(this);
//     _watchdog?.cancel();
//     super.dispose();
//   }
//
//   // 앱이 다시 foreground로 올라올 때도 부팅 점검
//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     if (!mounted || _navigated) return;
//     if (state == AppLifecycleState.resumed && !_booting) {
//       _boot();
//     }
//   }
//
//   Future<void> _boot() async {
//     if (!mounted || _navigated || _booting) return;
//     _booting = true;
//
//     // 최후 안전장치: 일정 시간 내에 못 빠져나가면 재시도 화면으로
//     _watchdog?.cancel();
//     _watchdog = Timer(_kWatchdog, _goInitRetry);
//
//     try {
//       // 로고 약간 노출
//       await Future.delayed(_kLogoDelay);
//
//       // (1) SharedPreferences 준비 + 기본값 시드
//       final prefs = await SharedPreferences.getInstance();
//       await _seedDefaults(prefs);
//
//       // (2) Firebase 초기화 보장 (이미 초기화되어 있으면 skip)
//       bool firebaseReady = await _ensureFirebaseInitialized();
//
//       // (3) 인증 세션 보장 (firebaseReady일 때만 의미 있음)
//       if (firebaseReady) {
//         await _ensureAuthSession();
//       }
//
//       if (!mounted || _navigated) return;
//
//       // (4) 라우팅 결정
//       if (firebaseReady) {
//         // 로그인 되어 있으면 레코드 설정으로, 아니면 로그인으로
//         final user = FirebaseAuth.instance.currentUser;
//         _safeGo(user != null ? '/recordSetup' : '/login');
//       } else {
//         // 오프라인/초기화 실패 시: 선택 1) 재시도 화면
//         // _goInitRetry();
//
//         // 선택 2) 오프라인 모드로 바로 진입하고, 이후 화면에서 Firebase 재시도(권장)
//         // 필요에 맞게 둘 중 하나 택하세요. 아래는 오프라인 진입 예시:
//         _safeGo('/recordSetup');
//       }
//     } catch (e, st) {
//       // 치명 실패 시 재시도 화면
//       FlutterError.reportError(FlutterErrorDetails(exception: e, stack: st));
//       if (!mounted) return;
//       _goInitRetry();
//     } finally {
//       _booting = false;
//     }
//   }
//
//   /// Firebase 초기화 (이미 초기화되어 있으면 빠르게 true)
//   Future<bool> _ensureFirebaseInitialized() async {
//     try {
//       if (Firebase.apps.isNotEmpty) return true;
//       await Firebase.initializeApp().timeout(_kInitTimeout);
//       return true;
//     } catch (_) {
//       // 네트워크/권한 문제 등으로 실패할 수 있음
//       return false;
//     }
//   }
//
//   /// 인증 세션 확보: 현재 유저가 없으면 익명 로그인(실패해도 앱 진입은 허용)
//   Future<void> _ensureAuthSession() async {
//     try {
//       final auth = FirebaseAuth.instance;
//       if (auth.currentUser == null) {
//         // 익명 로그인 시도 (네트워크 지연 대비 타임아웃)
//         await auth.signInAnonymously().timeout(_kSignInTimeout);
//       }
//       // 굳이 authStateChanges().first 를 기다릴 필요 없음
//     } catch (_) {
//       // 오프라인/타임아웃 등 실패 → 이후 화면에서 재시도 가능하므로 무시
//     }
//   }
//
//   Future<void> _seedDefaults(SharedPreferences prefs) async {
//     const defaults = {
//       'schemaVersion': 1,
//       'recordType': 'PM',
//       'amNumber': '',
//       'pmNumber': '',
//     };
//     for (final entry in defaults.entries) {
//       if (!prefs.containsKey(entry.key)) {
//         final v = entry.value;
//         if (v is int) await prefs.setInt(entry.key, v);
//         if (v is String) await prefs.setString(entry.key, v);
//         if (v is bool) await prefs.setBool(entry.key, v);
//       }
//     }
//   }
//
//   void _goInitRetry() {
//     _safeGo('/initRetry');
//   }
//
//   void _safeGo(String route) {
//     if (!mounted || _navigated) return;
//     _navigated = true;
//     _watchdog?.cancel();
//
//     scheduleMicrotask(() {
//       if (!mounted) return;
//       Navigator.of(context, rootNavigator: true).pushReplacementNamed(route);
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       body: Center(child: CircularProgressIndicator()),
//     );
//   }
// }

// // splash_screen.dart
// import 'dart:async' show Timer, scheduleMicrotask;
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../providers/app_mode_provider.dart';
// import '../providers/dental_data_provider.dart';
// import '../services/local_store.dart';
//
// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});
//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen> with WidgetsBindingObserver {
//   // ---- Configurable timeouts ----
//   static const _kLogoDelay = Duration(milliseconds: 200);
//   static const _kInitTimeout = Duration(seconds: 10);   // Firebase init
//   static const _kSignInTimeout = Duration(seconds: 8);  // Anonymous sign-in
//   static const _kWatchdog = Duration(seconds: 12);      // 최후 안전장치
//
//   bool _navigated = false;   // 중복 네비 방지
//   bool _booting = false;     // 동시 부팅 방지
//   Timer? _watchdog;
//
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addObserver(this);
//     // 첫 프레임 이후 부팅 시작 (Navigator 안전)
//     WidgetsBinding.instance.addPostFrameCallback((_) => _boot());
//   }
//
//   @override
//   void dispose() {
//     WidgetsBinding.instance.removeObserver(this);
//     _watchdog?.cancel();
//     super.dispose();
//   }
//
//   // 앱이 다시 foreground로 올라올 때도 부팅 점검
//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     if (!mounted || _navigated) return;
//     if (state == AppLifecycleState.resumed && !_booting) {
//       _boot();
//     }
//   }
//
//   Future<void> _boot() async {
//     if (!mounted || _navigated || _booting) return;
//     _booting = true;
//
//     // 최후 안전장치: 일정 시간 내에 못 빠져나가면 재시도 화면으로
//     _watchdog?.cancel();
//     _watchdog = Timer(_kWatchdog, _goInitRetry);
//
//     try {
//       // 로고 약간 노출
//       await Future.delayed(_kLogoDelay);
//
//       // (1) SharedPreferences 기본값 시드
//       final prefs = await SharedPreferences.getInstance();
//       await _seedDefaults(prefs);
//
//       // (2) 로컬 저장 & 상태 하이드레이트 (오프라인 우선)
//       await LocalStore.init(inMemory: false);
//       final dental = context.read<DentalDataProvider>();
//       await dental.hydrate();
//
//       // (3) Firebase 초기화 보장 (이미 초기화되어 있으면 skip)
//       final firebaseReady = await _ensureFirebaseInitialized();
//
//       // (4) 인증 세션 보장 (firebaseReady일 때만 의미 있음)
//       if (firebaseReady) {
//         await _ensureAuthSession();
//       }
//
//       // if (!mounted || _navigated) return;
//
//       if (firebaseReady && mounted) {
//         context.read<AppModeProvider>().onFirebaseReady();
//       }
//
//       // (5) 라우팅 결정
//       if (firebaseReady) {
//         final user = FirebaseAuth.instance.currentUser;
//         _safeGo(user != null ? '/recordSetup' : '/login');
//       } else {
//         // 오프라인 모드로 바로 진입 (이후 화면에서 재시도)
//         _safeGo('/recordSetup');
//       }
//     } catch (e, st) {
//       // 치명 실패 시 재시도 화면
//       FlutterError.reportError(FlutterErrorDetails(exception: e, stack: st));
//       if (!mounted) return;
//       _goInitRetry();
//     } finally {
//       _booting = false;
//     }
//   }
//
//   /// Firebase 초기화 (이미 초기화되어 있으면 빠르게 true)
//   Future<bool> _ensureFirebaseInitialized() async {
//     try {
//       if (Firebase.apps.isNotEmpty) return true;
//       await Firebase.initializeApp().timeout(_kInitTimeout);
//       return true;
//     } catch (_) {
//       // 네트워크/권한 문제 등으로 실패할 수 있음
//       return false;
//     }
//   }
//
//   /// 인증 세션 확보: 현재 유저가 없으면 익명 로그인(실패해도 앱 진입은 허용)
//   Future<void> _ensureAuthSession() async {
//     try {
//       final auth = FirebaseAuth.instance;
//       if (auth.currentUser == null) {
//         await auth.signInAnonymously().timeout(_kSignInTimeout);
//       }
//     } catch (_) {
//       // 오프라인/타임아웃 등 실패 → 이후 화면에서 재시도 가능하므로 무시
//     }
//   }
//
//   Future<void> _seedDefaults(SharedPreferences prefs) async {
//     const defaults = {
//       'schemaVersion': 1,
//       'recordType': 'PM',
//       'amNumber': '',
//       'pmNumber': '',
//     };
//     for (final entry in defaults.entries) {
//       if (!prefs.containsKey(entry.key)) {
//         final v = entry.value;
//         if (v is int) await prefs.setInt(entry.key, v);
//         if (v is String) await prefs.setString(entry.key, v);
//         if (v is bool) await prefs.setBool(entry.key, v);
//       }
//     }
//   }
//
//   void _goInitRetry() {
//     _safeGo('/initRetry');
//   }
//
//   void _safeGo(String route) {
//     if (!mounted || _navigated) return;
//     _navigated = true;
//     _watchdog?.cancel();
//
//     // 전역 오버레이/프레임 경합 회피
//     scheduleMicrotask(() {
//       if (!mounted) return;
//       Navigator.of(context, rootNavigator: true).pushReplacementNamed(route);
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       body: Center(child: CircularProgressIndicator()),
//     );
//   }
// }

// lib/screens/splash_screen.dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../providers/dental_data_provider.dart';

import 'package:flutter/foundation.dart' show kIsWeb, debugPrint;
import '../firebase_options.dart';
import '../utils/auth_persistence.dart'; // 경로 맞게

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with WidgetsBindingObserver {

  static final _kInitTimeout  = kIsWeb ? const Duration(seconds: 20) : const Duration(seconds: 10);
  static final _kSignInTimeout = kIsWeb ? const Duration(seconds: 15) : const Duration(seconds: 8);
  static const _kLogoDelay = Duration(milliseconds: 200);
  static const _kWatchdog = Duration(seconds: 12);

  bool _navigated = false;
  bool _booting = false;
  Timer? _watchdog;

  String? _fatal;

  void _log(String m) => debugPrint('[SPLASH] $m');

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) => _boot());
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _watchdog?.cancel();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (!mounted || _navigated) return;
    if (state == AppLifecycleState.resumed && !_booting) {
      _log('resumed -> re-boot');
      _boot();
    }
  }

  Future<void> _boot() async {
    if (!mounted || _navigated || _booting) return;
    _booting = true;
    _log('boot() start');

    _watchdog?.cancel();
    if (!kIsWeb) {
      _watchdog = Timer(_kWatchdog, () {
        _log('WATCHDOG fired -> go /initRetry');
        _goInitRetry();
      });
    } else {
      _log('watchdog disabled on web');
    }

    try {
      _log('logo delay');
      await Future.delayed(_kLogoDelay);

      // try {
      //   _log('SharedPreferences.getInstance()');
      //   final prefs = await SharedPreferences.getInstance()
      //       .timeout(const Duration(seconds: 3));
      //   await _seedDefaults(prefs);
      //   _log('seed defaults OK');
      // } catch (e, st) {
      //   if (kIsWeb) {
      //     // iOS Safari/PWA에서 localStorage/IndexedDB가 막힌 경우 등
      //     _log('SharedPreferences unavailable on web → skip seeding: $e');
      //     // 웹에서는 무시하고 계속 진행
      //   } else {
      //     _log('SharedPreferences fatal on native → rethrow');
      //     // 네이티브에서는 기존 로직대로 바깥 try/catch로 던져서 /initRetry로
      //     rethrow;
      //   }
      // }

      // 기존 try-catch 블록 지우고 아래로 교체
      if (!kIsWeb) {
        _log('SharedPreferences.getInstance()');
        final prefs = await SharedPreferences.getInstance()
            .timeout(const Duration(seconds: 3));
        await _seedDefaults(prefs);
        _log('seed defaults OK');
      } else {
        _log('Web → skip SharedPreferences seed (Safari/PWA storage issues)');
      }


      _log('Firebase.apps.length=${Firebase.apps.length}');
      final firebaseReady = await _ensureFirebaseInitialized();
      _log('Firebase ready=$firebaseReady, apps=${Firebase.apps.length}');

      if (firebaseReady) {
        _log('ensureAuthSession() start');
        await _ensureAuthSession();
        final user = FirebaseAuth.instance.currentUser;
        _log('ensureAuthSession() done, user=${user?.uid ?? "null"}');
      }

      if (!mounted || _navigated) {
        _log('already navigated or unmounted, return');
        return;
      }

      if (firebaseReady) {
        final user = FirebaseAuth.instance.currentUser;
        final route = user != null ? '/recordSetup' : '/login';
        _log('routing -> $route');
        _safeGo(route);
        if (user != null) {
          final dental = Provider.of<DentalDataProvider>(context, listen: false);
          dental.startIncidentLockListener();
        }
      } else {
        _log('firebase NOT ready -> offline route /recordSetup');
        _safeGo('/recordSetup');
      }
    } catch (e, st) {
      _fatal = '$e';
      _log('FATAL: $e');
      _log('$st');
      if (!mounted) return;
      if (kIsWeb) {
        // ✅ 웹은 initRetry 대신 로그인 화면으로 안전 폴백
        _log('web fatal during boot → safeGo(/login)');
        _safeGo('/login');
        return;
      } else {
        _goInitRetry();
      }
    } finally {
      _booting = false;
      _log('boot() end');
    }
  }

  Future<bool> _ensureFirebaseInitialized() async {
    try {
      if (Firebase.apps.isNotEmpty) return true;

      if (kIsWeb) {
        await Firebase.initializeApp(
          options: DefaultFirebaseOptions.web, // 웹만 옵션 사용
        ).timeout(_kInitTimeout);
      } else {
        await Firebase.initializeApp().timeout(_kInitTimeout);
      }
      return true;
    } catch (e, st) {
      debugPrint('Firebase init FAIL: $e');
      debugPrint('$st');
      return false;
    }
  }

  // Future<void> _ensureAuthSession() async {
  //   try {
  //     final auth = FirebaseAuth.instance;
  //     if (auth.currentUser == null) {
  //       _log('signInAnonymously start');
  //       await auth.signInAnonymously().timeout(_kSignInTimeout);
  //       _log('signInAnonymously OK -> uid=${auth.currentUser?.uid}');
  //     } else {
  //       _log('already signed in -> uid=${auth.currentUser?.uid}');
  //     }
  //   } catch (e, st) {
  //     _log('signIn FAIL: $e');
  //     _log('$st');
  //   }
  // }

  Future<void> _ensureAuthSession() async {
    try {
      // ✅ 웹 환경일 때만 내부에서 LOCAL/SESSION/NONE 고름
      await setBestWebPersistence();

      final user = FirebaseAuth.instance.currentUser;
      _log('auth session -> ${user?.uid ?? "null"}');
    } catch (e, st) {
      _log('auth session check FAIL: $e'); _log('$st');
    }
  }

  Future<void> _seedDefaults(SharedPreferences prefs) async {
    const defaults = {
      'schemaVersion': 1,
      'recordType': 'PM',
      'amNumber': '',
      'pmNumber': '',
    };
    for (final entry in defaults.entries) {
      if (!prefs.containsKey(entry.key)) {
        final v = entry.value;
        if (v is int) await prefs.setInt(entry.key, v);
        if (v is String) await prefs.setString(entry.key, v);
        if (v is bool) await prefs.setBool(entry.key, v);
      }
    }
  }

  void _goInitRetry() {
    _safeGo('/initRetry');
  }

  void _safeGo(String route) {
    if (!mounted || _navigated) return;
    _navigated = true;
    _watchdog?.cancel();
    _log('Navigator.pushReplacementNamed($route)');
    // 프레임 충돌 방지
    scheduleMicrotask(() {
      if (!mounted) return;
      Navigator.of(context, rootNavigator: true).pushReplacementNamed(route);
    });
  }

  @override
  Widget build(BuildContext context) {
    _log('build()');
    return Scaffold(
      body: Stack(
        children: [
          const Center(child: CircularProgressIndicator()),
          if (_fatal != null && kIsWeb)
            Positioned(
              left: 8, right: 8, bottom: 8,
              child: Container(
                padding: const EdgeInsets.all(8),
                color: Colors.black87,
                child: Text('Boot error: $_fatal',
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:flutter/foundation.dart' show kIsWeb, debugPrint;
//
// import '../providers/dental_data_provider.dart';
// import '../firebase_options.dart';
//
// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});
//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen> with WidgetsBindingObserver {
//   static final _kInitTimeout  = kIsWeb ? const Duration(seconds: 20) : const Duration(seconds: 10);
//   static final _kSignInTimeout = kIsWeb ? const Duration(seconds: 15) : const Duration(seconds: 8);
//   static const _kLogoDelay = Duration(milliseconds: 200);
//   static const _kWatchdog = Duration(seconds: 12);
//
//   bool _navigated = false;
//   bool _booting = false;
//   Timer? _watchdog;
//   String? _fatal;
//
//   void _log(String m) => debugPrint('[SPLASH] $m');
//
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addObserver(this);
//     WidgetsBinding.instance.addPostFrameCallback((_) => _boot());
//   }
//
//   @override
//   void dispose() {
//     WidgetsBinding.instance.removeObserver(this);
//     _watchdog?.cancel();
//     super.dispose();
//   }
//
//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     if (!mounted || _navigated) return;
//     if (state == AppLifecycleState.resumed && !_booting) {
//       _log('resumed -> re-boot');
//       _boot();
//     }
//   }
//
//   Future<void> _boot() async {
//     if (!mounted || _navigated || _booting) return;
//     _booting = true;
//     _log('boot() start');
//
//     _watchdog?.cancel();
//     if (!kIsWeb) {
//       _watchdog = Timer(_kWatchdog, () {
//         _log('WATCHDOG fired -> go /initRetry');
//         _goInitRetry();
//       });
//     } else {
//       _log('watchdog disabled on web');
//     }
//
//     try {
//       _log('logo delay');
//       await Future.delayed(_kLogoDelay);
//
//       // 웹은 SharedPreferences 스킵 (사파리 PWA 저장소 이슈)
//       if (!kIsWeb) {
//         _log('SharedPreferences.getInstance()');
//         final prefs = await SharedPreferences.getInstance()
//             .timeout(const Duration(seconds: 3));
//         await _seedDefaults(prefs);
//         _log('seed defaults OK');
//       } else {
//         _log('Web → skip SharedPreferences seed');
//       }
//
//       _log('Firebase.apps.length=${Firebase.apps.length}');
//       final firebaseReady = await _ensureFirebaseInitialized();
//       _log('Firebase ready=$firebaseReady, apps=${Firebase.apps.length}');
//
//       if (firebaseReady) {
//         _log('ensureAuthSession() start');
//         await _ensureAuthSession();
//         final user = FirebaseAuth.instance.currentUser;
//         _log('ensureAuthSession() done, user=${user?.uid ?? "null"}');
//       }
//
//       if (!mounted || _navigated) {
//         _log('already navigated or unmounted, return');
//         return;
//       }
//
//       if (firebaseReady) {
//         final user = FirebaseAuth.instance.currentUser;
//         final route = user != null ? '/recordSetup' : '/login';
//         _log('routing -> $route');
//         _safeGo(route);
//         if (user != null) {
//           final dental = Provider.of<DentalDataProvider>(context, listen: false);
//           dental.startIncidentLockListener();
//         }
//       } else {
//         _log('firebase NOT ready -> offline route /recordSetup');
//         _safeGo('/recordSetup');
//       }
//     } catch (e, st) {
//       _fatal = '$e';
//       _log('FATAL: $e');
//       _log('$st');
//       if (!mounted) return;
//       if (kIsWeb) {
//         _log('web fatal during boot → safeGo(/login)');
//         _safeGo('/login');
//         return;
//       } else {
//         _goInitRetry();
//       }
//     } finally {
//       _booting = false;
//       _log('boot() end');
//     }
//   }
//
//   Future<bool> _ensureFirebaseInitialized() async {
//     try {
//       if (Firebase.apps.isNotEmpty) return true;
//
//       if (kIsWeb) {
//         await Firebase.initializeApp(
//           options: DefaultFirebaseOptions.web,
//         ).timeout(_kInitTimeout);
//       } else {
//         await Firebase.initializeApp().timeout(_kInitTimeout);
//       }
//       return true;
//     } catch (e, st) {
//       debugPrint('Firebase init FAIL: $e');
//       debugPrint('$st');
//       return false;
//     }
//   }
//
//   Future<void> _ensureAuthSession() async {
//     try {
//       if (kIsWeb) {
//         // iOS Safari/PWA에서 SESSION 실패 시 NONE으로 폴백
//         try {
//           await FirebaseAuth.instance.setPersistence(Persistence.SESSION);
//         } catch (e) {
//           _log('setPersistence SESSION failed → try NONE: $e');
//           try {
//             await FirebaseAuth.instance.setPersistence(Persistence.NONE);
//           } catch (e2) {
//             _log('setPersistence NONE also failed: $e2');
//           }
//         }
//       }
//       final user = FirebaseAuth.instance.currentUser;
//       _log('auth session -> ${user?.uid ?? "null"}');
//     } catch (e, st) {
//       _log('auth session check FAIL: $e'); _log('$st');
//     }
//   }
//
//   Future<void> _seedDefaults(SharedPreferences prefs) async {
//     const defaults = {
//       'schemaVersion': 1,
//       'recordType': 'PM',
//       'amNumber': '',
//       'pmNumber': '',
//     };
//     for (final entry in defaults.entries) {
//       if (!prefs.containsKey(entry.key)) {
//         final v = entry.value;
//         if (v is int)    await prefs.setInt(entry.key, v);
//         if (v is String) await prefs.setString(entry.key, v);
//         if (v is bool)   await prefs.setBool(entry.key, v);
//       }
//     }
//   }
//
//   void _goInitRetry() {
//     _safeGo('/initRetry');
//   }
//
//   void _safeGo(String route) {
//     if (!mounted || _navigated) return;
//     _navigated = true;
//     _watchdog?.cancel();
//     _log('Navigator.pushReplacementNamed($route)');
//     scheduleMicrotask(() {
//       if (!mounted) return;
//       Navigator.of(context, rootNavigator: true).pushReplacementNamed(route);
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     _log('build()');
//     return Scaffold(
//       body: Stack(
//         children: [
//           const Center(child: CircularProgressIndicator()),
//           if (_fatal != null && kIsWeb)
//             Positioned(
//               left: 8, right: 8, bottom: 8,
//               child: Container(
//                 padding: const EdgeInsets.all(8),
//                 color: Colors.black87,
//                 child: Text(
//                   'Boot error: $_fatal',
//                   style: const TextStyle(color: Colors.white, fontSize: 12),
//                 ),
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }

