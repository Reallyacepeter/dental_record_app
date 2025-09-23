import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../schema.dart';

/// 간단 저장소 래퍼:
/// - 테스트: inMemory=true → 파일 I/O 없이 메모리에만 저장
/// - 실제앱: inMemory=false → SharedPreferences(JSON 문자열) 사용
class LocalStore {
  static const _keyDentalState = 'dental_state_v1';

  static bool _ready = false;
  static bool _inMemory = false;

  /// 메모리 모드의 현재 스냅샷(딥카피로 반환/보관)
  static Map<String, dynamic>? _memData;

  /// 디스크 모드에서 init 시 미리 읽어둔 스냅샷(동기 반환용 캐시)
  static Map<String, dynamic>? _cachedDiskData;

  /// 반드시 앱/테스트 시작 시 1회 호출
  static Future<void> init({bool inMemory = false}) async {

    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('dental_schema_version', Schema.current);

    _inMemory = inMemory;

    if (_inMemory) {
      // 메모리 모드: 미리 아무 것도 안 해도 OK
      _ready = true;
      return;
    }

    // 디스크 모드: SharedPreferences에서 한번 읽어 캐싱(동기 반환용)

    final raw = prefs.getString(_keyDentalState);
    if (raw != null && raw.isNotEmpty) {
      try {
        final decoded = jsonDecode(raw);
        if (decoded is Map<String, dynamic>) {
          _cachedDiskData = decoded;
        }
      } catch (e) {
        debugPrint('LocalStore.init decode error: $e');
      }
    }
    _ready = true;
  }

  /// 동기 로드: init()에서 읽어둔 캐시(디스크) 또는 메모리 스냅샷을 반환
  /// - DentalDataProvider.hydrate() 가 동기 API를 기대하므로 sync 제공
  static Map<String, dynamic>? loadDentalState() {
    if (!_ready) {
      debugPrint('LocalStore.loadDentalState called before init()');
    }

    final Map<String, dynamic>? src = _inMemory ? _memData : _cachedDiskData;
    if (src == null) return null;

    // 방어적 딥카피(참조 공유 방지)
    return jsonDecode(jsonEncode(src)) as Map<String, dynamic>;
  }

  /// 저장(비동기): 메모리 모드면 메모리 변수에, 디스크 모드면 SharedPreferences에 JSON으로
  static Future<void> saveDentalState(Map<String, dynamic> data) async {
    if (!_ready) {
      debugPrint('LocalStore.saveDentalState called before init()');
    }

    // 방어적 딥카피 후 보관
    final copy = jsonDecode(jsonEncode(data)) as Map<String, dynamic>;

    if (_inMemory) {
      _memData = copy;
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyDentalState, jsonEncode(copy));
    _cachedDiskData = copy;
  }

  /// 삭제: 메모리/디스크 각각 초기화
  static Future<void> resetDentalState() async {
    if (!_ready) {
      debugPrint('LocalStore.resetDentalState called before init()');
    }

    if (_inMemory) {
      _memData = null;
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyDentalState);
    _cachedDiskData = null;
  }
  static const _keyPendingSubmissions = 'pending_submissions_v1';

  static Future<void> enqueuePendingSubmission(Map<String, dynamic> data) async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_keyPendingSubmissions);
    final list = (raw == null || raw.isEmpty)
        ? <Map<String, dynamic>>[]
        : List<Map<String, dynamic>>.from(jsonDecode(raw) as List);
    list.insert(0, {
      'id': DateTime.now().microsecondsSinceEpoch.toString(),
      'savedAt': DateTime.now().toIso8601String(),
      'data': data,
    });
    await prefs.setString(_keyPendingSubmissions, jsonEncode(list));
  }

  static Future<List<Map<String, dynamic>>> loadPendingSubmissions() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_keyPendingSubmissions);
    if (raw == null || raw.isEmpty) return [];
    return List<Map<String, dynamic>>.from(jsonDecode(raw) as List);
  }

  static Future<void> removePendingSubmission(String id) async {
    final prefs = await SharedPreferences.getInstance();
    final list = await loadPendingSubmissions();
    list.removeWhere((e) => (e['id']?.toString() ?? '') == id);
    await prefs.setString(_keyPendingSubmissions, jsonEncode(list));
  }
}