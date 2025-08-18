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

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _navigated = false;

  @override
  void initState() {
    super.initState();
    // ✅ 첫 프레임 이후에 부팅 로직 실행 (초기 네비게이션 충돌 방지)
    WidgetsBinding.instance.addPostFrameCallback((_) => _boot());
  }

  Future<void> _boot() async {
    try {
      // (선택) 살짝 딜레이로 로고가 보이도록
      await Future.delayed(const Duration(milliseconds: 300));

      // ✅ 인증 세션 복원 신호를 1회 기다림 (최대 3초)
      await FirebaseAuth.instance.authStateChanges().first.timeout(
        const Duration(seconds: 3),
        onTimeout: () => null,
      );

      final prefs = await SharedPreferences.getInstance();
      final user = FirebaseAuth.instance.currentUser;

      // 🔒 1시간 TTL 체크 (원하면 제거 가능)
      final lastLoginTime = prefs.getInt('last_login_time');
      final now = DateTime.now().millisecondsSinceEpoch;
      final expired = lastLoginTime == null || (now - lastLoginTime) > 3600 * 1000;

      if (!mounted || _navigated) return;

      if (user != null && !expired) {
        _navigated = true;
        Navigator.pushReplacementNamed(context, '/recordSetup');
      } else {
        await FirebaseAuth.instance.signOut();
        await prefs.remove('last_login_time');
        _navigated = true;
        Navigator.pushReplacementNamed(context, '/login');
      }
    } catch (e) {
      // 에러 시 안전하게 로그인 화면으로
      if (!mounted || _navigated) return;
      _navigated = true;
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
