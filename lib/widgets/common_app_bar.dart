// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../providers/dental_data_provider.dart';
//
// class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
//   final String title;
//   final bool showRecordBadge;
//   final bool automaticallyImplyLeading;
//
//   const CommonAppBar({
//     super.key,
//     required this.title,
//     this.showRecordBadge = false,
//     this.automaticallyImplyLeading = true,
//   });
//
//   @override
//   Size get preferredSize => const Size.fromHeight(kToolbarHeight);
//
//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       // ⬇️ 길면 자동 스크롤(마키), 짧으면 고정 표시
//       title: _ScrollingTitle(text: title),
//       automaticallyImplyLeading: automaticallyImplyLeading,
//       actions: showRecordBadge
//           ? [
//         Consumer<DentalDataProvider>(
//           builder: (context, p, _) {
//             final isPm = p.recordType == 'PM';
//             final no = isPm ? p.pmNumber : p.amNumber;
//             final label = isPm ? 'PM' : 'AM';
//             final icon = isPm ? Icons.person_off : Icons.person;
//             return Padding(
//               padding: const EdgeInsets.only(right: 12),
//               child: Chip(
//                 avatar: Icon(icon, size: 18),
//                 label: ConstrainedBox(
//                   // ⬇️ Chip 내부 텍스트도 오버플로 시 … 처리
//                   constraints: const BoxConstraints(maxWidth: 160),
//                   child: Text(
//                     '$label No: ${no.isEmpty ? "-" : no}',
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                 ),
//                 materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
//               ),
//             );
//           },
//         ),
//       ]
//           : null,
//     );
//   }
// }
//
// /// 길면 자동으로 좌→우로 흐르는 제목 위젯(마키 효과)
// class _ScrollingTitle extends StatefulWidget {
//   final String text;
//   final double gap;      // 반복 사이 간격
//   final double speedPxS; // 초당 픽셀 속도
//
//   const _ScrollingTitle({
//     required this.text,
//     this.gap = 32,
//     this.speedPxS = 40, // 숫자 클수록 빨라짐
//   });
//
//   @override
//   State<_ScrollingTitle> createState() => _ScrollingTitleState();
// }
//
// class _ScrollingTitleState extends State<_ScrollingTitle> {
//   final _ctrl = ScrollController();
//   Timer? _loopTimer;
//   bool _shouldScroll = false;
//
//   @override
//   void initState() {
//     super.initState();
//     // 첫 레이아웃 후 스크롤 필요 여부 판단 및 루프 시작
//     WidgetsBinding.instance.addPostFrameCallback((_) => _setup());
//   }
//
//   @override
//   void didUpdateWidget(covariant _ScrollingTitle oldWidget) {
//     super.didUpdateWidget(oldWidget);
//     // 텍스트 변경 시 루프 재설정
//     if (oldWidget.text != widget.text) {
//       _stopLoop();
//       WidgetsBinding.instance.addPostFrameCallback((_) => _setup());
//     }
//   }
//
//   Future<void> _setup() async {
//     // 잠깐 대기(레이아웃 안정화)
//     await Future.delayed(const Duration(milliseconds: 50));
//     if (!mounted) return;
//
//     // 스크롤 필요 판단: maxScrollExtent > 0 면 넘침
//     final need = _ctrl.hasClients && _ctrl.position.maxScrollExtent > 0;
//     setState(() => _shouldScroll = need);
//
//     if (need) _startLoop();
//   }
//
//   void _startLoop() {
//     if (!mounted || !_ctrl.hasClients) return;
//
//     // 한 번 끝까지 가는 데 필요한 시간 계산
//     final max = _ctrl.position.maxScrollExtent;
//     final seconds = (max / widget.speedPxS).clamp(4, 30); // 최소 4초, 최대 30초
//
//     // 처음 위치로 점프
//     _ctrl.jumpTo(0);
//
//     // 첫 애니메이션 시작
//     _animateTo(max, Duration(seconds: seconds.round()), () async {
//       // 끝 도달 후 잠깐 멈춤
//       await Future.delayed(const Duration(milliseconds: 600));
//       if (!mounted || !_ctrl.hasClients) return;
//       // 다시 처음으로 점프 후 재시작
//       _ctrl.jumpTo(0);
//       _loopTimer?.cancel();
//       _loopTimer = Timer(const Duration(milliseconds: 150), _startLoop);
//     });
//   }
//
//   void _animateTo(double offset, Duration duration, VoidCallback onDone) {
//     if (!mounted || !_ctrl.hasClients) return;
//     _ctrl
//         .animateTo(offset, duration: duration, curve: Curves.linear)
//         .whenComplete(onDone);
//   }
//
//   void _stopLoop() {
//     _loopTimer?.cancel();
//     _loopTimer = null;
//     if (_ctrl.hasClients) {
//       // 중간에 멈추더라도 문제 없음
//     }
//   }
//
//   @override
//   void dispose() {
//     _stopLoop();
//     _ctrl.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // AppBar의 title 영역 폭 안에서만 동작하도록 ClipRect 사용
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         // 두 번 이어 붙여 무한 루프 느낌 + 간격(gap)
//         final text = Text(
//           widget.text,
//           maxLines: 1,
//           overflow: TextOverflow.visible, // 우리가 직접 스크롤하므로 잘리지 않게
//           style: Theme.of(context).appBarTheme.titleTextStyle ??
//               Theme.of(context).textTheme.titleLarge,
//         );
//
//         return ClipRect(
//           child: SingleChildScrollView(
//             controller: _ctrl,
//             scrollDirection: Axis.horizontal,
//             physics: const BouncingScrollPhysics(),
//             child: Row(
//               children: [
//                 // 원본
//                 ConstrainedBox(
//                   constraints: BoxConstraints(maxWidth: _shouldScroll ? double.infinity : constraints.maxWidth),
//                   child: text,
//                 ),
//                 if (_shouldScroll) ...[
//                   SizedBox(width: widget.gap),
//                   // 반복본(무한처럼 보이게)
//                   text,
//                 ],
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

