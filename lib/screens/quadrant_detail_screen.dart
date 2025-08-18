import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/dental_data_provider.dart';
import 'odontogram_overview_screen.dart';
import 'dart:ui' show PointerDeviceKind;

class QuadrantDetailScreen extends StatelessWidget {
  final Quadrant quadrant;
  const QuadrantDetailScreen({super.key, required this.quadrant});

  List<int> get permanent {
    switch (quadrant) {
      case Quadrant.upperLeft:   return [18,17,16,15,14,13,12,11];
      case Quadrant.upperRight:  return [21,22,23,24,25,26,27,28];
      case Quadrant.lowerLeft:   return [48,47,46,45,44,43,42,41];
      case Quadrant.lowerRight:  return [31,32,33,34,35,36,37,38];
    }
  }

  List<int> get primary {
    switch (quadrant) {
      case Quadrant.upperLeft:   return [55,54,53,52,51];
      case Quadrant.upperRight:  return [61,62,63,64,65];
      case Quadrant.lowerLeft:   return [85,84,83,82,81];
      case Quadrant.lowerRight:  return [71,72,73,74,75];
    }
  }

  bool isAnterior(int fdi) {
    final d = fdi % 10;
    return d == 1 || d == 2 || d == 3; // 1~3 전치
  }

  @override
  Widget build(BuildContext context) {
    final title = () {
      switch (quadrant) {
        case Quadrant.upperLeft:  return '상악 좌측 (18–11 / 55–51)';
        case Quadrant.upperRight: return '상악 우측 (21–28 / 61–65)';
        case Quadrant.lowerLeft:  return '하악 좌측 (48–41 / 85–81)';
        case Quadrant.lowerRight: return '하악 우측 (31–38 / 71–75)';
      }
    }();

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
          IconButton(
            tooltip: '모든 선택 해제',
            icon: const Icon(Icons.layers_clear),
            onPressed: () {
              final prov = context.read<DentalDataProvider>();
              for (final t in [...permanent, ...primary]) {
                prov.clearSurfaces(t);
              }
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Row(
              children: [
                const Text('영구치', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(width: 8),
                Text(permanent.first.toString() + '…' + permanent.last.toString()),
              ],
            ),
            const SizedBox(height: 8),
            _TeethRowFDI(numbers: permanent, isAnterior: isAnterior),

            const SizedBox(height: 16),
            Row(
              children: [
                const Text('유치', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(width: 8),
                Text(primary.first.toString() + '…' + primary.last.toString()),
              ],
            ),
            const SizedBox(height: 8),
            _TeethRowFDI(numbers: primary, isAnterior: isAnterior),
          ],
        ),
      ),
    );
  }
}

class _TeethRowFDI extends StatelessWidget {
  final List<int> numbers;
  final bool Function(int) isAnterior;
  const _TeethRowFDI({required this.numbers, required this.isAnterior});

  @override
  Widget build(BuildContext context) {
    // 핀치-줌 가능하게 감싸기(가로 스크롤도)
    return SizedBox(
      height: 120,
      child: InteractiveViewer(
        minScale: 0.8,
        maxScale: 4.0,
        child: Row(
          children: [
            for (final fdi in numbers)
              _ToothSurfaceTile(
                fdi: fdi,
                anterior: isAnterior(fdi),
              ),
          ],
        ),
      ),
    );
  }
}

/// 치아 1개: 전치(4분할) / 구치(5분할) + 표면별 히트 테스트
class _ToothSurfaceTile extends StatelessWidget {
  final int fdi;
  final bool anterior; // true면 4분할, false면 5분할
  const _ToothSurfaceTile({required this.fdi, required this.anterior});

  @override
  Widget build(BuildContext context) {
    final prov = context.watch<DentalDataProvider>();
    final selected = prov.getSelectedSurfaces(fdi); // Set<String>

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTapDown: (d) {
          // 이 위젯의 RenderBox
          final box = context.findRenderObject() as RenderBox?;
          if (box == null) return;

          // 탭 위치 (이미 이 위젯의 로컬 좌표)
          final Offset local = d.localPosition;

          // 위젯 크기
          final Size size = box.size;

          // TODO: 여기서 분할/히트판정 함수 호출
          // e.g. _handleHit(local, size);
        },
        child: CustomPaint(
          size: const Size(70, 100),
          painter: _ToothPainter(
            fdi: fdi,
            anterior: anterior,
            selected: selected,
            onHitSurface: (key) {
              context.read<DentalDataProvider>().toggleSurface(fdi, key);
            },
          ),
        ),
      ),
    );
  }
}

typedef HitCallback = void Function(String surfaceKey);

class _ToothPainter extends CustomPainter {
  final int fdi;
  final bool anterior;             // true=4분할, false=5분할
  final Set<String> selected;      // 선택된 표면키
  final HitCallback onHitSurface;  // 탭 판정 콜백

