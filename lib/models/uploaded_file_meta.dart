import 'dart:convert';

enum MediaKind { image, pdf, video, other }

class UploadedFileMeta {
  final String url;              // Storage URL (키)
  String name;                   // 파일명(표시용)
  MediaKind kind;                // 타입
  String? folder;                // 폴더(그룹명)
  List<String> tags;             // 태그
  String? description;           // 설명
  DateTime? takenAt;             // 촬영/작성일

  UploadedFileMeta({
    required this.url,
    required this.name,
    required this.kind,
    this.folder,
    List<String>? tags,
    this.description,
    this.takenAt,
  }) : tags = [...(tags ?? const [])];

  factory UploadedFileMeta.fromMap(Map<String, dynamic> m) {
    return UploadedFileMeta(
      url: (m['url'] ?? '').toString(),
      name: (m['name'] ?? '').toString(),
      kind: _kindFromName((m['kind'] ?? 'other').toString()),
      folder: (m['folder'] as String?)?.trim().isEmpty ?? true ? null : (m['folder'] as String).trim(),
      tags: List<String>.from((m['tags'] as List?) ?? const []),
      description: (m['description'] as String?),
      takenAt: _parseDate(m['takenAt']),
    );
  }

  Map<String, dynamic> toMap() => {
    'url': url,
    'name': name,
    'kind': kind.name,
    'folder': folder,
    'tags': tags,
    'description': description,
    'takenAt': takenAt?.toIso8601String(),
  };

  static MediaKind _kindFromName(String s) {
    switch (s) {
      case 'image':
        return MediaKind.image;
      case 'pdf':
        return MediaKind.pdf;
      case 'video':
        return MediaKind.video;
      default:
        return MediaKind.other;
    }
  }

  static DateTime? _parseDate(dynamic v) {
    if (v == null) return null;
    if (v is DateTime) return v;
    if (v is int) return DateTime.fromMillisecondsSinceEpoch(v);
    if (v is String && v.isNotEmpty) return DateTime.tryParse(v);
    return null;
  }
}
