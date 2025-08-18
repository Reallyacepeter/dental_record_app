import 'package:flutter/material.dart';
import '../models/tooth_models.dart';

/// 치아 번호의 사분(1~8) 반환
int fdiQuadrant(int fdi) => (fdi ~/ 10);

/// 해당 사분에서 Mesial이 우측인지? (1,4,5,8 = true / 2,3,6,7 = false)
bool mesialIsRight(int quadrant) {
  return quadrant == 1 || quadrant == 4 || quadrant == 5 || quadrant == 8;
}

/// 소형 타일(요약 점만). 탭하면 onTap 호출.
class OdontogramTile extends StatelessWidget {
  final int fdi;
  final ToothFinding? finding;
  final VoidCallback? onTap;
  const OdontogramTile({super.key, required this.fdi, this.finding, this.onTap});

  @override
  Widget build(BuildContext context) {
    final q = fdiQuadrant(fdi);
    return InkWell(
      onTap: onTap,
      child: CustomPaint(
        painter: _TilePainter(
          q: q,
          finding: finding,
        ),
        size: const Size(42, 42),
      ),
    );
  }
}

class _TilePainter extends CustomPainter {
  final int q;
  final ToothFinding? finding;
  _TilePainter({required this.q, this.finding});

  @override
  void paint(Canvas canvas, Size size) {
    final r = Offset.zero & size;
    final stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4
      ..color = const Color(0xFF616161);

    // 바깥 사각
    final outer = RRect.fromRectAndRadius(r.deflate(2), const Radius.circular(5));
    canvas.drawRRect(outer, stroke);

    // 중앙(가로 긴) 직사각
    final inner = r.deflate(9);
    final midH = inner.height * .45;
    final midRect = Rect.fromCenter(
      center: inner.center,
      width: inner.width * .64,
      height: midH,
    );
    canvas.drawRect(midRect, stroke);

    // 네 대각선 (중앙 직사각 꼭짓점 -> 외곽 중점)
    final topMid = Offset(r.center.dx, r.top + 2);
    final botMid = Offset(r.center.dx, r.bottom - 2);
    final leftMid = Offset(r.left + 2, r.center.dy);
    final rightMid = Offset(r.right - 2, r.center.dy);

    canvas.drawLine(midRect.topLeft, topMid, stroke);
    canvas.drawLine(midRect.topRight, topMid, stroke);
    canvas.drawLine(midRect.bottomLeft, botMid, stroke);
    canvas.drawLine(midRect.bottomRight, botMid, stroke);
    canvas.drawLine(midRect.topLeft, leftMid, stroke);
    canvas.drawLine(midRect.bottomLeft, leftMid, stroke);
    canvas.drawLine(midRect.topRight, rightMid, stroke);
    canvas.drawLine(midRect.bottomRight, rightMid, stroke);

    // 표면 요약 점(좌상·우상·중앙·좌하·우하에 작은 점으로 표시)
    if (finding != null) {
      final dots = <Color>[];
      Color? colFor(String s) {
        final list = finding!.surfaces[s]!;
        if (list.isEmpty) return null;
        // 우선순위: Prosthesis/Restoration > Pathology > Status
        Color? c;
        if (list.any((m) => m.domain == 'Prosthesis' || m.domain == 'Restoration')) {
          c = domainColor('Restoration');
        } else if (list.any((m) => m.domain == 'Pathology')) {
          c = domainColor('Pathology');
        } else if (list.isNotEmpty) {
          c = domainColor(list.first.domain);
        }
        return c;
      }
      final mRight = mesialIsRight(q);
      final mKey = mRight ? 'M' : 'D';
      final dKey = mRight ? 'D' : 'M';
      final mapPos = <String, Offset>{
        'O': inner.center,
        'L': Offset(inner.center.dx, inner.top + 4),
        'B': Offset(inner.center.dx, inner.bottom - 4),
        mKey: Offset(inner.right - 4, inner.center.dy),
        dKey: Offset(inner.left + 4, inner.center.dy),
      };
      final p = Paint()..style = PaintingStyle.fill;
      for (final kv in mapPos.entries) {
        final c = colFor(kv.key);
        if (c == null) continue;
        p.color = c;
        canvas.drawCircle(kv.value, 2.4, p);
      }
    }
  }

  @override
  bool shouldRepaint(covariant _TilePainter old) =>
      old.q != q || old.finding != finding;
}

/// 한 줄(8개) 렌더링
class OdontogramRow extends StatelessWidget {
  final List<int> fdis;                  // 예: [18..11]
  final Map<int, ToothFinding> data;
  final void Function(int fdi) onTap;
  final EdgeInsetsGeometry padding;
  const OdontogramRow({
    super.key,
    required this.fdis,
    required this.data,
    required this.onTap,
    this.padding = const EdgeInsets.symmetric(horizontal: 6),
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: fdis.map((fdi) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('$fdi', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700)),
              const SizedBox(height: 2),
              OdontogramTile(
                fdi: fdi,
                finding: data[fdi],
                onTap: () => onTap(fdi),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}
