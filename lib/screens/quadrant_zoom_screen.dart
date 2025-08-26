// import 'dart:math' show min, max;
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../providers/dental_data_provider.dart';
//
// class QuadrantZoomScreen extends StatefulWidget {
//   final String title;
//   final bool isUpper;
//   final bool isPermanent;
//   final List<int> teeth;
//
//   const QuadrantZoomScreen({
//     super.key,
//     required this.title,
//     required this.isUpper,
//     required this.isPermanent,
//     required this.teeth,
//   });
//
//   @override
//   State<QuadrantZoomScreen> createState() => _QuadrantZoomScreenState();
// }
//
// class _QuadrantZoomScreenState extends State<QuadrantZoomScreen> {
//   static const _minScale = 0.8;
//   static const _maxScale = 4.0;
//
//   final _controller = TransformationController();
//   bool _showHint = true;
//
//   @override
//   void initState() {
//     super.initState();
//     Future.delayed(const Duration(milliseconds: 2500), () {
//       if (mounted) setState(() => _showHint = false);
//     });
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final numbersOnTop = widget.isUpper;
//
//     return Scaffold(
//       appBar: AppBar(title: Text(widget.title)),
//       body: Stack(
//         children: [
//           InteractiveViewer(
//             transformationController: _controller,
//             minScale: _minScale,
//             maxScale: _maxScale,
//             boundaryMargin: const EdgeInsets.all(64),
//             child: Padding(
//               padding: const EdgeInsets.all(16),
//               child: FittedBox(
//                 fit: BoxFit.scaleDown,
//                 alignment: Alignment.topLeft,
//                 child: _QuadrantRow(
//                   teeth: widget.teeth,
//                   numbersOnTop: numbersOnTop,
//                   showOuterNumbers: false, // ← 바깥 번호 숨김
//                 ),
//               ),
//             ),
//           ),
//
//           // 핀치 힌트(탭하면 닫힘, 2.5초 후 자동 숨김)
//           if (_showHint)
//             Positioned(
//               top: 12,
//               left: 12,
//               right: 12,
//               child: GestureDetector(
//                 onTap: () => setState(() => _showHint = false),
//                 child: Container(
//                   padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
//                   decoration: BoxDecoration(
//                     color: Colors.black.withOpacity(.65),
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: const Row(
//                     children: [
//                       Icon(Icons.zoom_in_outlined, color: Colors.white),
//                       SizedBox(width: 8),
//                       Expanded(
//                         child: Text(
//                           '두 손가락으로 확대/축소 • 짧게 탭: 면 선택 • 길게: 해당 치아 표면 초기화',
//                           style: TextStyle(color: Colors.white),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }
//
// class _QuadrantRow extends StatelessWidget {
//   final List<int> teeth;
//   final bool numbersOnTop;
//   final bool showOuterNumbers; // ← 추가
//   const _QuadrantRow({
//     required this.teeth,
//     required this.numbersOnTop,
//     this.showOuterNumbers = true, // 기본값 true
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     const spacing = 12.0;
//     return LayoutBuilder(
//       builder: (context, c) {
//         final n = teeth.length;
//         final tile = ((c.maxWidth - spacing * (n - 1)) / n).clamp(28.0, 90.0);
//
//         return Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             for (final fdi in teeth) ...[
//               SizedBox(
//                 width: tile,
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     if (showOuterNumbers && numbersOnTop) _ToothNumber(fdi, tile),
//                     _BigToothTile(fdi: fdi, size: tile),
//                     if (showOuterNumbers && !numbersOnTop) _ToothNumber(fdi, tile),
//                   ],
//                 ),
//               ),
//               if (fdi != teeth.last) const SizedBox(width: spacing),
//             ],
//           ],
//         );
//       },
//     );
//   }
// }
//
// class _ToothNumber extends StatelessWidget {
//   final int fdi;
//   final double size;
//   const _ToothNumber(this.fdi, this.size);
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: size * .45, // 살짝 줄여 상하 여유 확보
//       child: Center(
//         child: Text('$fdi', style: const TextStyle(fontWeight: FontWeight.w700)),
//       ),
//     );
//   }
// }
//
// class _BigToothTile extends StatelessWidget {
//   final int fdi;
//   final double size;
//   const _BigToothTile({required this.fdi, required this.size});
//
//   bool get _mesialOnRight {
//     final q = fdi ~/ 10;
//     if (q == 1 || q == 4 || q == 5 || q == 8) return true;
//     if (q == 2 || q == 3 || q == 6 || q == 7) return false;
//     return true;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final p = context.watch<DentalDataProvider>();
//     final selected = p.getSelectedSurfaces(fdi);
//
//     return GestureDetector(
//       behavior: HitTestBehavior.opaque,
//       onTapDown: (d) {
//         final key = _hitSurface(d.localPosition, Size.square(size), mesialOnRight: _mesialOnRight);
//         if (key != null) p.toggleSurface(fdi, key);
//       },
//       onLongPress: () => p.clearSurfaces(fdi),
//       child: CustomPaint(
//         size: Size.square(size),
//         painter: _FiveSurfacePainter(
//           selected: selected,
//           mesialOnRight: _mesialOnRight,
//           fdi: fdi,                 // ← 타일 안쪽에 번호 그리기
//         ),
//       ),
//     );
//   }
//
//   String? _hitSurface(Offset p, Size s, {required bool mesialOnRight}) {
//     final g = _Geom(s);
//     if (g.rectO.contains(p)) return 'O';
//     if (g.pathL.contains(p)) return 'L';
//     if (g.pathB.contains(p)) return 'B';
//     if (mesialOnRight) {
//       if (g.pathRight.contains(p)) return 'M';
//       if (g.pathLeft.contains(p))  return 'D';
//     } else {
//       if (g.pathLeft.contains(p))  return 'M';
//       if (g.pathRight.contains(p)) return 'D';
//     }
//     return null;
//   }
// }
//
// class _FiveSurfacePainter extends CustomPainter {
//   final Set<String> selected;
//   final bool mesialOnRight;
//   final int fdi;                    // ← 추가
//   _FiveSurfacePainter({
//     required this.selected,
//     required this.mesialOnRight,
//     required this.fdi,
//   });
//
//   @override
//   void paint(Canvas canvas, Size s) {
//     final g = _Geom(s);
//
//     final stroke = Paint()
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = (s.width * .04).clamp(1.0, 2.0)
//       ..color = Colors.black87;
//
//     final innerStroke = Paint()
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = (s.width * .032).clamp(0.8, 1.6)
//       ..color = Colors.black54;
//
//     final selFill = Paint()
//       ..style = PaintingStyle.fill
//       ..color = Colors.amber.withOpacity(.35);
//
//     if (selected.contains('L')) canvas.drawPath(g.pathL, selFill);
//     if (selected.contains('B')) canvas.drawPath(g.pathB, selFill);
//     if (selected.contains('O')) canvas.drawRect(g.rectO, selFill);
//
//     if (mesialOnRight) {
//       if (selected.contains('M')) canvas.drawPath(g.pathRight, selFill);
//       if (selected.contains('D')) canvas.drawPath(g.pathLeft,  selFill);
//     } else {
//       if (selected.contains('M')) canvas.drawPath(g.pathLeft,  selFill);
//       if (selected.contains('D')) canvas.drawPath(g.pathRight, selFill);
//     }
//
//     // 외곽/내부선
//     canvas.drawRRect(g.outerRRect, stroke);
//     canvas.drawRect(g.rectO, innerStroke);
//
//     final oc = [g.outerRect.topLeft, g.outerRect.topRight, g.outerRect.bottomRight, g.outerRect.bottomLeft];
//     final ic = [g.rectO.topLeft, g.rectO.topRight, g.rectO.bottomRight, g.rectO.bottomLeft];
//     for (int i = 0; i < 4; i++) {
//       canvas.drawLine(ic[i], oc[i], innerStroke);
//     }
//
//     // 타일 안쪽 좌상단에 FDI 번호(흰 배경으로 가독성 확보)
//     final pad = s.width * .04;
//     final textPainter = TextPainter(
//       text: TextSpan(
//         text: '$fdi',
//         style: TextStyle(
//           color: Colors.black87,
//           fontSize: s.width * .22,
//           fontWeight: FontWeight.w600,
//         ),
//       ),
//       textDirection: TextDirection.ltr,
//     )..layout();
//
//     final bgRect = Rect.fromLTWH(
//       pad - 2,
//       pad - 1,
//       textPainter.width + 4,
//       textPainter.height,
//     );
//     final bgPaint = Paint()..color = Colors.white.withOpacity(.9);
//     canvas.drawRRect(RRect.fromRectAndRadius(bgRect, const Radius.circular(2)), bgPaint);
//     textPainter.paint(canvas, Offset(pad, pad));
//   }
//
//   @override
//   bool shouldRepaint(covariant _FiveSurfacePainter old) =>
//       old.selected != selected || old.mesialOnRight != mesialOnRight || old.fdi != fdi;
// }
//
// class _Geom {
//   late final Rect outerRect;
//   late final RRect outerRRect;
//   late final Rect rectO;
//   late final Path pathL, pathB, pathLeft, pathRight;
//
//   _Geom(Size s) {
//     outerRect  = Offset.zero & s;
//     outerRRect = RRect.fromRectAndRadius(outerRect.deflate(1), Radius.circular(s.width * .12));
//
//     final w = s.width, h = s.height;
//     final rectW = w * .66;
//     final rectH = h * .46;
//     rectO = Rect.fromCenter(center: outerRect.center, width: rectW, height: rectH);
//
//     pathL = Path()
//       ..moveTo(outerRect.left, outerRect.top)
//       ..lineTo(outerRect.right, outerRect.top)
//       ..lineTo(rectO.right, rectO.top)
//       ..lineTo(rectO.left,  rectO.top)
//       ..close();
//
//     pathB = Path()
//       ..moveTo(outerRect.left,  outerRect.bottom)
//       ..lineTo(outerRect.right, outerRect.bottom)
//       ..lineTo(rectO.right,     rectO.bottom)
//       ..lineTo(rectO.left,      rectO.bottom)
//       ..close();
//
//     pathLeft = Path()
//       ..moveTo(outerRect.left,  outerRect.top)
//       ..lineTo(rectO.left,      rectO.top)
//       ..lineTo(rectO.left,      rectO.bottom)
//       ..lineTo(outerRect.left,  outerRect.bottom)
//       ..close();
//
//     pathRight = Path()
//       ..moveTo(outerRect.right, outerRect.top)
//       ..lineTo(rectO.right,     rectO.top)
//       ..lineTo(rectO.right,     rectO.bottom)
//       ..lineTo(outerRect.right, outerRect.bottom)
//       ..close();
//   }
// }

import 'dart:math' show min, max;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/dental_data_provider.dart';
import '../data/codes_635.dart';
import '../data/surface_fill.dart';


/// ====== (임시) 코드 카탈로그 ======
/// TODO: /assets/interpol_dental_code.json 으로 교체해서 로드하도록 바꾸기
/// 현재 미사용
// const Map<String, List<String>> kCatalogGlobal = {
//   'bite': ['COI','OVB','OBB','XBV'],
//   'crown': ['CAR','ABR','AMF','RCT'],
//   'root': ['RBL','RES','RFX','IPX'],
//   'status': ['MIS','MOB','IMP'],
//   'position': ['ROT','TIP','MAL'],
// };
//
// const Map<String, List<String>> kCatalogSurface = {
//   'fillings': ['AM','COM','INL','ONL','GIC','CAR'],
//   'periodontium': ['CAL','PG','REC','BOP'],
// };

class QuadrantZoomScreen extends StatelessWidget {
  final String title;
  final bool isUpper;        // 상악이면 true
  final bool isPermanent;    // 라벨/표시용
  final List<int> teeth;     // 예) [18..11] 또는 [21..28], [55..51] 등

  const QuadrantZoomScreen({
    super.key,
    required this.title,
    required this.isUpper,
    required this.isPermanent,
    required this.teeth,
  });

  @override
  Widget build(BuildContext context) {
    final numbersOnTop = isUpper;

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
          IconButton(
            tooltip: '도움말',
            icon: const Icon(Icons.help_outline),
            onPressed: () => _showZoomHelp(context),
          ),
        ],
      ),
      body: InteractiveViewer(
        panEnabled: false,
        minScale: .7,
        maxScale: 3.5,
        boundaryMargin: const EdgeInsets.all(200),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: _QuadrantRow(
              teeth: teeth,
              numbersOnTop: numbersOnTop,
              onOpenGlobal: (fdi) => _openGlobalSheet(context, fdi),
              onOpenSurface: (fdi, surf) => _openSurfaceSheet(context, fdi, surf),
            ),
          ),
        ),
      ),
    );
  }

  void _showZoomHelp(BuildContext context) {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      builder: (_) => Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('확대 화면 사용법', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
            SizedBox(height: 8),
            Text("• 한 번 탭: 탭한 표면의 ‘코드/메모’ 시트를 바로 엽니다."),
            Text("• 길게 누르기: 표면 컨텍스트 메뉴(편집 / 표면 데이터 삭제)를 엽니다."),
            Text("• 빈 영역 길게 누르기: 치아 전역 코드/메모 시트를 엽니다."),
            SizedBox(height: 12),
            Align(
              alignment: Alignment.centerRight,
              child: Text('닫으려면 바깥을 탭하세요', style: TextStyle(color: Colors.black54)),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _openGlobalSheet(BuildContext context, int fdi) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      showDragHandle: true,
      builder: (_) => _Global635Sheet(fdi: fdi),
    );
  }

  Future<void> _openSurfaceSheet(BuildContext context, int fdi, String surface) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      showDragHandle: true,
      builder: (_) => _Surface635Sheet(fdi: fdi, surface: surface),
    );
  }
}

