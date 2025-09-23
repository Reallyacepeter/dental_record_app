import 'dart:io';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:url_launcher/url_launcher.dart';
import '../services/file_cache_service.dart';

class VideoPlayerScreen extends StatefulWidget {
  final String url;
  final String? title;

  const VideoPlayerScreen({super.key, required this.url, this.title});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  VideoPlayerController? _videoController;
  ChewieController? _chewie;
  String? _localPath;

  @override
  void initState() {
    super.initState();
    _initPlayer();
  }

  Future<void> _initPlayer() async {
    try {
      final path = await FileCacheService.I.getOrDownload(widget.url);
      _localPath = path;
      _videoController = VideoPlayerController.file(File(path));
    } catch (_) {
      _videoController = VideoPlayerController.networkUrl(Uri.parse(widget.url));
    }

    await _videoController!.initialize();
    _chewie = ChewieController(
      videoPlayerController: _videoController!,
      autoInitialize: true,
      autoPlay: true,
      looping: false,
      allowMuting: true,
      allowPlaybackSpeedChanging: true,
      showControls: true,
    );
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _chewie?.dispose();
    _videoController?.dispose();
    super.dispose();
  }

  Future<void> _openExternal() async {
    final uri = Uri.parse(widget.url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('외부 앱으로 열 수 없습니다.')),
      );
    }
  }

  String get _title {
    try {
      return widget.title ?? Uri.decodeComponent(Uri.parse(widget.url).pathSegments.last);
    } catch (_) {
      return widget.title ?? 'Video';
    }
  }

  @override
  Widget build(BuildContext context) {
    final ready = _videoController?.value.isInitialized ?? false;

    return Scaffold(
      appBar: AppBar(
        title: Text(_title, overflow: TextOverflow.ellipsis),
        actions: [
          if (_localPath != null && File(_localPath!).existsSync())
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text('Cached', style: TextStyle(color: Colors.green)),
                ),
              ),
            ),
          IconButton(icon: const Icon(Icons.open_in_new), onPressed: _openExternal),
        ],
      ),
      body: Center(
        child: ready ? Chewie(controller: _chewie!) : const CircularProgressIndicator(),
      ),
    );
  }
}
