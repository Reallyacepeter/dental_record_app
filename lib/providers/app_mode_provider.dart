// app_mode_provider.dart
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/network_status_service.dart';

class AppModeProvider extends ChangeNotifier {
  final NetworkStatus net;
  AppModeProvider(this.net) {
    net.addListener(notifyListeners);
    // 여기서는 Firebase에 손대지 말 것!
  }

  StreamSubscription<User?>? _authSub;

  // Firebase init 후에 한 번만 호출
  void attachAuthOnce() {
    if (_authSub != null) return;
    if (Firebase.apps.isEmpty) return; // 아직이면 그냥 리턴
    _authSub = FirebaseAuth.instance.authStateChanges().listen((_) {
      notifyListeners();
    });
  }

  bool get isAuthed {
    if (Firebase.apps.isEmpty) return false; // init 전엔 false 취급
    try { return FirebaseAuth.instance.currentUser != null; } catch (_) { return false; }
  }

  bool get isOnline => net.hasConnection;
  bool get isOfflineMode => !isOnline || !isAuthed;

  @override
  void dispose() {
    _authSub?.cancel();
    net.removeListener(notifyListeners);
    super.dispose();
  }
}
