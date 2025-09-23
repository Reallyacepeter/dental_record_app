import 'dart:async';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';

class NetworkStatus extends ChangeNotifier {
  bool _hasConnection = true;
  bool get hasConnection => _hasConnection;

  StreamSubscription<List<ConnectivityResult>>? _sub;

  Future<void> init() async {
    // 최초 체크 (인터넷 실제 접근으로 오탐 줄이기)
    _set(await _probeInternet());

    _sub = Connectivity().onConnectivityChanged.listen((_) async {
      _set(await _probeInternet());
    });
  }

  Future<bool> _probeInternet() async {
    try {
      final res = await InternetAddress.lookup('example.com')
          .timeout(const Duration(seconds: 3));
      return res.isNotEmpty && res.first.rawAddress.isNotEmpty;
    } catch (_) {
      return false;
    }
  }

  void _set(bool v) {
    if (_hasConnection == v) return;
    _hasConnection = v;
    notifyListeners();
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }
}