// CommonAppBar.dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/dental_data_provider.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showRecordBadge;
  final bool automaticallyImplyLeading;

  const CommonAppBar({
    super.key,
    required this.title,
    this.showRecordBadge = false,
    this.automaticallyImplyLeading = true,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: false,    // Chip과 겹치지 않게 좌정렬
      titleSpacing: 8,
      title: _ScrollingTitle(text: title),  // ✅ 여기서 바로 제목 넘김
      automaticallyImplyLeading: automaticallyImplyLeading,
      actions: showRecordBadge
          ? [
        Consumer<DentalDataProvider>(
          builder: (context, p, _) {
            final isPm = p.recordType == 'PM';
            final no = isPm ? p.pmNumber : p.amNumber;
            final label = isPm ? 'PM' : 'AM';
            final icon = isPm ? Icons.person_off : Icons.person;
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 180),
                child: Chip(
                  avatar: Icon(icon, size: 18),
                  label: Text(
                    '$label No: ${no.isEmpty ? "-" : no}',
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                  ),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
              ),
            );
          },
        ),
      ]
          : null,
    );
  }
}

class _ScrollingTitle extends StatefulWidget {
  final String text;
  final double gap;       // 반복본 앞 간격(px)
  final double speedPxS;  // 초당 픽셀 속도

  const _ScrollingTitle({
    required this.text,
    this.gap = 32,
    this.speedPxS = 40,
  });

  @override
  State<_ScrollingTitle> createState() => _ScrollingTitleState();
}

class _ScrollingTitleState extends State<_ScrollingTitle> {
  final _ctrl = ScrollController();
  Timer? _loopTimer;