class _QuadrantRow extends StatelessWidget {
  final List<int> teeth;
  final bool numbersOnTop;
  final void Function(int fdi) onOpenGlobal;
  final void Function(int fdi, String surface) onOpenSurface;

  const _QuadrantRow({
    required this.teeth,
    required this.numbersOnTop,
    required this.onOpenGlobal,
    required this.onOpenSurface,
  });

  @override
  Widget build(BuildContext context) {
    const spacing = 12.0;
    return LayoutBuilder(
      builder: (context, c) {
        final n = teeth.length; // 8 or 5
        final tile = ((c.maxWidth - spacing * (n - 1)) / n).clamp(28.0, 90.0);
        final rowWidth = n * tile + (n - 1) * spacing;

        return Center(
          child: SizedBox(
            width: rowWidth,
            child: Stack(
              children: [
                // 행 오버레이(덴쳐 타원)
                Positioned.fill(
                  child: _RowDentureOverlayPainterWidget(
                    teeth: teeth,
                    tile: tile,
                    spacing: spacing,
                  ),
                ),
                // 실제 타일들
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    for (final fdi in teeth) ...[
                      SizedBox(
                        width: tile,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // ✅ 숫자(위)에 길게=전역 시트
                            if (numbersOnTop)
                              GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onLongPress: () => onOpenGlobal(fdi),
                                child: _ToothNumber(fdi, tile),
                              ),

                            _BigToothTile(
                              fdi: fdi,
                              size: tile,
                              onOpenGlobal: onOpenGlobal,
                              onOpenSurface: onOpenSurface,
                            ),

                            // ✅ 숫자(아래)에 길게=전역 시트
                            if (!numbersOnTop)
                              GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onLongPress: () => onOpenGlobal(fdi),
                                child: _ToothNumber(fdi, tile),
                              ),
                          ],
                        ),
                      ),
                      if (fdi != teeth.last) const SizedBox(width: spacing),
                    ],
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
class _RowDentureOverlayPainterWidget extends StatelessWidget {
  final List<int> teeth;
  final double tile;
  final double spacing;
  const _RowDentureOverlayPainterWidget({
    required this.teeth,
    required this.tile,
    required this.spacing,
  });

  @override
  Widget build(BuildContext context) {
    final p = context.watch<DentalDataProvider>();
    // 덴쳐 스팬만 투영
    final spans = p.spans.where((sp) => sp.type == DentalSpanType.dentureOrtho).toList();
    return CustomPaint(
      painter: _RowDentureOverlayPainter(
        teeth: teeth,
        tile: tile,
        spacing: spacing,
        spans: spans,
      ),
    );
  }
}

class _RowDentureOverlayPainter extends CustomPainter {
  final List<int> teeth;
  final double tile;
  final double spacing;
  final List<DentalSpan> spans;
  _RowDentureOverlayPainter({
    required this.teeth,
    required this.tile,
    required this.spacing,
    required this.spans,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (teeth.isEmpty) return;
    // 각 치아의 타일 좌표(로컬) 맵핑
    final rects = <int, Rect>{};
    for (int i = 0; i < teeth.length; i++) {
      final x = i * (tile + spacing);
      rects[teeth[i]] = Rect.fromLTWH(x, 0, tile, tile);
    }

    final paintBlue = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = (tile * .12).clamp(1.6, 3.2)
      ..color = Colors.blueAccent;

    for (final sp in spans) {
      final inside = teeth.where(sp.teeth.contains).toList();
      if (inside.isEmpty) continue;

      // 클러스터(연속 부분) 별로 나누기
      final clusters = <List<int>>[];
      List<int> cur = [];
      for (int i = 0; i < inside.length; i++) {
        if (cur.isEmpty) {
          cur = [inside[i]];
        } else {
          final prevIdx = teeth.indexOf(cur.last);
          final thisIdx = teeth.indexOf(inside[i]);
          if (thisIdx == prevIdx + 1) {
            cur.add(inside[i]);
          } else {
            clusters.add(cur);
            cur = [inside[i]];
          }
        }
      }
      if (cur.isNotEmpty) clusters.add(cur);

      for (final cluster in clusters) {
        final left = rects[cluster.first]!;
        final right = rects[cluster.last]!;
        Rect union = Rect.fromLTRB(left.left, left.top, right.right, right.bottom);

        // 약간 여백을 둔 캡슐(라운드 큰 RRect)로 타원 느낌
        final marginX = tile * .18, marginY = tile * .12;
        final rr = RRect.fromRectAndRadius(
          union.inflate(marginX).deflate(0).inflate(0).deflate(-marginY),
          Radius.circular(union.height),
        );
        canvas.drawRRect(rr, paintBlue);
      }
    }
  }

  @override
  bool shouldRepaint(covariant _RowDentureOverlayPainter old) =>
      old.teeth != teeth || old.tile != tile || old.spacing != spacing || old.spans != spans;
}


class _ToothNumber extends StatelessWidget {
  final int fdi;
  final double size;
  const _ToothNumber(this.fdi, this.size);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size * .6,
      child: Center(
        child: Text('$fdi', style: const TextStyle(fontWeight: FontWeight.w700)),
      ),
    );
  }
}

class _BigToothTile extends StatelessWidget {
  final int fdi;
  final double size;
  final void Function(int) onOpenGlobal;          // 그대로 사용
  final void Function(int, String) onOpenSurface; // 그대로 사용

  const _BigToothTile({
    required this.fdi,
    required this.size,
    required this.onOpenGlobal,
    required this.onOpenSurface,
  });

  bool get _mesialOnRight {
    final q = fdi ~/ 10;
    if (q == 1 || q == 4 || q == 5 || q == 8) return true;  // 우측군
    if (q == 2 || q == 3 || q == 6 || q == 7) return false; // 좌측군
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final p = context.watch<DentalDataProvider>();
    final spec = p.getSpecRead(fdi);

    // ── (기존) 표면 채우기 계산 ─────────────────────────
    final Map<String, _SurfaceFill> fill = {
      for (final s in kToothSurfaces) s: _SurfaceFill.none,
    };
    if (spec != null) {
      for (final s in kToothSurfaces) {
        final list = spec.surface[s]!['fillings']!;
        final hasCaries = list.any(isCariesCode);
        if (hasCaries) {
          fill[s] = _SurfaceFill.cariesRed;
        } else if (list.isNotEmpty) {
          fill[s] = _SurfaceFill.fillingBlue;
        }
      }
    }

    // ── ✅ 전역 코드에 따른 확대화면 마킹 ───────────────────
// crown: 아무 코드라도 선택돼 있으면 파란 링
    final bool markCrownRing =
        (spec?.global['crown'] ?? const <String>[]).isNotEmpty;

// status: MIS 계열(= 'MIS' 또는 'MIS...' 로 시작) → 수평선 2개
    final bool markStatusMissing =
    (spec?.global['status'] ?? const <String>[])
        .map((e) => e.toUpperCase())
        .any((c) => c == 'MIS' || c.startsWith('MIS'));

// root: IPX 계열(= 'IPX' 또는 'IPX...' 로 시작) → 수직선 1개
    final bool markRootImplant =
    (spec?.global['root'] ?? const <String>[])
        .map((e) => e.toUpperCase())
        .any((c) => c == 'IPX' || c.startsWith('IPX'));

    // ── ✅ 스팬(덴쳐/브릿지) 마킹 계산 ───────────────────
    bool markDenture = false, markAbut = false, markPontic = false;
    for (final sp in p.spans) {
      if (!sp.teeth.contains(fdi)) continue;
      if (sp.type == DentalSpanType.dentureOrtho) {
        markDenture = true;
      } else {
        if (sp.abutments.contains(fdi)) markAbut = true;
        if (sp.pontics.contains(fdi))   markPontic = true;
      }
    }

    return GestureDetector(
      behavior: HitTestBehavior.opaque,

      // ✔ 탭 업에서만 실행 → 롱프레스가 발생하면 탭이 취소됨
      onTapUp: (d) {
        final surface = surfaceAtPoint(
          d.localPosition,
          Size.square(size),
          mesialOnRight: _mesialOnRight,
          hitSlop: 12,
        );
        if (surface != null) {
          onOpenSurface(fdi, surface);
        }
      },

      // ✔ 롱프레스: 표면이면 메뉴, 아니면 전역 시트
      onLongPressStart: (details) async {
        final key = _hitSurface(details.localPosition, Size.square(size), mesialOnRight: _mesialOnRight);
        if (key == null) {
          // ✅ 프레임(빈공간) 길게 → 전역
          onOpenGlobal(fdi);
          return;
        }

        final choice = await showMenu<String>(
          context: context,
          position: RelativeRect.fromLTRB(
            details.globalPosition.dx,
            details.globalPosition.dy,
            details.globalPosition.dx,
            details.globalPosition.dy,
          ),
          items: const [
            PopupMenuItem(value: 'edit',  child: Text('코드/메모 편집')),
            PopupMenuItem(value: 'clear', child: Text('표면 데이터 삭제')),
          ],
        );

        if (choice == 'edit') {
          onOpenSurface(fdi, key);
        } else if (choice == 'clear') {
          context.read<DentalDataProvider>().clearSurface635(fdi, key);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Tooth $fdi / $key 표면 데이터가 삭제되었습니다.')),
          );
        }
      },

      child: CustomPaint(
        size: Size.square(size),
        painter: _FiveSurfacePainter(
          mesialOnRight: _mesialOnRight,
          abut: markAbut,
          pontic: markPontic,
          fill: fill,
          ringCrown: markCrownRing,       // ← crown 전역코드 → 링
          twoHorizontal: markStatusMissing, // ← status(MIS*) → 수평 2줄
          oneVertical: markRootImplant,   // ← root(IPX*) → 수직 1줄
        ),
      ),
    );
  }

  String? _hitSurface(Offset p, Size s, {required bool mesialOnRight}) {
    final g = _Geom(s);

    // ✅ ① 프레임(가장자리 띠)을 '빈공간'으로 간주 → 전역 시트 트리거
    final frameBand = s.width * 0.08; // 가장자리 두께
    final inner = g.outerRect.deflate(frameBand);
    if (g.outerRect.contains(p) && !inner.contains(p)) {
      // 프레임 영역이면 표면이 아님 => null 반환
      return null;
    }

    // ② 기존 표면 판정
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

enum _SurfaceFill { none, toggleAmber, fillingBlue, cariesRed }

class _FiveSurfacePainter extends CustomPainter {
  final bool mesialOnRight;
  final Map<String, _SurfaceFill> fill;

  final bool abut;     // 지대치 → 파란 링
  final bool pontic;   // Pontic → 수평 2줄

  final bool ringCrown;     // crown 선택 시 파란 링
  final bool twoHorizontal; // status MIS* → 수평 2줄
  final bool oneVertical;   // root IPX* → 수직 1줄

  const _FiveSurfacePainter({
    required this.mesialOnRight,
    required this.fill,
    this.abut = false,
    this.pontic = false,
    this.ringCrown = false,
    this.twoHorizontal = false,
    this.oneVertical = false,
  });

  @override
  void paint(Canvas canvas, Size s) {
    final g = _Geom(s);

    final outerStroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = (s.width * .04).clamp(1.0, 2.0)
      ..color = Colors.black87;

    final innerStroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = (s.width * .032).clamp(0.8, 1.6)
      ..color = Colors.black54;

    Paint paintOf(_SurfaceFill f) {
      switch (f) {
        case _SurfaceFill.cariesRed:
          return Paint()..style = PaintingStyle.fill..color = Colors.red.withOpacity(.35);
        case _SurfaceFill.fillingBlue:
          return Paint()..style = PaintingStyle.fill..color = Colors.blue.withOpacity(.28);
        case _SurfaceFill.toggleAmber:
          return Paint()..style = PaintingStyle.fill..color = Colors.amber.withOpacity(.35);
        case _SurfaceFill.none:
          return Paint()..style = PaintingStyle.stroke..color = Colors.transparent;
      }
    }

    // 면 채우기
    final l = fill['L'] ?? _SurfaceFill.none;
    final b = fill['B'] ?? _SurfaceFill.none;
    final o = fill['O'] ?? _SurfaceFill.none;
    final m = fill['M'] ?? _SurfaceFill.none;
    final d = fill['D'] ?? _SurfaceFill.none;

    if (l != _SurfaceFill.none) canvas.drawPath(g.pathL, paintOf(l));
    if (b != _SurfaceFill.none) canvas.drawPath(g.pathB, paintOf(b));
    if (o != _SurfaceFill.none) canvas.drawRect(g.rectO, paintOf(o));

    // M/D는 사분면에 따라 좌/우를 뒤집음
    final leftFill  = mesialOnRight ? d : m;
    final rightFill = mesialOnRight ? m : d;
    if (leftFill  != _SurfaceFill.none) canvas.drawPath(g.pathLeft,  paintOf(leftFill));
    if (rightFill != _SurfaceFill.none) canvas.drawPath(g.pathRight, paintOf(rightFill));

    // 윤곽/내부선
    canvas.drawRRect(g.outerRRect, outerStroke);
    canvas.drawRect(g.rectO, innerStroke);

    final oc = [g.outerRect.topLeft, g.outerRect.topRight, g.outerRect.bottomRight, g.outerRect.bottomLeft];
    final ic = [g.rectO.topLeft, g.rectO.topRight, g.rectO.bottomRight, g.rectO.bottomLeft];
    for (int i = 0; i < 4; i++) {
      canvas.drawLine(ic[i], oc[i], innerStroke);
    }

    // ===== 파란 마킹 공통 페인트 =====
    final blue = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = (s.width * .06).clamp(1.2, 2.4)
      ..color = Colors.blueAccent;

    // ▼ crown 또는 지대치 중 하나라도 있으면 '한 번만' 링을 그림
    if (ringCrown || abut) {
      final ring = g.outerRect.deflate(s.width * .18);
      canvas.drawRRect(
        RRect.fromRectAndRadius(ring, Radius.circular(ring.width * .20)),
        blue,
      );
    }

    // ▼ Pontic(또는 status MIS*) → 수평 2줄
    if (pontic || twoHorizontal) {
      final y1 = s.height * .40, y2 = s.height * .60;
      canvas.drawLine(Offset(s.width * .18, y1), Offset(s.width * .82, y1), blue);
      canvas.drawLine(Offset(s.width * .18, y2), Offset(s.width * .82, y2), blue);
    }

    // ▼ root(IPX*) → 수직 1줄
    if (oneVertical) {
      final x = s.width * .50;
      canvas.drawLine(Offset(x, s.height * .20), Offset(x, s.height * .80), blue);
    }
  }

  @override
  bool shouldRepaint(covariant _FiveSurfacePainter old) =>
      old.mesialOnRight != mesialOnRight ||
          !_mapEquals(old.fill, fill) ||
          old.abut != abut ||
          old.pontic != pontic ||
          old.ringCrown != ringCrown ||
          old.twoHorizontal != twoHorizontal ||
          old.oneVertical != oneVertical;

  bool _mapEquals(Map<String, _SurfaceFill> a, Map<String, _SurfaceFill> b) {
    if (identical(a, b)) return true;
    if (a.length != b.length) return false;
    for (final k in kToothSurfaces) {
      if ((a[k] ?? _SurfaceFill.none) != (b[k] ?? _SurfaceFill.none)) return false;
    }
    return true;
  }
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
    final rectW = w * .54;  // 중앙 가로직사각 비율(방패연)
    final rectH = h * .36;
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

/// =====================
/// 단일치아용 폼(전역 5그룹)
/// =====================
class _Global635Sheet extends StatelessWidget {
  final int fdi;
  const _Global635Sheet({required this.fdi});

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final kb = media.viewInsets.bottom;                  // ✅ 키보드 높이
    // 기본 65% 높이를 쓰되, 키보드가 올라오면 그만큼 줄여서 겹치지 않게
    final base = media.size.height * 0.65;
    final sheetHeight = (base > media.size.height - kb - 24)
        ? media.size.height - kb - 24
        : base;

    final p = context.watch<DentalDataProvider>();
    final spec = p.getSpecRead(fdi);
    final noteCtrl = TextEditingController(text: spec?.toothNote ?? '');

    return AnimatedPadding(                                  // ✅ 부드럽게 위로 올림
      duration: const Duration(milliseconds: 180),
      curve: Curves.easeOut,
      padding: EdgeInsets.only(bottom: kb),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
          child: SizedBox(
            height: sheetHeight,                              // ✅ 동적 높이
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Tooth $fdi — Global codes',
                    style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 8),
                Expanded(
                  child: ListView(
                    keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,   // ✅ 스크롤로 키보드 내림
                    children: k635GlobalCodes.entries.map((e) {
                      final group = e.key;
                      final codes = e.value;
                      final picked = p.getSpecRead(fdi)?.global[group] ?? const <String>[];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(group.toUpperCase(),
                                style: const TextStyle(fontWeight: FontWeight.w700)),
                            const SizedBox(height: 4),
                            Wrap(
                              spacing: 6, runSpacing: 6,
                              children: codes.map((c) {
                                final sel = picked.contains(c);
                                return FilterChip(
                                  label: Text(c),
                                  selected: sel,
                                  onSelected: (_) => p.toggleGlobalCode(fdi, group, c),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const Divider(),
                const Text('자연어 메모 (코드는 위에 칩으로 즉시 반영, 메모는 저장 버튼을 눌러야 반영됩니다)'),
                const SizedBox(height: 6),
                TextField(
                  controller: noteCtrl,
                  maxLines: 3,
                  keyboardType: TextInputType.multiline,           // ✅ 멀티라인
                  textInputAction: TextInputAction.newline,
                  decoration: const InputDecoration(
                    hintText: '예: 교합 개방감 있음. 회전 양상 관찰...',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(onPressed: () => Navigator.pop(context), child: const Text('닫기')),
                    const SizedBox(width: 8),
                    FilledButton(
                      onPressed: () {
                        p.setToothNote635(fdi, noteCtrl.text.trim());
                        Navigator.pop(context);
                      },
                      child: const Text('저장'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


/// =====================
/// 표면별 폼(표면 2그룹)
/// =====================
class _Surface635Sheet extends StatelessWidget {
  final int fdi;
  final String surface; // 'O','M','D','L','B'
  const _Surface635Sheet({required this.fdi, required this.surface});

  @override
  Widget build(BuildContext context) {
    final p = context.watch<DentalDataProvider>();
    final spec = p.getSpecRead(fdi);
    final initNote = spec?.surfaceNote[surface] ?? '';
    final noteCtrl = TextEditingController(text: initNote);

    // ✅ 키보드 높이만큼 안전하게 올리기 + 동적 높이
    final media = MediaQuery.of(context);
    final kb = media.viewInsets.bottom;                 // 키보드 높이
    final base = media.size.height * 0.65;              // 기본 시트 높이
    final sheetHeight = (base > media.size.height - kb - 24)
        ? media.size.height - kb - 24
        : base;

    return AnimatedPadding(                              // ✅ 키보드에 맞춰 부드럽게 위로
      duration: const Duration(milliseconds: 180),
      curve: Curves.easeOut,
      padding: EdgeInsets.only(bottom: kb),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
          child: SizedBox(
            height: sheetHeight,                         // ✅ 동적 높이 적용
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Tooth $fdi — Surface $surface',
                    style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 8),
                Expanded(
                  child: ListView(
                    keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag, // ✅ 드래그로 키보드 내리기
                    children: [
                      for (final grp in ['fillings','periodontium'])
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: _SurfaceGroupChips(
                            fdi: fdi,
                            surface: surface,
                            group: grp,
                            codes: k635SurfaceCodes[grp] ?? const [],
                          ),
                        ),
                    ],
                  ),
                ),
                const Divider(),
                const Text('자연어 메모 (코드 칩 선택은 즉시 반영, 메모는 저장 버튼을 눌러야 반영됩니다)'),
                const SizedBox(height: 6),
                TextField(
                  controller: noteCtrl,
                  maxLines: 3,
                  keyboardType: TextInputType.multiline,  // ✅ 멀티라인
                  textInputAction: TextInputAction.newline,
                  scrollPadding: const EdgeInsets.only(bottom: 80),
                  decoration: const InputDecoration(
                    hintText: '예: 교합면 소와열 우식 의심...',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context), // 미저장 닫기
                      child: const Text('닫기'),
                    ),
                    const SizedBox(width: 8),
                    FilledButton(
                      onPressed: () {
                        p.setSurfaceNote635(fdi, surface, noteCtrl.text.trim()); // 저장
                        Navigator.pop(context);
                      },
                      child: const Text('저장'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SurfaceGroupChips extends StatelessWidget {
  final int fdi;
  final String surface; // O/M/D/L/B
  final String group;   // fillings / periodontium
  final List<String> codes;

  const _SurfaceGroupChips({
    required this.fdi,
    required this.surface,
    required this.group,
    required this.codes,
  });

  @override
  Widget build(BuildContext context) {
    final p = context.watch<DentalDataProvider>();
    final picked = p.getSpecRead(fdi)?.surface[surface]?[group] ?? const <String>[];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(group.toUpperCase(), style: const TextStyle(fontWeight: FontWeight.w700)),
        const SizedBox(height: 4),
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: codes.map((c) {
            final sel = picked.contains(c);
            final isCar = (group == 'fillings') && isCariesCode(c);
            return FilterChip(
              selected: sel,
              label: Text(c),
              selectedColor: isCar ? Colors.red.withOpacity(.18) : Colors.blue.withOpacity(.14),
              onSelected: (_) => p.toggleSurfaceCode(fdi, surface, group, c),
            );
          }).toList(),
        ),
      ],
    );
  }
}

/// 공통: “코드 칩은 잠금, 자연어에서 삭제 불가” 안내줄
class _LockedCodeHintRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Icon(Icons.lock, size: 16),
        SizedBox(width: 6),
        Expanded(child: Text('선택한 코드들은 위에 칩으로 고정 표시되고, 자연어 입력창에서 삭제할 수 없습니다.')),
      ],
    );
  }
}

/// 공통: 코드 칩 섹션 (현재 사용 안 함; 필요시 재활용)
class _CodeSection extends StatelessWidget {
  final String title;
  final List<String> codes;
  final bool Function(String code) isSelected;
  final void Function(String code) onToggle;

  const _CodeSection({
    required this.title,
    required this.codes,
    required this.isSelected,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final c in codes)
                  FilterChip(
                    label: Text(c),
                    selected: isSelected(c),
                    onSelected: (_) => onToggle(c),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// 표면 판정: O/L/B 우선 → 그 다음 M/D hitSlop 밴드 → 마지막에 좌/우 폴리곤
String? surfaceAtPoint(
    Offset local,
    Size size, {
      required bool mesialOnRight,
      double? hitSlop, // null이면 타일 크기 비례
    }) {
  final g = _Geom(size);

  // 1) 정확 판정 (O/L/B)
  if (g.rectO.contains(local)) return 'O';
  if (g.pathL.contains(local)) return 'L';
  if (g.pathB.contains(local)) return 'B';

  // 2) 관대한 M/D: 중앙 사각형 좌/우 가장자리 부근 + 수직 게이트 안에서만
  final double base = (size.width * 0.08).clamp(6.0, 12.0);
  final double slop = (hitSlop ?? base).toDouble();

  // 수직 게이트: 중앙 사각형 높이에 약간 여유를 준 범위에서만 M/D 슬롭 인정
  final gateTop = g.rectO.top - slop * 0.8;
  final gateBottom = g.rectO.bottom + slop * 0.8;
  final inGateY = (local.dy >= gateTop && local.dy <= gateBottom);

  if (inGateY) {
    // 왼쪽 슬롭
    if (local.dx <= g.rectO.left + slop && local.dx >= g.outerRect.left) {
      return mesialOnRight ? 'D' : 'M';
    }
    // 오른쪽 슬롭
    if (local.dx >= g.rectO.right - slop && local.dx <= g.outerRect.right) {
      return mesialOnRight ? 'M' : 'D';
    }
  }

  // 3) 폴리곤 최종 판정(정밀)
  if (g.pathLeft.contains(local))  return mesialOnRight ? 'D' : 'M';
  if (g.pathRight.contains(local)) return mesialOnRight ? 'M' : 'D';

  return null;
}
