import 'dart:math' show min, max;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/dental_data_provider.dart';

class QuadrantZoomScreen extends StatefulWidget {
  final String title;
  final bool isUpper;
  final bool isPermanent;
  final List<int> teeth;

  const QuadrantZoomScreen({
    super.key,
    required this.title,
    required this.isUpper,
    required this.isPermanent,
    required this.teeth,
  });

  @override
  State<QuadrantZoomScreen> createState() => _QuadrantZoomScreenState();
}

class _QuadrantZoomScreenState extends State<QuadrantZoomScreen> {
  static const _minScale = 0.8;
  static const _maxScale = 4.0;

  final _controller = TransformationController();
  bool _showHint = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 2500), () {
      if (mounted) setState(() => _showHint = false);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final numbersOnTop = widget.isUpper;

    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Stack(
        children: [
          InteractiveViewer(
            transformationController: _controller,
            minScale: _minScale,
            maxScale: _maxScale,
            boundaryMargin: const EdgeInsets.all(64),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.topLeft,
                child: _QuadrantRow(
                  teeth: widget.teeth,
                  numbersOnTop: numbersOnTop,
                  showOuterNumbers: false, // ← 바깥 번호 숨김
                ),
              ),
            ),
          ),

          // 핀치 힌트(탭하면 닫힘, 2.5초 후 자동 숨김)
          if (_showHint)
            Positioned(
              top: 12,
              left: 12,
              right: 12,
              child: GestureDetector(
                onTap: () => setState(() => _showHint = false),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(.65),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.zoom_in_outlined, color: Colors.white),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          '두 손가락으로 확대/축소 • 짧게 탭: 면 선택 • 길게: 해당 치아 표면 초기화',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _QuadrantRow extends StatelessWidget {
  final List<int> teeth;
  final bool numbersOnTop;
  final bool showOuterNumbers; // ← 추가
  const _QuadrantRow({
    required this.teeth,
    required this.numbersOnTop,
    this.showOuterNumbers = true, // 기본값 true
  });

  @override
  Widget build(BuildContext context) {
    const spacing = 12.0;
    return LayoutBuilder(
      builder: (context, c) {
        final n = teeth.length;
        final tile = ((c.maxWidth - spacing * (n - 1)) / n).clamp(28.0, 90.0);

        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (final fdi in teeth) ...[
              SizedBox(
                width: tile,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (showOuterNumbers && numbersOnTop) _ToothNumber(fdi, tile),
                    _BigToothTile(fdi: fdi, size: tile),
                    if (showOuterNumbers && !numbersOnTop) _ToothNumber(fdi, tile),
                  ],
                ),
              ),
              if (fdi != teeth.last) const SizedBox(width: spacing),
            ],
          ],
        );
      },
    );
  }
}

class _ToothNumber extends StatelessWidget {
  final int fdi;
  final double size;
  const _ToothNumber(this.fdi, this.size);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size * .45, // 살짝 줄여 상하 여유 확보
      child: Center(
        child: Text('$fdi', style: const TextStyle(fontWeight: FontWeight.w700)),
      ),
    );
  }
}

class _BigToothTile extends StatelessWidget {
  final int fdi;
  final double size;
  const _BigToothTile({required this.fdi, required this.size});

  bool get _mesialOnRight {
    final q = fdi ~/ 10;
    if (q == 1 || q == 4 || q == 5 || q == 8) return true;
    if (q == 2 || q == 3 || q == 6 || q == 7) return false;
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final p = context.watch<DentalDataProvider>();
    final selected = p.getSelectedSurfaces(fdi);

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: (d) {
        final key = _hitSurface(d.localPosition, Size.square(size), mesialOnRight: _mesialOnRight);
        if (key != null) p.toggleSurface(fdi, key);
      },
      onLongPress: () => p.clearSurfaces(fdi),
      child: CustomPaint(
        size: Size.square(size),
        painter: _FiveSurfacePainter(
          selected: selected,
          mesialOnRight: _mesialOnRight,
          fdi: fdi,                 // ← 타일 안쪽에 번호 그리기
        ),
      ),
    );
  }

  String? _hitSurface(Offset p, Size s, {required bool mesialOnRight}) {
    final g = _Geom(s);
    if (g.rectO.contains(p)) return 'O';
    if (g.pathL.contains(p)) return 'L';
    if (g.pathB.contains(p)) return 'B';
    if (mesialOnRight) {
      if (g.pathRight.contains(p)) return 'M';
      if (g.pathLeft.contains(p))  return 'D';
    } else {
      if (g.pathLeft.contains(p))  return 'M';
      if (g.pathRight.contains(p)) return 'D';
    }
    return null;
  }
}