  _ToothPainter({
    required this.fdi,
    required this.anterior,
    required this.selected,
    required this.onHitSurface,
  });

  // 각 표면 Path를 만들어 저장 → 외부에서 히트테스트
  final Map<String, Path> _surfaces = {};

  @override
  void paint(Canvas canvas, Size size) {
    final r = Rect.fromLTWH(0, 0, size.width, size.height);

    // 치아 외곽(간단화된 형태)
    final outline = RRect.fromRectAndRadius(
      r.deflate(6),
      const Radius.circular(14),
    );
    final stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..color = Colors.black87;
    final fill = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.white;
    canvas.drawRRect(outline, fill);
    canvas.drawRRect(outline, stroke);

    // 분할 그리기 + path 저장
    _surfaces.clear();
    if (anterior) {
      _drawAnterior(canvas, r.deflate(12));
    } else {
      _drawPosterior(canvas, r.deflate(10));
    }

    // 표면 선택 채우기
    final selPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.amber.withOpacity(.35);
    for (final key in selected) {
      final p = _surfaces[key];
      if (p != null) canvas.drawPath(p, selPaint);
    }

    // fdi 라벨
    final tp = TextPainter(
      textDirection: TextDirection.ltr,
      text: TextSpan(
        text: '$fdi',
        style: const TextStyle(fontSize: 12, color: Colors.black87),
      ),
    )..layout();
    tp.paint(canvas, Offset((size.width - tp.width) / 2, size.height - tp.height - 2));
  }

  // 전치: 4분할 (Mesial/Distal/Labial(Lab)/Lingual(Lin) 느낌의 2x2)
  void _drawAnterior(Canvas canvas, Rect r) {
    final midX = r.center.dx;
    final midY = r.center.dy;

    Path mk(Rect a) => Path()..addRect(a);

    final tl = Rect.fromLTRB(r.left, r.top, midX, midY);     // Q1
    final tr = Rect.fromLTRB(midX, r.top, r.right, midY);    // Q2
    final bl = Rect.fromLTRB(r.left, midY, midX, r.bottom);  // Q3
    final br = Rect.fromLTRB(midX, midY, r.right, r.bottom); // Q4

    _surfaces['Q1'] = mk(tl);
    _surfaces['Q2'] = mk(tr);
    _surfaces['Q3'] = mk(bl);
    _surfaces['Q4'] = mk(br);

    final guide = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2
      ..color = Colors.black38;
    canvas.drawLine(Offset(midX, r.top), Offset(midX, r.bottom), guide);
    canvas.drawLine(Offset(r.left, midY), Offset(r.right, midY), guide);
  }

  // 구치/소구치: 5분할 (MB/DB/ML/DL + Occlusal center)
  void _drawPosterior(Canvas canvas, Rect r) {
    final midX = r.center.dx;
    final midY = r.center.dy;

    // 4분면
    Rect q(String where) {
      switch (where) {
        case 'MB': return Rect.fromLTRB(r.left, r.top, midX, midY);
        case 'DB': return Rect.fromLTRB(midX, r.top, r.right, midY);
        case 'ML': return Rect.fromLTRB(r.left, midY, midX, r.bottom);
        case 'DL': return Rect.fromLTRB(midX, midY, r.right, r.bottom);
      }
      return r;
    }

    Path mk(Rect a) => Path()..addRect(a);

    _surfaces['MB'] = mk(q('MB'));
    _surfaces['DB'] = mk(q('DB'));
    _surfaces['ML'] = mk(q('ML'));
    _surfaces['DL'] = mk(q('DL'));

    // 중앙 Occlusal : 마름모
    final o = Path()
      ..moveTo(midX, r.top + r.height * .35)
      ..lineTo(r.left + r.width * .35, midY)
      ..lineTo(midX, r.bottom - r.height * .35)
      ..lineTo(r.right - r.width * .35, midY)
      ..close();
    _surfaces['O'] = o;

    final guide = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2
      ..color = Colors.black38;
    // 4분면 경계
    canvas.drawLine(Offset(midX, r.top), Offset(midX, r.bottom), guide);
    canvas.drawLine(Offset(r.left, midY), Offset(r.right, midY), guide);
    // 중앙 마름모
    canvas.drawPath(o, guide);
  }

  @override
  bool? hitTest(Offset position) {
    // 캔버스 내부에서 탭된 표면 찾아 콜백
    for (final e in _surfaces.entries) {
      if (e.value.contains(position)) {
        onHitSurface(e.key);
        return true;
      }
    }
    return false;
  }

  @override
  bool shouldRepaint(covariant _ToothPainter old) =>
      anterior != old.anterior || selected != old.selected || fdi != old.fdi;
}