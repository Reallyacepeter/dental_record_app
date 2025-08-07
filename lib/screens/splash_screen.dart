import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkLoginState();
  }

  Future<void> _checkLoginState() async {
    final prefs = await SharedPreferences.getInstance();
    final user = FirebaseAuth.instance.currentUser;

    final lastLoginTime = prefs.getInt('last_login_time');
    final now = DateTime.now().millisecondsSinceEpoch;
    final expired = lastLoginTime == null || (now - lastLoginTime) > 3600 * 1000;

    if (user != null && !expired) {
      Navigator.pushReplacementNamed(context, '/record');
    } else {
      await FirebaseAuth.instance.signOut();
      await prefs.remove('last_login_time');
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
