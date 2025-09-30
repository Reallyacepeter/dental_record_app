import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../firebase_options.dart';

class InitRetryScreen extends StatefulWidget {
  const InitRetryScreen({super.key});

  @override
  State<InitRetryScreen> createState() => _InitRetryScreenState();
}

class _InitRetryScreenState extends State<InitRetryScreen> {
  bool _navigated = false;
  Timer? _timer;
  int _attempt = 0;

  @override
  void initState() {
    super.initState();
    _kickoff();
    // 3초마다 재시도 (네트워크/Play 서비스 복구, Firebase 콘솔 전파 지연 등 대비)
    _timer = Timer.periodic(const Duration(seconds: 3), (_) => _kickoff());
  }

  Future<void> _kickoff() async {
    if (!mounted || _navigated) return;
    _attempt++;
    try {
      if (Firebase.apps.isEmpty) {
        await Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ).timeout(const Duration(seconds: 8));
      }

      try {
        await FirebaseAuth.instance.signInAnonymously()
            .timeout(const Duration(seconds: 5));
      } catch (e) {
        debugPrint('anon sign-in skip/err: $e');
      }

      final user = FirebaseAuth.instance.currentUser;
      _safeGo(user != null ? '/recordSetup' : '/login');
    } catch (e) {
      debugPrint('kickoff error: $e');
      if (mounted) setState(() {});
    }
  }

  void _safeGo(String route) {
    if (!mounted || _navigated) return;
    _navigated = true;
    _timer?.cancel();
    Navigator.pushReplacementNamed(context, route);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          const SizedBox(height: 8),
          const CircularProgressIndicator(),
          const SizedBox(height: 16),
          Text('앱 초기화 중... (재시도: $_attempt)'),
          const SizedBox(height: 8),
          TextButton(
            onPressed: _kickoff,
            child: const Text('다시 시도'),
          ),
        ]),
      ),
    );
  }
}
