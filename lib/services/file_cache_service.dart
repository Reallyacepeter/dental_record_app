import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class FileCacheService {
  FileCacheService._();
  static final FileCacheService I = FileCacheService._();

  final Dio _dio = Dio(BaseOptions(
    connectTimeout: const Duration(seconds: 15),
    receiveTimeout: const Duration(seconds: 60),
    sendTimeout: const Duration(seconds: 60),
  ));

  // ---- 타입 판별 ----
  bool isImage(String url) {
    final u = url.toLowerCase();
    return u.endsWith('.jpg') || u.endsWith('.jpeg') || u.endsWith('.png') ||
        u.endsWith('.gif') || u.endsWith('.webp') || u.contains('image%2f');
  }

  bool isPdf(String url) {
    final u = url.toLowerCase();
    return u.endsWith('.pdf') || u.contains('application%2fpdf');
  }

  bool isVideo(String url) {
    final u = url.toLowerCase();
    return u.endsWith('.mp4') || u.endsWith('.mov') || u.endsWith('.m4v') ||
        u.endsWith('.webm') || u.endsWith('.mkv') || u.contains('video%2f');
  }

  String safeFileNameFromUrl(String url) {
    try {
      final seg = Uri.parse(url).pathSegments.last;
      return Uri.decodeComponent(seg);
    } catch (_) {
      return url.hashCode.toString();
    }
  }

  Future<Directory> _cacheDir([String child = 'media']) async {
    final base = await getTemporaryDirectory();
    final dir = Directory(p.join(base.path, child));
    if (!await dir.exists()) await dir.create(recursive: true);
    return dir;
  }

  /// URL을 캐시에 저장하고 로컬 경로 반환. 이미 있으면 즉시 반환.
  Future<String> getOrDownload(String url) async {
    final dir = await _cacheDir();
    final name = safeFileNameFromUrl(url);
    final localPath = p.join(dir.path, name);

    final f = File(localPath);
    if (await f.exists() && await f.length() > 0) {
      return localPath;
    }

    final tmp = '$localPath.part';
    await _dio.download(url, tmp);
    await File(tmp).rename(localPath);
    return localPath;
  }

  /// 영상 썸네일 기능 제거/비활성화: 이전 코드 호환성을 위해 메서드 유지(항상 null 반환).
  /// 필요한 경우, 나중에 placeholder 이미지를 리턴하도록 수정할 수 있음.
  Future<String?> getVideoThumbnail(String url) async {
    // video_thumbnail 패키지를 제거했으므로 썸네일 자동 생성은 하지 않습니다.
    // 만약 썸네일 파일 경로가 필요하면, 아래처럼 비디오 파일 자체를 반환하거나
    // null을 반환하도록 호출부에서 처리하세요.
    try {
      // 원본 비디오를 캐시해두고 path만 필요하면 반환(옵션)
      // final videoPath = await getOrDownload(url);
      // return videoPath; // <-- 필요시 주석 해제
      return null;
    } catch (_) {
      return null;
    }
  }

  Future<Uint8List?> getImageBytes(String url) async {
    try {
      final local = await getOrDownload(url);
      return await File(local).readAsBytes();
    } catch (_) {
      return null;
    }
  }

  Future<void> clearAll() async {
    final d1 = await _cacheDir();
    final d2 = await _cacheDir('thumbs');
    if (await d1.exists()) await d1.delete(recursive: true);
    if (await d2.exists()) await d2.delete(recursive: true);
  }
}