  bool _shouldScroll = false;
  double _viewWidth = 0;   // AppBar title 영역 가용 폭
  double _textWidth = 0;   // 실제 텍스트 폭(스타일 반영)

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _setup());
  }

  @override
  void didUpdateWidget(covariant _ScrollingTitle oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.text != widget.text ||
        oldWidget.gap != widget.gap ||
        oldWidget.speedPxS != widget.speedPxS) {
      _restart();
    }
  }

  void _restart() {
    _stopLoop();
    WidgetsBinding.instance.addPostFrameCallback((_) => _setup());
  }

  Future<void> _setup() async {
    await Future.delayed(const Duration(milliseconds: 20));
    if (!mounted) return;

    // 텍스트가 가용 폭을 초과하면 스크롤 필요
    final need = _textWidth > _viewWidth + 1; // +1은 여유 마진
    setState(() => _shouldScroll = need);

    if (!need) return;

    // 첫 루프 거리 보정:
    // - 컨트롤러의 maxScrollExtent가 아직 0일 수 있으니
    //   "텍스트 폭 - 뷰 폭 + gap"을 기준으로 거리 계산
    final distance = (_textWidth - _viewWidth) + widget.gap;
    _startLoop(distance);
  }

  void _startLoop(double distance) {
    if (!mounted) return;
    if (!_ctrl.hasClients) {
      // 컨트롤러가 아직 attach 안 됐으면 다음 프레임에 재시도
      WidgetsBinding.instance.addPostFrameCallback((_) => _startLoop(distance));
      return;
    }

    // 거리 하한 보정(첫 루프가 너무 느려지지 않도록 최소 200px)
    final dist = distance.isFinite && distance > 20 ? distance : 200.0;

    // 속도 기반 시간 계산 (항상 일정 속도)
    final seconds = (dist / widget.speedPxS).clamp(4, 30);

    _ctrl.jumpTo(0);
    _ctrl
        .animateTo(
      dist,
      duration: Duration(seconds: seconds.round()),
      curve: Curves.linear,
    )
        .whenComplete(() async {
      await Future.delayed(const Duration(milliseconds: 600));
      if (!mounted || !_ctrl.hasClients) return;
      _ctrl.jumpTo(0);
      _loopTimer?.cancel();
      _loopTimer = Timer(const Duration(milliseconds: 150), () {
        // 다음 루프는 실제 maxScrollExtent와 텍스트 폭 중 큰 값을 사용
        final fallback = (_textWidth - _viewWidth) + widget.gap;
        final maxExtent = _ctrl.position.hasContentDimensions
            ? _ctrl.position.maxScrollExtent
            : 0.0;
        final nextDistance = (maxExtent > 20 ? maxExtent : fallback);
        _startLoop(nextDistance);
      });
    });
  }

  void _stopLoop() {
    _loopTimer?.cancel();
    _loopTimer = null;
  }

  @override
  void dispose() {
    _stopLoop();
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).appBarTheme.titleTextStyle ??
        Theme.of(context).textTheme.titleLarge;

    // 가용 폭 측정 + 텍스트 폭 측정
    return LayoutBuilder(
      builder: (context, constraints) {
        _viewWidth = constraints.maxWidth;

        // 실제 텍스트 폭 계산 (첫 루프 안정화에 중요)
        final painter = TextPainter(
          text: TextSpan(text: widget.text, style: style),
          maxLines: 1,
          textDirection: TextDirection.ltr,
        )..layout(); // unconstrained로 실제 폭 측정
        _textWidth = painter.size.width;

        final textWidget = Text(
          widget.text,
          maxLines: 1,
          overflow: TextOverflow.visible,
          softWrap: false,
          style: style,
        );

        return ClipRect(
          child: SingleChildScrollView(
            controller: _ctrl,
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: Row(
              children: [
                ConstrainedBox(
                  constraints: BoxConstraints(
                    // 넘치면 무한 확장해서 스크롤, 아니면 가용 폭까지만
                    maxWidth: _shouldScroll ? double.infinity : _viewWidth,
                  ),
                  child: textWidget,
                ),
                if (_shouldScroll) ...[
                  SizedBox(width: widget.gap),
                  textWidget, // 반복본(무한 루프처럼 보이게)
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}
