import 'package:flutter/material.dart';

/// 표면 키 고정: O(교합/절단), M, D, L(설/구개), B(협/순)
const kToothSurfaces = ['O', 'M', 'D', 'L', 'B'];

/// 1건의 마크(코드). 상위노드만 선택한 경우 [isParent]=true.
class ToothMark {
  final String domain; // 'Pathology' | 'Restoration' | 'Prosthesis' | 'Status'
  final String group;  // 상위 분류명(예: 'Crowns','Fillings','Root'…)
  final String code;   // 코드(예: UIC, MTC, TCF, COF, RFX, APX…)
  final bool isParent; // 부모만 선택(세부 미상)
  final String? note;  // 비고(선택)
  final double? confidence;

  const ToothMark({
    required this.domain,
    required this.group,
    required this.code,
    this.isParent = false,
    this.note,
    this.confidence,
  });

  Map<String, dynamic> toJson() => {
    'domain': domain,
    'group': group,
    'code': code,
    'isParent': isParent,
    'note': note,
    'confidence': confidence,
  };

  static ToothMark fromJson(Map<String, dynamic> j) => ToothMark(
    domain: j['domain'] ?? '',
    group: j['group'] ?? '',
    code: j['code'] ?? '',
    isParent: (j['isParent'] ?? false) as bool,
    note: j['note'],
    confidence: (j['confidence'] as num?)?.toDouble(),
  );
}

/// 치아 1개의 소견(표면·전역·메모)
class ToothFinding {
  final Map<String, List<ToothMark>> surfaces; // O/M/D/L/B
  final List<ToothMark> global;                 // 표면 무관
  String? toothNote;                            // 치아 전체 메모
  final Map<String, String> surfaceNote;        // 표면 메모

  ToothFinding({
    Map<String, List<ToothMark>>? surfaces,
    List<ToothMark>? global,
    this.toothNote,
    Map<String, String>? surfaceNote,
  })  : surfaces = surfaces ??
      {for (final s in kToothSurfaces) s: <ToothMark>[]},
        global = global ?? <ToothMark>[],
        surfaceNote = surfaceNote ?? <String, String>{};

  Map<String, dynamic> toJson() => {
    'surfaces': {
      for (final e in surfaces.entries)
        e.key: e.value.map((m) => m.toJson()).toList(),
    },
    'global': global.map((m) => m.toJson()).toList(),
    'toothNote': toothNote,
    'surfaceNote': surfaceNote,
  };

  static ToothFinding fromJson(Map<String, dynamic> j) {
    Map<String, List<ToothMark>> s = {
      for (final k in kToothSurfaces) k: <ToothMark>[]
    };
    final sj = j['surfaces'];
    if (sj is Map) {
      for (final kv in sj.entries) {
        final list = <ToothMark>[];
        if (kv.value is List) {
          for (final x in (kv.value as List)) {
            if (x is Map) list.add(ToothMark.fromJson(x.cast<String, dynamic>()));
          }
        }
        s[kv.key.toString()] = list;
      }
    }
    final g = <ToothMark>[];
    final gj = j['global'];
    if (gj is List) {
      for (final x in gj) {
        if (x is Map) g.add(ToothMark.fromJson(x.cast<String, dynamic>()));
      }
    }
    return ToothFinding(
      surfaces: s,
      global: g,
      toothNote: j['toothNote'],
      surfaceNote: (j['surfaceNote'] as Map?)?.cast<String, String>(),
    );
  }
}

/// 도메인별 대표 색(요약 점/채움에 사용)
Color domainColor(String domain) {
  switch (domain) {
    case 'Pathology':   return const Color(0xFFE53935); // red
    case 'Restoration': return const Color(0xFF1E88E5); // blue
    case 'Prosthesis':  return const Color(0xFF1565C0); // darker blue
    case 'Status':      return const Color(0xFF616161); // grey
    default:            return const Color(0xFF9E9E9E);
  }
}
