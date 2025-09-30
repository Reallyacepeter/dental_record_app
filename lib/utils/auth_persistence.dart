// lib/utils/auth_persistence.dart
import 'package:flutter/foundation.dart' show kIsWeb, debugPrint;
import 'package:firebase_auth/firebase_auth.dart';
// universal_html은 웹/모바일 모두 import 가능 (모바일에서도 에러 안 남)
import 'package:universal_html/html.dart' as html;

/// 웹일 때만 환경에 맞춰 Firebase Auth 퍼시스턴스 설정.
/// - iOS PWA(홈화면) / 인앱 브라우저: NONE (저장소 이슈 회피 → 매번 로그인)
/// - 그 외 브라우저: LOCAL (실패하면 SESSION → 실패하면 NONE)
Future<void> setBestWebPersistence() async {
  if (!kIsWeb) return; // 웹이 아니면 아무것도 안 함
  try {
    final ua = (html.window.navigator.userAgent ?? '').toLowerCase();
    final isIOS = ua.contains('iphone') || ua.contains('ipad') || ua.contains('ipod');
    final isStandalone = _isStandalone();   // PWA 감지
    final isInApp = _isInApp(ua);           // 인앱 브라우저 감지

    if (isIOS && (isStandalone || isInApp)) {
      await FirebaseAuth.instance.setPersistence(Persistence.NONE);
      debugPrint('[auth] persistence = NONE (iOS PWA/인앱)');
      return;
    }

    try {
      await FirebaseAuth.instance.setPersistence(Persistence.LOCAL);
      debugPrint('[auth] persistence = LOCAL');
    } catch (_) {
      try {
        await FirebaseAuth.instance.setPersistence(Persistence.SESSION);
        debugPrint('[auth] persistence = SESSION (LOCAL failed)');
      } catch (_) {
        await FirebaseAuth.instance.setPersistence(Persistence.NONE);
        debugPrint('[auth] persistence = NONE (LOCAL/SESSION failed)');
      }
    }
  } catch (e) {
    debugPrint('[auth] setBestWebPersistence error: $e');
  }
}

bool _isStandalone() {
  try {
    if (html.window.matchMedia('(display-mode: standalone)').matches) return true;
    final nav = html.window.navigator as dynamic;
    if (nav.standalone == true) return true; // iOS Safari 홈화면
  } catch (_) {}
  return false;
}

bool _isInApp(String ua) {
  return ua.contains('kakaotalk') ||
      ua.contains('fbav') || ua.contains('fban') || ua.contains('instagram') ||
      ua.contains('line') || ua.contains('naver') || ua.contains('daumapps') ||
      ua.contains('whale') || ua.contains('band');
}