class _FiveSurfacePainter extends CustomPainter {
  final Set<String> selected;
  final bool mesialOnRight;
  final int fdi;                    // ← 추가
  _FiveSurfacePainter({
    required this.selected,
    required this.mesialOnRight,
    required this.fdi,
  });

  @override
  void paint(Canvas canvas, Size s) {
    final g = _Geom(s);

    final stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = (s.width * .04).clamp(1.0, 2.0)
      ..color = Colors.black87;

    final innerStroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = (s.width * .032).clamp(0.8, 1.6)
      ..color = Colors.black54;

    final selFill = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.amber.withOpacity(.35);

    if (selected.contains('L')) canvas.drawPath(g.pathL, selFill);
    if (selected.contains('B')) canvas.drawPath(g.pathB, selFill);
    if (selected.contains('O')) canvas.drawRect(g.rectO, selFill);

    if (mesialOnRight) {
      if (selected.contains('M')) canvas.drawPath(g.pathRight, selFill);
      if (selected.contains('D')) canvas.drawPath(g.pathLeft,  selFill);
    } else {
      if (selected.contains('M')) canvas.drawPath(g.pathLeft,  selFill);
      if (selected.contains('D')) canvas.drawPath(g.pathRight, selFill);
    }

    // 외곽/내부선
    canvas.drawRRect(g.outerRRect, stroke);
    canvas.drawRect(g.rectO, innerStroke);

    final oc = [g.outerRect.topLeft, g.outerRect.topRight, g.outerRect.bottomRight, g.outerRect.bottomLeft];
    final ic = [g.rectO.topLeft, g.rectO.topRight, g.rectO.bottomRight, g.rectO.bottomLeft];
    for (int i = 0; i < 4; i++) {
      canvas.drawLine(ic[i], oc[i], innerStroke);
    }

    // 타일 안쪽 좌상단에 FDI 번호(흰 배경으로 가독성 확보)
    final pad = s.width * .04;
    final textPainter = TextPainter(
      text: TextSpan(
        text: '$fdi',
        style: TextStyle(
          color: Colors.black87,
          fontSize: s.width * .22,
          fontWeight: FontWeight.w600,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();

    final bgRect = Rect.fromLTWH(
      pad - 2,
      pad - 1,
      textPainter.width + 4,
      textPainter.height,
    );
    final bgPaint = Paint()..color = Colors.white.withOpacity(.9);
    canvas.drawRRect(RRect.fromRectAndRadius(bgRect, const Radius.circular(2)), bgPaint);
    textPainter.paint(canvas, Offset(pad, pad));
  }

  @override
  bool shouldRepaint(covariant _FiveSurfacePainter old) =>
      old.selected != selected || old.mesialOnRight != mesialOnRight || old.fdi != fdi;
}

class _Geom {
  late final Rect outerRect;
  late final RRect outerRRect;
  late final Rect rectO;
  late final Path pathL, pathB, pathLeft, pathRight;

  _Geom(Size s) {
    outerRect  = Offset.zero & s;
    outerRRect = RRect.fromRectAndRadius(outerRect.deflate(1), Radius.circular(s.width * .12));

    final w = s.width, h = s.height;
    final rectW = w * .66;
    final rectH = h * .46;
    rectO = Rect.fromCenter(center: outerRect.center, width: rectW, height: rectH);

    pathL = Path()
      ..moveTo(outerRect.left, outerRect.top)
      ..lineTo(outerRect.right, outerRect.top)
      ..lineTo(rectO.right, rectO.top)
      ..lineTo(rectO.left,  rectO.top)
      ..close();

    pathB = Path()
      ..moveTo(outerRect.left,  outerRect.bottom)
      ..lineTo(outerRect.right, outerRect.bottom)
      ..lineTo(rectO.right,     rectO.bottom)
      ..lineTo(rectO.left,      rectO.bottom)
      ..close();

    pathLeft = Path()
      ..moveTo(outerRect.left,  outerRect.top)
      ..lineTo(rectO.left,      rectO.top)
      ..lineTo(rectO.left,      rectO.bottom)
      ..lineTo(outerRect.left,  outerRect.bottom)
      ..close();

    pathRight = Path()
      ..moveTo(outerRect.right, outerRect.top)
      ..lineTo(rectO.right,     rectO.top)
      ..lineTo(rectO.right,     rectO.bottom)
      ..lineTo(outerRect.right, outerRect.bottom)
      ..close();
  }
}
