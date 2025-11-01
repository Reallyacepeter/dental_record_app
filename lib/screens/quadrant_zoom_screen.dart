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

// import 'dart:math' show min, max;
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../providers/dental_data_provider.dart';
// import '../data/codes_635.dart';
// import '../data/surface_fill.dart';
//
// // === caries 3종만 빨강 처리 ===
// bool _isCariesThree(String c) {
//   final u = c.toUpperCase();
//   return u == 'CAR' || u == 'ACA' || u == 'CCA';
// }
//
// class QuadrantZoomScreen extends StatelessWidget {
//   final String title;
//   final bool isUpper;        // 상악이면 true
//   final bool isPermanent;    // 라벨/표시용
//   final List<int> teeth;     // 예) [18..11] 또는 [21..28], [55..51] 등
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
//   Widget build(BuildContext context) {
//     final numbersOnTop = isUpper;
//     final media = MediaQuery.of(context);
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(title),
//         actions: [
//           IconButton(
//             tooltip: '도움말',
//             icon: const Icon(Icons.help_outline),
//             onPressed: () => _showZoomHelp(context),
//           ),
//         ],
//       ),
//       body: Stack(
//         children: [
//           // ① 원래의 확대 뷰
//           InteractiveViewer(
//             panEnabled: false,
//             minScale: .7,
//             maxScale: 3.5,
//             boundaryMargin: const EdgeInsets.all(200),
//             child: Center(
//               child: Padding(
//                 padding: const EdgeInsets.all(16),
//                 child: _QuadrantRow(
//                   teeth: teeth,
//                   numbersOnTop: numbersOnTop,
//                   onOpenGlobal: (fdi) => _openGlobalSheet(context, fdi),
//                   onOpenSurface: (fdi, surf) => _openSurfaceSheet(context, fdi, surf),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   void _showZoomHelp(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       showDragHandle: true,
//       builder: (_) => Padding(
//         padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: const [
//             Text('확대 화면 사용법', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
//             SizedBox(height: 8),
//             Text("• 한 번 탭: 탭한 표면의 ‘코드/메모’ 시트를 엽니다."),
//             Text("• 숫자(치아 번호) 길게 누르기: 치아 ‘전역’ 코드/메모 시트를 엽니다."),
//             Text("• 빈 영역 길게 누르기: 전역 코드/메모 시트를 엽니다."),
//             SizedBox(height: 12),
//             Align(
//               alignment: Alignment.centerRight,
//               child: Text('닫으려면 바깥을 탭하세요', style: TextStyle(color: Colors.black54)),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   // Future<void> _openInterpolPicker(BuildContext context) async {
//   //   final p = context.read<DentalDataProvider>();
//   //   await p.loadCodeTreeOnce(); // 최초 1회 로드
//   //
//   //   // 확대뷰에서 쓸 카테고리(= 브릿지/덴쳐 제외 나머지 전부)
//   //   final categories = p.availableCategories(ViewMode.zoomIn);
//   //   if (categories.isEmpty) {
//   //     ScaffoldMessenger.of(context).showSnackBar(
//   //       const SnackBar(content: Text('사용 가능한 코드 카테고리가 없습니다.')),
//   //     );
//   //     return;
//   //   }
//   //
//   //   // 초기 선택 복원
//   //   CodeSelection? init = p.currentSelectionZoom;
//   //   String? cat = (init != null && categories.contains(init.category)) ? init.category : categories.first;
//   //   final List<String> path = [...(init?.path ?? const <String>[])];
//   //
//   //   List<CodeNode> childrenOf(String category, List<String> prefix) =>
//   //       p.listChildren(category, prefix);
//   //
//   //   await showModalBottomSheet(
//   //     context: context,
//   //     isScrollControlled: true,
//   //     useSafeArea: true,
//   //     showDragHandle: true,
//   //     builder: (_) => StatefulBuilder(
//   //       builder: (ctx, setStateDlg) {
//   //         // 레벨별 옵션(선택한 카테고리에 따라 갱신)
//   //         final level0 = cat == null ? const <CodeNode>[] : childrenOf(cat!, const []);
//   //         final level1 = (cat == null || path.isEmpty) ? const <CodeNode>[] : childrenOf(cat!, path.take(1).toList());
//   //         final level2 = (cat == null || path.length < 2) ? const <CodeNode>[] : childrenOf(cat!, path.take(2).toList());
//   //         final level3 = (cat == null || path.length < 3) ? const <CodeNode>[] : childrenOf(cat!, path.take(3).toList());
//   //
//   //         DropdownButtonFormField<String> catDD() {
//   //           return DropdownButtonFormField<String>(
//   //             isExpanded: true,
//   //             value: cat,
//   //             decoration: const InputDecoration(labelText: 'Category'),
//   //             items: categories.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
//   //             onChanged: (v) => setStateDlg(() { cat = v; path.clear(); }),
//   //           );
//   //         }
//   //
//   //         DropdownButtonFormField<String> dd(List<CodeNode> items, int level, String label) {
//   //           final cur = path.length > level ? path[level] : null;
//   //           return DropdownButtonFormField<String>(
//   //             isExpanded: true,
//   //             value: cur,
//   //             decoration: InputDecoration(labelText: label),
//   //             items: items.map((n) => DropdownMenuItem(value: n.code, child: Text('${n.code} — ${n.label}'))).toList(),
//   //             onChanged: (v) {
//   //               if (v == null) return;
//   //               setStateDlg(() {
//   //                 if (path.length > level) path.removeRange(level, path.length);
//   //                 if (path.length == level) { path.add(v); } else { path[level] = v; }
//   //               });
//   //             },
//   //           );
//   //         }
//   //
//   //         return Padding(
//   //           padding: EdgeInsets.only(
//   //             left: 16, right: 16, top: 12,
//   //             bottom: MediaQuery.of(ctx).viewInsets.bottom + 16,
//   //           ),
//   //           child: Column(
//   //             mainAxisSize: MainAxisSize.min,
//   //             crossAxisAlignment: CrossAxisAlignment.start,
//   //             children: [
//   //               Text('Interpol 코드 선택 (확대뷰)', style: Theme.of(ctx).textTheme.titleMedium),
//   //               const SizedBox(height: 8),
//   //               catDD(),
//   //               if (cat != null) ...[
//   //                 const SizedBox(height: 8),
//   //                 dd(level0, 0, 'Level 1'),
//   //                 if (level1.isNotEmpty) ...[
//   //                   const SizedBox(height: 8), dd(level1, 1, 'Level 2'),
//   //                 ],
//   //                 if (level2.isNotEmpty) ...[
//   //                   const SizedBox(height: 8), dd(level2, 2, 'Level 3'),
//   //                 ],
//   //                 if (level3.isNotEmpty) ...[
//   //                   const SizedBox(height: 8), dd(level3, 3, 'Level 4'),
//   //                 ],
//   //                 const SizedBox(height: 12),
//   //                 Row(
//   //                   children: [
//   //                     Expanded(
//   //                       child: Text(
//   //                         (cat == null)
//   //                             ? '선택 없음'
//   //                             : '확정: $cat${path.isEmpty ? '' : ' · ${path.join(" > ")}'}',
//   //                         overflow: TextOverflow.ellipsis,
//   //                         style: const TextStyle(color: Colors.black54),
//   //                       ),
//   //                     ),
//   //                     TextButton.icon(
//   //                       onPressed: () => setStateDlg(() => path.clear()),
//   //                       icon: const Icon(Icons.clear),
//   //                       label: const Text('경로 초기화'),
//   //                     ),
//   //                   ],
//   //                 ),
//   //               ],
//   //               const SizedBox(height: 8),
//   //               Row(
//   //                 mainAxisAlignment: MainAxisAlignment.end,
//   //                 children: [
//   //                   TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('닫기')),
//   //                   const SizedBox(width: 8),
//   //                   FilledButton(
//   //                     onPressed: (cat == null)
//   //                         ? null
//   //                         : () {
//   //                       final sel = CodeSelection(category: cat!, path: List<String>.from(path));
//   //                       // 경로가 실제로 존재하는지만 확인(레벨 강제 없음)
//   //                       if (!p.isValidSelection(sel.category, sel.path)) {
//   //                         ScaffoldMessenger.of(ctx).showSnackBar(
//   //                           const SnackBar(content: Text('유효하지 않은 선택 경로입니다.')),
//   //                         );
//   //                         return;
//   //                       }
//   //                       p.setSelectionFor(ViewMode.zoomIn, sel);
//   //                       Navigator.pop(ctx);
//   //                       ScaffoldMessenger.of(context).showSnackBar(
//   //                         SnackBar(content: Text('확대뷰 코드 확정: ${sel.category}${sel.path.isEmpty ? "" : " · ${sel.path.join(" > ")}"}')),
//   //                       );
//   //                     },
//   //                     child: const Text('확인'),
//   //                   ),
//   //                 ],
//   //               ),
//   //             ],
//   //           ),
//   //         );
//   //       },
//   //     ),
//   //   );
//   // }
//
//   Future<void> _openGlobalSheet(BuildContext context, int fdi) async {
//     await showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       useSafeArea: true,
//       showDragHandle: true,
//       builder: (_) => _Global635Sheet(fdi: fdi),
//     );
//   }
//
//   Future<void> _openSurfaceSheet(BuildContext context, int fdi, String surface) async {
//     await showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       useSafeArea: true,
//       showDragHandle: true,
//       builder: (_) => _Surface635Sheet(fdi: fdi, surface: surface),
//     );
//   }
// }
//
// class _QuadrantRow extends StatelessWidget {
//   final List<int> teeth;
//   final bool numbersOnTop;
//   final void Function(int fdi) onOpenGlobal;
//   final void Function(int fdi, String surface) onOpenSurface;
//
//   const _QuadrantRow({
//     required this.teeth,
//     required this.numbersOnTop,
//     required this.onOpenGlobal,
//     required this.onOpenSurface,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     const spacing = 12.0;
//     return LayoutBuilder(
//       builder: (context, c) {
//         final n = teeth.length; // 8 or 5
//         final tile = ((c.maxWidth - spacing * (n - 1)) / n).clamp(28.0, 90.0);
//         final rowWidth = n * tile + (n - 1) * spacing;
//
//         return Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             // ✔️ 행 위쪽, 오른쪽 정렬 요약 패널 (겹치지 않음, 폭 제한)
//             Align(
//               alignment: Alignment.topRight,
//               child: ConstrainedBox(
//                 constraints: BoxConstraints(maxWidth: min<double>(c.maxWidth, 280)),
//                 child: _QuadrantInfoOverlay(
//                   teeth: teeth,
//                   // 더 이상 tile 필요 없음
//                 ),
//               ),
//             ),
//             const SizedBox(height: 8),
//             // 치아 행
//             Center(
//               child: SizedBox(
//                 width: rowWidth,
//                 child: Stack(
//                   children: [
//                     Positioned.fill(
//                       child: _RowDentureOverlayPainterWidget(
//                         teeth: teeth, tile: tile, spacing: spacing,
//                       ),
//                     ),
//                     Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         for (final fdi in teeth) ...[
//                           SizedBox(
//                             width: tile,
//                             child: Column(
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 if (numbersOnTop)
//                                   GestureDetector(
//                                     behavior: HitTestBehavior.opaque,
//                                     onLongPress: () => onOpenGlobal(fdi),
//                                     child: _ToothNumber(fdi, tile),
//                                   ),
//                                 _BigToothTile(
//                                   fdi: fdi,
//                                   size: tile,
//                                   onOpenGlobal: onOpenGlobal,
//                                   onOpenSurface: onOpenSurface,
//                                 ),
//                                 if (!numbersOnTop)
//                                   GestureDetector(
//                                     behavior: HitTestBehavior.opaque,
//                                     onLongPress: () => onOpenGlobal(fdi),
//                                     child: _ToothNumber(fdi, tile),
//                                   ),
//                               ],
//                             ),
//                           ),
//                           if (fdi != teeth.last) const SizedBox(width: spacing),
//                         ],
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
//
// // 2) 패널 위젯
// // class _QuadrantInfoOverlay extends StatefulWidget {
// //   final List<int> teeth;
// //   const _QuadrantInfoOverlay({required this.teeth});
// //
// //   @override
// //   State<_QuadrantInfoOverlay> createState() => _QuadrantInfoOverlayState();
// // }
// //
// // class _QuadrantInfoOverlayState extends State<_QuadrantInfoOverlay> {
// //   bool showOnlyHighlighted = false; // ← 기본값: 전체(데이터 있는 치아)
// //   bool showSpans = true;
// //   bool expandSpans = false;
// //
// //   bool _isHighlighted(_SpecView spec) {
// //     // 확대뷰와 동일한 규칙을 그대로 재사용 (요약판)
// //     bool anySurface = kToothSurfaces.any((s) {
// //       final m = spec.surface[s];
// //       if (m == null) return false;
// //       final f = (m['fillings'] ?? const <String>[]) as List<String>;
// //       final p = (m['periodontium'] ?? const <String>[]) as List<String>;
// //       return f.isNotEmpty || p.isNotEmpty;
// //     });
// //     bool anyGlobal = spec.global.values.any((lst) => lst.isNotEmpty);
// //     bool anyNote = spec.toothNote.trim().isNotEmpty ||
// //         spec.surfaceNote.values.any((v) => v.trim().isNotEmpty);
// //
// //     final hasAnyInput = anySurface || anyGlobal || anyNote;
// //
// //     // 자체 시각표시(빨강/파랑/링/선/덴쳐) 여부
// //     final hasSurfacePaint = kToothSurfaces.any((s) {
// //       final f = (spec.surface[s]?['fillings'] ?? const <String>[]) as List<String>;
// //       final hasCaries = f.any(_isCariesThree);
// //       return hasCaries || f.isNotEmpty;
// //     });
// //     final ring = (spec.global['crown'] ?? const <String>[]).isNotEmpty;
// //     final twoH = (spec.global['status'] ?? const <String>[])
// //         .map((e)=>e.toUpperCase())
// //         .any((c)=> c=='MIS' || c.startsWith('MIS') || c=='MAM' || c=='MPM' || c=='EXT' || c=='SOX' || c=='MJA');
// //     final oneV = (spec.global['root'] ?? const <String>[])
// //         .map((e)=>e.toUpperCase())
// //         .any((c)=> c=='IPX' || c.startsWith('IPX'));
// //
// //     final hasOwnVisual = hasSurfacePaint || ring || twoH || oneV;
// //     return hasAnyInput && !hasOwnVisual;
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     final p = context.watch<DentalDataProvider>();
// //     final specs = <int, _SpecView>{
// //       for (final t in widget.teeth) t: _SpecView(t, p.getSpecRead(t))
// //     };
// //
// //     // 화면 폭 기준으로 패널 최대폭 계산
// //     final screenW = MediaQuery.of(context).size.width;
// //     final panelWidth = (screenW * 0.42).clamp(180, 280).toDouble();
// //
// //     // 필터링
// //     final items = specs.entries.where((e) {
// //       final spec = e.value;
// //       if (!showOnlyHighlighted) {
// //         // 입력이 있는 치아만 보이기
// //         final hasAny = spec.global.values.any((lst)=>lst.isNotEmpty) ||
// //             kToothSurfaces.any((s){
// //               final m=spec.surface[s];
// //               if (m==null) return false;
// //               return (m['fillings']??const <String>[]).isNotEmpty ||
// //                   (m['periodontium']??const <String>[]).isNotEmpty;
// //             }) ||
// //             spec.toothNote.trim().isNotEmpty ||
// //             spec.surfaceNote.values.any((v)=>v.trim().isNotEmpty);
// //         return hasAny;
// //       } else {
// //         return _isHighlighted(spec);
// //       }
// //     }).toList()
// //       ..sort((a,b)=>a.key.compareTo(b.key));
// //
// //     // 스팬(현재 사분면과 교집합만)
// //     final spans = p.spans.where((sp) => sp.teeth.any(widget.teeth.contains)).toList();
// //
// //     if (items.isEmpty && (!showSpans || spans.isEmpty)) {
// //       // 아무 것도 보여줄 게 없으면 패널 감춤
// //       return const SizedBox.shrink();
// //     }
// //
// //     return ConstrainedBox(
// //       constraints: BoxConstraints(maxWidth: panelWidth.toDouble()),
// //       child: Card(
// //         elevation: 2,
// //         margin: const EdgeInsets.only(top: 4, right: 4),
// //         child: Padding(
// //           padding: const EdgeInsets.fromLTRB(12, 8, 12, 10),
// //           child: Column(
// //             crossAxisAlignment: CrossAxisAlignment.start,
// //             children: [
// //               // 헤더 + 토글
// //               Row(
// //                 children: [
// //                   const Text('요약', style: TextStyle(fontWeight: FontWeight.w700)),
// //                   const Spacer(),
// //                   // 보라색만/입력있는치아 모두
// //                   DropdownButton<bool>(
// //                     value: showOnlyHighlighted,
// //                     underline: const SizedBox.shrink(),
// //                     items: const [
// //                       DropdownMenuItem(value: true,  child: Text('보라색만')),
// //                       DropdownMenuItem(value: false, child: Text('입력있는치아')),
// //                     ],
// //                     onChanged: (v)=>setState(()=>showOnlyHighlighted = v ?? true),
// //                   ),
// //                 ],
// //               ),
// //               const SizedBox(height: 6),
// //
// //               // 스팬 섹션
// //               if (showSpans && spans.isNotEmpty) ...[
// //                 InkWell(
// //                   onTap: ()=>setState(()=>expandSpans = !expandSpans),
// //                   child: Row(
// //                     children: [
// //                       const Icon(Icons.linear_scale, size: 16),
// //                       const SizedBox(width: 6),
// //                       Text('스팬 ${spans.length}개',
// //                           style: const TextStyle(fontWeight: FontWeight.w600)),
// //                       const Spacer(),
// //                       Icon(expandSpans ? Icons.expand_less : Icons.expand_more, size: 18),
// //                     ],
// //                   ),
// //                 ),
// //                 if (expandSpans)
// //                   ...spans.map((sp) => Padding(
// //                     padding: const EdgeInsets.only(top: 4),
// //                     child: Text(
// //                       _spanLine(sp, widget.teeth),
// //                       style: const TextStyle(fontSize: 12, color: Colors.black87),
// //                     ),
// //                   )),
// //                 const Divider(),
// //               ],
// //
// //               // 치아별 요약
// //               ...items.map((e) {
// //                 final fdi = e.key;
// //                 final s = e.value;
// //
// //                 final globals = _pickGlobalsOneLine(s.global);
// //                 final surfaces = _pickSurfacesOneLine(s.surface);
// //                 final note = (s.toothNote ?? '').trim();
// //
// //                 return Padding(
// //                   padding: const EdgeInsets.only(bottom: 8),
// //                   child: Column(
// //                     crossAxisAlignment: CrossAxisAlignment.start,
// //                     children: [
// //                       // 타이틀 행: [FDI] 전역/표면 열기 버튼
// //                       Row(
// //                         children: [
// //                           Text('[$fdi]',
// //                               style: const TextStyle(fontWeight: FontWeight.w700)),
// //                           const Spacer(),
// //                           TextButton(
// //                             child: const Text('전역'),
// //                             onPressed: ()=>_openGlobalFromOverlay(context, fdi),
// //                           ),
// //                           TextButton(
// //                             child: const Text('표면'),
// //                             onPressed: ()=>_openFirstSurfaceWithInput(context, fdi, s),
// //                           ),
// //                         ],
// //                       ),
// //                       if (globals.isNotEmpty)
// //                         Text('전역: $globals', style: const TextStyle(fontSize: 12)),
// //                       if (surfaces.isNotEmpty)
// //                         Text('표면: $surfaces', style: const TextStyle(fontSize: 12)),
// //                       if (note.isNotEmpty)
// //                         Text('메모: ${_ellipsis(note, 60)}',
// //                             style: const TextStyle(fontSize: 12, color: Colors.black87)),
// //                     ],
// //                   ),
// //                 );
// //               }),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// //
// //   String _spanLine(DentalSpan sp, List<int> visible) {
// //     String typ = sp.type == DentalSpanType.dentureOrtho ? 'Denture/Ortho' : 'Bridge';
// //     String range = _fmtSpanTeeth(sp.teeth.where(visible.contains).toList());
// //     String ap = '';
// //     if (sp.type != DentalSpanType.dentureOrtho) {
// //       ap = ' · Abut:${_fmtSpanTeeth(sp.abutments)} · Pontic:${_fmtSpanTeeth(sp.pontics)}';
// //     }
// //     return '$typ  $range$ap';
// //   }
// //
// //   String _fmtSpanTeeth(Iterable<int> ts) {
// //     final list = ts.toList();
// //     if (list.isEmpty) return '-';
// //     list.sort();
// //     // 간단 요약: 연속은 "11–14", 비연속은 "11,13"
// //     final buf = <String>[];
// //     int start = list.first, prev = list.first;
// //     for (int i = 1; i < list.length; i++) {
// //       if (list[i] == prev + 1) {
// //         prev = list[i];
// //       } else {
// //         buf.add(start == prev ? '$start' : '$start–$prev');
// //         start = prev = list[i];
// //       }
// //     }
// //     buf.add(start == prev ? '$start' : '$start–$prev');
// //     return buf.join(', ');
// //   }
// //
// //   String _pickGlobalsOneLine(Map<String, List<String>> g) {
// //     const keys = ['bite','position','status','root','crown','crown pathology'];
// //     final parts = <String>[];
// //     for (final k in keys) {
// //       final v = g[k] ?? const <String>[];
// //       if (v.isNotEmpty) parts.add('$k:${v.join("/")}');
// //     }
// //     return parts.join(' · ');
// //   }
// //
// //   String _pickSurfacesOneLine(Map<String, Map<String, List<String>>> m) {
// //     final parts = <String>[];
// //     for (final s in kToothSurfaces) {
// //       final f = (m[s]?['fillings'] ?? const <String>[]) as List<String>;
// //       final p = (m[s]?['periodontium'] ?? const <String>[]) as List<String>;
// //       if (f.isEmpty && p.isEmpty) continue;
// //       final join = [
// //         if (f.isNotEmpty) 'F:${f.join("/")}',
// //         if (p.isNotEmpty) 'P:${p.join("/")}',
// //       ].join(',');
// //       parts.add('$s($join)');
// //     }
// //     return parts.join(' · ');
// //   }
// //
// //   String _ellipsis(String s, int n) => s.length <= n ? s : '${s.substring(0, n)}…';
// //
// //   void _openGlobalFromOverlay(BuildContext context, int fdi) {
// //     showModalBottomSheet(
// //       context: context,
// //       isScrollControlled: true,
// //       useSafeArea: true,
// //       showDragHandle: true,
// //       builder: (_) => _Global635Sheet(fdi: fdi),
// //     );
// //   }
// //
// //   void _openFirstSurfaceWithInput(BuildContext context, int fdi, _SpecView spec) {
// //     // 입력 있는 표면 우선, 없으면 O로
// //     String surf = kToothSurfaces.firstWhere(
// //           (s) {
// //         final m = spec.surface[s];
// //         if (m == null) return false;
// //         final hasF = (m['fillings'] ?? const <String>[]).isNotEmpty;
// //         final hasP = (m['periodontium'] ?? const <String>[]).isNotEmpty;
// //         final hasN = (spec.surfaceNote[s]?.trim().isNotEmpty ?? false);
// //         return hasF || hasP || hasN;
// //       },
// //       orElse: () => 'O',
// //     );
// //     showModalBottomSheet(
// //       context: context,
// //       isScrollControlled: true,
// //       useSafeArea: true,
// //       showDragHandle: true,
// //       builder: (_) => _Surface635Sheet(fdi: fdi, surface: surf),
// //     );
// //   }
// //
// // }
//
// class _QuadrantInfoOverlay extends StatelessWidget {
//   final List<int> teeth;
//   const _QuadrantInfoOverlay({required this.teeth});
//
//   @override
//   Widget build(BuildContext context) {
//     final p = context.watch<DentalDataProvider>();
//     final specs = <int, _SpecView>{
//       for (final t in teeth) t: _SpecView(t, p.getSpecRead(t))
//     };
//
//     // 입력이 있는 치아만
//     final items = specs.entries.where((e) {
//       final s = e.value;
//       final anyGlobal = s.global.values.any((lst) => lst.isNotEmpty);
//       final anySurf = kToothSurfaces.any((x) {
//         final m = s.surface[x];
//         if (m == null) return false;
//         return (m['fillings'] ?? const <String>[]).isNotEmpty ||
//             (m['periodontium'] ?? const <String>[]).isNotEmpty;
//       });
//       final anyNote = s.toothNote.isNotEmpty ||
//           s.surfaceNote.values.any((v) => v.trim().isNotEmpty);
//       return anyGlobal || anySurf || anyNote;
//     }).toList()
//       ..sort((a,b) => a.key.compareTo(b.key));
//
//     // 현재 사분면과 교집합인 스팬만
//     final spans = p.spans.where((sp) => sp.teeth.any(teeth.contains)).toList();
//
//     return Card(
//       elevation: 2,
//       margin: const EdgeInsets.only(top: 4, right: 4),
//       child: Padding(
//         padding: const EdgeInsets.fromLTRB(12, 8, 12, 10),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text('요약', style: TextStyle(fontWeight: FontWeight.w700)),
//             const SizedBox(height: 6),
//
//             // 스팬 요약 (있으면)
//             if (spans.isNotEmpty) ...[
//               Row(
//                 children: [
//                   const Icon(Icons.linear_scale, size: 16),
//                   const SizedBox(width: 6),
//                   Text('스팬 ${spans.length}개',
//                       style: const TextStyle(fontWeight: FontWeight.w600)),
//                 ],
//               ),
//               const SizedBox(height: 4),
//               ...spans.map((sp) => Padding(
//                 padding: const EdgeInsets.only(bottom: 2),
//                 child: Text(
//                   _spanLine(sp, teeth),
//                   style: const TextStyle(fontSize: 12),
//                 ),
//               )),
//               const Divider(),
//             ],
//
//             if (items.isEmpty)
//               const Text(
//                 '이 사분면에 기록이 없습니다.',
//                 style: TextStyle(fontSize: 12, color: Colors.black54),
//               )
//             else
//               ...items.map((e) {
//                 final fdi = e.key;
//                 final s = e.value;
//                 final globals = _pickGlobalsOneLine(s.global);
//                 final surfaces = _pickSurfacesOneLine(s.surface);
//                 final note = s.toothNote;
//
//                 return Padding(
//                   padding: const EdgeInsets.only(bottom: 8),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         children: [
//                           Text('[$fdi]',
//                               style: const TextStyle(fontWeight: FontWeight.w700)),
//                           const Spacer(),
//                           TextButton(
//                             child: const Text('전역'),
//                             onPressed: () => _openGlobalFromOverlay(context, fdi),
//                           ),
//                           TextButton(
//                             child: const Text('표면'),
//                             onPressed: () => _openFirstSurfaceWithInput(context, fdi, s),
//                           ),
//                         ],
//                       ),
//                       if (globals.isNotEmpty)
//                         Text('전역: $globals', style: const TextStyle(fontSize: 12)),
//                       if (surfaces.isNotEmpty)
//                         Text('표면: $surfaces', style: const TextStyle(fontSize: 12)),
//                       if (note.isNotEmpty)
//                         Text('메모: ${_ellipsis(note, 60)}',
//                             style: const TextStyle(fontSize: 12, color: Colors.black87)),
//                     ],
//                   ),
//                 );
//               }),
//           ],
//         ),
//       ),
//     );
//   }
//
//   String _spanLine(DentalSpan sp, List<int> visible) {
//     final typ = sp.type == DentalSpanType.dentureOrtho ? 'Denture/Ortho' : 'Bridge';
//     final range = _fmtSpanTeeth(sp.teeth.where(visible.contains));
//     String ap = '';
//     if (sp.type != DentalSpanType.dentureOrtho) {
//       ap = ' · Abut:${_fmtSpanTeeth(sp.abutments)} · Pontic:${_fmtSpanTeeth(sp.pontics)}';
//     }
//     return '$typ  $range$ap';
//   }
//
//   String _fmtSpanTeeth(Iterable<int> it) {
//     final ts = it.toList()..sort();
//     if (ts.isEmpty) return '-';
//     final buf = <String>[];
//     int start = ts.first, prev = ts.first;
//     for (int i = 1; i < ts.length; i++) {
//       if (ts[i] == prev + 1) {
//         prev = ts[i];
//       } else {
//         buf.add(start == prev ? '$start' : '$start–$prev');
//         start = prev = ts[i];
//       }
//     }
//     buf.add(start == prev ? '$start' : '$start–$prev');
//     return buf.join(', ');
//   }
//
//   String _pickGlobalsOneLine(Map<String, List<String>> g) {
//     // Crowns 제거, crown만 사용
//     const keys = ['bite','position','status','root','crown','crown pathology'];
//     final parts = <String>[];
//     for (final k in keys) {
//       final v = g[k] ?? const <String>[];
//       if (v.isNotEmpty) parts.add('$k:${v.join("/")}');
//     }
//     return parts.join(' · ');
//   }
//
//   String _pickSurfacesOneLine(Map<String, Map<String, List<String>>> m) {
//     final parts = <String>[];
//     for (final s in kToothSurfaces) {
//       final f = (m[s]?['fillings'] ?? const <String>[]) as List<String>;
//       final p = (m[s]?['periodontium'] ?? const <String>[]) as List<String>;
//       if (f.isEmpty && p.isEmpty) continue;
//       final join = [
//         if (f.isNotEmpty) 'F:${f.join("/")}',
//         if (p.isNotEmpty) 'P:${p.join("/")}',
//       ].join(',');
//       parts.add('$s($join)');
//     }
//     return parts.join(' · ');
//   }
//
//   String _ellipsis(String s, int n) => s.length <= n ? s : '${s.substring(0, n)}…';
//
//   void _openGlobalFromOverlay(BuildContext context, int fdi) { /* 동일 */ }
//   void _openFirstSurfaceWithInput(BuildContext context, int fdi, _SpecView spec) { /* 동일 */ }
// }
//
// class _RowDentureOverlayPainterWidget extends StatelessWidget {
//   final List<int> teeth;
//   final double tile;
//   final double spacing;
//   const _RowDentureOverlayPainterWidget({
//     required this.teeth,
//     required this.tile,
//     required this.spacing,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     final p = context.watch<DentalDataProvider>();
//     // 덴쳐 스팬만 투영
//     final spans = p.spans.where((sp) => sp.type == DentalSpanType.dentureOrtho).toList();
//     return CustomPaint(
//       painter: _RowDentureOverlayPainter(
//         teeth: teeth,
//         tile: tile,
//         spacing: spacing,
//         spans: spans,
//       ),
//     );
//   }
// }
//
// class _RowDentureOverlayPainter extends CustomPainter {
//   final List<int> teeth;
//   final double tile;
//   final double spacing;
//   final List<DentalSpan> spans;
//   _RowDentureOverlayPainter({
//     required this.teeth,
//     required this.tile,
//     required this.spacing,
//     required this.spans,
//   });
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     if (teeth.isEmpty) return;
//     // 각 치아의 타일 좌표(로컬) 맵핑
//     final rects = <int, Rect>{};
//     for (int i = 0; i < teeth.length; i++) {
//       final x = i * (tile + spacing);
//       rects[teeth[i]] = Rect.fromLTWH(x, 0, tile, tile);
//     }
//
//     final paintBlue = Paint()
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = (tile * .12).clamp(1.6, 3.2)
//       ..color = Colors.blueAccent;
//
//     for (final sp in spans) {
//       final inside = teeth.where(sp.teeth.contains).toList();
//       if (inside.isEmpty) continue;
//
//       // 클러스터(연속 부분) 별로 나누기
//       final clusters = <List<int>>[];
//       List<int> cur = [];
//       for (int i = 0; i < inside.length; i++) {
//         if (cur.isEmpty) {
//           cur = [inside[i]];
//         } else {
//           final prevIdx = teeth.indexOf(cur.last);
//           final thisIdx = teeth.indexOf(inside[i]);
//           if (thisIdx == prevIdx + 1) {
//             cur.add(inside[i]);
//           } else {
//             clusters.add(cur);
//             cur = [inside[i]];
//           }
//         }
//       }
//       if (cur.isNotEmpty) clusters.add(cur);
//
//       for (final cluster in clusters) {
//         final left = rects[cluster.first]!;
//         final right = rects[cluster.last]!;
//         Rect union = Rect.fromLTRB(left.left, left.top, right.right, right.bottom);
//
//         // 약간 여백을 둔 캡슐(라운드 큰 RRect)로 타원 느낌
//         final marginX = tile * .18, marginY = tile * .12;
//         final rr = RRect.fromRectAndRadius(
//           union.inflate(marginX).deflate(0).inflate(0).deflate(-marginY),
//           Radius.circular(union.height),
//         );
//         canvas.drawRRect(rr, paintBlue);
//       }
//     }
//   }
//
//   @override
//   bool shouldRepaint(covariant _RowDentureOverlayPainter old) =>
//       old.teeth != teeth || old.tile != tile || old.spacing != spacing || old.spans != spans;
// }
//
//
// class _ToothNumber extends StatelessWidget {
//   final int fdi;
//   final double size;
//   const _ToothNumber(this.fdi, this.size);
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: size * .6,
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
//   final void Function(int) onOpenGlobal;          // 그대로 사용
//   final void Function(int, String) onOpenSurface; // 그대로 사용
//
//   const _BigToothTile({
//     required this.fdi,
//     required this.size,
//     required this.onOpenGlobal,
//     required this.onOpenSurface,
//   });
//
//   bool get _mesialOnRight {
//     final q = fdi ~/ 10;
//     if (q == 1 || q == 4 || q == 5 || q == 8) return true;  // 우측군
//     if (q == 2 || q == 3 || q == 6 || q == 7) return false; // 좌측군
//     return true;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final p = context.watch<DentalDataProvider>();
//     final spec = p.getSpecRead(fdi);
//
//     // ── (기존) 표면 채우기 계산 ─────────────────────────
//     final Map<String, _SurfaceFill> fill = {
//       for (final s in kToothSurfaces) s: _SurfaceFill.none,
//     };
//     if (spec != null) {
//       for (final s in kToothSurfaces) {
//         final list = spec.surface[s]!['fillings']!;
//         final hasCaries = list.any(_isCariesThree);
//         if (hasCaries) {
//           fill[s] = _SurfaceFill.cariesRed;
//         } else if (list.isNotEmpty) {
//           fill[s] = _SurfaceFill.fillingBlue;
//         }
//       }
//     }
//
//     // ── ✅ 전역 코드에 따른 확대화면 마킹 ───────────────────
//
// // crown: 아무 코드라도 선택돼 있으면 파란 링
// //  - 기존 'crown' 키뿐 아니라 'Crowns' 카테고리도 허용
//     final bool markCrownRing =
//         (spec?.global['crown'] ?? const <String>[]).isNotEmpty;
//
// // status: missing 계열 전부 → 수평선 2개
//     final bool markStatusMissing =
//     (spec?.global['status'] ?? const <String>[])
//         .map((e) => e.toUpperCase())
//         .any((c) =>
//     c == 'MIS' || c.startsWith('MIS') || // missing tooth
//         c == 'MAM' ||                        // missing ante mortem
//         c == 'MPM' ||                        // missing post mortem
//         c == 'EXT' ||                        // extracted tooth
//         c == 'SOX' ||                        // socket (mam)
//         c == 'MJA');                         // missing jaw fragment
//
// // root: IPX 계열(= 'IPX' 또는 'IPX...' 로 시작) → 수직선 1개
//     final bool markRootImplant =
//     (spec?.global['root'] ?? const <String>[])
//         .map((e) => e.toUpperCase())
//         .any((c) => c == 'IPX' || c.startsWith('IPX'));
//
//     // ── ✅ 스팬(덴쳐/브릿지) 마킹 계산 ───────────────────
//     bool markDenture = false, markAbut = false, markPontic = false;
//     for (final sp in p.spans) {
//       if (!sp.teeth.contains(fdi)) continue;
//       if (sp.type == DentalSpanType.dentureOrtho) {
//         markDenture = true;
//       } else {
//         if (sp.abutments.contains(fdi)) markAbut = true;
//         if (sp.pontics.contains(fdi))   markPontic = true;
//       }
//     }
//
//     // --- ✅ 확대뷰 하이라이트 여부 결정 (축소뷰와 동일 규칙) ---
//     bool hasAnyDetail = false;
//     if (spec != null) {
//       // 표면: fillings/periodontium 중 하나라도 있으면 입력 존재
//       for (final surf in kToothSurfaces) {
//         final f = (spec.surface[surf]?['fillings'] ?? const <String>[]) as List<String>;
//         final pr = (spec.surface[surf]?['periodontium'] ?? const <String>[]) as List<String>;
//         if (f.isNotEmpty || pr.isNotEmpty) { hasAnyDetail = true; break; }
//       }
//       // 전역
//       if (!hasAnyDetail) {
//         for (final g in const ['bite','crown','root','status','position','crown pathology']) {
//           if ((spec.global[g] ?? const <String>[]).isNotEmpty) { hasAnyDetail = true; break; }
//         }
//       }
//       // 메모
//       if (!hasAnyDetail) {
//         if ((spec.toothNote ?? '').trim().isNotEmpty ||
//             spec.surfaceNote.values.any((v) => (v).toString().trim().isNotEmpty)) {
//           hasAnyDetail = true;
//         }
//       }
//     }
//
//     // 1) “입력 있음” 판정(코드/메모)
//     bool anyGlobalCode = false, anySurfaceCode = false, anyNote = false;
//     if (spec != null) {
//       anyGlobalCode = spec.global.values.any((lst) => lst.isNotEmpty);
//
//       anySurfaceCode = kToothSurfaces.any((s) {
//         final m = spec.surface[s];
//         if (m == null) return false;
//         final f = (m['fillings'] ?? const <String>[]);
//         final pds = (m['periodontium'] ?? const <String>[]);
//         return f.isNotEmpty || pds.isNotEmpty;
//       });
//
//       final hasToothNote = (spec.toothNote?.trim().isNotEmpty ?? false);
//       final hasSurfaceNote =
//       spec.surfaceNote.values.any((v) => v.trim().isNotEmpty);
//       anyNote = hasToothNote || hasSurfaceNote;
//     }
//     final bool hasAnyInput = anyGlobalCode || anySurfaceCode || anyNote;
//
//     // 2) “이미 자체 시각표시 있음” 판정
//     final bool hasSurfacePaint =
//     fill.values.any((f) => f != _SurfaceFill.none); // 빨강/파랑
//     final bool hasBlueRing   = markCrownRing || markAbut; // 링
//     final bool hasBlueLines  = markPontic || markStatusMissing || markRootImplant; // 선들
//     final bool hasOwnVisualMark =
//         hasSurfacePaint || hasBlueRing || hasBlueLines || markDenture;
//
//     // 3) 최종 보라색 표시 여부
//     final bool highlightUnmarked = hasAnyInput && !hasOwnVisualMark;
//
//     return GestureDetector(
//       behavior: HitTestBehavior.opaque,
//
//       // ✔ 탭 업에서만 실행 → 롱프레스가 발생하면 탭이 취소됨
//       onTapUp: (d) {
//         final surface = surfaceAtPoint(
//           d.localPosition,
//           Size.square(size),
//           mesialOnRight: _mesialOnRight,
//           hitSlop: 12,
//         );
//         if (surface != null) {
//           onOpenSurface(fdi, surface);
//         }
//       },
//
//       onLongPressStart: (details) async {
//         final key = _hitSurface(details.localPosition, Size.square(size), mesialOnRight: _mesialOnRight);
//
//         if (key == null) {
//           // 프레임(빈 공간) 길게 → 전역 시트
//           onOpenGlobal(fdi);
//         } else {
//           // 표면 길게 → 표면 시트 (이제 컨텍스트 메뉴 없음)
//           onOpenSurface(fdi, key);
//         }
//       },
//
//       child: CustomPaint(
//         size: Size.square(size),
//         painter: _FiveSurfacePainter(
//           mesialOnRight: _mesialOnRight,
//           abut: markAbut,
//           pontic: markPontic,
//           fill: fill,
//           ringCrown: markCrownRing,       // ← crown 전역코드 → 링
//           twoHorizontal: markStatusMissing, // ← status(MIS*) → 수평 2줄
//           oneVertical: markRootImplant,   // ← root(IPX*) → 수직 1줄
//           highlightAny: highlightUnmarked,
//         ),
//       ),
//     );
//   }
//
//   String? _hitSurface(Offset p, Size s, {required bool mesialOnRight}) {
//     final g = _Geom(s);
//
//     // ✅ ① 프레임(가장자리 띠)을 '빈공간'으로 간주 → 전역 시트 트리거
//     final frameBand = s.width * 0.08; // 가장자리 두께
//     final inner = g.outerRect.deflate(frameBand);
//     if (g.outerRect.contains(p) && !inner.contains(p)) {
//       // 프레임 영역이면 표면이 아님 => null 반환
//       return null;
//     }
//
//     // ② 기존 표면 판정
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
// enum _SurfaceFill { none, toggleAmber, fillingBlue, cariesRed }
//
// class _FiveSurfacePainter extends CustomPainter {
//   final bool mesialOnRight;
//   final Map<String, _SurfaceFill> fill;
//
//   final bool abut;     // 지대치 → 파란 링
//   final bool pontic;   // Pontic → 수평 2줄
//
//   final bool ringCrown;     // crown 선택 시 파란 링
//   final bool twoHorizontal; // status MIS* → 수평 2줄
//   final bool oneVertical;   // root IPX* → 수직 1줄
//
//   final bool highlightAny;
//
//   const _FiveSurfacePainter({
//     required this.mesialOnRight,
//     required this.fill,
//     this.abut = false,
//     this.pontic = false,
//     this.ringCrown = false,
//     this.twoHorizontal = false,
//     this.oneVertical = false,
//     this.highlightAny = false,
//   });
//
//   @override
//   void paint(Canvas canvas, Size s) {
//     final g = _Geom(s);
//
//     final outerStroke = Paint()
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = (s.width * .04).clamp(1.0, 2.0)
//       ..color = highlightAny ? Colors.deepPurple : Colors.black87;
//
//     final innerStroke = Paint()
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = (s.width * .032).clamp(0.8, 1.6)
//       ..color = Colors.black54;
//
//     Paint paintOf(_SurfaceFill f) {
//       switch (f) {
//         case _SurfaceFill.cariesRed:
//           return Paint()..style = PaintingStyle.fill..color = Colors.red.withOpacity(.35);
//         case _SurfaceFill.fillingBlue:
//           return Paint()..style = PaintingStyle.fill..color = Colors.blue.withOpacity(.28);
//         case _SurfaceFill.toggleAmber:
//           return Paint()..style = PaintingStyle.fill..color = Colors.amber.withOpacity(.35);
//         case _SurfaceFill.none:
//           return Paint()..style = PaintingStyle.stroke..color = Colors.transparent;
//       }
//     }
//
//     // 면 채우기
//     final l = fill['L'] ?? _SurfaceFill.none;
//     final b = fill['B'] ?? _SurfaceFill.none;
//     final o = fill['O'] ?? _SurfaceFill.none;
//     final m = fill['M'] ?? _SurfaceFill.none;
//     final d = fill['D'] ?? _SurfaceFill.none;
//
//     if (l != _SurfaceFill.none) canvas.drawPath(g.pathL, paintOf(l));
//     if (b != _SurfaceFill.none) canvas.drawPath(g.pathB, paintOf(b));
//     if (o != _SurfaceFill.none) canvas.drawRect(g.rectO, paintOf(o));
//
//     // M/D는 사분면에 따라 좌/우를 뒤집음
//     final leftFill  = mesialOnRight ? d : m;
//     final rightFill = mesialOnRight ? m : d;
//     if (leftFill  != _SurfaceFill.none) canvas.drawPath(g.pathLeft,  paintOf(leftFill));
//     if (rightFill != _SurfaceFill.none) canvas.drawPath(g.pathRight, paintOf(rightFill));
//
//     // 윤곽/내부선
//     canvas.drawRRect(g.outerRRect, outerStroke);
//     canvas.drawRect(g.rectO, innerStroke);
//
//     final oc = [g.outerRect.topLeft, g.outerRect.topRight, g.outerRect.bottomRight, g.outerRect.bottomLeft];
//     final ic = [g.rectO.topLeft, g.rectO.topRight, g.rectO.bottomRight, g.rectO.bottomLeft];
//     for (int i = 0; i < 4; i++) {
//       canvas.drawLine(ic[i], oc[i], innerStroke);
//     }
//
//     // ===== 파란 마킹 공통 페인트 =====
//     final blue = Paint()
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = (s.width * .06).clamp(1.2, 2.4)
//       ..color = Colors.blueAccent;
//
//     // ▼ crown 또는 지대치 중 하나라도 있으면 '한 번만' 링을 그림
//     if (ringCrown || abut) {
//       final ring = g.outerRect.deflate(s.width * .18);
//       canvas.drawRRect(
//         RRect.fromRectAndRadius(ring, Radius.circular(ring.width * .20)),
//         blue,
//       );
//     }
//
//     // ▼ Pontic(또는 status MIS*) → 수평 2줄
//     if (pontic || twoHorizontal) {
//       final y1 = s.height * .40, y2 = s.height * .60;
//       canvas.drawLine(Offset(s.width * .18, y1), Offset(s.width * .82, y1), blue);
//       canvas.drawLine(Offset(s.width * .18, y2), Offset(s.width * .82, y2), blue);
//     }
//
//     // ▼ root(IPX*) → 수직 1줄
//     if (oneVertical) {
//       final x = s.width * .50;
//       canvas.drawLine(Offset(x, s.height * .20), Offset(x, s.height * .80), blue);
//     }
//   }
//
//   @override
//   bool shouldRepaint(covariant _FiveSurfacePainter old) =>
//       old.mesialOnRight != mesialOnRight ||
//           !_mapEquals(old.fill, fill) ||
//           old.abut != abut ||
//           old.pontic != pontic ||
//           old.ringCrown != ringCrown ||
//           old.twoHorizontal != twoHorizontal ||
//           old.oneVertical != oneVertical ||
//           old.highlightAny != highlightAny;
//
//   bool _mapEquals(Map<String, _SurfaceFill> a, Map<String, _SurfaceFill> b) {
//     if (identical(a, b)) return true;
//     if (a.length != b.length) return false;
//     for (final k in kToothSurfaces) {
//       if ((a[k] ?? _SurfaceFill.none) != (b[k] ?? _SurfaceFill.none)) return false;
//     }
//     return true;
//   }
// }
//
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
//     final rectW = w * .54;  // 중앙 가로직사각 비율(방패연)
//     final rectH = h * .36;
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
//
// // /// =====================
// // /// 단일치아용 폼(전역 5그룹)
// // /// =====================
// // class _Global635Sheet extends StatelessWidget {
// //   final int fdi;
// //   const _Global635Sheet({required this.fdi});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     final media = MediaQuery.of(context);
// //     final kb = media.viewInsets.bottom;                  // ✅ 키보드 높이
// //     // 기본 65% 높이를 쓰되, 키보드가 올라오면 그만큼 줄여서 겹치지 않게
// //     final base = media.size.height * 0.65;
// //     final sheetHeight = (base > media.size.height - kb - 24)
// //         ? media.size.height - kb - 24
// //         : base;
// //
// //     final p = context.watch<DentalDataProvider>();
// //     final spec = p.getSpecRead(fdi);
// //     final noteCtrl = TextEditingController(text: spec?.toothNote ?? '');
// //
// //     return AnimatedPadding(                                  // ✅ 부드럽게 위로 올림
// //       duration: const Duration(milliseconds: 180),
// //       curve: Curves.easeOut,
// //       padding: EdgeInsets.only(bottom: kb),
// //       child: SafeArea(
// //         child: Padding(
// //           padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
// //           child: SizedBox(
// //             height: sheetHeight,                              // ✅ 동적 높이
// //             child: Column(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 Text('Tooth $fdi — Global codes',
// //                     style: Theme.of(context).textTheme.titleMedium),
// //                 const SizedBox(height: 8),
// //
// //                 // _Global635Sheet.build() 안, ListView 위쪽에 이 블럭을 끼워 넣기
// //                 Padding(
// //                   padding: const EdgeInsets.only(bottom: 12),
// //                   child: _InterpolPickerInline(
// //                     title: 'Interpol 코드 선택 (전역)',
// //                     categoryFilter: (cats) => cats.where((c) => c != 'Bridge' && c != 'Denture and Orthodontic Appl.').toList(),
// //                     onConfirm: (sel) {
// //                       // 선택 상태만 기억 (필요시 여기에서 635 글로벌 코드에 직접 매핑해 넣을 수 있음)
// //                       context.read<DentalDataProvider>().setSelectionFor(ViewMode.zoomIn, sel);
// //                       ScaffoldMessenger.of(context).showSnackBar(
// //                         SnackBar(content: Text('확정: ${sel.category}${sel.path.isEmpty ? "" : " · ${sel.path.join(" > ")}"}')),
// //                       );
// //                     },
// //                   ),
// //                 ),
// //
// //                 Expanded(
// //                   child: ListView(
// //                     keyboardDismissBehavior:
// //                     ScrollViewKeyboardDismissBehavior.onDrag,   // ✅ 스크롤로 키보드 내림
// //                     children: k635GlobalCodes.entries.map((e) {
// //                       final group = e.key;
// //                       final codes = e.value;
// //                       final picked = p.getSpecRead(fdi)?.global[group] ?? const <String>[];
// //                       return Padding(
// //                         padding: const EdgeInsets.only(bottom: 8),
// //                         child: Column(
// //                           crossAxisAlignment: CrossAxisAlignment.start,
// //                           children: [
// //                             Text(group.toUpperCase(),
// //                                 style: const TextStyle(fontWeight: FontWeight.w700)),
// //                             const SizedBox(height: 4),
// //                             Wrap(
// //                               spacing: 6, runSpacing: 6,
// //                               children: codes.map((c) {
// //                                 final sel = picked.contains(c);
// //                                 return FilterChip(
// //                                   label: Text(c),
// //                                   selected: sel,
// //                                   onSelected: (_) => p.toggleGlobalCode(fdi, group, c),
// //                                 );
// //                               }).toList(),
// //                             ),
// //                           ],
// //                         ),
// //                       );
// //                     }).toList(),
// //                   ),
// //                 ),
// //                 const Divider(),
// //                 const Text('자연어 메모 (코드는 위에 칩으로 즉시 반영, 메모는 저장 버튼을 눌러야 반영됩니다)'),
// //                 const SizedBox(height: 6),
// //                 TextField(
// //                   controller: noteCtrl,
// //                   maxLines: 3,
// //                   keyboardType: TextInputType.multiline,           // ✅ 멀티라인
// //                   textInputAction: TextInputAction.newline,
// //                   decoration: const InputDecoration(
// //                     hintText: '예: 교합 개방감 있음. 회전 양상 관찰...',
// //                     border: OutlineInputBorder(),
// //                   ),
// //                 ),
// //                 const SizedBox(height: 8),
// //                 Row(
// //                   mainAxisAlignment: MainAxisAlignment.end,
// //                   children: [
// //                     TextButton(onPressed: () => Navigator.pop(context), child: const Text('닫기')),
// //                     const SizedBox(width: 8),
// //                     FilledButton(
// //                       onPressed: () {
// //                         p.setToothNote635(fdi, noteCtrl.text.trim());
// //                         Navigator.pop(context);
// //                       },
// //                       child: const Text('저장'),
// //                     ),
// //                   ],
// //                 ),
// //               ],
// //             ),
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }
//
// /// =====================
// /// 단일치아용 폼(전역) — Interpol + 메모만, 저장/취소/삭제
// /// =====================
// class _Global635Sheet extends StatefulWidget {
//   final int fdi;
//   const _Global635Sheet({required this.fdi});
//   @override
//   State<_Global635Sheet> createState() => _Global635SheetState();
// }
//
// class _Global635SheetState extends State<_Global635Sheet> {
//   final _pickerKey = GlobalKey<_InterpolPickerInlineState>();
//   bool _canSaveCode = false; // ✅ 코드 선택 완료 여부
//   CodeSelection? _pendingSel; // 저장 버튼 누를 때만 확정
//   late final TextEditingController _noteCtrl;
//   late final String _initialNote; // ✅ 메모 변경 여부 체크용
//
//   @override
//   void initState() {
//     super.initState();
//     final p = context.read<DentalDataProvider>();
//     final spec = p.getSpecRead(widget.fdi);
//     _initialNote = spec?.toothNote ?? '';
//     _noteCtrl = TextEditingController(text: spec?.toothNote ?? '');
//     // 트리 1회 로딩
//     WidgetsBinding.instance.addPostFrameCallback((_) => p.loadCodeTreeOnce());
//   }
//
//   @override
//   void dispose() {
//     _noteCtrl.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final media = MediaQuery.of(context);
//     final kb = media.viewInsets.bottom;
//     final base = media.size.height * 0.45; // 낮춰서 오버플로우 방지
//     final sheetHeight = (base > media.size.height - kb - 24)
//         ? media.size.height - kb - 24
//         : base;
//
//     final bool noteChanged = _noteCtrl.text.trim() != _initialNote.trim();
//
//     final p = context.watch<DentalDataProvider>();
//
//     return AnimatedPadding(
//       duration: const Duration(milliseconds: 180),
//       curve: Curves.easeOut,
//       padding: EdgeInsets.only(bottom: kb),
//       child: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
//           child: SizedBox(
//             height: sheetHeight,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text('Tooth ${widget.fdi} — Global',
//                     style: Theme.of(context).textTheme.titleMedium),
//                 const SizedBox(height: 8),
//
//                 // ▼ Interpol 코드 선택(전역). 칩들은 제거.
//                 Expanded(
//                   child: SingleChildScrollView(
//                     child: _InterpolPickerInline(
//                       key: _pickerKey,
//                       title: 'Interpol 코드 선택 (전역)',
//                       categoryFilter: (cats) => cats.where((c) =>
//                       c != 'Fillings' &&
//                           c != 'Periodontium' &&
//                           c != 'Bridge' &&
//                           c != 'Denture and Orthodontic Appl.'
//                       ).toList(),
//                       onConfirm: (_) {}, // (확정 버튼 없으므로 사용 안 함)
//                       onHasCodeChanged: (ok) => setState(() => _canSaveCode = ok),
//                     ),
//                   ),
//                 ),
//
//                 if (kb > 0) ...[
//                   const SizedBox(height: 6),
//                   const Text('아래에 더 있어요 · 스크롤해서 확인하세요',
//                     style: TextStyle(fontSize: 12, color: Colors.black54),
//                   ),
//                 ],
//
//                 const SizedBox(height: 12),
//                 const Text('자연어 메모'),
//                 const SizedBox(height: 6),
//                 TextField(
//                   controller: _noteCtrl,
//                   // ✅ 입력 시 버튼 상태 갱신
//                   onChanged: (_) => setState(() {}),
//                   maxLines: 3,
//                   keyboardType: TextInputType.multiline,
//                   textInputAction: TextInputAction.newline,
//                   decoration: const InputDecoration(
//                     hintText: '예: 교합 개방감 있음. 회전 양상 관찰...',
//                     border: OutlineInputBorder(),
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//
//                 Row(
//                   children: [
//                     // 기록 삭제(전역) — 필요 시 provider에 clear 함수가 있어야 함
//                     TextButton.icon(
//                       onPressed: () {
//                         // 전역 데이터/메모 초기화
//                         context.read<DentalDataProvider>()
//                             .clearGlobalAll635(widget.fdi);
//                         Navigator.pop(context);
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           const SnackBar(content: Text('전역 기록을 삭제했습니다.')),
//                         );
//                       },
//                       icon: const Icon(Icons.delete_outline),
//                       label: const Text('기록 삭제'),
//                     ),
//                     const Spacer(),
//                     TextButton(
//                       onPressed: () => Navigator.pop(context),
//                       child: const Text('취소'),
//                     ),
//                     const SizedBox(width: 8),
//                     // FilledButton(
//                     //   onPressed: () {
//                     //     final sel = _pickerKey.currentState?.currentSelection;
//                     //     if (sel != null) {
//                     //       applyInterpolToGlobal635WithToggles(context, widget.fdi, sel);
//                     //     }
//                     //     context.read<DentalDataProvider>()
//                     //         .setToothNote635(widget.fdi, _noteCtrl.text.trim());
//                     //     Navigator.pop(context);
//                     //     ScaffoldMessenger.of(context).showSnackBar(
//                     //       const SnackBar(content: Text('전역 내용이 저장되었습니다.')),
//                     //     );
//                     //   },
//                     //   child: const Text('저장'),
//                     // ),
//                     FilledButton(
//                       // ✅ 코드도 안 골랐고, 메모도 안 바뀌었으면 비활성화
//                       onPressed: (!_canSaveCode && !noteChanged)
//                           ? null
//                           : () {
//                         bool savedCode = false;
//                         final sel = _pickerKey.currentState?.currentSelection; // 전역 선택(하위 코드 필수)
//
//                         if (_canSaveCode && sel != null) {
//                           // ⛳ 전역 저장: surface 사용 금지!
//                           applyInterpolToGlobal635WithToggles(
//                             context, widget.fdi, sel,
//                           );
//                           savedCode = true;
//                         }
//
//                         if (noteChanged) {
//                           context.read<DentalDataProvider>()
//                               .setToothNote635(widget.fdi, _noteCtrl.text.trim());
//                         }
//
//                         Navigator.pop(context);
//
//                         // ✅ 상황별 메시지
//                         final msg = savedCode && noteChanged
//                             ? '전역 코드와 메모가 저장되었습니다.'
//                             : savedCode
//                             ? '전역 코드가 저장되었습니다.'
//                             : '메모만 저장되었습니다.';
//                         ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
//                       },
//                       child: const Text('저장'),
//                     )
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// /// =====================
// /// 표면 폼 — Interpol + 메모만, 저장/취소/삭제
// /// =====================
// class _Surface635Sheet extends StatefulWidget {
//   final int fdi;
//   final String surface; // 'O','M','D','L','B'
//   const _Surface635Sheet({required this.fdi, required this.surface});
//   @override
//   State<_Surface635Sheet> createState() => _Surface635SheetState();
// }
//
// class _Surface635SheetState extends State<_Surface635Sheet> {
//   final _pickerKey = GlobalKey<_InterpolPickerInlineState>();
//   CodeSelection? _pendingSel;
//   bool _canSaveCode = false;
//   late final TextEditingController _noteCtrl;
//   late final String _initialNote;
//
//   @override
//   void initState() {
//     super.initState();
//     final p = context.read<DentalDataProvider>();
//     final spec = p.getSpecRead(widget.fdi);
//     _initialNote = spec?.surfaceNote[widget.surface] ?? '';
//     _noteCtrl = TextEditingController(text: _initialNote);
//     WidgetsBinding.instance.addPostFrameCallback((_) => p.loadCodeTreeOnce());
//   }
//
//   @override
//   void dispose() {
//     _noteCtrl.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final media = MediaQuery.of(context);
//     final kb = media.viewInsets.bottom;
//     final base = media.size.height * 0.45;
//     final sheetHeight = (base > media.size.height - kb - 24)
//         ? media.size.height - kb - 24
//         : base;
//
//     final bool noteChanged = _noteCtrl.text.trim() != _initialNote.trim();
//     final p = context.watch<DentalDataProvider>();
//
//     return AnimatedPadding(
//       duration: const Duration(milliseconds: 180),
//       curve: Curves.easeOut,
//       padding: EdgeInsets.only(bottom: kb),
//       child: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
//           child: SizedBox(
//             height: sheetHeight,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text('Tooth ${widget.fdi} — Surface ${widget.surface}',
//                     style: Theme.of(context).textTheme.titleMedium),
//                 const SizedBox(height: 8),
//
//                 Expanded(
//                   child: SingleChildScrollView(
//                     child: _InterpolPickerInline(
//                       key: _pickerKey,
//                       title: 'Interpol 코드 선택 (표면)',
//                       categoryFilter: (cats) => cats.where((c) =>
//                       c == 'Fillings' || c == 'Periodontium'
//                       ).toList(),
//                       onConfirm: (_) {}, // 사용 안 함
//                       onHasCodeChanged: (ok) => setState(() => _canSaveCode = ok),
//                     ),
//                   ),
//                 ),
//
//                 if (kb > 0) ...[
//                   const SizedBox(height: 6),
//                   const Text('아래에 더 있어요 · 스크롤해서 확인하세요',
//                     style: TextStyle(fontSize: 12, color: Colors.black54),
//                   ),
//                 ],
//
//                 const SizedBox(height: 12),
//                 const Text('자연어 메모'),
//                 const SizedBox(height: 6),
//                 TextField(
//                   controller: _noteCtrl,
//                   onChanged: (_) => setState(() {}),
//                   maxLines: 3,
//                   keyboardType: TextInputType.multiline,
//                   textInputAction: TextInputAction.newline,
//                   scrollPadding: const EdgeInsets.only(bottom: 80),
//                   decoration: const InputDecoration(
//                     hintText: '예: 교합면 소와열 우식 의심...',
//                     border: OutlineInputBorder(),
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//
//                 Row(
//                   children: [
//                     // 표면 기록 삭제(코드/메모)
//                     TextButton.icon(
//                       onPressed: () {
//                         context
//                             .read<DentalDataProvider>()
//                             .clearSurface635(widget.fdi, widget.surface);
//                         Navigator.pop(context);
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           const SnackBar(content: Text('표면 기록을 삭제했습니다.')),
//                         );
//                       },
//                       icon: const Icon(Icons.delete_outline),
//                       label: const Text('기록 삭제'),
//                     ),
//                     const Spacer(),
//                     TextButton(
//                       onPressed: () => Navigator.pop(context),
//                       child: const Text('취소'),
//                     ),
//                     const SizedBox(width: 8),
//                     FilledButton(
//                       // ⛳ 규칙: (코드 유효 선택 없음 && 메모도 변화 없음) → 비활성
//                       onPressed: (!_canSaveCode && !noteChanged)
//                           ? null
//                           : () {
//                         bool savedCode = false;
//                         final sel = _pickerKey.currentState?.currentSelection; // 하위 코드까지 선택된 경우만 null 아님
//
//                         if (_canSaveCode && sel != null) {
//                           applyInterpolToSurface635WithToggles(
//                             context, widget.fdi, widget.surface, sel,
//                           );
//                           savedCode = true;
//                         }
//
//                         if (noteChanged) {
//                           context.read<DentalDataProvider>()
//                               .setSurfaceNote635(widget.fdi, widget.surface, _noteCtrl.text.trim());
//                         }
//
//                         Navigator.pop(context);
//
//                         final msg = savedCode && noteChanged
//                             ? '표면 코드와 메모가 저장되었습니다.'
//                             : savedCode
//                             ? '표면 코드가 저장되었습니다.'
//                             : '메모만 저장되었습니다.';
//                         ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
//                       },
//                       child: const Text('저장'),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class _InterpolPickerInline extends StatefulWidget {
//   final String title;
//   final List<String> Function(List<String> all)? categoryFilter;
//   final void Function(CodeSelection sel) onConfirm;
//
//   final void Function(bool hasCodeSelected)? onHasCodeChanged;
//
//   const _InterpolPickerInline({
//     Key? key,
//     required this.title,
//     this.categoryFilter,
//     required this.onConfirm,
//     this.onHasCodeChanged,
//   }) : super(key: key);
//
//   @override
//   State<_InterpolPickerInline> createState() => _InterpolPickerInlineState();
// }
//
// class _InterpolPickerInlineState extends State<_InterpolPickerInline> {
//   String? cat;
//   final List<String> path = [];
//
//   CodeSelection? get currentSelection {
//     if (cat == null) return null;
//     final p = context.read<DentalDataProvider>();
//     final sel = CodeSelection(category: cat!, path: List<String>.from(path));
//     // ✅ “하위 코드”가 최소 1개 있어야만 유효로 간주
//     final valid = path.isNotEmpty && p.isValidSelection(sel.category, sel.path);
//     return valid ? sel : null;
//   }
//
//   void _notifyHasCode() {
//     // ✅ 현재 상태를 부모에 통지
//     widget.onHasCodeChanged?.call(currentSelection != null);
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     // 최초 1회 로딩 시도 (실패해도 UI는 열린다)
//     WidgetsBinding.instance.addPostFrameCallback((_) async {
//       try {
//         await context.read<DentalDataProvider>().loadCodeTreeOnce();
//         setState(() {}); // 로드 후 새로고침
//         _notifyHasCode();
//       } catch (e) {
//         _notifyHasCode();
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('코드 트리 로딩 실패: $e')),
//         );
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final p = context.watch<DentalDataProvider>();
//     var cats = p.availableCategories(ViewMode.zoomIn);
//     if (widget.categoryFilter != null) cats = widget.categoryFilter!(cats);
//
//     List<CodeNode> childrenOf(List<String> prefix) {
//       if (cat == null) return const <CodeNode>[];
//       return p.listChildren(cat!, prefix);
//     }
//
//     final level0 = cat == null ? const <CodeNode>[] : childrenOf(const []);
//     final level1 = (cat == null || path.isEmpty) ? const <CodeNode>[] : childrenOf(path.take(1).toList());
//     final level2 = (cat == null || path.length < 2) ? const <CodeNode>[] : childrenOf(path.take(2).toList());
//     final level3 = (cat == null || path.length < 3) ? const <CodeNode>[] : childrenOf(path.take(3).toList());
//
//     DropdownButtonFormField<String> dd(List<CodeNode> items, int level, String label) {
//       final cur = path.length > level ? path[level] : null;
//       return DropdownButtonFormField<String>(
//         isExpanded: true,
//         value: cur,
//         decoration: InputDecoration(labelText: label),
//         items: items.map((n) => DropdownMenuItem(value: n.code, child: Text('${n.code} — ${n.label}'))).toList(),
//         onChanged: (v) {
//           if (v == null) return;
//           setState(() {
//             if (path.length > level) path.removeRange(level, path.length);
//             if (path.length == level) { path.add(v); } else { path[level] = v; }
//             _notifyHasCode();
//           });
//         },
//       );
//     }
//
//     return ExpansionTile(
//       title: Text(widget.title),
//       initiallyExpanded: false,
//       childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
//       children: [
//         DropdownButtonFormField<String>(
//           isExpanded: true,
//           value: (cats.contains(cat)) ? cat : null, // ← 기본 선택 해제
//           decoration: const InputDecoration(labelText: 'Category'),
//           hint: const Text('(System code/text를 선택하세요.)'), // ← 디폴트 라벨
//           items: cats.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
//           onChanged: (v) => setState(() { cat = v; path.clear(); _notifyHasCode();}),
//         ),
//         const SizedBox(height: 8),
//         if (cat != null) ...[
//           dd(level0, 0, 'Level 1'),
//           if (level1.isNotEmpty) ...[const SizedBox(height: 8), dd(level1, 1, 'Level 2')],
//           if (level2.isNotEmpty) ...[const SizedBox(height: 8), dd(level2, 2, 'Level 3')],
//           if (level3.isNotEmpty) ...[const SizedBox(height: 8), dd(level3, 3, 'Level 4')],
//           const SizedBox(height: 12),
//           if (path.isEmpty)
//             const Text(
//               '카테고리만 선택한 상태입니다. 아래 단계에서 시스템 코드/텍스트를 선택하세요.',
//               style: TextStyle(color: Colors.redAccent, fontSize: 12),
//             ),
//
//           const SizedBox(height: 8),
//           Row(
//             children: [
//               Expanded(
//                 child: Text(
//                   '현재 선택: ${cat ?? "-"}${path.isEmpty ? "" : " · ${path.join(" > ")}"}',
//                   overflow: TextOverflow.ellipsis,
//                   style: const TextStyle(color: Colors.black54),
//                 ),
//               ),
//               TextButton.icon(
//                 onPressed: () => setState(() => path.clear()),
//                 icon: const Icon(Icons.clear),
//                 label: const Text('경로 초기화'),
//               ),
//             ],
//           ),
//           const SizedBox(height: 8),
//         ],
//         const SizedBox(height: 4),
//       ],
//     );
//   }
// }
//
// /// Interpol 선택을 전역 6그룹(bite/position/status/root/crown/crown pathology)에 "덮어쓰기"로 반영
// void applyInterpolToGlobal635WithToggles(
//     BuildContext context,
//     int fdi,
//     CodeSelection sel,
//     ) {
//   final p = context.read<DentalDataProvider>();
//
//   // 카테고리 → 전역 그룹 키 매핑 (현재 JSON 카테고리 명 기준)
//   const cat2group = <String, String>{
//     'Bite and occlusion': 'bite',
//     'Tooth position'    : 'position',
//     'Status'            : 'status',
//     'Root'              : 'root',
//     'Crowns'            : 'crown',
//     'Crown pathology'   : 'crown pathology'
//   };
//
//   final code = (sel.path.isNotEmpty) ? sel.path.last : null;
//   final group = cat2group[sel.category];
//   if (code == null || group == null) return;
//
//   // 기존 선택 전부 해제 후, 최종 code만 남기기 (toggle API만 사용)
//   final prev = p.getSpecRead(fdi)?.global[group] ?? const <String>[];
//   for (final c in prev) {
//     if (c != code) {
//       p.toggleGlobalCode(fdi, group, c); // 선택돼 있던 것들 해제
//     }
//   }
//   final cur = p.getSpecRead(fdi)?.global[group] ?? const <String>[];
//   if (!cur.contains(code)) {
//     p.toggleGlobalCode(fdi, group, code); // 최종 코드만 선택 상태로
//   }
// }
//
// /// Interpol 선택을 표면 2그룹(fillings/periodontium)에 "덮어쓰기"로 반영
// void applyInterpolToSurface635WithToggles(
//     BuildContext context,
//     int fdi,
//     String surface,
//     CodeSelection sel,
//     ) {
//   final p = context.read<DentalDataProvider>();
//
//   // 카테고리 → 표면 그룹 키 매핑
//   String? group;
//   if (sel.category == 'Fillings') {
//     group = 'fillings';
//   } else if (sel.category == 'Periodontium') {
//     group = 'periodontium';
//   } else {
//     return; // 표면 시트에선 다른 카테고리는 무시
//   }
//
//   final code = (sel.path.isNotEmpty) ? sel.path.last : null;
//   if (code == null) return;
//
//   final prev = p.getSpecRead(fdi)?.surface[surface]?[group] ?? const <String>[];
//   for (final c in prev) {
//     if (c != code) {
//       p.toggleSurfaceCode(fdi, surface, group, c); // 기존 것들 해제
//     }
//   }
//   final cur = p.getSpecRead(fdi)?.surface[surface]?[group] ?? const <String>[];
//   if (!cur.contains(code)) {
//     p.toggleSurfaceCode(fdi, surface, group, code); // 최종 코드만 선택
//   }
// }
//
//
// class _SurfaceGroupChips extends StatelessWidget {
//   final int fdi;
//   final String surface; // O/M/D/L/B
//   final String group;   // fillings / periodontium
//   final List<String> codes;
//
//   const _SurfaceGroupChips({
//     required this.fdi,
//     required this.surface,
//     required this.group,
//     required this.codes,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     final p = context.watch<DentalDataProvider>();
//     final picked = p.getSpecRead(fdi)?.surface[surface]?[group] ?? const <String>[];
//
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(group.toUpperCase(), style: const TextStyle(fontWeight: FontWeight.w700)),
//         const SizedBox(height: 4),
//         Wrap(
//           spacing: 6,
//           runSpacing: 6,
//           children: codes.map((c) {
//             final sel = picked.contains(c);
//             final isCar = (group == 'fillings') && _isCariesThree(c);
//             return FilterChip(
//               selected: sel,
//               label: Text(c),
//               selectedColor: isCar ? Colors.red.withOpacity(.18) : Colors.blue.withOpacity(.14),
//               onSelected: (_) => p.toggleSurfaceCode(fdi, surface, group, c),
//             );
//           }).toList(),
//         ),
//       ],
//     );
//   }
// }
//
// /// 공통: “코드 칩은 잠금, 자연어에서 삭제 불가” 안내줄
// class _LockedCodeHintRow extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: const [
//         Icon(Icons.lock, size: 16),
//         SizedBox(width: 6),
//         Expanded(child: Text('선택한 코드들은 위에 칩으로 고정 표시되고, 자연어 입력창에서 삭제할 수 없습니다.')),
//       ],
//     );
//   }
// }
//
// /// 공통: 코드 칩 섹션 (현재 사용 안 함; 필요시 재활용)
// class _CodeSection extends StatelessWidget {
//   final String title;
//   final List<String> codes;
//   final bool Function(String code) isSelected;
//   final void Function(String code) onToggle;
//
//   const _CodeSection({
//     required this.title,
//     required this.codes,
//     required this.isSelected,
//     required this.onToggle,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: const EdgeInsets.symmetric(vertical: 8),
//       child: Padding(
//         padding: const EdgeInsets.all(10),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(title, style: Theme.of(context).textTheme.titleSmall),
//             const SizedBox(height: 8),
//             Wrap(
//               spacing: 8,
//               runSpacing: 8,
//               children: [
//                 for (final c in codes)
//                   FilterChip(
//                     label: Text(c),
//                     selected: isSelected(c),
//                     onSelected: (_) => onToggle(c),
//                   ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// /// 표면 판정: O/L/B 우선 → 그 다음 M/D hitSlop 밴드 → 마지막에 좌/우 폴리곤
// String? surfaceAtPoint(
//     Offset local,
//     Size size, {
//       required bool mesialOnRight,
//       double? hitSlop, // null이면 타일 크기 비례
//     }) {
//   final g = _Geom(size);
//
//   // 1) 정확 판정 (O/L/B)
//   if (g.rectO.contains(local)) return 'O';
//   if (g.pathL.contains(local)) return 'L';
//   if (g.pathB.contains(local)) return 'B';
//
//   // 2) 관대한 M/D: 중앙 사각형 좌/우 가장자리 부근 + 수직 게이트 안에서만
//   final double base = (size.width * 0.08).clamp(6.0, 12.0);
//   final double slop = (hitSlop ?? base).toDouble();
//
//   // 수직 게이트: 중앙 사각형 높이에 약간 여유를 준 범위에서만 M/D 슬롭 인정
//   final gateTop = g.rectO.top - slop * 0.8;
//   final gateBottom = g.rectO.bottom + slop * 0.8;
//   final inGateY = (local.dy >= gateTop && local.dy <= gateBottom);
//
//   if (inGateY) {
//     // 왼쪽 슬롭
//     if (local.dx <= g.rectO.left + slop && local.dx >= g.outerRect.left) {
//       return mesialOnRight ? 'D' : 'M';
//     }
//     // 오른쪽 슬롭
//     if (local.dx >= g.rectO.right - slop && local.dx <= g.outerRect.right) {
//       return mesialOnRight ? 'M' : 'D';
//     }
//   }
//
//   // 3) 폴리곤 최종 판정(정밀)
//   if (g.pathLeft.contains(local))  return mesialOnRight ? 'D' : 'M';
//   if (g.pathRight.contains(local)) return mesialOnRight ? 'M' : 'D';
//
//   return null;
// }
// /// getSpecRead(fdi) 가 null 이어도 안전하게 읽도록 하는 뷰
// class _SpecView {
//   final int fdi;
//   final dynamic _raw;
//   _SpecView(this.fdi, this._raw);
//
//   // 전역 코드 맵 (필요한 키를 프로젝트에 맞게 추가/수정 가능)
//   Map<String, List<String>> get global {
//     if (_raw?.global != null) return _raw!.global;
//     return <String, List<String>>{
//       'bite': <String>[],
//       'position': <String>[],
//       'status': <String>[],
//       'root': <String>[],
//       'crown': <String>[],
//       'crown pathology': <String>[],
//     };
//   }
//
//   // 표면 코드 맵: 각 표면에 fillings/periodontium 2그룹이 있다고 가정
//   Map<String, Map<String, List<String>>> get surface {
//     if (_raw?.surface != null) return _raw!.surface;
//     return {
//       for (final s in kToothSurfaces)
//         s: <String, List<String>>{
//           'fillings': <String>[],
//           'periodontium': <String>[],
//         }
//     };
//   }
//
//   // 전역 메모
//   String get toothNote => (_raw?.toothNote ?? '').trim();
//
//   // 표면 메모
//   Map<String, String> get surfaceNote {
//     if (_raw?.surfaceNote != null) return _raw!.surfaceNote;
//     return { for (final s in kToothSurfaces) s: '' };
//   }
// }

// import 'dart:math' show min, max;
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// import '../providers/dental_data_provider.dart';
// import '../data/codes_635.dart';
// import '../data/surface_fill.dart';
// import 'tree_selector_screen.dart';
//
// /// ─────────────────────────────────────────────────────────────────
// /// 공통: 충치 3종 판단
// bool _isCariesThree(String c) {
//   final u = c.toUpperCase();
//   return u == 'CAR' || u == 'ACA' || u == 'CCA';
// }
//
// /// ─────────────────────────────────────────────────────────────────
// /// 즐겨찾기(스프레드시트 재분류 반영)
// Map<String, List<String>> kFavSurfaceGroups() => {
//   'Fillings': ['CAR','UIF','CAV','AMF','TCF','COF','FIS','GOI','POI'],
//   // Periodontium 자주 쓰는 항목이 있으면 여기에 추가
// };
//
// Map<String, List<String>> kFavGlobalGroups() => {
//   // CAR는 Fillings로, ROV는 Status로, IPX는 Root로 분류
//   'Status': ['INT','MAM','MPM','CFR','IMX','IMV','ERU','ROV'],
//   'Root'  : ['RFX','IPX'],
//   'Crowns': ['UIC','MTC','GOC','MEC','TCC','MCC','POC','TEC'],
// };
//
// Set<String> favCodesUpperForMode(_EditMode mode) {
//   final m = (mode == _EditMode.surface) ? kFavSurfaceGroups() : kFavGlobalGroups();
//   return m.values.expand((e) => e).map((c) => c.toUpperCase()).toSet();
// }
//
// /// ─────────────────────────────────────────────────────────────────
// /// 사분면(축소) 화면: 핀치 줌 제거, 치아 탭 시 단일치아 에디터로 이동
// class QuadrantZoomScreen extends StatelessWidget {
//   final String title;
//   final bool isUpper;        // 상악 true
//   final bool isPermanent;    // 라벨/표시용
//   final List<int> teeth;     // 예: [18..11], [21..28] 등
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
//   Widget build(BuildContext context) {
//     final numbersOnTop = isUpper;
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(title),
//         actions: [
//           IconButton(
//             tooltip: '도움말',
//             icon: const Icon(Icons.help_outline),
//             onPressed: () => _showHelp(context),
//           ),
//         ],
//       ),
//       body: LayoutBuilder(
//         builder: (context, c) {
//           const spacing = 12.0;
//           final n = teeth.length; // 8 or 5
//           final tile = ((c.maxWidth - spacing * (n - 1)) / n).clamp(28.0, 90.0);
//           final rowWidth = n * tile + (n - 1) * spacing;
//
//           return Stack(
//             children: [
//               // 치아 행
//               Center(
//                 child: SizedBox(
//                   width: rowWidth,
//                   child: Stack(
//                     children: [
//                       Positioned.fill(
//                         child: _RowDentureOverlayPainterWidget(
//                           teeth: teeth, tile: tile, spacing: spacing,
//                         ),
//                       ),
//                       Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           for (final fdi in teeth) ...[
//                             SizedBox(
//                               width: tile,
//                               child: Column(
//                                 mainAxisSize: MainAxisSize.min,
//                                 children: [
//                                   if (numbersOnTop)
//                                     GestureDetector(
//                                       behavior: HitTestBehavior.opaque,
//                                       onLongPress: () => _openOneToothEditor(context, fdi),
//                                       child: _ToothNumber(fdi, tile),
//                                     ),
//                                   _BigToothTileSimple(
//                                     fdi: fdi,
//                                     size: tile,
//                                     onOpenEditor: _openOneToothEditor,
//                                   ),
//                                   if (!numbersOnTop)
//                                     GestureDetector(
//                                       behavior: HitTestBehavior.opaque,
//                                       onLongPress: () => _openOneToothEditor(context, fdi),
//                                       child: _ToothNumber(fdi, tile),
//                                     ),
//                                 ],
//                               ),
//                             ),
//                             if (fdi != teeth.last) const SizedBox(width: spacing),
//                           ],
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//
//               // 우상단 요약 패널(기록 있으면 표시)
//               Positioned(
//                 top: 4,
//                 right: 4,
//                 child: ConstrainedBox(
//                   constraints: const BoxConstraints(maxWidth: 280),
//                   child: _QuadrantInfoOverlay(teeth: teeth),
//                 ),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }
//
//   void _showHelp(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       showDragHandle: true,
//       builder: (_) => const Padding(
//         padding: EdgeInsets.fromLTRB(16, 12, 16, 16),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('화면 사용법', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
//             SizedBox(height: 8),
//             Text("• 치아 한 번 탭: 단일치아 편집 화면으로 이동합니다."),
//             Text("• 숫자(치아 번호) 길게 누르기: 동일하게 단일치아 편집 화면으로 이동합니다."),
//             SizedBox(height: 12),
//             Align(
//               alignment: Alignment.centerRight,
//               child: Text('닫으려면 바깥을 탭하세요', style: TextStyle(color: Colors.black54)),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Future<void> _openOneToothEditor(BuildContext context, int fdi) async {
//     // await Navigator.of(context).push(
//     //   MaterialPageRoute(builder: (_) => SingleToothEditorScreen(fdi: fdi)),
//     // );
//     await Navigator.of(context).push(
//       MaterialPageRoute(builder: (_) => TreeSelectorScreen(fdi: fdi)),
//     );
//   }
// }
//
// /// ─────────────────────────────────────────────────────────────────
// /// 우상단 요약 패널: 입력 있는 치아/스팬만 요약
// class _QuadrantInfoOverlay extends StatelessWidget {
//   final List<int> teeth;
//   const _QuadrantInfoOverlay({required this.teeth});
//
//   @override
//   Widget build(BuildContext context) {
//     final p = context.watch<DentalDataProvider>();
//     final specs = <int, _SpecView>{
//       for (final t in teeth) t: _SpecView(t, p.getSpecRead(t))
//     };
//
//     final items = specs.entries.where((e) {
//       final s = e.value;
//       final anyGlobal = s.global.values.any((lst) => lst.isNotEmpty);
//       final anySurf = kToothSurfaces.any((x) {
//         final m = s.surface[x];
//         if (m == null) return false;
//         return (m['fillings'] ?? const <String>[]).isNotEmpty ||
//             (m['periodontium'] ?? const <String>[]).isNotEmpty;
//       });
//       final anyNote = s.toothNote.isNotEmpty ||
//           s.surfaceNote.values.any((v) => v.trim().isNotEmpty);
//       return anyGlobal || anySurf || anyNote;
//     }).toList()
//       ..sort((a,b) => a.key.compareTo(b.key));
//
//     final spans = p.spans.where((sp) => sp.teeth.any(teeth.contains)).toList();
//
//     if (items.isEmpty && spans.isEmpty) return const SizedBox.shrink();
//
//     return Card(
//       elevation: 2,
//       margin: const EdgeInsets.only(top: 4, right: 4),
//       child: Padding(
//         padding: const EdgeInsets.fromLTRB(12, 8, 12, 10),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text('요약', style: TextStyle(fontWeight: FontWeight.w700)),
//             const SizedBox(height: 6),
//
//             if (spans.isNotEmpty) ...[
//               Row(
//                 children: [
//                   const Icon(Icons.linear_scale, size: 16),
//                   const SizedBox(width: 6),
//                   Text('스팬 ${spans.length}개',
//                       style: const TextStyle(fontWeight: FontWeight.w600)),
//                 ],
//               ),
//               const SizedBox(height: 4),
//               ...spans.map((sp) => Padding(
//                 padding: const EdgeInsets.only(bottom: 2),
//                 child: Text(_spanLine(sp, teeth), style: const TextStyle(fontSize: 12)),
//               )),
//               const Divider(),
//             ],
//
//             ...items.map((e) {
//               final fdi = e.key;
//               final s = e.value;
//               final globals = _pickGlobalsOneLine(s.global);
//               final surfaces = _pickSurfacesOneLine(s.surface);
//               final note = s.toothNote;
//
//               return Padding(
//                 padding: const EdgeInsets.only(bottom: 8),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text('[$fdi]', style: const TextStyle(fontWeight: FontWeight.w700)),
//                     if (globals.isNotEmpty)
//                       Text('전역: $globals', style: const TextStyle(fontSize: 12)),
//                     if (surfaces.isNotEmpty)
//                       Text('표면: $surfaces', style: const TextStyle(fontSize: 12)),
//                     if (note.isNotEmpty)
//                       Text('메모: ${_ellipsis(note, 60)}',
//                           style: const TextStyle(fontSize: 12, color: Colors.black87)),
//                   ],
//                 ),
//               );
//             }),
//           ],
//         ),
//       ),
//     );
//   }
//
//   String _spanLine(DentalSpan sp, List<int> visible) {
//     final typ = sp.type == DentalSpanType.dentureOrtho ? 'Denture/Ortho' : 'Bridge';
//     final range = _fmtSpanTeeth(sp.teeth.where(visible.contains));
//     String ap = '';
//     if (sp.type != DentalSpanType.dentureOrtho) {
//       ap = ' · Abut:${_fmtSpanTeeth(sp.abutments)} · Pontic:${_fmtSpanTeeth(sp.pontics)}';
//     }
//     return '$typ  $range$ap';
//   }
//
//   String _fmtSpanTeeth(Iterable<int> it) {
//     final ts = it.toList()..sort();
//     if (ts.isEmpty) return '-';
//     final buf = <String>[];
//     int start = ts.first, prev = ts.first;
//     for (int i = 1; i < ts.length; i++) {
//       if (ts[i] == prev + 1) {
//         prev = ts[i];
//       } else {
//         buf.add(start == prev ? '$start' : '$start–$prev');
//         start = prev = ts[i];
//       }
//     }
//     buf.add(start == prev ? '$start' : '$start–$prev');
//     return buf.join(', ');
//   }
//
//   String _pickGlobalsOneLine(Map<String, List<String>> g) {
//     const keys = ['bite','position','status','root','crown','crown pathology'];
//     final parts = <String>[];
//     for (final k in keys) {
//       final v = g[k] ?? const <String>[];
//       if (v.isNotEmpty) parts.add('$k:${v.join("/")}');
//     }
//     return parts.join(' · ');
//   }
//
//   String _pickSurfacesOneLine(Map<String, Map<String, List<String>>> m) {
//     final parts = <String>[];
//     for (final s in kToothSurfaces) {
//       final f = (m[s]?['fillings'] ?? const <String>[]) as List<String>;
//       final p = (m[s]?['periodontium'] ?? const <String>[]) as List<String>;
//       if (f.isEmpty && p.isEmpty) continue;
//       final join = [
//         if (f.isNotEmpty) 'F:${f.join("/")}',
//         if (p.isNotEmpty) 'P:${p.join("/")}',
//       ].join(',');
//       parts.add('$s($join)');
//     }
//     return parts.join(' · ');
//   }
//
//   String _ellipsis(String s, int n) => s.length <= n ? s : '${s.substring(0, n)}…';
// }
//
// /// ─────────────────────────────────────────────────────────────────
// /// 덴쳐 스팬 오버레이(축소 행 전체에 파란 캡슐)
// class _RowDentureOverlayPainterWidget extends StatelessWidget {
//   final List<int> teeth;
//   final double tile;
//   final double spacing;
//   const _RowDentureOverlayPainterWidget({
//     required this.teeth,
//     required this.tile,
//     required this.spacing,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     final p = context.watch<DentalDataProvider>();
//     final spans = p.spans.where((sp) => sp.type == DentalSpanType.dentureOrtho).toList();
//     return CustomPaint(
//       painter: _RowDentureOverlayPainter(
//         teeth: teeth,
//         tile: tile,
//         spacing: spacing,
//         spans: spans,
//       ),
//     );
//   }
// }
//
// class _RowDentureOverlayPainter extends CustomPainter {
//   final List<int> teeth;
//   final double tile;
//   final double spacing;
//   final List<DentalSpan> spans;
//   _RowDentureOverlayPainter({
//     required this.teeth,
//     required this.tile,
//     required this.spacing,
//     required this.spans,
//   });
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     if (teeth.isEmpty) return;
//
//     final rects = <int, Rect>{};
//     for (int i = 0; i < teeth.length; i++) {
//       final x = i * (tile + spacing);
//       rects[teeth[i]] = Rect.fromLTWH(x, 0, tile, tile);
//     }
//
//     final paintBlue = Paint()
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = (tile * .12).clamp(1.6, 3.2)
//       ..color = Colors.blueAccent;
//
//     for (final sp in spans) {
//       final inside = teeth.where(sp.teeth.contains).toList();
//       if (inside.isEmpty) continue;
//
//       // 연속 클러스터
//       final clusters = <List<int>>[];
//       List<int> cur = [];
//       for (int i = 0; i < inside.length; i++) {
//         if (cur.isEmpty) {
//           cur = [inside[i]];
//         } else {
//           final prevIdx = teeth.indexOf(cur.last);
//           final thisIdx = teeth.indexOf(inside[i]);
//           if (thisIdx == prevIdx + 1) {
//             cur.add(inside[i]);
//           } else {
//             clusters.add(cur);
//             cur = [inside[i]];
//           }
//         }
//       }
//       if (cur.isNotEmpty) clusters.add(cur);
//
//       for (final cluster in clusters) {
//         final left = rects[cluster.first]!;
//         final right = rects[cluster.last]!;
//         Rect union = Rect.fromLTRB(left.left, left.top, right.right, right.bottom);
//
//         final marginX = tile * .18, marginY = tile * .12;
//         final rr = RRect.fromRectAndRadius(
//           union.inflate(marginX).deflate(0).inflate(0).deflate(-marginY),
//           Radius.circular(union.height),
//         );
//         canvas.drawRRect(rr, paintBlue);
//       }
//     }
//   }
//
//   @override
//   bool shouldRepaint(covariant _RowDentureOverlayPainter old) =>
//       old.teeth != teeth || old.tile != tile || old.spacing != spacing || old.spans != spans;
// }
//
// /// ─────────────────────────────────────────────────────────────────
// /// 번호/그리기(축소)
// class _ToothNumber extends StatelessWidget {
//   final int fdi;
//   final double size;
//   const _ToothNumber(this.fdi, this.size);
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: size * .6,
//       child: Center(
//         child: Text('$fdi', style: const TextStyle(fontWeight: FontWeight.w700)),
//       ),
//     );
//   }
// }
//
// /// 축소 그리기 + 탭 시 단일치아 에디터로 이동
// class _BigToothTileSimple extends StatelessWidget {
//   final int fdi;
//   final double size;
//   final void Function(BuildContext, int) onOpenEditor;
//
//   const _BigToothTileSimple({
//     required this.fdi,
//     required this.size,
//     required this.onOpenEditor,
//   });
//
//   bool get _mesialOnRight {
//     final q = fdi ~/ 10;
//     if (q == 1 || q == 4 || q == 5 || q == 8) return true;  // 우측군
//     if (q == 2 || q == 3 || q == 6 || q == 7) return false; // 좌측군
//     return true;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final p = context.watch<DentalDataProvider>();
//     final spec = p.getSpecRead(fdi);
//
//     // 면 채우기
//     final Map<String, _SurfaceFill> fill = {
//       for (final s in kToothSurfaces) s: _SurfaceFill.none,
//     };
//     if (spec != null) {
//       for (final s in kToothSurfaces) {
//         final list = spec.surface[s]!['fillings']!;
//         final hasCaries = list.any(_isCariesThree);
//         if (hasCaries) {
//           fill[s] = _SurfaceFill.cariesRed;
//         } else if (list.isNotEmpty) {
//           fill[s] = _SurfaceFill.fillingBlue;
//         }
//       }
//     }
//
//     final bool ringCrown =
//         (spec?.global['crown'] ?? const <String>[]).isNotEmpty;
//     final bool markStatusMissing =
//     (spec?.global['status'] ?? const <String>[])
//         .map((e) => e.toUpperCase())
//         .any((c) => c == 'MIS' || c.startsWith('MIS') || c == 'MAM' || c == 'MPM' || c == 'EXT' || c == 'SOX' || c == 'MJA');
//     final bool markRootImplant =
//     (spec?.global['root'] ?? const <String>[])
//         .map((e) => e.toUpperCase())
//         .any((c) => c == 'IPX' || c.startsWith('IPX'));
//
//     bool markDenture = false, markAbut = false, markPontic = false;
//     for (final sp in p.spans) {
//       if (!sp.teeth.contains(fdi)) continue;
//       if (sp.type == DentalSpanType.dentureOrtho) {
//         markDenture = true;
//       } else {
//         if (sp.abutments.contains(fdi)) markAbut = true;
//         if (sp.pontics.contains(fdi))   markPontic = true;
//       }
//     }
//
//     bool hasAnyInput = false;
//     if (spec != null) {
//       for (final s in kToothSurfaces) {
//         final f = (spec.surface[s]?['fillings'] ?? const <String>[]);
//         final pr = (spec.surface[s]?['periodontium'] ?? const <String>[]);
//         if (f.isNotEmpty || pr.isNotEmpty) { hasAnyInput = true; break; }
//       }
//       if (!hasAnyInput) {
//         for (final g in const ['bite','crown','root','status','position','crown pathology']) {
//           if ((spec.global[g] ?? const <String>[]).isNotEmpty) { hasAnyInput = true; break; }
//         }
//       }
//       if (!hasAnyInput) {
//         if ((spec.toothNote ?? '').trim().isNotEmpty ||
//             spec.surfaceNote.values.any((v) => v.trim().isNotEmpty)) {
//           hasAnyInput = true;
//         }
//       }
//     }
//
//     final hasSurfacePaint = fill.values.any((f) => f != _SurfaceFill.none);
//     final hasBlueRing   = ringCrown || markAbut;
//     final hasBlueLines  = markPontic || markStatusMissing || markRootImplant;
//     final hasOwnVisual  = hasSurfacePaint || hasBlueRing || hasBlueLines || markDenture;
//     final highlightAny  = hasAnyInput && !hasOwnVisual;
//
//     return GestureDetector(
//       behavior: HitTestBehavior.opaque,
//       onTap: () => onOpenEditor(context, fdi),
//       onLongPress: () => onOpenEditor(context, fdi),
//       child: CustomPaint(
//         size: Size.square(size),
//         painter: _FiveSurfacePainter(
//           mesialOnRight: _mesialOnRight,
//           fill: fill,
//           abut: markAbut,
//           pontic: markPontic,
//           ringCrown: ringCrown,
//           twoHorizontal: markStatusMissing,
//           oneVertical: markRootImplant,
//           highlightAny: highlightAny,
//         ),
//       ),
//     );
//   }
// }
//
// /// ─────────────────────────────────────────────────────────────────
// /// 단일치아 편집 화면: Global / Surface(OMDBL 다중선택)
// class SingleToothEditorScreen extends StatefulWidget {
//   final int fdi;
//   const SingleToothEditorScreen({super.key, required this.fdi});
//
//   @override
//   State<SingleToothEditorScreen> createState() => _SingleToothEditorScreenState();
// }
//
// enum _EditMode { global, surface }
//
// class _SingleToothEditorScreenState extends State<SingleToothEditorScreen> {
//   _EditMode mode = _EditMode.global;
//
//   final _pickerKey = GlobalKey<_InterpolPickerInlineState>();
//
//   // Surface 모드: OMDBL 다중 선택
//   final Set<String> _surfaces = {'O','M','D','B','L'};
//   final Set<String> _pickedSurfaces = {'O'}; // 기본값
//
//   bool _canSaveCode = false;
//
//   CodeSelection? _quickSel; // 'Frequently Used' 칩으로 고른 임시 선택 (저장 전)
//
//   // 메모
//   late final TextEditingController _noteCtrl;
//   late String _initialNoteForGlobal;
//   final Map<String, String> _initialSurfaceNotes = {};
//
//   @override
//   void initState() {
//     super.initState();
//     final p = context.read<DentalDataProvider>();
//     final spec = p.getSpecRead(widget.fdi);
//
//     _initialNoteForGlobal = spec?.toothNote ?? '';
//     _noteCtrl = TextEditingController(text: _initialNoteForGlobal);
//
//     for (final s in _surfaces) {
//       final note = spec?.surfaceNote[s] ?? '';
//       _initialSurfaceNotes[s] = note;
//     }
//
//     WidgetsBinding.instance.addPostFrameCallback((_) => p.loadCodeTreeOnce());
//   }
//
//   @override
//   void dispose() {
//     _noteCtrl.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final p = context.watch<DentalDataProvider>();
//     final media = MediaQuery.of(context);
//     final kb = media.viewInsets.bottom;
//
//     _syncNoteTextForMode(p);
//
//     // 미리보기 크기: 화면폭의 56%~220 사이
//     final previewSize = min(media.size.width * 0.56, 220.0);
//
//     // 즐겨찾기 코드(대문자) 집합 — 아래 인터폴 선택에서 제외할 용도
//     final exclude = favCodesUpperForMode(mode);
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Tooth ${widget.fdi}'),
//         actions: [
//           IconButton(icon: const Icon(Icons.help_outline), onPressed: () => _showHelp(context)),
//         ],
//       ),
//       body: SafeArea(
//         child: Padding(
//           padding: EdgeInsets.fromLTRB(16, 12, 16, max(12, kb)),
//           // 세로 스크롤 하나로 모두 감싸 오버플로우 방지
//           child: ListView(
//             children: [
//               // 모드 토글
//               SegmentedButton<_EditMode>(
//                 segments: const [
//                   ButtonSegment(value: _EditMode.global,  icon: Icon(Icons.public),  label: Text('Global')),
//                   ButtonSegment(value: _EditMode.surface, icon: Icon(Icons.grid_on), label: Text('Surface(OMDBL)')),
//                 ],
//                 selected: {mode},
//                 onSelectionChanged: (s) => setState(() => mode = s.first),
//               ),
//               const SizedBox(height: 12),
//
//               if (mode == _EditMode.surface) ...[
//                 Wrap(
//                   spacing: 8,
//                   children: _surfaces.map((s) {
//                     final selected = _pickedSurfaces.contains(s);
//                     return FilterChip(
//                       label: Text(s),
//                       selected: selected,
//                       onSelected: (v) => setState(() {
//                         if (v) _pickedSurfaces.add(s);
//                         else if (_pickedSurfaces.length > 1) _pickedSurfaces.remove(s);
//                       }),
//                     );
//                   }).toList(),
//                 ),
//                 const SizedBox(height: 8),
//                 const Text('※ Surface 선택은 여러 개 동시 적용됩니다. (예: MOD)'),
//                 const SizedBox(height: 12),
//               ],
//
//               _FrequentlyUsedPanel(
//                 mode: mode,
//                 onPick: (category, code) {
//                   setState(() {
//                     _quickSel = CodeSelection(category: category, path: [code.toUpperCase()]); // 대문자화
//                     _canSaveCode = true; // 저장 버튼 활성화를 위해
//                   });
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(content: Text('선택됨: $category · $code — 저장을 눌러 적용됩니다.')),
//                   );
//                 },
//               ),
//               const SizedBox(height: 8),
//
//               // 저장 전 선택까지 반영되는 "라이브 미리보기"
//               Center(
//                 child: _ToothPreviewLive(
//                   fdi: widget.fdi,
//                   size: previewSize,
//                   mode: mode,
//                   pickedSurfaces: _pickedSurfaces,
//                   pendingSel: _quickSel ?? _pickerKey.currentState?.currentSelection,
//                   pendingNote: _noteCtrl.text,
//                 ),
//               ),
//               const SizedBox(height: 8),
//
//               // 현재 저장 상태 요약(저장된 값 기준)
//               _CurrentStateInlineSummary(fdi: widget.fdi),
//               const SizedBox(height: 12),
//
//               // Interpol 선택(트리 모드 + 즐겨찾기 중복 제거)
//               _InterpolPickerInline(
//                 key: _pickerKey,
//                 title: mode == _EditMode.global ? 'Interpol 코드 선택 (전역)' : 'Interpol 코드 선택 (표면)',
//                 categoryFilter: (cats) {
//                   if (mode == _EditMode.global) {
//                     // Global: 표면/스팬/교정류 제외
//                     return cats.where((c) {
//                       final u = c.toLowerCase();
//                       final isSurface = u == 'fillings' || u == 'periodontium';
//                       final isSpan = u.contains('bridge');
//                       final isDentOrtho = u.contains('denture') || u.contains('orthodont');
//                       return !(isSurface || isSpan || isDentOrtho);
//                     }).toList();
//                   } else {
//                     // Surface: Fillings/Periodontium만
//                     return cats.where((c) => c == 'Fillings' || c == 'Periodontium').toList();
//                   }
//                 },
//                 onConfirm: (_) {},
//                 onHasCodeChanged: (_) => setState(() => _canSaveCode = _),
//                 excludeCodes: exclude, // 즐겨찾기와 중복되는 코드 숨김
//               ),
//               const SizedBox(height: 12),
//
//               // 메모
//               Text(mode == _EditMode.global ? '자연어 메모 (전역)' : '자연어 메모 (선택된 표면 모두에 적용)'),
//               const SizedBox(height: 6),
//               TextField(
//                 controller: _noteCtrl,
//                 onChanged: (_) => setState(() {}), // 미리보기 하이라이트 즉시 반영
//                 maxLines: 3,
//                 keyboardType: TextInputType.multiline,
//                 textInputAction: TextInputAction.newline,
//                 decoration: const InputDecoration(
//                   border: OutlineInputBorder(),
//                   hintText: '예: Global - 교합 개방감 / Surface - MOD 수복 예정 등',
//                 ),
//               ),
//               const SizedBox(height: 12),
//
//               // 버튼들: 줄바꿈 안전
//               OverflowBar(
//                 alignment: MainAxisAlignment.end,
//                 spacing: 8,
//                 children: [
//                   TextButton.icon(
//                     icon: const Icon(Icons.delete_outline),
//                     label: const Text('기록 삭제'),
//                     onPressed: () {
//                       if (mode == _EditMode.global) {
//                         context.read<DentalDataProvider>().clearGlobalAll635(widget.fdi);
//                         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('전역 기록을 삭제했습니다.')));
//                       } else {
//                         for (final s in _pickedSurfaces) {
//                           context.read<DentalDataProvider>().clearSurface635(widget.fdi, s);
//                         }
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           SnackBar(content: Text('표면(${_pickedSurfaces.join(",")}) 기록을 삭제했습니다.')),
//                         );
//                       }
//                     },
//                   ),
//                   TextButton(onPressed: () => Navigator.pop(context), child: const Text('취소')),
//                   FilledButton(
//                     onPressed: _canPressSave(p) ? () => _handleSave(p) : null,
//                     child: const Text('저장'),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   void _showHelp(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       showDragHandle: true,
//       builder: (_) => const Padding(
//         padding: EdgeInsets.fromLTRB(16, 12, 16, 16),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('단일치아 편집 도움말', style: TextStyle(fontWeight: FontWeight.w700)),
//             SizedBox(height: 8),
//             Text('• Global: OMDBL 선택 없이 전역 코드만 고릅니다.'),
//             Text('• Surface: OMDBL 여러 표면을 동시에 선택하고, 선택한 코드가 한 번에 적용됩니다.'),
//             Text('• 메모: Global은 치아 전역 메모, Surface는 선택된 표면 모두에 동일 메모가 저장됩니다.'),
//             SizedBox(height: 8),
//             Text('• 삭제: 현재 모드에 따라 전역 전체 또는 선택 표면들의 기록을 삭제합니다.'),
//           ],
//         ),
//       ),
//     );
//   }
//
//   // 모드에 따라 메모 텍스트 동기화
//   void _syncNoteTextForMode(DentalDataProvider p) {
//     final spec = p.getSpecRead(widget.fdi);
//     if (mode == _EditMode.global) {
//       final want = spec?.toothNote ?? '';
//       if (_noteCtrl.text != want) {
//         _noteCtrl.text = want;
//         _noteCtrl.selection = TextSelection.fromPosition(
//           TextPosition(offset: _noteCtrl.text.length),
//         );
//       }
//     } else {
//       final notes = _pickedSurfaces.map((s) => spec?.surfaceNote[s]?.trim() ?? '').toSet();
//       final String want = (notes.length == 1) ? notes.first : '';
//       if (_noteCtrl.text != want) {
//         _noteCtrl.text = want;
//         _noteCtrl.selection = TextSelection.fromPosition(
//           TextPosition(offset: _noteCtrl.text.length),
//         );
//       }
//     }
//   }
//
//   bool _canPressSave(DentalDataProvider p) {
//     if (mode == _EditMode.global) {
//       final noteChanged = (_noteCtrl.text.trim() != _initialNoteForGlobal.trim());
//       final hasPendingCode = _canSaveCode || (_quickSel != null);
//       return hasPendingCode || noteChanged;
//     } else {
//       final note = _noteCtrl.text.trim();
//       final anyNoteChanged = _pickedSurfaces.any((s) => (note != (_initialSurfaceNotes[s]?.trim() ?? '')));
//       final hasPendingCode = _canSaveCode || (_quickSel != null);
//       return hasPendingCode || anyNoteChanged;
//     }
//   }
//
//   void _handleSave(DentalDataProvider p) {
//     final sel = _pickerKey.currentState?.currentSelection ?? _quickSel; // ← 우선
//     final note = _noteCtrl.text.trim();
//
//     bool savedCode = false, savedNote = false;
//
//     if (mode == _EditMode.global) {
//       if (sel != null) { applyInterpolToGlobal635WithToggles(context, widget.fdi, sel); savedCode = true; }
//       if (note != _initialNoteForGlobal.trim()) { p.setToothNote635(widget.fdi, note); savedNote = true; _initialNoteForGlobal = note; }
//     } else {
//       if (sel != null) {
//         for (final s in _pickedSurfaces) { applyInterpolToSurface635WithToggles(context, widget.fdi, s, sel); }
//         savedCode = true;
//       }
//       for (final s in _pickedSurfaces) {
//         if (note != (_initialSurfaceNotes[s]?.trim() ?? '')) { p.setSurfaceNote635(widget.fdi, s, note); _initialSurfaceNotes[s] = note; savedNote = true; }
//       }
//     }
//
//     _quickSel = null; // 임시 선택 초기화
//     Navigator.pop(context);
//     final msg = (savedCode && savedNote) ? '코드와 메모가 저장되었습니다.' : (savedCode ? '코드가 저장되었습니다.' : '메모만 저장되었습니다.');
//     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
//   }
// }
//
// /// 저장된 spec + (선택 중인 Interpol 코드/표면/메모)을 합성해 그리는 라이브 미리보기
// class _ToothPreviewLive extends StatelessWidget {
//   final int fdi;
//   final double size;
//   final _EditMode mode;
//   final Set<String> pickedSurfaces;      // Surface 모드에서 동시 적용할 OMDBL
//   final CodeSelection? pendingSel;       // _pickerKey.currentState?.currentSelection
//   final String pendingNote;              // 메모 입력창 현재 값
//
//   const _ToothPreviewLive({
//     super.key,
//     required this.fdi,
//     required this.size,
//     required this.mode,
//     required this.pickedSurfaces,
//     required this.pendingSel,
//     required this.pendingNote,
//   });
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
//     final spec = p.getSpecRead(fdi);
//
//     // 1) 저장된 상태로부터 기본 표시 계산
//     final Map<String, _SurfaceFill> fill = { for (final s in kToothSurfaces) s: _SurfaceFill.none };
//     if (spec != null) {
//       for (final s in kToothSurfaces) {
//         final list = spec.surface[s]!['fillings']!;
//         final hasCaries = list.any(_isCariesThree);
//         if (hasCaries)      fill[s] = _SurfaceFill.cariesRed;
//         else if (list.isNotEmpty) fill[s] = _SurfaceFill.fillingBlue;
//       }
//     }
//
//     bool ringCrown = (spec?.global['crown'] ?? const <String>[]).isNotEmpty;
//     bool twoHorizontal = (spec?.global['status'] ?? const <String>[])
//         .map((e)=>e.toUpperCase())
//         .any((c)=> c=='MIS' || c.startsWith('MIS') || c=='MAM' || c=='MPM' || c=='EXT' || c=='SOX' || c=='MJA');
//     bool oneVertical = (spec?.global['root'] ?? const <String>[])
//         .map((e)=>e.toUpperCase())
//         .any((c)=> c=='IPX' || c.startsWith('IPX'));
//
//     bool markDenture=false, markAbut=false, markPontic=false;
//     for (final sp in p.spans) {
//       if (!sp.teeth.contains(fdi)) continue;
//       if (sp.type == DentalSpanType.dentureOrtho) markDenture = true;
//       else {
//         if (sp.abutments.contains(fdi)) markAbut = true;
//         if (sp.pontics.contains(fdi))   markPontic = true;
//       }
//     }
//
//     // 2) “선택 중”인 코드로 오버레이(미리보기 전용, 실제 저장 아님)
//     if (pendingSel != null) {
//       if (mode == _EditMode.surface) {
//         // Fillings/Periodontium만 허용
//         if (pendingSel!.category == 'Fillings') {
//           final last = pendingSel!.path.isNotEmpty ? pendingSel!.path.last : null;
//           final isCar = last != null && _isCariesThree(last);
//           for (final s in pickedSurfaces) {
//             fill[s] = isCar ? _SurfaceFill.cariesRed : _SurfaceFill.fillingBlue;
//           }
//         } else if (pendingSel!.category == 'Periodontium') {
//           // Periodontium은 기존처럼 색 채움 없음(하이라이트만 영향)
//         }
//       } else {
//         // Global 미리보기: 그룹별 시각표시 반영
//         const cat2group = <String, String>{
//           'Bite and occlusion': 'bite',
//           'Tooth position'    : 'position',
//           'Status'            : 'status',
//           'Root'              : 'root',
//           'Crowns'            : 'crown',
//           'Crown pathology'   : 'crown pathology'
//         };
//         final code = pendingSel!.path.isNotEmpty ? pendingSel!.path.last : null;
//         final g = cat2group[pendingSel!.category];
//         if (code != null && g != null) {
//           if (g == 'crown') ringCrown = true;
//           if (g == 'status') twoHorizontal = (() {
//             final c = code.toUpperCase();
//             return c=='MIS' || c.startsWith('MIS') || c=='MAM' || c=='MPM' || c=='EXT' || c=='SOX' || c=='MJA';
//           })();
//           if (g == 'root')   oneVertical = (() {
//             final c = code.toUpperCase();
//             return c=='IPX' || c.startsWith('IPX');
//           })();
//         }
//       }
//     }
//
//     // 3) 하이라이트(보라색) 판단: 저장값 + “선택중” + 메모 입력 고려
//     bool anyGlobal = spec?.global.values.any((lst)=>lst.isNotEmpty) ?? false;
//     bool anySurface = false;
//     if (spec != null) {
//       for (final s in kToothSurfaces) {
//         final f = (spec.surface[s]?['fillings'] ?? const <String>[]);
//         final pr= (spec.surface[s]?['periodontium'] ?? const <String>[]);
//         if (f.isNotEmpty || pr.isNotEmpty) { anySurface = true; break; }
//       }
//     }
//     final bool anyNote =
//         ((spec?.toothNote ?? '').trim().isNotEmpty) ||
//             (((spec?.surfaceNote ?? const <String, String>{}).values)
//                 .any((v) => v.trim().isNotEmpty));
//
//     // “선택 중” 효과도 입력으로 간주
//     final hasPendingGlobal =
//     (mode==_EditMode.global && pendingSel!=null);
//     final hasPendingSurface =
//     (mode==_EditMode.surface && pendingSel!=null && pickedSurfaces.isNotEmpty);
//     final hasPendingNote = pendingNote.trim().isNotEmpty;
//
//     final hasAnyInput = anyGlobal || anySurface || anyNote
//         || hasPendingGlobal || hasPendingSurface || hasPendingNote;
//
//     final hasSurfacePaint = fill.values.any((f)=>f!=_SurfaceFill.none);
//     final hasBlueRing   = ringCrown || markAbut;
//     final hasBlueLines  = markPontic || twoHorizontal || oneVertical;
//     final hasOwnVisual  = hasSurfacePaint || hasBlueRing || hasBlueLines || markDenture;
//     final highlightAny  = hasAnyInput && !hasOwnVisual;
//
//     return Column(
//       children: [
//         Text('$fdi', style: const TextStyle(fontWeight: FontWeight.w700)),
//         const SizedBox(height: 6),
//         SizedBox(
//           width: size, height: size,
//           child: CustomPaint(
//             painter: _FiveSurfacePainter(
//               mesialOnRight: _mesialOnRight,
//               fill: fill,
//               abut: markAbut,
//               pontic: markPontic,
//               ringCrown: ringCrown,
//               twoHorizontal: twoHorizontal,
//               oneVertical: oneVertical,
//               highlightAny: highlightAny,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
//
// /// ─────────────────────────────────────────────────────────────────
// /// Interpol 인라인 피커: 트리 모드 + 하위코드 중복제외 + 레벨무관 선택 허용
// class _InterpolPickerInline extends StatefulWidget {
//   final String title;
//   final List<String> Function(List<String> all)? categoryFilter;
//   final void Function(CodeSelection sel) onConfirm;
//   final void Function(bool hasCodeSelected)? onHasCodeChanged;
//   final Set<String>? excludeCodes; // 즐겨찾기 항목 중복 제거
//
//   const _InterpolPickerInline({
//     Key? key,
//     required this.title,
//     this.categoryFilter,
//     required this.onConfirm,
//     this.onHasCodeChanged,
//     this.excludeCodes,
//   }) : super(key: key);
//
//   @override
//   State<_InterpolPickerInline> createState() => _InterpolPickerInlineState();
// }
//
// class _InterpolPickerInlineState extends State<_InterpolPickerInline> {
//   String? cat;
//   final List<String> path = [];
//   bool _treeMode = false; // 트리/드롭다운 전환
//
//   Set<String> get _exclude => (widget.excludeCodes ?? const <String>{})
//       .map((e) => e.toUpperCase()).toSet();
//
//   CodeSelection? get currentSelection {
//     if (cat == null) return null;
//     final sel = CodeSelection(category: cat!, path: List<String>.from(path));
//     // 레벨과 무관: 경로가 1개 이상이면 유효로 본다
//     final valid = path.isNotEmpty;
//     return valid ? sel : null;
//   }
//
//   void _notifyHasCode() {
//     widget.onHasCodeChanged?.call(currentSelection != null);
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) async {
//       try {
//         await context.read<DentalDataProvider>().loadCodeTreeOnce();
//         if (mounted) setState(() {});
//         _notifyHasCode();
//       } catch (_) {
//         _notifyHasCode();
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('코드 트리 로딩 실패.')),
//         );
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final p = context.watch<DentalDataProvider>();
//     var cats = p.availableCategories(ViewMode.zoomIn);
//     if (widget.categoryFilter != null) cats = widget.categoryFilter!(cats);
//
//     List<CodeNode> childrenOf(List<String> prefix) {
//       if (cat == null) return const <CodeNode>[];
//       return p.listChildren(cat!, prefix)
//           .where((n) => !_exclude.contains(n.code.toUpperCase()))
//           .toList();
//     }
//
//     DropdownButtonFormField<String> dd(List<CodeNode> items, int level, String label) {
//       final cur = path.length > level ? path[level] : null;
//       return DropdownButtonFormField<String>(
//         isExpanded: true,
//         value: cur,
//         decoration: InputDecoration(labelText: label),
//         items: items.map((n) => DropdownMenuItem(value: n.code, child: Text('${n.code} — ${n.label}'))).toList(),
//         onChanged: (v) {
//           if (v == null) return;
//           setState(() {
//             if (path.length > level) path.removeRange(level, path.length);
//             if (path.length == level) { path.add(v); } else { path[level] = v; }
//             _notifyHasCode();
//           });
//         },
//       );
//     }
//
//     // 트리 렌더러: 아무 레벨이든 선택 가능
//     List<Widget> buildLevel(List<String> prefix) {
//       final items = childrenOf(prefix);
//       return items.map((n) {
//         final next = [...prefix, n.code];
//         final kids = childrenOf(next);
//         final title = Text('${n.code} — ${n.label}');
//         if (kids.isEmpty) {
//           return ListTile(
//             dense: true,
//             title: title,
//             onTap: () {
//               setState(() { path..clear()..addAll(next); });
//               _notifyHasCode();
//             },
//           );
//         }
//         return ExpansionTile(
//           title: Row(
//             children: [
//               Expanded(child: title),
//               TextButton(
//                 onPressed: () {
//                   setState(() { path..clear()..addAll(next); });
//                   _notifyHasCode();
//                 },
//                 child: const Text('선택'),
//               ),
//             ],
//           ),
//           children: buildLevel(next),
//         );
//       }).toList();
//     }
//
//     final level0 = cat == null ? const <CodeNode>[] : childrenOf(const []);
//     final level1 = (cat == null || path.isEmpty) ? const <CodeNode>[] : childrenOf(path.take(1).toList());
//     final level2 = (cat == null || path.length < 2) ? const <CodeNode>[] : childrenOf(path.take(2).toList());
//     final level3 = (cat == null || path.length < 3) ? const <CodeNode>[] : childrenOf(path.take(3).toList());
//
//     return ExpansionTile(
//       title: Text(widget.title),
//       initiallyExpanded: false,
//       childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
//       children: [
//         DropdownButtonFormField<String>(
//           isExpanded: true,
//           value: (cats.contains(cat)) ? cat : null,
//           decoration: const InputDecoration(labelText: 'Category'),
//           hint: const Text('(System code/text를 선택하세요.)'),
//           items: cats.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
//           onChanged: (v) => setState(() { cat = v; path.clear(); _notifyHasCode();}),
//         ),
//         const SizedBox(height: 8),
//
//         if (cat != null) ...[
//           // 트리/드롭다운 토글
//           SwitchListTile.adaptive(
//             dense: true,
//             title: const Text('트리 모드(레벨1~4 자유 선택)'),
//             contentPadding: EdgeInsets.zero,
//             value: _treeMode,
//             onChanged: (v) => setState(() => _treeMode = v),
//           ),
//           const SizedBox(height: 8),
//
//           if (_treeMode) ...[
//             ...buildLevel(const []),
//           ] else ...[
//             dd(level0, 0, 'Level 1'),
//             if (level1.isNotEmpty) ...[const SizedBox(height: 8), dd(level1, 1, 'Level 2')],
//             if (level2.isNotEmpty) ...[const SizedBox(height: 8), dd(level2, 2, 'Level 3')],
//             if (level3.isNotEmpty) ...[const SizedBox(height: 8), dd(level3, 3, 'Level 4')],
//             const SizedBox(height: 12),
//             if (path.isEmpty)
//               const Text(
//                 '카테고리만 고른 상태입니다. LEVEL 1~4 중 아무 단계나 선택해도 됩니다.',
//                 style: TextStyle(color: Colors.redAccent, fontSize: 12),
//               ),
//           ],
//
//           const SizedBox(height: 8),
//           Row(
//             children: [
//               Expanded(
//                 child: Text(
//                   '현재 선택: ${cat ?? "-"}${path.isEmpty ? "" : " · ${path.join(" > ")}"}',
//                   overflow: TextOverflow.ellipsis,
//                   style: const TextStyle(color: Colors.black54),
//                 ),
//               ),
//               TextButton.icon(
//                 onPressed: () => setState(() => path.clear()),
//                 icon: const Icon(Icons.clear),
//                 label: const Text('경로 초기화'),
//               ),
//             ],
//           ),
//         ],
//         const SizedBox(height: 4),
//       ],
//     );
//   }
// }
//
// /// ─────────────────────────────────────────────────────────────────
// /// Interpol → 635 전역/표면에 “덮어쓰기” 반영 (토글 API만 사용)
// void applyInterpolToGlobal635WithToggles(
//     BuildContext context,
//     int fdi,
//     CodeSelection sel,
//     ) {
//   final p = context.read<DentalDataProvider>();
//
//   const cat2group = <String, String>{
//     'Bite and occlusion': 'bite',
//     'Tooth position'    : 'position',
//     'Status'            : 'status',
//     'Root'              : 'root',
//     'Crowns'            : 'crown',
//     'Crown pathology'   : 'crown pathology'
//   };
//
//   final code = (sel.path.isNotEmpty) ? sel.path.last : null;
//   final group = cat2group[sel.category];
//   if (code == null || group == null) return;
//
//   final prev = p.getSpecRead(fdi)?.global[group] ?? const <String>[];
//   for (final c in prev) {
//     if (c != code) {
//       p.toggleGlobalCode(fdi, group, c);
//     }
//   }
//   final cur = p.getSpecRead(fdi)?.global[group] ?? const <String>[];
//   if (!cur.contains(code)) {
//     p.toggleGlobalCode(fdi, group, code);
//   }
// }
//
// void applyInterpolToSurface635WithToggles(
//     BuildContext context,
//     int fdi,
//     String surface,
//     CodeSelection sel,
//     ) {
//   final p = context.read<DentalDataProvider>();
//
//   String? group;
//   if (sel.category == 'Fillings') {
//     group = 'fillings';
//   } else if (sel.category == 'Periodontium') {
//     group = 'periodontium';
//   } else {
//     return;
//   }
//
//   final code = (sel.path.isNotEmpty) ? sel.path.last : null;
//   if (code == null) return;
//
//   final prev = p.getSpecRead(fdi)?.surface[surface]?[group] ?? const <String>[];
//   for (final c in prev) {
//     if (c != code) {
//       p.toggleSurfaceCode(fdi, surface, group, c);
//     }
//   }
//   final cur = p.getSpecRead(fdi)?.surface[surface]?[group] ?? const <String>[];
//   if (!cur.contains(code)) {
//     p.toggleSurfaceCode(fdi, surface, group, code);
//   }
// }
//
// /// ─────────────────────────────────────────────────────────────────
// /// 그리기 유틸
// enum _SurfaceFill { none, toggleAmber, fillingBlue, cariesRed }
//
// class _FiveSurfacePainter extends CustomPainter {
//   final bool mesialOnRight;
//   final Map<String, _SurfaceFill> fill;
//
//   final bool abut;     // 지대치 → 파란 링
//   final bool pontic;   // pontic → 수평 2줄
//
//   final bool ringCrown;     // crown 선택 시 링
//   final bool twoHorizontal; // status MIS* → 수평 2줄
//   final bool oneVertical;   // root IPX* → 수직 1줄
//
//   final bool highlightAny;  // 보라색 테두리
//
//   const _FiveSurfacePainter({
//     required this.mesialOnRight,
//     required this.fill,
//     this.abut = false,
//     this.pontic = false,
//     this.ringCrown = false,
//     this.twoHorizontal = false,
//     this.oneVertical = false,
//     this.highlightAny = false,
//   });
//
//   @override
//   void paint(Canvas canvas, Size s) {
//     final g = _Geom(s);
//
//     final outerStroke = Paint()
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = (s.width * .04).clamp(1.0, 2.0)
//       ..color = highlightAny ? Colors.deepPurple : Colors.black87;
//
//     final innerStroke = Paint()
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = (s.width * .032).clamp(0.8, 1.6)
//       ..color = Colors.black54;
//
//     Paint paintOf(_SurfaceFill f) {
//       switch (f) {
//         case _SurfaceFill.cariesRed:
//           return Paint()..style = PaintingStyle.fill..color = Colors.red.withOpacity(.35);
//         case _SurfaceFill.fillingBlue:
//           return Paint()..style = PaintingStyle.fill..color = Colors.blue.withOpacity(.28);
//         case _SurfaceFill.toggleAmber:
//           return Paint()..style = PaintingStyle.fill..color = Colors.amber.withOpacity(.35);
//         case _SurfaceFill.none:
//           return Paint()..style = PaintingStyle.stroke..color = Colors.transparent;
//       }
//     }
//
//     final l = fill['L'] ?? _SurfaceFill.none;
//     final b = fill['B'] ?? _SurfaceFill.none;
//     final o = fill['O'] ?? _SurfaceFill.none;
//     final m = fill['M'] ?? _SurfaceFill.none;
//     final d = fill['D'] ?? _SurfaceFill.none;
//
//     if (l != _SurfaceFill.none) canvas.drawPath(g.pathL, paintOf(l));
//     if (b != _SurfaceFill.none) canvas.drawPath(g.pathB, paintOf(b));
//     if (o != _SurfaceFill.none) canvas.drawRect(g.rectO, paintOf(o));
//
//     final leftFill  = mesialOnRight ? d : m;
//     final rightFill = mesialOnRight ? m : d;
//     if (leftFill  != _SurfaceFill.none) canvas.drawPath(g.pathLeft,  paintOf(leftFill));
//     if (rightFill != _SurfaceFill.none) canvas.drawPath(g.pathRight, paintOf(rightFill));
//
//     // 윤곽/내부선
//     canvas.drawRRect(g.outerRRect, outerStroke);
//     canvas.drawRect(g.rectO, innerStroke);
//
//     final oc = [g.outerRect.topLeft, g.outerRect.topRight, g.outerRect.bottomRight, g.outerRect.bottomLeft];
//     final ic = [g.rectO.topLeft, g.rectO.topRight, g.rectO.bottomRight, g.rectO.bottomLeft];
//     for (int i = 0; i < 4; i++) {
//       canvas.drawLine(ic[i], oc[i], innerStroke);
//     }
//
//     // 파란 공통
//     final blue = Paint()
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = (s.width * .06).clamp(1.2, 2.4)
//       ..color = Colors.blueAccent;
//
//     if (ringCrown || abut) {
//       final ring = g.outerRect.deflate(s.width * .18);
//       canvas.drawRRect(
//         RRect.fromRectAndRadius(ring, Radius.circular(ring.width * .20)),
//         blue,
//       );
//     }
//
//     if (pontic || twoHorizontal) {
//       final y1 = s.height * .40, y2 = s.height * .60;
//       canvas.drawLine(Offset(s.width * .18, y1), Offset(s.width * .82, y1), blue);
//       canvas.drawLine(Offset(s.width * .18, y2), Offset(s.width * .82, y2), blue);
//     }
//
//     if (oneVertical) {
//       final x = s.width * .50;
//       canvas.drawLine(Offset(x, s.height * .20), Offset(x, s.height * .80), blue);
//     }
//   }
//
//   @override
//   bool shouldRepaint(covariant _FiveSurfacePainter old) =>
//       old.mesialOnRight != mesialOnRight ||
//           !_mapEquals(old.fill, fill) ||
//           old.abut != abut ||
//           old.pontic != pontic ||
//           old.ringCrown != ringCrown ||
//           old.twoHorizontal != twoHorizontal ||
//           old.oneVertical != oneVertical ||
//           old.highlightAny != highlightAny;
//
//   bool _mapEquals(Map<String, _SurfaceFill> a, Map<String, _SurfaceFill> b) {
//     if (identical(a, b)) return true;
//     if (a.length != b.length) return false;
//     for (final k in kToothSurfaces) {
//       if ((a[k] ?? _SurfaceFill.none) != (b[k] ?? _SurfaceFill.none)) return false;
//     }
//     return true;
//   }
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
//     final rectW = w * .54;  // 방패연 비율
//     final rectH = h * .36;
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
//
// /// getSpecRead가 null이어도 안전한 뷰
// class _SpecView {
//   final int fdi;
//   final dynamic _raw;
//   _SpecView(this.fdi, this._raw);
//
//   Map<String, List<String>> get global {
//     if (_raw?.global != null) return _raw!.global;
//     return <String, List<String>>{
//       'bite': <String>[],
//       'position': <String>[],
//       'status': <String>[],
//       'root': <String>[],
//       'crown': <String>[],
//       'crown pathology': <String>[],
//     };
//   }
//
//   Map<String, Map<String, List<String>>> get surface {
//     if (_raw?.surface != null) return _raw!.surface;
//     return {
//       for (final s in kToothSurfaces)
//         s: <String, List<String>>{
//           'fillings': <String>[],
//           'periodontium': <String>[],
//         }
//     };
//   }
//
//   String get toothNote => (_raw?.toothNote ?? '').trim();
//
//   Map<String, String> get surfaceNote {
//     if (_raw?.surfaceNote != null) return _raw!.surfaceNote;
//     return { for (final s in kToothSurfaces) s: '' };
//   }
// }
//
// class _CurrentStateInlineSummary extends StatelessWidget {
//   final int fdi;
//   const _CurrentStateInlineSummary({super.key, required this.fdi});
//
//   @override
//   Widget build(BuildContext context) {
//     final p = context.watch<DentalDataProvider>();
//     final spec = p.getSpecRead(fdi);
//     String _ellipsis(String s, int n) => s.length <= n ? s : '${s.substring(0, n)}…';
//
//     // 안전 뷰로 변환
//     final view = _SpecView(fdi, spec);
//
//     final g = view.global;
//     final s = view.surface;
//     final toothNote = view.toothNote;
//
//     String joinMapList(Map<String, List<String>> m, List<String> keys) {
//       final parts = <String>[];
//       for (final k in keys) {
//         final v = m[k] ?? const <String>[];
//         if (v.isNotEmpty) parts.add('$k:${v.join("/")}');
//       }
//       return parts.join(' · ');
//     }
//
//     String surfLine() {
//       final buf = <String>[];
//       for (final surf in kToothSurfaces) {
//         final f = (s[surf]?['fillings'] ?? const <String>[]);
//         final pds = (s[surf]?['periodontium'] ?? const <String>[]);
//         if (f.isEmpty && pds.isEmpty) continue;
//         final inner = [
//           if (f.isNotEmpty) 'F:${f.join("/")}',
//           if (pds.isNotEmpty) 'P:${pds.join("/")}',
//         ].join(',');
//         buf.add('$surf($inner)');
//       }
//       return buf.join(' · ');
//     }
//
//     final gLine = joinMapList(g, ['bite','position','status','root','crown','crown pathology']);
//     final sLine = surfLine();
//
//     // 아무 것도 없으면 감춤
//     if (gLine.isEmpty && sLine.isEmpty && toothNote.isEmpty) {
//       return const SizedBox.shrink();
//     }
//
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.grey.withOpacity(0.06),
//         borderRadius: BorderRadius.circular(12),
//       ),
//       padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text('현재 저장 상태', style: TextStyle(fontWeight: FontWeight.w700)),
//           const SizedBox(height: 6),
//           if (gLine.isNotEmpty)
//             Text('전역: $gLine', style: const TextStyle(fontSize: 12)),
//           if (sLine.isNotEmpty)
//             Padding(
//               padding: const EdgeInsets.only(top: 2),
//               child: Text('표면: $sLine', style: const TextStyle(fontSize: 12)),
//             ),
//           if (toothNote.isNotEmpty)
//             Padding(
//               padding: const EdgeInsets.only(top: 2),
//               child: Text('메모: ${_ellipsis(toothNote, 80)}',
//                   style: const TextStyle(fontSize: 12, color: Colors.black87)),
//             ),
//         ],
//       ),
//     );
//   }
// }
//
// class _ToothPreviewLarge extends StatelessWidget {
//   final int fdi;
//   final double size;
//   const _ToothPreviewLarge({super.key, required this.fdi, required this.size});
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
//     final spec = p.getSpecRead(fdi);
//
//     final Map<String, _SurfaceFill> fill = {
//       for (final s in kToothSurfaces) s: _SurfaceFill.none,
//     };
//     if (spec != null) {
//       for (final s in kToothSurfaces) {
//         final list = spec.surface[s]!['fillings']!;
//         final hasCaries = list.any(_isCariesThree);
//         if (hasCaries) {
//           fill[s] = _SurfaceFill.cariesRed;
//         } else if (list.isNotEmpty) {
//           fill[s] = _SurfaceFill.fillingBlue;
//         }
//       }
//     }
//
//     final bool ringCrown =
//         (spec?.global['crown'] ?? const <String>[]).isNotEmpty;
//     final bool markStatusMissing =
//     (spec?.global['status'] ?? const <String>[])
//         .map((e) => e.toUpperCase())
//         .any((c) => c == 'MIS' || c.startsWith('MIS') || c == 'MAM' || c == 'MPM' || c == 'EXT' || c == 'SOX' || c == 'MJA');
//     final bool markRootImplant =
//     (spec?.global['root'] ?? const <String>[])
//         .map((e) => e.toUpperCase())
//         .any((c) => c == 'IPX' || c.startsWith('IPX'));
//
//     bool markDenture = false, markAbut = false, markPontic = false;
//     for (final sp in p.spans) {
//       if (!sp.teeth.contains(fdi)) continue;
//       if (sp.type == DentalSpanType.dentureOrtho) {
//         markDenture = true;
//       } else {
//         if (sp.abutments.contains(fdi)) markAbut = true;
//         if (sp.pontics.contains(fdi))   markPontic = true;
//       }
//     }
//
//     bool hasAnyInput = false;
//     if (spec != null) {
//       for (final s in kToothSurfaces) {
//         final f = (spec.surface[s]?['fillings'] ?? const <String>[]);
//         final pr = (spec.surface[s]?['periodontium'] ?? const <String>[]);
//         if (f.isNotEmpty || pr.isNotEmpty) { hasAnyInput = true; break; }
//       }
//       if (!hasAnyInput) {
//         for (final g in const ['bite','crown','root','status','position','crown pathology']) {
//           if ((spec.global[g] ?? const <String>[]).isNotEmpty) { hasAnyInput = true; break; }
//         }
//       }
//       if (!hasAnyInput) {
//         if ((spec.toothNote ?? '').trim().isNotEmpty ||
//             spec.surfaceNote.values.any((v) => v.trim().isNotEmpty)) {
//           hasAnyInput = true;
//         }
//       }
//     }
//
//     final hasSurfacePaint = fill.values.any((f) => f != _SurfaceFill.none);
//     final hasBlueRing   = ringCrown || markAbut;
//     final hasBlueLines  = markPontic || markStatusMissing || markRootImplant;
//     final hasOwnVisual  = hasSurfacePaint || hasBlueRing || hasBlueLines || markDenture;
//     final highlightAny  = hasAnyInput && !hasOwnVisual;
//
//     return Column(
//       children: [
//         Text('$fdi', style: const TextStyle(fontWeight: FontWeight.w700)),
//         const SizedBox(height: 6),
//         SizedBox(
//           width: size,
//           height: size,
//           child: CustomPaint(
//             painter: _FiveSurfacePainter(
//               mesialOnRight: _mesialOnRight,
//               fill: fill,
//               abut: markAbut,
//               pontic: markPontic,
//               ringCrown: ringCrown,
//               twoHorizontal: markStatusMissing,
//               oneVertical: markRootImplant,
//               highlightAny: highlightAny,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
//
// typedef _QuickPick = void Function(String category, String code);
//
// class _FrequentlyUsedPanel extends StatelessWidget {
//   final _EditMode mode;
//   final _QuickPick onPick;
//   const _FrequentlyUsedPanel({super.key, required this.mode, required this.onPick});
//
//   @override
//   Widget build(BuildContext context) {
//     final groups = (mode == _EditMode.surface) ? kFavSurfaceGroups() : kFavGlobalGroups();
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text('Frequently Used', style: TextStyle(fontWeight: FontWeight.w700)),
//         const SizedBox(height: 6),
//         ...groups.entries.map((e) => _groupChips(context, e.key, e.value)),
//       ],
//     );
//   }
//
//   Widget _groupChips(BuildContext context, String category, List<String> codes) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 8),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(category, style: const TextStyle(fontSize: 12, color: Colors.black54)),
//           const SizedBox(height: 4),
//           Wrap(
//             spacing: 8, runSpacing: 6,
//             children: codes.map((code) {
//               final label = _labelFor(context, category, code) ?? '';
//               final text = label.isEmpty ? code : '$code — $label';
//               return ActionChip(
//                 label: Text(text),
//                 onPressed: () => onPick(category, code),
//               );
//             }).toList(),
//           ),
//         ],
//       ),
//     );
//   }
//
//   /// 코드 → 시스템 텍스트 조회 (카테고리 트리 BFS)
//   String? _labelFor(BuildContext context, String category, String code) {
//     final p = context.read<DentalDataProvider>();
//     final want = code.toUpperCase();
//     final visited = <String>{};
//     List<CodeNode> childrenOf(List<String> prefix) => p.listChildren(category, prefix);
//
//     String? search(List<String> prefix) {
//       final key = '${prefix.join(">")}';
//       if (!visited.add(key)) return null;
//
//       for (final n in childrenOf(prefix)) {
//         if (n.code.toUpperCase() == want) return n.label;
//         final lab = search([...prefix, n.code]);
//         if (lab != null) return lab;
//       }
//       return null;
//     }
//
//     try {
//       return search(const []);
//     } catch (_) {
//       return null;
//     }
//   }
// }

// import 'dart:math' show min, max;
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// import '../providers/dental_data_provider.dart';
// import '../data/codes_635.dart';
// import '../data/surface_fill.dart';
// import 'tree_selector_screen.dart';
// import '../models/code_node.dart';
//
//
// /// ─────────────────────────────────────────────────────────────────
// /// 공통: 충치 3종 판단
// bool _isCariesThree(String c) {
//   final u = c.toUpperCase();
//   return u == 'CAR' || u == 'ACA' || u == 'CCA';
// }
//
// /// ─────────────────────────────────────────────────────────────────
// /// 즐겨찾기(스프레드시트 재분류 반영)
// Map<String, List<String>> kFavSurfaceGroups() => {
//   'Fillings': ['CAR','UIF','CAV','AMF','TCF','COF','FIS','GOI','POI'],
//   // Periodontium 자주 쓰는 항목이 있으면 여기에 추가
// };
//
// Map<String, List<String>> kFavGlobalGroups() => {
//   // CAR는 Fillings로, ROV는 Status로, IPX는 Root로 분류
//   'Status': ['INT','MAM','MPM','CFR','IMX','IMV','ERU','ROV'],
//   'Root'  : ['RFX','IPX'],
//   'Crowns': ['UIC','MTC','GOC','MEC','TCC','MCC','POC','TEC'],
// };
//
// Set<String> favCodesUpperForMode(_EditMode mode) {
//   final m = (mode == _EditMode.surface) ? kFavSurfaceGroups() : kFavGlobalGroups();
//   return m.values.expand((e) => e).map((c) => c.toUpperCase()).toSet();
// }
//
// /// ─────────────────────────────────────────────────────────────────
// /// 사분면(축소) 화면: 핀치 줌 제거, 치아 탭 시 단일치아 에디터로 이동
// class QuadrantZoomScreen extends StatelessWidget {
//   final String title;
//   final bool isUpper;        // 상악 true
//   final bool isPermanent;    // 라벨/표시용
//   final List<int> teeth;     // 예: [18..11], [21..28] 등
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
//   Widget build(BuildContext context) {
//     final numbersOnTop = isUpper;
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(title),
//         actions: [
//           IconButton(
//             tooltip: '도움말',
//             icon: const Icon(Icons.help_outline),
//             onPressed: () => _showHelp(context),
//           ),
//         ],
//       ),
//       body: LayoutBuilder(
//         builder: (context, c) {
//           const spacing = 12.0;
//           final n = teeth.length; // 8 or 5
//           final tile = ((c.maxWidth - spacing * (n - 1)) / n).clamp(28.0, 90.0);
//           final rowWidth = n * tile + (n - 1) * spacing;
//
//           return Stack(
//             children: [
//               // 치아 행
//               Center(
//                 child: SizedBox(
//                   width: rowWidth,
//                   child: Stack(
//                     children: [
//                       Positioned.fill(
//                         child: _RowDentureOverlayPainterWidget(
//                           teeth: teeth, tile: tile, spacing: spacing,
//                         ),
//                       ),
//                       Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           for (final fdi in teeth) ...[
//                             SizedBox(
//                               width: tile,
//                               child: Column(
//                                 mainAxisSize: MainAxisSize.min,
//                                 children: [
//                                   if (numbersOnTop)
//                                     GestureDetector(
//                                       behavior: HitTestBehavior.opaque,
//                                       onLongPress: () => _openOneToothEditor(context, fdi),
//                                       child: _ToothNumber(fdi, tile),
//                                     ),
//                                   _BigToothTileSimple(
//                                     fdi: fdi,
//                                     size: tile,
//                                     onOpenEditor: _openOneToothEditor,
//                                   ),
//                                   if (!numbersOnTop)
//                                     GestureDetector(
//                                       behavior: HitTestBehavior.opaque,
//                                       onLongPress: () => _openOneToothEditor(context, fdi),
//                                       child: _ToothNumber(fdi, tile),
//                                     ),
//                                 ],
//                               ),
//                             ),
//                             if (fdi != teeth.last) const SizedBox(width: spacing),
//                           ],
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//
//               // 우상단 요약 패널(기록 있으면 표시)
//               Positioned(
//                 top: 4,
//                 right: 4,
//                 child: ConstrainedBox(
//                   constraints: const BoxConstraints(maxWidth: 280),
//                   child: _QuadrantInfoOverlay(teeth: teeth),
//                 ),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }
//
//   void _showHelp(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       showDragHandle: true,
//       builder: (_) => const Padding(
//         padding: EdgeInsets.fromLTRB(16, 12, 16, 16),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('화면 사용법', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
//             SizedBox(height: 8),
//             Text("• 치아 한 번 탭: 단일치아 편집 화면으로 이동합니다."),
//             Text("• 숫자(치아 번호) 길게 누르기: 동일하게 단일치아 편집 화면으로 이동합니다."),
//             SizedBox(height: 12),
//             Align(
//               alignment: Alignment.centerRight,
//               child: Text('닫으려면 바깥을 탭하세요', style: TextStyle(color: Colors.black54)),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Future<void> _openOneToothEditor(BuildContext context, int fdi) async {
//     // await Navigator.of(context).push(
//     //   MaterialPageRoute(builder: (_) => SingleToothEditorScreen(fdi: fdi)),
//     // );
//     await Navigator.of(context).push(
//       MaterialPageRoute(builder: (_) => TreeSelectorScreen(fdi: fdi)),
//     );
//   }
// }
//
// /// ─────────────────────────────────────────────────────────────────
// /// 우상단 요약 패널: 입력 있는 치아/스팬만 요약
// class _QuadrantInfoOverlay extends StatelessWidget {
//   final List<int> teeth;
//   const _QuadrantInfoOverlay({required this.teeth});
//
//   @override
//   Widget build(BuildContext context) {
//     final p = context.watch<DentalDataProvider>();
//     final specs = <int, _SpecView>{
//       for (final t in teeth) t: _SpecView(t, p.getSpecRead(t))
//     };
//
//     final items = specs.entries.where((e) {
//       final s = e.value;
//       final anyGlobal = s.global.values.any((lst) => lst.isNotEmpty);
//       final anySurf = kToothSurfaces.any((x) {
//         final m = s.surface[x];
//         if (m == null) return false;
//         return (m['fillings'] ?? const <String>[]).isNotEmpty ||
//             (m['periodontium'] ?? const <String>[]).isNotEmpty;
//       });
//       final anyNote = s.toothNote.isNotEmpty ||
//           s.surfaceNote.values.any((v) => v.trim().isNotEmpty);
//       return anyGlobal || anySurf || anyNote;
//     }).toList()
//       ..sort((a,b) => a.key.compareTo(b.key));
//
//     final spans = p.spans.where((sp) => sp.teeth.any(teeth.contains)).toList();
//
//     if (items.isEmpty && spans.isEmpty) return const SizedBox.shrink();
//
//     return Card(
//       elevation: 2,
//       margin: const EdgeInsets.only(top: 4, right: 4),
//       child: Padding(
//         padding: const EdgeInsets.fromLTRB(12, 8, 12, 10),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text('요약', style: TextStyle(fontWeight: FontWeight.w700)),
//             const SizedBox(height: 6),
//
//             if (spans.isNotEmpty) ...[
//               Row(
//                 children: [
//                   const Icon(Icons.linear_scale, size: 16),
//                   const SizedBox(width: 6),
//                   Text('스팬 ${spans.length}개',
//                       style: const TextStyle(fontWeight: FontWeight.w600)),
//                 ],
//               ),
//               const SizedBox(height: 4),
//               ...spans.map((sp) => Padding(
//                 padding: const EdgeInsets.only(bottom: 2),
//                 child: Text(_spanLine(sp, teeth), style: const TextStyle(fontSize: 12)),
//               )),
//               const Divider(),
//             ],
//
//             ...items.map((e) {
//               final fdi = e.key;
//               final s = e.value;
//               final globals = _pickGlobalsOneLine(s.global);
//               final surfaces = _pickSurfacesOneLine(s.surface);
//               final note = s.toothNote;
//
//               return Padding(
//                 padding: const EdgeInsets.only(bottom: 8),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text('[$fdi]', style: const TextStyle(fontWeight: FontWeight.w700)),
//                     if (globals.isNotEmpty)
//                       Text('전역: $globals', style: const TextStyle(fontSize: 12)),
//                     if (surfaces.isNotEmpty)
//                       Text('표면: $surfaces', style: const TextStyle(fontSize: 12)),
//                     if (note.isNotEmpty)
//                       Text('메모: ${_ellipsis(note, 60)}',
//                           style: const TextStyle(fontSize: 12, color: Colors.black87)),
//                   ],
//                 ),
//               );
//             }),
//           ],
//         ),
//       ),
//     );
//   }
//
//   String _spanLine(DentalSpan sp, List<int> visible) {
//     final typ = sp.type == DentalSpanType.dentureOrtho ? 'Denture/Ortho' : 'Bridge';
//     final range = _fmtSpanTeeth(sp.teeth.where(visible.contains));
//     String ap = '';
//     if (sp.type != DentalSpanType.dentureOrtho) {
//       ap = ' · Abut:${_fmtSpanTeeth(sp.abutments)} · Pontic:${_fmtSpanTeeth(sp.pontics)}';
//     }
//     return '$typ  $range$ap';
//   }
//
//   String _fmtSpanTeeth(Iterable<int> it) {
//     final ts = it.toList()..sort();
//     if (ts.isEmpty) return '-';
//     final buf = <String>[];
//     int start = ts.first, prev = ts.first;
//     for (int i = 1; i < ts.length; i++) {
//       if (ts[i] == prev + 1) {
//         prev = ts[i];
//       } else {
//         buf.add(start == prev ? '$start' : '$start–$prev');
//         start = prev = ts[i];
//       }
//     }
//     buf.add(start == prev ? '$start' : '$start–$prev');
//     return buf.join(', ');
//   }
//
//   String _pickGlobalsOneLine(Map<String, List<String>> g) {
//     const keys = ['bite','position','status','root','crown','crown pathology'];
//     final parts = <String>[];
//     for (final k in keys) {
//       final v = g[k] ?? const <String>[];
//       if (v.isNotEmpty) parts.add('$k:${v.join("/")}');
//     }
//     return parts.join(' · ');
//   }
//
//   String _pickSurfacesOneLine(Map<String, Map<String, List<String>>> m) {
//     final parts = <String>[];
//     for (final s in kToothSurfaces) {
//       final f = (m[s]?['fillings'] ?? const <String>[]) as List<String>;
//       final p = (m[s]?['periodontium'] ?? const <String>[]) as List<String>;
//       if (f.isEmpty && p.isEmpty) continue;
//       final join = [
//         if (f.isNotEmpty) 'F:${f.join("/")}',
//         if (p.isNotEmpty) 'P:${p.join("/")}',
//       ].join(',');
//       parts.add('$s($join)');
//     }
//     return parts.join(' · ');
//   }
//
//   String _ellipsis(String s, int n) => s.length <= n ? s : '${s.substring(0, n)}…';
// }
//
// /// ─────────────────────────────────────────────────────────────────
// /// 덴쳐 스팬 오버레이(축소 행 전체에 파란 캡슐)
// class _RowDentureOverlayPainterWidget extends StatelessWidget {
//   final List<int> teeth;
//   final double tile;
//   final double spacing;
//   const _RowDentureOverlayPainterWidget({
//     required this.teeth,
//     required this.tile,
//     required this.spacing,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     final p = context.watch<DentalDataProvider>();
//     final spans = p.spans.where((sp) => sp.type == DentalSpanType.dentureOrtho).toList();
//     return CustomPaint(
//       painter: _RowDentureOverlayPainter(
//         teeth: teeth,
//         tile: tile,
//         spacing: spacing,
//         spans: spans,
//       ),
//     );
//   }
// }
//
// class _RowDentureOverlayPainter extends CustomPainter {
//   final List<int> teeth;
//   final double tile;
//   final double spacing;
//   final List<DentalSpan> spans;
//   _RowDentureOverlayPainter({
//     required this.teeth,
//     required this.tile,
//     required this.spacing,
//     required this.spans,
//   });
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     if (teeth.isEmpty) return;
//
//     final rects = <int, Rect>{};
//     for (int i = 0; i < teeth.length; i++) {
//       final x = i * (tile + spacing);
//       rects[teeth[i]] = Rect.fromLTWH(x, 0, tile, tile);
//     }
//
//     final paintBlue = Paint()
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = (tile * .12).clamp(1.6, 3.2)
//       ..color = Colors.blueAccent;
//
//     for (final sp in spans) {
//       final inside = teeth.where(sp.teeth.contains).toList();
//       if (inside.isEmpty) continue;
//
//       // 연속 클러스터
//       final clusters = <List<int>>[];
//       List<int> cur = [];
//       for (int i = 0; i < inside.length; i++) {
//         if (cur.isEmpty) {
//           cur = [inside[i]];
//         } else {
//           final prevIdx = teeth.indexOf(cur.last);
//           final thisIdx = teeth.indexOf(inside[i]);
//           if (thisIdx == prevIdx + 1) {
//             cur.add(inside[i]);
//           } else {
//             clusters.add(cur);
//             cur = [inside[i]];
//           }
//         }
//       }
//       if (cur.isNotEmpty) clusters.add(cur);
//
//       for (final cluster in clusters) {
//         final left = rects[cluster.first]!;
//         final right = rects[cluster.last]!;
//         Rect union = Rect.fromLTRB(left.left, left.top, right.right, right.bottom);
//
//         final marginX = tile * .18, marginY = tile * .12;
//         final rr = RRect.fromRectAndRadius(
//           union.inflate(marginX).deflate(0).inflate(0).deflate(-marginY),
//           Radius.circular(union.height),
//         );
//         canvas.drawRRect(rr, paintBlue);
//       }
//     }
//   }
//
//   @override
//   bool shouldRepaint(covariant _RowDentureOverlayPainter old) =>
//       old.teeth != teeth || old.tile != tile || old.spacing != spacing || old.spans != spans;
// }
//
// /// ─────────────────────────────────────────────────────────────────
// /// 번호/그리기(축소)
// class _ToothNumber extends StatelessWidget {
//   final int fdi;
//   final double size;
//   const _ToothNumber(this.fdi, this.size);
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: size * .6,
//       child: Center(
//         child: Text('$fdi', style: const TextStyle(fontWeight: FontWeight.w700)),
//       ),
//     );
//   }
// }
//
// /// 축소 그리기 + 탭 시 단일치아 에디터로 이동
// class _BigToothTileSimple extends StatelessWidget {
//   final int fdi;
//   final double size;
//   final void Function(BuildContext, int) onOpenEditor;
//
//   const _BigToothTileSimple({
//     required this.fdi,
//     required this.size,
//     required this.onOpenEditor,
//   });
//
//   bool get _mesialOnRight {
//     final q = fdi ~/ 10;
//     if (q == 1 || q == 4 || q == 5 || q == 8) return true;  // 우측군
//     if (q == 2 || q == 3 || q == 6 || q == 7) return false; // 좌측군
//     return true;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final p = context.watch<DentalDataProvider>();
//     final spec = p.getSpecRead(fdi);
//
//     // 면 채우기
//     final Map<String, _SurfaceFill> fill = {
//       for (final s in kToothSurfaces) s: _SurfaceFill.none,
//     };
//     if (spec != null) {
//       for (final s in kToothSurfaces) {
//         final list = spec.surface[s]!['fillings']!;
//         final hasCaries = list.any(_isCariesThree);
//         if (hasCaries) {
//           fill[s] = _SurfaceFill.cariesRed;
//         } else if (list.isNotEmpty) {
//           fill[s] = _SurfaceFill.fillingBlue;
//         }
//       }
//     }
//
//     final bool ringCrown =
//         (spec?.global['crown'] ?? const <String>[]).isNotEmpty;
//     final bool markStatusMissing =
//     (spec?.global['status'] ?? const <String>[])
//         .map((e) => e.toUpperCase())
//         .any((c) => c == 'MIS' || c.startsWith('MIS') || c == 'MAM' || c == 'MPM' || c == 'EXT' || c == 'SOX' || c == 'MJA');
//     final bool markRootImplant =
//     (spec?.global['root'] ?? const <String>[])
//         .map((e) => e.toUpperCase())
//         .any((c) => c == 'IPX' || c.startsWith('IPX'));
//
//     bool markDenture = false, markAbut = false, markPontic = false;
//     for (final sp in p.spans) {
//       if (!sp.teeth.contains(fdi)) continue;
//       if (sp.type == DentalSpanType.dentureOrtho) {
//         markDenture = true;
//       } else {
//         if (sp.abutments.contains(fdi)) markAbut = true;
//         if (sp.pontics.contains(fdi))   markPontic = true;
//       }
//     }
//
//     bool hasAnyInput = false;
//     if (spec != null) {
//       for (final s in kToothSurfaces) {
//         final f = (spec.surface[s]?['fillings'] ?? const <String>[]);
//         final pr = (spec.surface[s]?['periodontium'] ?? const <String>[]);
//         if (f.isNotEmpty || pr.isNotEmpty) { hasAnyInput = true; break; }
//       }
//       if (!hasAnyInput) {
//         for (final g in const ['bite','crown','root','status','position','crown pathology']) {
//           if ((spec.global[g] ?? const <String>[]).isNotEmpty) { hasAnyInput = true; break; }
//         }
//       }
//       if (!hasAnyInput) {
//         if ((spec.toothNote ?? '').trim().isNotEmpty ||
//             spec.surfaceNote.values.any((v) => v.trim().isNotEmpty)) {
//           hasAnyInput = true;
//         }
//       }
//     }
//
//     final hasSurfacePaint = fill.values.any((f) => f != _SurfaceFill.none);
//     final hasBlueRing   = ringCrown || markAbut;
//     final hasBlueLines  = markPontic || markStatusMissing || markRootImplant;
//     final hasOwnVisual  = hasSurfacePaint || hasBlueRing || hasBlueLines || markDenture;
//     final highlightAny  = hasAnyInput && !hasOwnVisual;
//
//     return GestureDetector(
//       behavior: HitTestBehavior.opaque,
//       onTap: () => onOpenEditor(context, fdi),
//       onLongPress: () => onOpenEditor(context, fdi),
//       child: CustomPaint(
//         size: Size.square(size),
//         painter: _FiveSurfacePainter(
//           mesialOnRight: _mesialOnRight,
//           fill: fill,
//           abut: markAbut,
//           pontic: markPontic,
//           ringCrown: ringCrown,
//           twoHorizontal: markStatusMissing,
//           oneVertical: markRootImplant,
//           highlightAny: highlightAny,
//         ),
//       ),
//     );
//   }
// }
//
// /// ─────────────────────────────────────────────────────────────────
// /// 단일치아 편집 화면: Global / Surface(OMDBL 다중선택)
// class SingleToothEditorScreen extends StatefulWidget {
//   final int fdi;
//   const SingleToothEditorScreen({super.key, required this.fdi});
//
//   @override
//   State<SingleToothEditorScreen> createState() => _SingleToothEditorScreenState();
// }
//
// enum _EditMode { global, surface }
//
// class _SingleToothEditorScreenState extends State<SingleToothEditorScreen> {
//   _EditMode mode = _EditMode.global;
//
//   final _pickerKey = GlobalKey<_InterpolPickerInlineState>();
//
//   // Surface 모드: OMDBL 다중 선택
//   final Set<String> _surfaces = {'O','M','D','B','L'};
//   final Set<String> _pickedSurfaces = {'O'}; // 기본값
//
//   bool _canSaveCode = false;
//
//   CodeSelection? _quickSel; // 'Frequently Used' 칩으로 고른 임시 선택 (저장 전)
//
//   // 메모
//   late final TextEditingController _noteCtrl;
//   late String _initialNoteForGlobal;
//   final Map<String, String> _initialSurfaceNotes = {};
//
//   @override
//   void initState() {
//     super.initState();
//     final p = context.read<DentalDataProvider>();
//     final spec = p.getSpecRead(widget.fdi);
//
//     _initialNoteForGlobal = spec?.toothNote ?? '';
//     _noteCtrl = TextEditingController(text: _initialNoteForGlobal);
//
//     for (final s in _surfaces) {
//       final note = spec?.surfaceNote[s] ?? '';
//       _initialSurfaceNotes[s] = note;
//     }
//
//     WidgetsBinding.instance.addPostFrameCallback((_) => p.loadCodeTreeOnce());
//   }
//
//   @override
//   void dispose() {
//     _noteCtrl.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final p = context.watch<DentalDataProvider>();
//     final media = MediaQuery.of(context);
//     final kb = media.viewInsets.bottom;
//
//     _syncNoteTextForMode(p);
//
//     // 미리보기 크기: 화면폭의 56%~220 사이
//     final previewSize = min(media.size.width * 0.56, 220.0);
//
//     // 즐겨찾기 코드(대문자) 집합 — 아래 인터폴 선택에서 제외할 용도
//     final exclude = favCodesUpperForMode(mode);
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Tooth ${widget.fdi}'),
//         actions: [
//           IconButton(icon: const Icon(Icons.help_outline), onPressed: () => _showHelp(context)),
//         ],
//       ),
//       body: SafeArea(
//         child: Padding(
//           padding: EdgeInsets.fromLTRB(16, 12, 16, max(12, kb)),
//           // 세로 스크롤 하나로 모두 감싸 오버플로우 방지
//           child: ListView(
//             children: [
//               // 모드 토글
//               SegmentedButton<_EditMode>(
//                 segments: const [
//                   ButtonSegment(value: _EditMode.global,  icon: Icon(Icons.public),  label: Text('Global')),
//                   ButtonSegment(value: _EditMode.surface, icon: Icon(Icons.grid_on), label: Text('Surface(OMDBL)')),
//                 ],
//                 selected: {mode},
//                 onSelectionChanged: (s) => setState(() => mode = s.first),
//               ),
//               const SizedBox(height: 12),
//
//               if (mode == _EditMode.surface) ...[
//                 Wrap(
//                   spacing: 8,
//                   children: _surfaces.map((s) {
//                     final selected = _pickedSurfaces.contains(s);
//                     return FilterChip(
//                       label: Text(s),
//                       selected: selected,
//                       onSelected: (v) => setState(() {
//                         if (v) _pickedSurfaces.add(s);
//                         else if (_pickedSurfaces.length > 1) _pickedSurfaces.remove(s);
//                       }),
//                     );
//                   }).toList(),
//                 ),
//                 const SizedBox(height: 8),
//                 const Text('※ Surface 선택은 여러 개 동시 적용됩니다. (예: MOD)'),
//                 const SizedBox(height: 12),
//               ],
//
//               _FrequentlyUsedPanel(
//                 mode: mode,
//                 onPick: (category, code) {
//                   setState(() {
//                     _quickSel = CodeSelection(category: category, path: [code.toUpperCase()]); // 대문자화
//                     _canSaveCode = true; // 저장 버튼 활성화를 위해
//                   });
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(content: Text('선택됨: $category · $code — 저장을 눌러 적용됩니다.')),
//                   );
//                 },
//               ),
//               const SizedBox(height: 8),
//
//               // 저장 전 선택까지 반영되는 "라이브 미리보기"
//               Center(
//                 child: _ToothPreviewLive(
//                   fdi: widget.fdi,
//                   size: previewSize,
//                   mode: mode,
//                   pickedSurfaces: _pickedSurfaces,
//                   pendingSel: _quickSel ?? _pickerKey.currentState?.currentSelection,
//                   pendingNote: _noteCtrl.text,
//                 ),
//               ),
//               const SizedBox(height: 8),
//
//               // 현재 저장 상태 요약(저장된 값 기준)
//               _CurrentStateInlineSummary(fdi: widget.fdi),
//               const SizedBox(height: 12),
//
//               // Interpol 선택(트리 모드 + 즐겨찾기 중복 제거)
//               _InterpolPickerInline(
//                 key: _pickerKey,
//                 title: mode == _EditMode.global ? 'Interpol 코드 선택 (전역)' : 'Interpol 코드 선택 (표면)',
//                 categoryFilter: (cats) {
//                   if (mode == _EditMode.global) {
//                     // Global: 표면/스팬/교정류 제외
//                     return cats.where((c) {
//                       final u = c.toLowerCase();
//                       final isSurface = u == 'fillings' || u == 'periodontium';
//                       final isSpan = u.contains('bridge');
//                       final isDentOrtho = u.contains('denture') || u.contains('orthodont');
//                       return !(isSurface || isSpan || isDentOrtho);
//                     }).toList();
//                   } else {
//                     // Surface: Fillings/Periodontium만
//                     return cats.where((c) => c == 'Fillings' || c == 'Periodontium').toList();
//                   }
//                 },
//                 onConfirm: (_) {},
//                 onHasCodeChanged: (_) => setState(() => _canSaveCode = _),
//                 excludeCodes: exclude, // 즐겨찾기와 중복되는 코드 숨김
//               ),
//               const SizedBox(height: 12),
//
//               // 메모
//               Text(mode == _EditMode.global ? '자연어 메모 (전역)' : '자연어 메모 (선택된 표면 모두에 적용)'),
//               const SizedBox(height: 6),
//               TextField(
//                 controller: _noteCtrl,
//                 onChanged: (_) => setState(() {}), // 미리보기 하이라이트 즉시 반영
//                 maxLines: 3,
//                 keyboardType: TextInputType.multiline,
//                 textInputAction: TextInputAction.newline,
//                 decoration: const InputDecoration(
//                   border: OutlineInputBorder(),
//                   hintText: '예: Global - 교합 개방감 / Surface - MOD 수복 예정 등',
//                 ),
//               ),
//               const SizedBox(height: 12),
//
//               // 버튼들: 줄바꿈 안전
//               OverflowBar(
//                 alignment: MainAxisAlignment.end,
//                 spacing: 8,
//                 children: [
//                   TextButton.icon(
//                     icon: const Icon(Icons.delete_outline),
//                     label: const Text('기록 삭제'),
//                     onPressed: () {
//                       if (mode == _EditMode.global) {
//                         context.read<DentalDataProvider>().clearGlobalAll635(widget.fdi);
//                         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('전역 기록을 삭제했습니다.')));
//                       } else {
//                         for (final s in _pickedSurfaces) {
//                           context.read<DentalDataProvider>().clearSurface635(widget.fdi, s);
//                         }
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           SnackBar(content: Text('표면(${_pickedSurfaces.join(",")}) 기록을 삭제했습니다.')),
//                         );
//                       }
//                     },
//                   ),
//                   TextButton(onPressed: () => Navigator.pop(context), child: const Text('취소')),
//                   FilledButton(
//                     onPressed: _canPressSave(p) ? () => _handleSave(p) : null,
//                     child: const Text('저장'),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   void _showHelp(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       showDragHandle: true,
//       builder: (_) => const Padding(
//         padding: EdgeInsets.fromLTRB(16, 12, 16, 16),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('단일치아 편집 도움말', style: TextStyle(fontWeight: FontWeight.w700)),
//             SizedBox(height: 8),
//             Text('• Global: OMDBL 선택 없이 전역 코드만 고릅니다.'),
//             Text('• Surface: OMDBL 여러 표면을 동시에 선택하고, 선택한 코드가 한 번에 적용됩니다.'),
//             Text('• 메모: Global은 치아 전역 메모, Surface는 선택된 표면 모두에 동일 메모가 저장됩니다.'),
//             SizedBox(height: 8),
//             Text('• 삭제: 현재 모드에 따라 전역 전체 또는 선택 표면들의 기록을 삭제합니다.'),
//           ],
//         ),
//       ),
//     );
//   }
//
//   // 모드에 따라 메모 텍스트 동기화
//   void _syncNoteTextForMode(DentalDataProvider p) {
//     final spec = p.getSpecRead(widget.fdi);
//     if (mode == _EditMode.global) {
//       final want = spec?.toothNote ?? '';
//       if (_noteCtrl.text != want) {
//         _noteCtrl.text = want;
//         _noteCtrl.selection = TextSelection.fromPosition(
//           TextPosition(offset: _noteCtrl.text.length),
//         );
//       }
//     } else {
//       final notes = _pickedSurfaces.map((s) => spec?.surfaceNote[s]?.trim() ?? '').toSet();
//       final String want = (notes.length == 1) ? notes.first : '';
//       if (_noteCtrl.text != want) {
//         _noteCtrl.text = want;
//         _noteCtrl.selection = TextSelection.fromPosition(
//           TextPosition(offset: _noteCtrl.text.length),
//         );
//       }
//     }
//   }
//
//   bool _canPressSave(DentalDataProvider p) {
//     if (mode == _EditMode.global) {
//       final noteChanged = (_noteCtrl.text.trim() != _initialNoteForGlobal.trim());
//       final hasPendingCode = _canSaveCode || (_quickSel != null);
//       return hasPendingCode || noteChanged;
//     } else {
//       final note = _noteCtrl.text.trim();
//       final anyNoteChanged = _pickedSurfaces.any((s) => (note != (_initialSurfaceNotes[s]?.trim() ?? '')));
//       final hasPendingCode = _canSaveCode || (_quickSel != null);
//       return hasPendingCode || anyNoteChanged;
//     }
//   }
//
//   void _handleSave(DentalDataProvider p) {
//     final sel = _pickerKey.currentState?.currentSelection ?? _quickSel; // ← 우선
//     final note = _noteCtrl.text.trim();
//
//     bool savedCode = false, savedNote = false;
//
//     if (mode == _EditMode.global) {
//       if (sel != null) { applyInterpolToGlobal635WithToggles(context, widget.fdi, sel); savedCode = true; }
//       if (note != _initialNoteForGlobal.trim()) { p.setToothNote635(widget.fdi, note); savedNote = true; _initialNoteForGlobal = note; }
//     } else {
//       if (sel != null) {
//         for (final s in _pickedSurfaces) { applyInterpolToSurface635WithToggles(context, widget.fdi, s, sel); }
//         savedCode = true;
//       }
//       for (final s in _pickedSurfaces) {
//         if (note != (_initialSurfaceNotes[s]?.trim() ?? '')) { p.setSurfaceNote635(widget.fdi, s, note); _initialSurfaceNotes[s] = note; savedNote = true; }
//       }
//     }
//
//     _quickSel = null; // 임시 선택 초기화
//     Navigator.pop(context);
//     final msg = (savedCode && savedNote) ? '코드와 메모가 저장되었습니다.' : (savedCode ? '코드가 저장되었습니다.' : '메모만 저장되었습니다.');
//     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
//   }
// }
//
// /// 저장된 spec + (선택 중인 Interpol 코드/표면/메모)을 합성해 그리는 라이브 미리보기
// class _ToothPreviewLive extends StatelessWidget {
//   final int fdi;
//   final double size;
//   final _EditMode mode;
//   final Set<String> pickedSurfaces;      // Surface 모드에서 동시 적용할 OMDBL
//   final CodeSelection? pendingSel;       // _pickerKey.currentState?.currentSelection
//   final String pendingNote;              // 메모 입력창 현재 값
//
//   const _ToothPreviewLive({
//     super.key,
//     required this.fdi,
//     required this.size,
//     required this.mode,
//     required this.pickedSurfaces,
//     required this.pendingSel,
//     required this.pendingNote,
//   });
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
//     final spec = p.getSpecRead(fdi);
//
//     // 1) 저장된 상태로부터 기본 표시 계산
//     final Map<String, _SurfaceFill> fill = { for (final s in kToothSurfaces) s: _SurfaceFill.none };
//     if (spec != null) {
//       for (final s in kToothSurfaces) {
//         final list = spec.surface[s]!['fillings']!;
//         final hasCaries = list.any(_isCariesThree);
//         if (hasCaries)      fill[s] = _SurfaceFill.cariesRed;
//         else if (list.isNotEmpty) fill[s] = _SurfaceFill.fillingBlue;
//       }
//     }
//
//     bool ringCrown = (spec?.global['crown'] ?? const <String>[]).isNotEmpty;
//     bool twoHorizontal = (spec?.global['status'] ?? const <String>[])
//         .map((e)=>e.toUpperCase())
//         .any((c)=> c=='MIS' || c.startsWith('MIS') || c=='MAM' || c=='MPM' || c=='EXT' || c=='SOX' || c=='MJA');
//     bool oneVertical = (spec?.global['root'] ?? const <String>[])
//         .map((e)=>e.toUpperCase())
//         .any((c)=> c=='IPX' || c.startsWith('IPX'));
//
//     bool markDenture=false, markAbut=false, markPontic=false;
//     for (final sp in p.spans) {
//       if (!sp.teeth.contains(fdi)) continue;
//       if (sp.type == DentalSpanType.dentureOrtho) markDenture = true;
//       else {
//         if (sp.abutments.contains(fdi)) markAbut = true;
//         if (sp.pontics.contains(fdi))   markPontic = true;
//       }
//     }
//
//     // 2) “선택 중”인 코드로 오버레이(미리보기 전용, 실제 저장 아님)
//     if (pendingSel != null) {
//       if (mode == _EditMode.surface) {
//         // Fillings/Periodontium만 허용
//         if (pendingSel!.category == 'Fillings') {
//           final last = pendingSel!.path.isNotEmpty ? pendingSel!.path.last : null;
//           final isCar = last != null && _isCariesThree(last);
//           for (final s in pickedSurfaces) {
//             fill[s] = isCar ? _SurfaceFill.cariesRed : _SurfaceFill.fillingBlue;
//           }
//         } else if (pendingSel!.category == 'Periodontium') {
//           // Periodontium은 기존처럼 색 채움 없음(하이라이트만 영향)
//         }
//       } else {
//         // Global 미리보기: 그룹별 시각표시 반영
//         const cat2group = <String, String>{
//           'Bite and occlusion': 'bite',
//           'Tooth position'    : 'position',
//           'Status'            : 'status',
//           'Root'              : 'root',
//           'Crowns'            : 'crown',
//           'Crown pathology'   : 'crown pathology'
//         };
//         final code = pendingSel!.path.isNotEmpty ? pendingSel!.path.last : null;
//         final g = cat2group[pendingSel!.category];
//         if (code != null && g != null) {
//           if (g == 'crown') ringCrown = true;
//           if (g == 'status') twoHorizontal = (() {
//             final c = code.toUpperCase();
//             return c=='MIS' || c.startsWith('MIS') || c=='MAM' || c=='MPM' || c=='EXT' || c=='SOX' || c=='MJA';
//           })();
//           if (g == 'root')   oneVertical = (() {
//             final c = code.toUpperCase();
//             return c=='IPX' || c.startsWith('IPX');
//           })();
//         }
//       }
//     }
//
//     // 3) 하이라이트(보라색) 판단: 저장값 + “선택중” + 메모 입력 고려
//     bool anyGlobal = spec?.global.values.any((lst)=>lst.isNotEmpty) ?? false;
//     bool anySurface = false;
//     if (spec != null) {
//       for (final s in kToothSurfaces) {
//         final f = (spec.surface[s]?['fillings'] ?? const <String>[]);
//         final pr= (spec.surface[s]?['periodontium'] ?? const <String>[]);
//         if (f.isNotEmpty || pr.isNotEmpty) { anySurface = true; break; }
//       }
//     }
//     final bool anyNote =
//         ((spec?.toothNote ?? '').trim().isNotEmpty) ||
//             (((spec?.surfaceNote ?? const <String, String>{}).values)
//                 .any((v) => v.trim().isNotEmpty));
//
//     // “선택 중” 효과도 입력으로 간주
//     final hasPendingGlobal =
//     (mode==_EditMode.global && pendingSel!=null);
//     final hasPendingSurface =
//     (mode==_EditMode.surface && pendingSel!=null && pickedSurfaces.isNotEmpty);
//     final hasPendingNote = pendingNote.trim().isNotEmpty;
//
//     final hasAnyInput = anyGlobal || anySurface || anyNote
//         || hasPendingGlobal || hasPendingSurface || hasPendingNote;
//
//     final hasSurfacePaint = fill.values.any((f)=>f!=_SurfaceFill.none);
//     final hasBlueRing   = ringCrown || markAbut;
//     final hasBlueLines  = markPontic || twoHorizontal || oneVertical;
//     final hasOwnVisual  = hasSurfacePaint || hasBlueRing || hasBlueLines || markDenture;
//     final highlightAny  = hasAnyInput && !hasOwnVisual;
//
//     return Column(
//       children: [
//         Text('$fdi', style: const TextStyle(fontWeight: FontWeight.w700)),
//         const SizedBox(height: 6),
//         SizedBox(
//           width: size, height: size,
//           child: CustomPaint(
//             painter: _FiveSurfacePainter(
//               mesialOnRight: _mesialOnRight,
//               fill: fill,
//               abut: markAbut,
//               pontic: markPontic,
//               ringCrown: ringCrown,
//               twoHorizontal: twoHorizontal,
//               oneVertical: oneVertical,
//               highlightAny: highlightAny,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
//
// /// ─────────────────────────────────────────────────────────────────
// /// Interpol 인라인 피커: 트리 모드 + 하위코드 중복제외 + 레벨무관 선택 허용
// class _InterpolPickerInline extends StatefulWidget {
//   final String title;
//   final List<String> Function(List<String> all)? categoryFilter;
//   final void Function(CodeSelection sel) onConfirm;
//   final void Function(bool hasCodeSelected)? onHasCodeChanged;
//   final Set<String>? excludeCodes; // 즐겨찾기 항목 중복 제거
//
//   const _InterpolPickerInline({
//     Key? key,
//     required this.title,
//     this.categoryFilter,
//     required this.onConfirm,
//     this.onHasCodeChanged,
//     this.excludeCodes,
//   }) : super(key: key);
//
//   @override
//   State<_InterpolPickerInline> createState() => _InterpolPickerInlineState();
// }
//
// class _InterpolPickerInlineState extends State<_InterpolPickerInline> {
//   String? cat;
//   final List<String> path = [];
//   bool _treeMode = false; // 트리/드롭다운 전환
//   String _search = '';     // (옵션) 레이블 검색 필터
//
//   Set<String> get _exclude => (widget.excludeCodes ?? const <String>{})
//       .map((e) => e.toUpperCase()).toSet();
//
//   CodeSelection? get currentSelection {
//     if (cat == null) return null;
//     final sel = CodeSelection(category: cat!, path: List<String>.from(path));
//     // 레벨과 무관: 경로가 1개 이상이면 유효로 본다
//     final valid = path.isNotEmpty;
//     return valid ? sel : null;
//   }
//
//   void _notifyHasCode() {
//     widget.onHasCodeChanged?.call(currentSelection != null);
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) async {
//       try {
//         await context.read<DentalDataProvider>().loadCodeTreeOnce();
//         if (mounted) setState(() {});
//         _notifyHasCode();
//       } catch (_) {
//         _notifyHasCode();
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('코드 트리 로딩 실패.')),
//         );
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final p = context.watch<DentalDataProvider>();
//     var cats = p.availableCategories(ViewMode.zoomIn);
//     if (widget.categoryFilter != null) cats = widget.categoryFilter!(cats);
//
//     List<CodeNode> childrenOf(List<String> prefix) {
//       final p = context.read<DentalDataProvider>();
//       final cat = /* 현재 선택된 카테고리 변수 */ ;
//       if (cat == null) return const <CodeNode>[];
//       final list = p
//           .listChildren(cat, prefix)                    // List<CodeNode>
//           .where((n) => !_exclude.contains(n.code.toUpperCase()))
//           .toList();
//       // (검색어 필터가 있다면) list.where(...) 적용
//       return list;
//     }
//
//
//
//     // ── 드롭다운(동적 레벨) 빌더 ─────────────────────────
//     List<Widget> _buildDropdownCascade() {
//       final widgets = <Widget>[];
//       if (cat == null) return widgets;
//
//       // level 0 부터, children이 있는 동안 계속 다음 레벨 드롭다운을 만듦
//       List<String> prefix = const [];
//       int level = 0;
//
//       while (true) {
//         final items = childrenOf(prefix);
//         if (items.isEmpty) break;
//
//         final cur = (path.length > level) ? path[level] : null;
//         widgets.add(
//           DropdownButtonFormField<String>(
//             isExpanded: true,
//             value: cur,
//             decoration: InputDecoration(labelText: 'Level ${level + 1}'),
//             items: items.map((n) => DropdownMenuItem(
//               value: n.code,
//               child: Text('${n.code} — ${n.label}'),
//             )).toList(),
//             onChanged: (v) {
//               if (v == null) return;
//               setState(() {
//                 // level 이후 경로 절단 후 현재 레벨 값을 세팅
//                 if (path.length > level) path.removeRange(level, path.length);
//                 if (path.length == level) { path.add(v); } else { path[level] = v; }
//                 _notifyHasCode();
//               });
//             },
//           ),
//         );
//
//         // 다음 레벨로 진행
//         if (path.length <= level) break;
//         prefix = [...prefix, path[level]];
//         level += 1;
//         widgets.add(const SizedBox(height: 8));
//       }
//
//       // 가이드
//       widgets.add(const SizedBox(height: 12));
//       if (path.isEmpty) {
//         widgets.add(const Text(
//           '카테고리만 고른 상태입니다. LEVEL 1~N 중 아무 단계나 선택해도 됩니다.',
//           style: TextStyle(color: Colors.redAccent, fontSize: 12),
//         ));
//       }
//       return widgets;
//     }
//
//     // ── 트리(무한 깊이) 빌더 ───────────────────────────
//     List<Widget> _buildTreeLevel(List<String> prefix) {
//       final items = childrenOf(prefix);
//       return items.map((n) {
//         final next = [...prefix, n.code];
//         final kids = childrenOf(next);
//         final title = Text('${n.code} — ${n.label}');
//         if (kids.isEmpty) {
//           return ListTile(
//             dense: true,
//             title: title,
//             onTap: () {
//               setState(() { path..clear()..addAll(next); });
//               _notifyHasCode();
//             },
//           );
//         }
//         return ExpansionTile(
//           title: Row(
//             children: [
//               Expanded(child: title),
//               TextButton(
//                 onPressed: () {
//                   setState(() { path..clear()..addAll(next); });
//                   _notifyHasCode();
//                 },
//                 child: const Text('선택'),
//               ),
//             ],
//           ),
//           children: _buildTreeLevel(next),
//         );
//       }).toList();
//     }
//
//     return ExpansionTile(
//       title: Text(widget.title),
//       initiallyExpanded: false,
//       childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
//       children: [
//         DropdownButtonFormField<String>(
//           isExpanded: true,
//           value: (cats.contains(cat)) ? cat : null,
//           decoration: const InputDecoration(labelText: 'Category'),
//           hint: const Text('(System code/text를 선택하세요.)'),
//           items: cats.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
//           onChanged: (v) => setState(() { cat = v; path.clear(); _notifyHasCode();}),
//         ),
//         const SizedBox(height: 8),
//
//         if (cat != null) ...[
//           // (옵션) 라벨/코드 검색
//           TextField(
//             decoration: const InputDecoration(
//               prefixIcon: Icon(Icons.search),
//               hintText: '코드 또는 라벨 검색',
//               border: OutlineInputBorder(),
//             ),
//             onChanged: (t) => setState(() => _search = t),
//           ),
//           const SizedBox(height: 8),
//
//           // 트리/드롭다운 토글
//           SwitchListTile.adaptive(
//             dense: true,
//             title: const Text('트리 모드(레벨1~N 자유 선택)'),
//             contentPadding: EdgeInsets.zero,
//             value: _treeMode,
//             onChanged: (v) => setState(() => _treeMode = v),
//           ),
//           const SizedBox(height: 8),
//
//           if (_treeMode) ...[
//             ..._buildTreeLevel(const []),
//           ] else ...[
//             ..._buildDropdownCascade(),
//           ],
//
//           const SizedBox(height: 8),
//           Row(
//             children: [
//               Expanded(
//                 child: Text(
//                   '현재 선택: ${cat ?? "-"}${path.isEmpty ? "" : " · ${path.join(" > ")}"}',
//                   overflow: TextOverflow.ellipsis,
//                   style: const TextStyle(color: Colors.black54),
//                 ),
//               ),
//               TextButton.icon(
//                 onPressed: () => setState(() => path.clear()),
//                 icon: const Icon(Icons.clear),
//                 label: const Text('경로 초기화'),
//               ),
//             ],
//           ),
//         ],
//         const SizedBox(height: 4),
//       ],
//     );
//   }
// }
//
// /// ─────────────────────────────────────────────────────────────────
// /// Interpol → 635 전역/표면에 “덮어쓰기” 반영 (토글 API만 사용)
// void applyInterpolToGlobal635WithToggles(
//     BuildContext context,
//     int fdi,
//     CodeSelection sel,
//     ) {
//   final p = context.read<DentalDataProvider>();
//
//   const cat2group = <String, String>{
//     'Bite and occlusion': 'bite',
//     'Tooth position'    : 'position',
//     'Status'            : 'status',
//     'Root'              : 'root',
//     'Crowns'            : 'crown',
//     'Crown pathology'   : 'crown pathology'
//   };
//
//   final code = (sel.path.isNotEmpty) ? sel.path.last : null;
//   final group = cat2group[sel.category];
//   if (code == null || group == null) return;
//
//   final prev = p.getSpecRead(fdi)?.global[group] ?? const <String>[];
//   for (final c in prev) {
//     if (c != code) {
//       p.toggleGlobalCode(fdi, group, c);
//     }
//   }
//   final cur = p.getSpecRead(fdi)?.global[group] ?? const <String>[];
//   if (!cur.contains(code)) {
//     p.toggleGlobalCode(fdi, group, code);
//   }
// }
//
// void applyInterpolToSurface635WithToggles(
//     BuildContext context,
//     int fdi,
//     String surface,
//     CodeSelection sel,
//     ) {
//   final p = context.read<DentalDataProvider>();
//
//   String? group;
//   if (sel.category == 'Fillings') {
//     group = 'fillings';
//   } else if (sel.category == 'Periodontium') {
//     group = 'periodontium';
//   } else {
//     return;
//   }
//
//   final code = (sel.path.isNotEmpty) ? sel.path.last : null;
//   if (code == null) return;
//
//   final prev = p.getSpecRead(fdi)?.surface[surface]?[group] ?? const <String>[];
//   for (final c in prev) {
//     if (c != code) {
//       p.toggleSurfaceCode(fdi, surface, group, c);
//     }
//   }
//   final cur = p.getSpecRead(fdi)?.surface[surface]?[group] ?? const <String>[];
//   if (!cur.contains(code)) {
//     p.toggleSurfaceCode(fdi, surface, group, code);
//   }
// }
//
// /// ─────────────────────────────────────────────────────────────────
// /// 그리기 유틸
// enum _SurfaceFill { none, toggleAmber, fillingBlue, cariesRed }
//
// class _FiveSurfacePainter extends CustomPainter {
//   final bool mesialOnRight;
//   final Map<String, _SurfaceFill> fill;
//
//   final bool abut;     // 지대치 → 파란 링
//   final bool pontic;   // pontic → 수평 2줄
//
//   final bool ringCrown;     // crown 선택 시 링
//   final bool twoHorizontal; // status MIS* → 수평 2줄
//   final bool oneVertical;   // root IPX* → 수직 1줄
//
//   final bool highlightAny;  // 보라색 테두리
//
//   const _FiveSurfacePainter({
//     required this.mesialOnRight,
//     required this.fill,
//     this.abut = false,
//     this.pontic = false,
//     this.ringCrown = false,
//     this.twoHorizontal = false,
//     this.oneVertical = false,
//     this.highlightAny = false,
//   });
//
//   @override
//   void paint(Canvas canvas, Size s) {
//     final g = _Geom(s);
//
//     final outerStroke = Paint()
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = (s.width * .04).clamp(1.0, 2.0)
//       ..color = highlightAny ? Colors.deepPurple : Colors.black87;
//
//     final innerStroke = Paint()
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = (s.width * .032).clamp(0.8, 1.6)
//       ..color = Colors.black54;
//
//     Paint paintOf(_SurfaceFill f) {
//       switch (f) {
//         case _SurfaceFill.cariesRed:
//           return Paint()..style = PaintingStyle.fill..color = Colors.red.withOpacity(.35);
//         case _SurfaceFill.fillingBlue:
//           return Paint()..style = PaintingStyle.fill..color = Colors.blue.withOpacity(.28);
//         case _SurfaceFill.toggleAmber:
//           return Paint()..style = PaintingStyle.fill..color = Colors.amber.withOpacity(.35);
//         case _SurfaceFill.none:
//           return Paint()..style = PaintingStyle.stroke..color = Colors.transparent;
//       }
//     }
//
//     final l = fill['L'] ?? _SurfaceFill.none;
//     final b = fill['B'] ?? _SurfaceFill.none;
//     final o = fill['O'] ?? _SurfaceFill.none;
//     final m = fill['M'] ?? _SurfaceFill.none;
//     final d = fill['D'] ?? _SurfaceFill.none;
//
//     if (l != _SurfaceFill.none) canvas.drawPath(g.pathL, paintOf(l));
//     if (b != _SurfaceFill.none) canvas.drawPath(g.pathB, paintOf(b));
//     if (o != _SurfaceFill.none) canvas.drawRect(g.rectO, paintOf(o));
//
//     final leftFill  = mesialOnRight ? d : m;
//     final rightFill = mesialOnRight ? m : d;
//     if (leftFill  != _SurfaceFill.none) canvas.drawPath(g.pathLeft,  paintOf(leftFill));
//     if (rightFill != _SurfaceFill.none) canvas.drawPath(g.pathRight, paintOf(rightFill));
//
//     // 윤곽/내부선
//     canvas.drawRRect(g.outerRRect, outerStroke);
//     canvas.drawRect(g.rectO, innerStroke);
//
//     final oc = [g.outerRect.topLeft, g.outerRect.topRight, g.outerRect.bottomRight, g.outerRect.bottomLeft];
//     final ic = [g.rectO.topLeft, g.rectO.topRight, g.rectO.bottomRight, g.rectO.bottomLeft];
//     for (int i = 0; i < 4; i++) {
//       canvas.drawLine(ic[i], oc[i], innerStroke);
//     }
//
//     // 파란 공통
//     final blue = Paint()
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = (s.width * .06).clamp(1.2, 2.4)
//       ..color = Colors.blueAccent;
//
//     if (ringCrown || abut) {
//       final ring = g.outerRect.deflate(s.width * .18);
//       canvas.drawRRect(
//         RRect.fromRectAndRadius(ring, Radius.circular(ring.width * .20)),
//         blue,
//       );
//     }
//
//     if (pontic || twoHorizontal) {
//       final y1 = s.height * .40, y2 = s.height * .60;
//       canvas.drawLine(Offset(s.width * .18, y1), Offset(s.width * .82, y1), blue);
//       canvas.drawLine(Offset(s.width * .18, y2), Offset(s.width * .82, y2), blue);
//     }
//
//     if (oneVertical) {
//       final x = s.width * .50;
//       canvas.drawLine(Offset(x, s.height * .20), Offset(x, s.height * .80), blue);
//     }
//   }
//
//   @override
//   bool shouldRepaint(covariant _FiveSurfacePainter old) =>
//       old.mesialOnRight != mesialOnRight ||
//           !_mapEquals(old.fill, fill) ||
//           old.abut != abut ||
//           old.pontic != pontic ||
//           old.ringCrown != ringCrown ||
//           old.twoHorizontal != twoHorizontal ||
//           old.oneVertical != oneVertical ||
//           old.highlightAny != highlightAny;
//
//   bool _mapEquals(Map<String, _SurfaceFill> a, Map<String, _SurfaceFill> b) {
//     if (identical(a, b)) return true;
//     if (a.length != b.length) return false;
//     for (final k in kToothSurfaces) {
//       if ((a[k] ?? _SurfaceFill.none) != (b[k] ?? _SurfaceFill.none)) return false;
//     }
//     return true;
//   }
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
//     final rectW = w * .54;  // 방패연 비율
//     final rectH = h * .36;
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
//
// /// getSpecRead가 null이어도 안전한 뷰
// class _SpecView {
//   final int fdi;
//   final dynamic _raw;
//   _SpecView(this.fdi, this._raw);
//
//   Map<String, List<String>> get global {
//     if (_raw?.global != null) return _raw!.global;
//     return <String, List<String>>{
//       'bite': <String>[],
//       'position': <String>[],
//       'status': <String>[],
//       'root': <String>[],
//       'crown': <String>[],
//       'crown pathology': <String>[],
//     };
//   }
//
//   Map<String, Map<String, List<String>>> get surface {
//     if (_raw?.surface != null) return _raw!.surface;
//     return {
//       for (final s in kToothSurfaces)
//         s: <String, List<String>>{
//           'fillings': <String>[],
//           'periodontium': <String>[],
//         }
//     };
//   }
//
//   String get toothNote => (_raw?.toothNote ?? '').trim();
//
//   Map<String, String> get surfaceNote {
//     if (_raw?.surfaceNote != null) return _raw!.surfaceNote;
//     return { for (final s in kToothSurfaces) s: '' };
//   }
// }
//
// class _CurrentStateInlineSummary extends StatelessWidget {
//   final int fdi;
//   const _CurrentStateInlineSummary({super.key, required this.fdi});
//
//   @override
//   Widget build(BuildContext context) {
//     final p = context.watch<DentalDataProvider>();
//     final spec = p.getSpecRead(fdi);
//     String _ellipsis(String s, int n) => s.length <= n ? s : '${s.substring(0, n)}…';
//
//     // 안전 뷰로 변환
//     final view = _SpecView(fdi, spec);
//
//     final g = view.global;
//     final s = view.surface;
//     final toothNote = view.toothNote;
//
//     String joinMapList(Map<String, List<String>> m, List<String> keys) {
//       final parts = <String>[];
//       for (final k in keys) {
//         final v = m[k] ?? const <String>[];
//         if (v.isNotEmpty) parts.add('$k:${v.join("/")}');
//       }
//       return parts.join(' · ');
//     }
//
//     String surfLine() {
//       final buf = <String>[];
//       for (final surf in kToothSurfaces) {
//         final f = (s[surf]?['fillings'] ?? const <String>[]);
//         final pds = (s[surf]?['periodontium'] ?? const <String>[]);
//         if (f.isEmpty && pds.isEmpty) continue;
//         final inner = [
//           if (f.isNotEmpty) 'F:${f.join("/")}',
//           if (pds.isNotEmpty) 'P:${pds.join("/")}',
//         ].join(',');
//         buf.add('$surf($inner)');
//       }
//       return buf.join(' · ');
//     }
//
//     final gLine = joinMapList(g, ['bite','position','status','root','crown','crown pathology']);
//     final sLine = surfLine();
//
//     // 아무 것도 없으면 감춤
//     if (gLine.isEmpty && sLine.isEmpty && toothNote.isEmpty) {
//       return const SizedBox.shrink();
//     }
//
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.grey.withOpacity(0.06),
//         borderRadius: BorderRadius.circular(12),
//       ),
//       padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text('현재 저장 상태', style: TextStyle(fontWeight: FontWeight.w700)),
//           const SizedBox(height: 6),
//           if (gLine.isNotEmpty)
//             Text('전역: $gLine', style: const TextStyle(fontSize: 12)),
//           if (sLine.isNotEmpty)
//             Padding(
//               padding: const EdgeInsets.only(top: 2),
//               child: Text('표면: $sLine', style: const TextStyle(fontSize: 12)),
//             ),
//           if (toothNote.isNotEmpty)
//             Padding(
//               padding: const EdgeInsets.only(top: 2),
//               child: Text('메모: ${_ellipsis(toothNote, 80)}',
//                   style: const TextStyle(fontSize: 12, color: Colors.black87)),
//             ),
//         ],
//       ),
//     );
//   }
// }
//
// class _ToothPreviewLarge extends StatelessWidget {
//   final int fdi;
//   final double size;
//   const _ToothPreviewLarge({super.key, required this.fdi, required this.size});
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
//     final spec = p.getSpecRead(fdi);
//
//     final Map<String, _SurfaceFill> fill = {
//       for (final s in kToothSurfaces) s: _SurfaceFill.none,
//     };
//     if (spec != null) {
//       for (final s in kToothSurfaces) {
//         final list = spec.surface[s]!['fillings']!;
//         final hasCaries = list.any(_isCariesThree);
//         if (hasCaries) {
//           fill[s] = _SurfaceFill.cariesRed;
//         } else if (list.isNotEmpty) {
//           fill[s] = _SurfaceFill.fillingBlue;
//         }
//       }
//     }
//
//     final bool ringCrown =
//         (spec?.global['crown'] ?? const <String>[]).isNotEmpty;
//     final bool markStatusMissing =
//     (spec?.global['status'] ?? const <String>[])
//         .map((e) => e.toUpperCase())
//         .any((c) => c == 'MIS' || c.startsWith('MIS') || c == 'MAM' || c == 'MPM' || c == 'EXT' || c == 'SOX' || c == 'MJA');
//     final bool markRootImplant =
//     (spec?.global['root'] ?? const <String>[])
//         .map((e) => e.toUpperCase())
//         .any((c) => c == 'IPX' || c.startsWith('IPX'));
//
//     bool markDenture = false, markAbut = false, markPontic = false;
//     for (final sp in p.spans) {
//       if (!sp.teeth.contains(fdi)) continue;
//       if (sp.type == DentalSpanType.dentureOrtho) {
//         markDenture = true;
//       } else {
//         if (sp.abutments.contains(fdi)) markAbut = true;
//         if (sp.pontics.contains(fdi))   markPontic = true;
//       }
//     }
//
//     bool hasAnyInput = false;
//     if (spec != null) {
//       for (final s in kToothSurfaces) {
//         final f = (spec.surface[s]?['fillings'] ?? const <String>[]);
//         final pr = (spec.surface[s]?['periodontium'] ?? const <String>[]);
//         if (f.isNotEmpty || pr.isNotEmpty) { hasAnyInput = true; break; }
//       }
//       if (!hasAnyInput) {
//         for (final g in const ['bite','crown','root','status','position','crown pathology']) {
//           if ((spec.global[g] ?? const <String>[]).isNotEmpty) { hasAnyInput = true; break; }
//         }
//       }
//       if (!hasAnyInput) {
//         if ((spec.toothNote ?? '').trim().isNotEmpty ||
//             spec.surfaceNote.values.any((v) => v.trim().isNotEmpty)) {
//           hasAnyInput = true;
//         }
//       }
//     }
//
//     final hasSurfacePaint = fill.values.any((f) => f != _SurfaceFill.none);
//     final hasBlueRing   = ringCrown || markAbut;
//     final hasBlueLines  = markPontic || markStatusMissing || markRootImplant;
//     final hasOwnVisual  = hasSurfacePaint || hasBlueRing || hasBlueLines || markDenture;
//     final highlightAny  = hasAnyInput && !hasOwnVisual;
//
//     return Column(
//       children: [
//         Text('$fdi', style: const TextStyle(fontWeight: FontWeight.w700)),
//         const SizedBox(height: 6),
//         SizedBox(
//           width: size,
//           height: size,
//           child: CustomPaint(
//             painter: _FiveSurfacePainter(
//               mesialOnRight: _mesialOnRight,
//               fill: fill,
//               abut: markAbut,
//               pontic: markPontic,
//               ringCrown: ringCrown,
//               twoHorizontal: markStatusMissing,
//               oneVertical: markRootImplant,
//               highlightAny: highlightAny,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
//
// typedef _QuickPick = void Function(String category, String code);
//
// class _FrequentlyUsedPanel extends StatelessWidget {
//   final _EditMode mode;
//   final _QuickPick onPick;
//   const _FrequentlyUsedPanel({super.key, required this.mode, required this.onPick});
//
//   @override
//   Widget build(BuildContext context) {
//     final groups = (mode == _EditMode.surface) ? kFavSurfaceGroups() : kFavGlobalGroups();
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text('Frequently Used', style: TextStyle(fontWeight: FontWeight.w700)),
//         const SizedBox(height: 6),
//         ...groups.entries.map((e) => _groupChips(context, e.key, e.value)),
//       ],
//     );
//   }
//
//   Widget _groupChips(BuildContext context, String category, List<String> codes) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 8),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(category, style: const TextStyle(fontSize: 12, color: Colors.black54)),
//           const SizedBox(height: 4),
//           Wrap(
//             spacing: 8, runSpacing: 6,
//             children: codes.map((code) {
//               final label = _labelFor(context, category, code) ?? '';
//               final text = label.isEmpty ? code : '$code — $label';
//               return ActionChip(
//                 label: Text(text),
//                 onPressed: () => onPick(category, code),
//               );
//             }).toList(),
//           ),
//         ],
//       ),
//     );
//   }
//
//   /// 코드 → 시스템 텍스트 조회 (카테고리 트리 BFS)
//   String? _labelFor(BuildContext context, String category, String code) {
//     final p = context.read<DentalDataProvider>();
//     final want = code.toUpperCase();
//     final visited = <String>{};
//     List<CodeNode> childrenOf(List<String> prefix) => p.listChildren(category, prefix);
//
//     String? search(List<String> prefix) {
//       final key = '${prefix.join(">")}';
//       if (!visited.add(key)) return null;
//
//       for (final n in childrenOf(prefix)) {
//         if (n.code.toUpperCase() == want) return n.label;
//         final lab = search([...prefix, n.code]);
//         if (lab != null) return lab;
//       }
//       return null;
//     }
//
//     try {
//       return search(const []);
//     } catch (_) {
//       return null;
//     }
//   }
// }

import 'dart:math' show min, max;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/dental_data_provider.dart'
    hide CodeSelection, kToothSurfaces; // provider 쪽 kToothSurfaces 가리기
import '../data/codes_635.dart' as interp show kToothSurfaces; // codes_635의 것만 명시 사용
import '../data/surface_fill.dart'; // (다른 화면과의 호환을 위해 유지)
import 'tree_selector_screen.dart' show TreeSelectorScreen;
import '../models/code_node.dart';

import '../data/codes_635.dart' as ic;


// ────────────────────────────────────────────────────────────────
// DentalDataProvider compatibility shim for listChildren(...)
// Tries a few likely method names via `dynamic`; falls back to [].
// Place this in the same file (e.g., under the imports).
extension InterpolListChildrenExt on DentalDataProvider {
  List<CodeNode> listChildren(String category, List<String> prefix) {
    // 1) If your provider already exposes a similar API, we proxy to it.
    try {
      final dyn = this as dynamic;
      final res = dyn.listChildren635(category, prefix);
      if (res is List<CodeNode>) return res;
    } catch (_) {}

    try {
      final dyn = this as dynamic;
      final res = dyn.getChildrenForCategory(category, prefix);
      if (res is List<CodeNode>) return res;
    } catch (_) {}

    try {
      final dyn = this as dynamic;
      final res = dyn.codeChildren(category, prefix);
      if (res is List<CodeNode>) return res;
    } catch (_) {}

    // 2) Fallback: 새 트리로 직접 조회
    try {
      return ic.listChildren(category, prefix);
    } catch (_) {
      return const <CodeNode>[];
    }
  }
}

/// ─────────────────────────────────────────────────────────────────
/// 공통: 충치 3종 판단
bool _isCariesThree(String c) {
  final u = c.toUpperCase();
  return u == 'CAR' || u == 'ACA' || u == 'CCA';
}

/// ─────────────────────────────────────────────────────────────────
/// 즐겨찾기(스프레드시트 재분류 반영)
Map<String, List<String>> kFavSurfaceGroups() => {
  'Fillings': ['CAR', 'UIF', 'CAV', 'AMF', 'TCF', 'COF', 'FIS', 'GOI', 'POI'],
  // Periodontium 자주 쓰는 항목이 있으면 여기에 추가
};

Map<String, List<String>> kFavGlobalGroups() => {
  // CAR는 Fillings로, ROV는 Status로, IPX는 Root로 분류
  'Status': ['INT', 'MAM', 'MPM', 'CFR', 'IMX', 'IMV', 'ERU', 'ROV'],
  'Root': ['RFX', 'IPX'],
  'Crowns': ['UIC', 'MTC', 'GOC', 'MEC', 'TCC', 'MCC', 'POC', 'TEC'],
};

Set<String> favCodesUpperForMode(_EditMode mode) {
  final m = (mode == _EditMode.surface) ? kFavSurfaceGroups() : kFavGlobalGroups();
  return m.values.expand((e) => e).map((c) => c.toUpperCase()).toSet();
}

/// ─────────────────────────────────────────────────────────────────
/// 사분면(축소) 화면: 핀치 줌 제거, 치아 탭 시 단일치아 에디터로 이동
class QuadrantZoomScreen extends StatelessWidget {
  final String title;
  final bool isUpper; // 상악 true
  final bool isPermanent; // 라벨/표시용
  final List<int> teeth; // 예: [18..11], [21..28] 등

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
            onPressed: () => _showHelp(context),
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, c) {
          const spacing = 12.0;
          final n = teeth.length; // 8 or 5
          final tile = ((c.maxWidth - spacing * (n - 1)) / n).clamp(28.0, 90.0);
          final rowWidth = n * tile + (n - 1) * spacing;

          return Stack(
            children: [
              // 치아 행
              Center(
                child: SizedBox(
                  width: rowWidth,
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: _RowDentureOverlayPainterWidget(
                          teeth: teeth,
                          tile: tile,
                          spacing: spacing,
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          for (final fdi in teeth) ...[
                            SizedBox(
                              width: tile,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  if (numbersOnTop)
                                    GestureDetector(
                                      behavior: HitTestBehavior.opaque,
                                      onLongPress: () => _openOneToothEditor(context, fdi),
                                      child: _ToothNumber(fdi, tile),
                                    ),
                                  _BigToothTileSimple(
                                    fdi: fdi,
                                    size: tile,
                                    onOpenEditor: _openOneToothEditor,
                                  ),
                                  if (!numbersOnTop)
                                    GestureDetector(
                                      behavior: HitTestBehavior.opaque,
                                      onLongPress: () => _openOneToothEditor(context, fdi),
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
              ),

              // 우상단 요약 패널(기록 있으면 표시)
              Positioned(
                top: 4,
                right: 4,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 280),
                  child: _QuadrantInfoOverlay(teeth: teeth),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _showHelp(BuildContext context) {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      builder: (_) => const Padding(
        padding: EdgeInsets.fromLTRB(16, 12, 16, 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('화면 사용법', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
            SizedBox(height: 8),
            Text("• 치아 한 번 탭: 단일치아 편집 화면으로 이동합니다."),
            Text("• 숫자(치아 번호) 길게 누르기: 동일하게 단일치아 편집 화면으로 이동합니다."),
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

  Future<void> _openOneToothEditor(BuildContext context, int fdi) async {
    await Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => TreeSelectorScreen(fdi: fdi)),
    );
  }
}

/// ─────────────────────────────────────────────────────────────────
/// 우상단 요약 패널: 입력 있는 치아/스팬만 요약
class _QuadrantInfoOverlay extends StatelessWidget {
  final List<int> teeth;
  const _QuadrantInfoOverlay({required this.teeth});

  @override
  Widget build(BuildContext context) {
    final p = context.watch<DentalDataProvider>();
    final specs = <int, _SpecView>{
      for (final t in teeth) t: _SpecView(t, p.getSpecRead(t))
    };

    final items = specs.entries
        .where((e) {
      final s = e.value;
      final anyGlobal = s.global.values.any((lst) => lst.isNotEmpty);
      final anySurf = interp.kToothSurfaces.any((x) {
        final m = s.surface[x];
        if (m == null) return false;
        return (m['fillings'] ?? const <String>[]).isNotEmpty ||
            (m['periodontium'] ?? const <String>[]).isNotEmpty;
      });
      final anyNote = s.toothNote.isNotEmpty || s.surfaceNote.values.any((v) => v.trim().isNotEmpty);
      return anyGlobal || anySurf || anyNote;
    })
        .toList()
      ..sort((a, b) => a.key.compareTo(b.key));

    final spans = p.spans.where((sp) => sp.teeth.any(teeth.contains)).toList();

    if (items.isEmpty && spans.isEmpty) return const SizedBox.shrink();

    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(top: 4, right: 4),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 8, 12, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('요약', style: TextStyle(fontWeight: FontWeight.w700)),
            const SizedBox(height: 6),

            if (spans.isNotEmpty) ...[
              Row(
                children: [
                  const Icon(Icons.linear_scale, size: 16),
                  const SizedBox(width: 6),
                  Text('스팬 ${spans.length}개', style: const TextStyle(fontWeight: FontWeight.w600)),
                ],
              ),
              const SizedBox(height: 4),
              ...spans.map(
                    (sp) => Padding(
                  padding: const EdgeInsets.only(bottom: 2),
                  child: Text(_spanLine(sp, teeth), style: const TextStyle(fontSize: 12)),
                ),
              ),
              const Divider(),
            ],

            ...items.map((e) {
              final fdi = e.key;
              final s = e.value;
              final globals = _pickGlobalsOneLine(s.global);
              final surfaces = _pickSurfacesOneLine(s.surface);
              final note = s.toothNote;

              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('[$fdi]', style: const TextStyle(fontWeight: FontWeight.w700)),
                    if (globals.isNotEmpty) Text('전역: $globals', style: const TextStyle(fontSize: 12)),
                    if (surfaces.isNotEmpty) Text('표면: $surfaces', style: const TextStyle(fontSize: 12)),
                    if (note.isNotEmpty)
                      Text('메모: ${_ellipsis(note, 60)}',
                          style: const TextStyle(fontSize: 12, color: Colors.black87)),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  String _spanLine(DentalSpan sp, List<int> visible) {
    final typ = sp.type == DentalSpanType.dentureOrtho ? 'Denture/Ortho' : 'Bridge';
    final range = _fmtSpanTeeth(sp.teeth.where(visible.contains));
    String ap = '';
    if (sp.type != DentalSpanType.dentureOrtho) {
      ap = ' · Abut:${_fmtSpanTeeth(sp.abutments)} · Pontic:${_fmtSpanTeeth(sp.pontics)}';
    }
    return '$typ  $range$ap';
  }

  String _fmtSpanTeeth(Iterable<int> it) {
    final ts = it.toList()..sort();
    if (ts.isEmpty) return '-';
    final buf = <String>[];
    int start = ts.first, prev = ts.first;
    for (int i = 1; i < ts.length; i++) {
      if (ts[i] == prev + 1) {
        prev = ts[i];
      } else {
        buf.add(start == prev ? '$start' : '$start–$prev');
        start = prev = ts[i];
      }
    }
    buf.add(start == prev ? '$start' : '$start–$prev');
    return buf.join(', ');
  }

  String _pickGlobalsOneLine(Map<String, List<String>> g) {
    const keys = ['bite', 'position', 'status', 'root', 'crown', 'crown pathology'];
    final parts = <String>[];
    for (final k in keys) {
      final v = g[k] ?? const <String>[];
      if (v.isNotEmpty) parts.add('$k:${v.join("/")}');
    }
    return parts.join(' · ');
  }

  String _pickSurfacesOneLine(Map<String, Map<String, List<String>>> m) {
    final parts = <String>[];
    for (final s in interp.kToothSurfaces) {
      final f = (m[s]?['fillings'] ?? const <String>[]) as List<String>;
      final p = (m[s]?['periodontium'] ?? const <String>[]) as List<String>;
      if (f.isEmpty && p.isEmpty) continue;
      final join = [
        if (f.isNotEmpty) 'F:${f.join("/")}',
        if (p.isNotEmpty) 'P:${p.join("/")}',
      ].join(',');
      parts.add('$s($join)');
    }
    return parts.join(' · ');
  }

  String _ellipsis(String s, int n) => s.length <= n ? s : '${s.substring(0, n)}…';
}

/// ─────────────────────────────────────────────────────────────────
/// 덴쳐 스팬 오버레이(축소 행 전체에 파란 캡슐)
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

      // 연속 클러스터
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

/// ─────────────────────────────────────────────────────────────────
/// 번호/그리기(축소)
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

/// 축소 그리기 + 탭 시 단일치아 에디터로 이동
class _BigToothTileSimple extends StatelessWidget {
  final int fdi;
  final double size;
  final void Function(BuildContext, int) onOpenEditor;

  const _BigToothTileSimple({
    required this.fdi,
    required this.size,
    required this.onOpenEditor,
  });

  bool get _mesialOnRight {
    final q = fdi ~/ 10;
    if (q == 1 || q == 4 || q == 5 || q == 8) return true; // 우측군
    if (q == 2 || q == 3 || q == 6 || q == 7) return false; // 좌측군
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final p = context.watch<DentalDataProvider>();
    final spec = p.getSpecRead(fdi);

    // 면 채우기
    final Map<String, _SurfaceFill> fill = {
      for (final s in interp.kToothSurfaces) s: _SurfaceFill.none,
    };
    if (spec != null) {
      for (final s in interp.kToothSurfaces) {
        final list = spec.surface[s]!['fillings']!;
        final hasCaries = list.any(_isCariesThree);
        if (hasCaries) {
          fill[s] = _SurfaceFill.cariesRed;
        } else if (list.isNotEmpty) {
          fill[s] = _SurfaceFill.fillingBlue;
        }
      }
    }

    final bool ringCrown = (spec?.global['crown'] ?? const <String>[]).isNotEmpty;
    final bool markStatusMissing = (spec?.global['status'] ?? const <String>[])
        .map((e) => e.toUpperCase())
        .any((c) => c == 'MIS' || c.startsWith('MIS') || c == 'MAM' || c == 'MPM' || c == 'EXT' || c == 'SOX' || c == 'MJA');
    final bool markRootImplant = (spec?.global['root'] ?? const <String>[])
        .map((e) => e.toUpperCase())
        .any((c) => c == 'IPX' || c.startsWith('IPX'));

    bool markDenture = false, markAbut = false, markPontic = false;
    for (final sp in p.spans) {
      if (!sp.teeth.contains(fdi)) continue;
      if (sp.type == DentalSpanType.dentureOrtho) {
        markDenture = true;
      } else {
        if (sp.abutments.contains(fdi)) markAbut = true;
        if (sp.pontics.contains(fdi)) markPontic = true;
      }
    }

    bool hasAnyInput = false;
    if (spec != null) {
      for (final s in interp.kToothSurfaces) {
        final f = (spec.surface[s]?['fillings'] ?? const <String>[]);
        final pr = (spec.surface[s]?['periodontium'] ?? const <String>[]);
        if (f.isNotEmpty || pr.isNotEmpty) {
          hasAnyInput = true;
          break;
        }
      }
      if (!hasAnyInput) {
        for (final g in const ['bite', 'crown', 'root', 'status', 'position', 'crown pathology']) {
          if ((spec.global[g] ?? const <String>[]).isNotEmpty) {
            hasAnyInput = true;
            break;
          }
        }
      }
      if (!hasAnyInput) {
        if ((spec.toothNote ?? '').trim().isNotEmpty ||
            spec.surfaceNote.values.any((v) => v.trim().isNotEmpty)) {
          hasAnyInput = true;
        }
      }
    }

    final hasSurfacePaint = fill.values.any((f) => f != _SurfaceFill.none);
    final hasBlueRing = ringCrown || markAbut;
    final hasBlueLines = markPontic || markStatusMissing || markRootImplant;
    final hasOwnVisual = hasSurfacePaint || hasBlueRing || hasBlueLines || markDenture;
    final highlightAny = hasAnyInput && !hasOwnVisual;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => onOpenEditor(context, fdi),
      onLongPress: () => onOpenEditor(context, fdi),
      child: CustomPaint(
        size: Size.square(size),
        painter: _FiveSurfacePainter(
          mesialOnRight: _mesialOnRight,
          fill: fill,
          abut: markAbut,
          pontic: markPontic,
          ringCrown: ringCrown,
          twoHorizontal: markStatusMissing,
          oneVertical: markRootImplant,
          highlightAny: highlightAny,
        ),
      ),
    );
  }
}

/// ─────────────────────────────────────────────────────────────────
/// 단일치아 편집 화면: Global / Surface(OMDBL 다중선택)
class SingleToothEditorScreen extends StatefulWidget {
  final int fdi;
  const SingleToothEditorScreen({super.key, required this.fdi});

  @override
  State<SingleToothEditorScreen> createState() => _SingleToothEditorScreenState();
}

enum _EditMode { global, surface }

class _SingleToothEditorScreenState extends State<SingleToothEditorScreen> {
  _EditMode mode = _EditMode.global;

  final _pickerKey = GlobalKey<_InterpolPickerInlineState>();

  // Surface 모드: OMDBL 다중 선택
  final Set<String> _surfaces = {'O', 'M', 'D', 'B', 'L'};
  final Set<String> _pickedSurfaces = {'O'}; // 기본값

  bool _canSaveCode = false;

  CodeSelection? _quickSel; // 'Frequently Used' 칩으로 고른 임시 선택 (저장 전)

  // 메모
  late final TextEditingController _noteCtrl;
  late String _initialNoteForGlobal;
  final Map<String, String> _initialSurfaceNotes = {};

  @override
  void initState() {
    super.initState();
    final p = context.read<DentalDataProvider>();
    final spec = p.getSpecRead(widget.fdi);

    _initialNoteForGlobal = spec?.toothNote ?? '';
    _noteCtrl = TextEditingController(text: _initialNoteForGlobal);

    for (final s in _surfaces) {
      final note = spec?.surfaceNote[s] ?? '';
      _initialSurfaceNotes[s] = note;
    }

    WidgetsBinding.instance.addPostFrameCallback((_) => p.loadCodeTreeOnce());
  }

  @override
  void dispose() {
    _noteCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final p = context.watch<DentalDataProvider>();
    final media = MediaQuery.of(context);
    final kb = media.viewInsets.bottom;

    _syncNoteTextForMode(p);

    // 미리보기 크기: 화면폭의 56%~220 사이
    final previewSize = min(media.size.width * 0.56, 220.0);

    // 즐겨찾기 코드(대문자) 집합 — 아래 인터폴 선택에서 제외할 용도
    final exclude = favCodesUpperForMode(mode);

    return Scaffold(
      appBar: AppBar(
        title: Text('Tooth ${widget.fdi}'),
        actions: [
          IconButton(icon: const Icon(Icons.help_outline), onPressed: () => _showHelp(context)),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(16, 12, 16, max(12, kb)),
          // 세로 스크롤 하나로 모두 감싸 오버플로우 방지
          child: ListView(
            children: [
              // 모드 토글
              SegmentedButton<_EditMode>(
                segments: const [
                  ButtonSegment(value: _EditMode.global, icon: Icon(Icons.public), label: Text('Global')),
                  ButtonSegment(value: _EditMode.surface, icon: Icon(Icons.grid_on), label: Text('Surface(OMDBL)')),
                ],
                selected: {mode},
                onSelectionChanged: (s) => setState(() => mode = s.first),
              ),
              const SizedBox(height: 12),

              if (mode == _EditMode.surface) ...[
                Wrap(
                  spacing: 8,
                  children: _surfaces.map((s) {
                    final selected = _pickedSurfaces.contains(s);
                    return FilterChip(
                      label: Text(s),
                      selected: selected,
                      onSelected: (v) => setState(() {
                        if (v) {
                          _pickedSurfaces.add(s);
                        } else if (_pickedSurfaces.length > 1) {
                          _pickedSurfaces.remove(s);
                        }
                      }),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 8),
                const Text('※ Surface 선택은 여러 개 동시 적용됩니다. (예: MOD)'),
                const SizedBox(height: 12),
              ],

              _FrequentlyUsedPanel(
                mode: mode,
                onPick: (category, code) {
                  setState(() {
                    _quickSel = CodeSelection(category: category, path: [code.toUpperCase()]); // 대문자화
                    _canSaveCode = true; // 저장 버튼 활성화를 위해
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('선택됨: $category · $code — 저장을 눌러 적용됩니다.')),
                  );
                },
              ),
              const SizedBox(height: 8),

              // 저장 전 선택까지 반영되는 "라이브 미리보기"
              Center(
                child: _ToothPreviewLive(
                  fdi: widget.fdi,
                  size: previewSize,
                  mode: mode,
                  pickedSurfaces: _pickedSurfaces,
                  pendingSel: _quickSel ?? _pickerKey.currentState?.currentSelection,
                  pendingNote: _noteCtrl.text,
                ),
              ),
              const SizedBox(height: 8),

              // 현재 저장 상태 요약(저장된 값 기준)
              _CurrentStateInlineSummary(fdi: widget.fdi),
              const SizedBox(height: 12),

              // Interpol 선택(트리 모드 + 즐겨찾기 중복 제거)
              _InterpolPickerInline(
                key: _pickerKey,
                title: mode == _EditMode.global ? 'Interpol 코드 선택 (전역)' : 'Interpol 코드 선택 (표면)',
                categoryFilter: (cats) {
                  if (mode == _EditMode.global) {
                    // Global: 표면/스팬/교정류 제외
                    return cats.where((c) {
                      final u = c.toLowerCase();
                      final isSurface = u == 'fillings' || u == 'periodontium';
                      final isSpan = u.contains('bridge');
                      final isDentOrtho = u.contains('denture') || u.contains('orthodont');
                      return !(isSurface || isSpan || isDentOrtho);
                    }).toList();
                  } else {
                    // Surface: Fillings/Periodontium만
                    return cats.where((c) => c == 'Fillings' || c == 'Periodontium').toList();
                  }
                },
                onConfirm: (_) {},
                onHasCodeChanged: (_) => setState(() => _canSaveCode = _),
                excludeCodes: exclude, // 즐겨찾기와 중복되는 코드 숨김
              ),
              const SizedBox(height: 12),

              // 메모
              Text(mode == _EditMode.global ? '자연어 메모 (전역)' : '자연어 메모 (선택된 표면 모두에 적용)'),
              const SizedBox(height: 6),
              TextField(
                controller: _noteCtrl,
                onChanged: (_) => setState(() {}), // 미리보기 하이라이트 즉시 반영
                maxLines: 3,
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.newline,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: '예: Global - 교합 개방감 / Surface - MOD 수복 예정 등',
                ),
              ),
              const SizedBox(height: 12),

              // 버튼들: 줄바꿈 안전
              OverflowBar(
                alignment: MainAxisAlignment.end,
                spacing: 8,
                children: [
                  TextButton.icon(
                    icon: const Icon(Icons.delete_outline),
                    label: const Text('기록 삭제'),
                    onPressed: () {
                      if (mode == _EditMode.global) {
                        context.read<DentalDataProvider>().clearGlobalAll635(widget.fdi);
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(content: Text('전역 기록을 삭제했습니다.')));
                      } else {
                        for (final s in _pickedSurfaces) {
                          context.read<DentalDataProvider>().clearSurface635(widget.fdi, s);
                        }
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('표면(${_pickedSurfaces.join(",")}) 기록을 삭제했습니다.')),
                        );
                      }
                    },
                  ),
                  TextButton(onPressed: () => Navigator.pop(context), child: const Text('취소')),
                  FilledButton(
                    onPressed: _canPressSave(p) ? () => _handleSave(p) : null,
                    child: const Text('저장'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showHelp(BuildContext context) {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      builder: (_) => const Padding(
        padding: EdgeInsets.fromLTRB(16, 12, 16, 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('단일치아 편집 도움말', style: TextStyle(fontWeight: FontWeight.w700)),
            SizedBox(height: 8),
            Text('• Global: OMDBL 선택 없이 전역 코드만 고릅니다.'),
            Text('• Surface: OMDBL 여러 표면을 동시에 선택하고, 선택한 코드가 한 번에 적용됩니다.'),
            Text('• 메모: Global은 치아 전역 메모, Surface는 선택된 표면 모두에 동일 메모가 저장됩니다.'),
            SizedBox(height: 8),
            Text('• 삭제: 현재 모드에 따라 전역 전체 또는 선택 표면들의 기록을 삭제합니다.'),
          ],
        ),
      ),
    );
  }

  // 모드에 따라 메모 텍스트 동기화
  void _syncNoteTextForMode(DentalDataProvider p) {
    final spec = p.getSpecRead(widget.fdi);
    if (mode == _EditMode.global) {
      final want = spec?.toothNote ?? '';
      if (_noteCtrl.text != want) {
        _noteCtrl.text = want;
        _noteCtrl.selection =
            TextSelection.fromPosition(TextPosition(offset: _noteCtrl.text.length));
      }
    } else {
      final notes = _pickedSurfaces.map((s) => spec?.surfaceNote[s]?.trim() ?? '').toSet();
      final String want = (notes.length == 1) ? notes.first : '';
      if (_noteCtrl.text != want) {
        _noteCtrl.text = want;
        _noteCtrl.selection =
            TextSelection.fromPosition(TextPosition(offset: _noteCtrl.text.length));
      }
    }
  }

  bool _canPressSave(DentalDataProvider p) {
    if (mode == _EditMode.global) {
      final noteChanged = (_noteCtrl.text.trim() != _initialNoteForGlobal.trim());
      final hasPendingCode = _canSaveCode || (_quickSel != null);
      return hasPendingCode || noteChanged;
    } else {
      final note = _noteCtrl.text.trim();
      final anyNoteChanged =
      _pickedSurfaces.any((s) => (note != (_initialSurfaceNotes[s]?.trim() ?? '')));
      final hasPendingCode = _canSaveCode || (_quickSel != null);
      return hasPendingCode || anyNoteChanged;
    }
  }

  void _handleSave(DentalDataProvider p) {
    final sel = _pickerKey.currentState?.currentSelection ?? _quickSel; // ← 우선
    final note = _noteCtrl.text.trim();

    bool savedCode = false, savedNote = false;

    if (mode == _EditMode.global) {
      if (sel != null) {
        applyInterpolToGlobal635WithToggles(context, widget.fdi, sel);
        savedCode = true;
      }
      if (note != _initialNoteForGlobal.trim()) {
        p.setToothNote635(widget.fdi, note);
        savedNote = true;
        _initialNoteForGlobal = note;
      }
    } else {
      if (sel != null) {
        for (final s in _pickedSurfaces) {
          applyInterpolToSurface635WithToggles(context, widget.fdi, s, sel);
        }
        savedCode = true;
      }
      for (final s in _pickedSurfaces) {
        if (note != (_initialSurfaceNotes[s]?.trim() ?? '')) {
          p.setSurfaceNote635(widget.fdi, s, note);
          _initialSurfaceNotes[s] = note;
          savedNote = true;
        }
      }
    }

    _quickSel = null; // 임시 선택 초기화
    Navigator.pop(context);
    final msg = (savedCode && savedNote)
        ? '코드와 메모가 저장되었습니다.'
        : (savedCode ? '코드가 저장되었습니다.' : '메모만 저장되었습니다.');
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }
}

/// 저장된 spec + (선택 중인 Interpol 코드/표면/메모)을 합성해 그리는 라이브 미리보기
class _ToothPreviewLive extends StatelessWidget {
  final int fdi;
  final double size;
  final _EditMode mode;
  final Set<String> pickedSurfaces; // Surface 모드에서 동시 적용할 OMDBL
  final CodeSelection? pendingSel; // _pickerKey.currentState?.currentSelection
  final String pendingNote; // 메모 입력창 현재 값

  const _ToothPreviewLive({
    super.key,
    required this.fdi,
    required this.size,
    required this.mode,
    required this.pickedSurfaces,
    required this.pendingSel,
    required this.pendingNote,
  });

  bool get _mesialOnRight {
    final q = fdi ~/ 10;
    if (q == 1 || q == 4 || q == 5 || q == 8) return true;
    if (q == 2 || q == 3 || q == 6 || q == 7) return false;
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final p = context.watch<DentalDataProvider>();
    final spec = p.getSpecRead(fdi);

    // 1) 저장된 상태로부터 기본 표시 계산
    final Map<String, _SurfaceFill> fill = {for (final s in interp.kToothSurfaces) s: _SurfaceFill.none};
    if (spec != null) {
      for (final s in interp.kToothSurfaces) {
        final list = spec.surface[s]!['fillings']!;
        final hasCaries = list.any(_isCariesThree);
        if (hasCaries) {
          fill[s] = _SurfaceFill.cariesRed;
        } else if (list.isNotEmpty) {
          fill[s] = _SurfaceFill.fillingBlue;
        }
      }
    }

    bool ringCrown = (spec?.global['crown'] ?? const <String>[]).isNotEmpty;
    bool twoHorizontal = (spec?.global['status'] ?? const <String>[])
        .map((e) => e.toUpperCase())
        .any((c) =>
    c == 'MIS' || c.startsWith('MIS') || c == 'MAM' || c == 'MPM' || c == 'EXT' || c == 'SOX' || c == 'MJA');
    bool oneVertical = (spec?.global['root'] ?? const <String>[])
        .map((e) => e.toUpperCase())
        .any((c) => c == 'IPX' || c.startsWith('IPX'));

    bool markDenture = false, markAbut = false, markPontic = false;
    for (final sp in p.spans) {
      if (!sp.teeth.contains(fdi)) continue;
      if (sp.type == DentalSpanType.dentureOrtho) {
        markDenture = true;
      } else {
        if (sp.abutments.contains(fdi)) markAbut = true;
        if (sp.pontics.contains(fdi)) markPontic = true;
      }
    }

    // 2) “선택 중”인 코드로 오버레이(미리보기 전용, 실제 저장 아님)
    if (pendingSel != null) {
      if (mode == _EditMode.surface) {
        // Fillings/Periodontium만 허용
        if (pendingSel!.category == 'Fillings') {
          final last = pendingSel!.path.isNotEmpty ? pendingSel!.path.last : null;
          final isCar = last != null && _isCariesThree(last);
          for (final s in pickedSurfaces) {
            fill[s] = isCar ? _SurfaceFill.cariesRed : _SurfaceFill.fillingBlue;
          }
        } else if (pendingSel!.category == 'Periodontium') {
          // Periodontium은 기존처럼 색 채움 없음(하이라이트만 영향)
        }
      } else {
        // Global 미리보기: 그룹별 시각표시 반영
        const cat2group = <String, String>{
          'Bite and occlusion': 'bite',
          'Tooth position': 'position',
          'Status': 'status',
          'Root': 'root',
          'Crowns': 'crown',
          'Crown pathology': 'crown pathology'
        };
        final code = pendingSel!.path.isNotEmpty ? pendingSel!.path.last : null;
        final g = cat2group[pendingSel!.category];
        if (code != null && g != null) {
          if (g == 'crown') ringCrown = true;
          if (g == 'status') {
            final c = code.toUpperCase();
            twoHorizontal = (c == 'MIS' ||
                c.startsWith('MIS') ||
                c == 'MAM' ||
                c == 'MPM' ||
                c == 'EXT' ||
                c == 'SOX' ||
                c == 'MJA');
          }
          if (g == 'root') {
            final c = code.toUpperCase();
            oneVertical = (c == 'IPX' || c.startsWith('IPX'));
          }
        }
      }
    }

    // 3) 하이라이트(보라색) 판단: 저장값 + “선택중” + 메모 입력 고려
    bool anyGlobal = spec?.global.values.any((lst) => lst.isNotEmpty) ?? false;
    bool anySurface = false;
    if (spec != null) {
      for (final s in interp.kToothSurfaces) {
        final f = (spec.surface[s]?['fillings'] ?? const <String>[]);
        final pr = (spec.surface[s]?['periodontium'] ?? const <String>[]);
        if (f.isNotEmpty || pr.isNotEmpty) {
          anySurface = true;
          break;
        }
      }
    }
    final bool anyNote = ((spec?.toothNote ?? '').trim().isNotEmpty) ||
        (((spec?.surfaceNote ?? const <String, String>{}).values).any((v) => v.trim().isNotEmpty));

    // “선택 중” 효과도 입력으로 간주
    final hasPendingGlobal = (mode == _EditMode.global && pendingSel != null);
    final hasPendingSurface = (mode == _EditMode.surface && pendingSel != null && pickedSurfaces.isNotEmpty);
    final hasPendingNote = pendingNote.trim().isNotEmpty;

    final hasAnyInput =
        anyGlobal || anySurface || anyNote || hasPendingGlobal || hasPendingSurface || hasPendingNote;

    final hasSurfacePaint = fill.values.any((f) => f != _SurfaceFill.none);
    final hasBlueRing = ringCrown || markAbut;
    final hasBlueLines = markPontic || twoHorizontal || oneVertical;
    final hasOwnVisual = hasSurfacePaint || hasBlueRing || hasBlueLines || markDenture;
    final highlightAny = hasAnyInput && !hasOwnVisual;

    return Column(
      children: [
        Text('$fdi', style: const TextStyle(fontWeight: FontWeight.w700)),
        const SizedBox(height: 6),
        SizedBox(
          width: size,
          height: size,
          child: CustomPaint(
            painter: _FiveSurfacePainter(
              mesialOnRight: _mesialOnRight,
              fill: fill,
              abut: markAbut,
              pontic: markPontic,
              ringCrown: ringCrown,
              twoHorizontal: twoHorizontal,
              oneVertical: oneVertical,
              highlightAny: highlightAny,
            ),
          ),
        ),
      ],
    );
  }
}

/// ─────────────────────────────────────────────────────────────────
/// Interpol 인라인 피커: 트리 모드 + 하위코드 중복제외 + 레벨무관 선택 허용
class _InterpolPickerInline extends StatefulWidget {
  final String title;
  final List<String> Function(List<String> all)? categoryFilter;
  final void Function(CodeSelection sel) onConfirm;
  final void Function(bool hasCodeSelected)? onHasCodeChanged;
  final Set<String>? excludeCodes; // 즐겨찾기 항목 중복 제거

  const _InterpolPickerInline({
    Key? key,
    required this.title,
    this.categoryFilter,
    required this.onConfirm,
    this.onHasCodeChanged,
    this.excludeCodes,
  }) : super(key: key);

  @override
  State<_InterpolPickerInline> createState() => _InterpolPickerInlineState();
}

class _InterpolPickerInlineState extends State<_InterpolPickerInline> {
  String? cat;
  final List<String> path = [];
  bool _treeMode = false; // 트리/드롭다운 전환
  String _search = ''; // 레이블/코드 검색 필터

  Set<String> get _exclude => (widget.excludeCodes ?? const <String>{}).map((e) => e.toUpperCase()).toSet();

  CodeSelection? get currentSelection {
    if (cat == null) return null;
    final sel = CodeSelection(category: cat!, path: List<String>.from(path));
    // 레벨과 무관: 경로가 1개 이상이면 유효로 본다
    final valid = path.isNotEmpty;
    return valid ? sel : null;
  }

  void _notifyHasCode() {
    widget.onHasCodeChanged?.call(currentSelection != null);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      try {
        await context.read<DentalDataProvider>().loadCodeTreeOnce();
        if (mounted) setState(() {});
        _notifyHasCode();
      } catch (_) {
        _notifyHasCode();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('코드 트리 로딩 실패.')),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final p = context.watch<DentalDataProvider>();
    var cats = ic.availableCategories();
    if (widget.categoryFilter != null) cats = widget.categoryFilter!(cats);

    List<CodeNode> childrenOf(List<String> prefix) {
      final category = cat;
      if (category == null) return const <CodeNode>[];
      var list = ic.listChildren(category, prefix);   // ⬅️ provider 경유 금지!
      if (_search.trim().isNotEmpty) {
        final kw = _search.trim().toLowerCase();
        list = list.where((n) =>
        n.code.toLowerCase().contains(kw) ||
            n.label.toLowerCase().contains(kw)
        ).toList();
      }
      return list;
    }

    // ── 드롭다운(동적 레벨) 빌더 ─────────────────────────
    List<Widget> _buildDropdownCascade() {
      final widgets = <Widget>[];
      if (cat == null) return widgets;

      // level 0 부터, children이 있는 동안 계속 다음 레벨 드롭다운을 만듦
      List<String> prefix = const [];
      int level = 0;

      while (true) {
        final items = childrenOf(prefix);
        if (items.isEmpty) break;

        final cur = (path.length > level) ? path[level] : null;
        widgets.add(
          DropdownButtonFormField<String>(
            isExpanded: true,
            value: cur,
            decoration: InputDecoration(labelText: 'Level ${level + 1}'),
            items: items
                .map((n) => DropdownMenuItem(
              value: n.code,
              child: Text('${n.code} — ${n.label}', overflow: TextOverflow.ellipsis),
            ))
                .toList(),
            onChanged: (v) {
              if (v == null) return;
              setState(() {
                // level 이후 경로 절단 후 현재 레벨 값을 세팅
                if (path.length > level) path.removeRange(level, path.length);
                if (path.length == level) {
                  path.add(v);
                } else {
                  path[level] = v;
                }
                _notifyHasCode();
              });
            },
          ),
        );

        // 다음 레벨로 진행
        if (path.length <= level) break;
        prefix = [...prefix, path[level]];
        level += 1;
        widgets.add(const SizedBox(height: 8));
      }

      // 가이드
      widgets.add(const SizedBox(height: 12));
      if (path.isEmpty) {
        widgets.add(const Text(
          '카테고리만 고른 상태입니다. LEVEL 1~N 중 아무 단계나 선택해도 됩니다.',
          style: TextStyle(color: Colors.redAccent, fontSize: 12),
        ));
      }
      return widgets;
    }

    // ── 트리(무한 깊이) 빌더 ───────────────────────────
    List<Widget> _buildTreeLevel(List<String> prefix) {
      final items = childrenOf(prefix);
      return items.map((n) {
        final next = [...prefix, n.code];
        final kids = childrenOf(next);
        final title = Text('${n.code} — ${n.label}');
        if (kids.isEmpty) {
          return ListTile(
            dense: true,
            title: title,
            onTap: () {
              setState(() {
                path
                  ..clear()
                  ..addAll(next);
              });
              _notifyHasCode();
            },
          );
        }
        return ExpansionTile(
          title: Row(
            children: [
              Expanded(child: title),
              TextButton(
                onPressed: () {
                  setState(() {
                    path
                      ..clear()
                      ..addAll(next);
                  });
                  _notifyHasCode();
                },
                child: const Text('선택'),
              ),
            ],
          ),
          children: _buildTreeLevel(next),
        );
      }).toList();
    }

    return ExpansionTile(
      title: Text(widget.title),
      initiallyExpanded: false,
      childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      children: [
        DropdownButtonFormField<String>(
          isExpanded: true,
          value: (cats.contains(cat)) ? cat : null,
          decoration: const InputDecoration(labelText: 'Category'),
          hint: const Text('(System code/text를 선택하세요.)'),
          items: cats.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
          onChanged: (v) => setState(() {
            cat = v;
            path.clear();
            _notifyHasCode();
          }),
        ),
        const SizedBox(height: 8),

        if (cat != null) ...[
          // (옵션) 라벨/코드 검색
          TextField(
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.search),
              hintText: '코드 또는 라벨 검색',
              border: OutlineInputBorder(),
            ),
            onChanged: (t) => setState(() => _search = t),
          ),
          const SizedBox(height: 8),

          // 트리/드롭다운 토글
          SwitchListTile.adaptive(
            dense: true,
            title: const Text('트리 모드(레벨1~N 자유 선택)'),
            contentPadding: EdgeInsets.zero,
            value: _treeMode,
            onChanged: (v) => setState(() => _treeMode = v),
          ),
          const SizedBox(height: 8),

          if (_treeMode) ...[
            ..._buildTreeLevel(const []),
          ] else ...[
            ..._buildDropdownCascade(),
          ],

          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: Text(
                  '현재 선택: ${cat ?? "-"}${path.isEmpty ? "" : " · ${path.join(" > ")}"}',
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.black54),
                ),
              ),
              TextButton.icon(
                onPressed: () => setState(() => path.clear()),
                icon: const Icon(Icons.clear),
                label: const Text('경로 초기화'),
              ),
            ],
          ),
        ],
        const SizedBox(height: 4),
      ],
    );
  }
}

/// ─────────────────────────────────────────────────────────────────
/// Interpol → 635 전역/표면에 “덮어쓰기” 반영 (토글 API만 사용)
void applyInterpolToGlobal635WithToggles(
    BuildContext context,
    int fdi,
    CodeSelection sel,
    ) {
  final p = context.read<DentalDataProvider>();

  const cat2group = <String, String>{
    'Bite and occlusion': 'bite',
    'Tooth position': 'position',
    'Status': 'status',
    'Root': 'root',
    'Crowns': 'crown',
    'Crown pathology': 'crown pathology'
  };

  final code = (sel.path.isNotEmpty) ? sel.path.last : null;
  final group = cat2group[sel.category];
  if (code == null || group == null) return;

  final prev = p.getSpecRead(fdi)?.global[group] ?? const <String>[];
  for (final c in prev) {
    if (c != code) {
      p.toggleGlobalCode(fdi, group, c);
    }
  }
  final cur = p.getSpecRead(fdi)?.global[group] ?? const <String>[];
  if (!cur.contains(code)) {
    p.toggleGlobalCode(fdi, group, code);
  }
}

void applyInterpolToSurface635WithToggles(
    BuildContext context,
    int fdi,
    String surface,
    CodeSelection sel,
    ) {
  final p = context.read<DentalDataProvider>();

  String? group;
  if (sel.category == 'Fillings') {
    group = 'fillings';
  } else if (sel.category == 'Periodontium') {
    group = 'periodontium';
  } else {
    return;
  }

  final code = (sel.path.isNotEmpty) ? sel.path.last : null;
  if (code == null) return;

  final prev = p.getSpecRead(fdi)?.surface[surface]?[group] ?? const <String>[];
  for (final c in prev) {
    if (c != code) {
      p.toggleSurfaceCode(fdi, surface, group, c);
    }
  }
  final cur = p.getSpecRead(fdi)?.surface[surface]?[group] ?? const <String>[];
  if (!cur.contains(code)) {
    p.toggleSurfaceCode(fdi, surface, group, code);
  }
}

/// ─────────────────────────────────────────────────────────────────
/// 그리기 유틸
enum _SurfaceFill { none, toggleAmber, fillingBlue, cariesRed }

class _FiveSurfacePainter extends CustomPainter {
  final bool mesialOnRight;
  final Map<String, _SurfaceFill> fill;

  final bool abut; // 지대치 → 파란 링
  final bool pontic; // pontic → 수평 2줄

  final bool ringCrown; // crown 선택 시 링
  final bool twoHorizontal; // status MIS* → 수평 2줄
  final bool oneVertical; // root IPX* → 수직 1줄

  final bool highlightAny; // 보라색 테두리

  const _FiveSurfacePainter({
    required this.mesialOnRight,
    required this.fill,
    this.abut = false,
    this.pontic = false,
    this.ringCrown = false,
    this.twoHorizontal = false,
    this.oneVertical = false,
    this.highlightAny = false,
  });

  @override
  void paint(Canvas canvas, Size s) {
    final g = _Geom(s);

    final outerStroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = (s.width * .04).clamp(1.0, 2.0)
      ..color = highlightAny ? Colors.deepPurple : Colors.black87;

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

    final l = fill['L'] ?? _SurfaceFill.none;
    final b = fill['B'] ?? _SurfaceFill.none;
    final o = fill['O'] ?? _SurfaceFill.none;
    final m = fill['M'] ?? _SurfaceFill.none;
    final d = fill['D'] ?? _SurfaceFill.none;

    if (l != _SurfaceFill.none) canvas.drawPath(g.pathL, paintOf(l));
    if (b != _SurfaceFill.none) canvas.drawPath(g.pathB, paintOf(b));
    if (o != _SurfaceFill.none) canvas.drawRect(g.rectO, paintOf(o));

    final leftFill = mesialOnRight ? d : m;
    final rightFill = mesialOnRight ? m : d;
    if (leftFill != _SurfaceFill.none) canvas.drawPath(g.pathLeft, paintOf(leftFill));
    if (rightFill != _SurfaceFill.none) canvas.drawPath(g.pathRight, paintOf(rightFill));

    // 윤곽/내부선
    canvas.drawRRect(g.outerRRect, outerStroke);
    canvas.drawRect(g.rectO, innerStroke);

    final oc = [g.outerRect.topLeft, g.outerRect.topRight, g.outerRect.bottomRight, g.outerRect.bottomLeft];
    final ic = [g.rectO.topLeft, g.rectO.topRight, g.rectO.bottomRight, g.rectO.bottomLeft];
    for (int i = 0; i < 4; i++) {
      canvas.drawLine(ic[i], oc[i], innerStroke);
    }

    // 파란 공통
    final blue = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = (s.width * .06).clamp(1.2, 2.4)
      ..color = Colors.blueAccent;

    if (ringCrown || abut) {
      final ring = g.outerRect.deflate(s.width * .18);
      canvas.drawRRect(
        RRect.fromRectAndRadius(ring, Radius.circular(ring.width * .20)),
        blue,
      );
    }

    if (pontic || twoHorizontal) {
      final y1 = s.height * .40, y2 = s.height * .60;
      canvas.drawLine(Offset(s.width * .18, y1), Offset(s.width * .82, y1), blue);
      canvas.drawLine(Offset(s.width * .18, y2), Offset(s.width * .82, y2), blue);
    }

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
          old.oneVertical != oneVertical ||
          old.highlightAny != highlightAny;

  bool _mapEquals(Map<String, _SurfaceFill> a, Map<String, _SurfaceFill> b) {
    if (identical(a, b)) return true;
    if (a.length != b.length) return false;
    for (final k in interp.kToothSurfaces) {
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
    outerRect = Offset.zero & s;
    outerRRect = RRect.fromRectAndRadius(outerRect.deflate(1), Radius.circular(s.width * .12));

    final w = s.width, h = s.height;
    // 사용자의 방패연(가로직사각형 + 4개 코너 대각) 요구 반영
    final rectW = w * .54;
    final rectH = h * .36;
    rectO = Rect.fromCenter(center: outerRect.center, width: rectW, height: rectH);

    pathL = Path()
      ..moveTo(outerRect.left, outerRect.top)
      ..lineTo(outerRect.right, outerRect.top)
      ..lineTo(rectO.right, rectO.top)
      ..lineTo(rectO.left, rectO.top)
      ..close();

    pathB = Path()
      ..moveTo(outerRect.left, outerRect.bottom)
      ..lineTo(outerRect.right, outerRect.bottom)
      ..lineTo(rectO.right, rectO.bottom)
      ..lineTo(rectO.left, rectO.bottom)
      ..close();

    pathLeft = Path()
      ..moveTo(outerRect.left, outerRect.top)
      ..lineTo(rectO.left, rectO.top)
      ..lineTo(rectO.left, rectO.bottom)
      ..lineTo(outerRect.left, outerRect.bottom)
      ..close();

    pathRight = Path()
      ..moveTo(outerRect.right, outerRect.top)
      ..lineTo(rectO.right, rectO.top)
      ..lineTo(rectO.right, rectO.bottom)
      ..lineTo(outerRect.right, outerRect.bottom)
      ..close();
  }
}

/// getSpecRead가 null이어도 안전한 뷰
class _SpecView {
  final int fdi;
  final dynamic _raw;
  _SpecView(this.fdi, this._raw);

  Map<String, List<String>> get global {
    if (_raw?.global != null) return _raw!.global;
    return <String, List<String>>{
      'bite': <String>[],
      'position': <String>[],
      'status': <String>[],
      'root': <String>[],
      'crown': <String>[],
      'crown pathology': <String>[],
    };
  }

  Map<String, Map<String, List<String>>> get surface {
    if (_raw?.surface != null) return _raw!.surface;
    return {
      for (final s in interp.kToothSurfaces)
        s: <String, List<String>>{
          'fillings': <String>[],
          'periodontium': <String>[],
        }
    };
  }

  String get toothNote => (_raw?.toothNote ?? '').trim();

  Map<String, String> get surfaceNote {
    if (_raw?.surfaceNote != null) return _raw!.surfaceNote;
    return {for (final s in interp.kToothSurfaces) s: ''};
  }
}

class _CurrentStateInlineSummary extends StatelessWidget {
  final int fdi;
  const _CurrentStateInlineSummary({super.key, required this.fdi});

  @override
  Widget build(BuildContext context) {
    final p = context.watch<DentalDataProvider>();
    final spec = p.getSpecRead(fdi);
    String _ellipsis(String s, int n) => s.length <= n ? s : '${s.substring(0, n)}…';

    // 안전 뷰로 변환
    final view = _SpecView(fdi, spec);

    final g = view.global;
    final s = view.surface;
    final toothNote = view.toothNote;

    String joinMapList(Map<String, List<String>> m, List<String> keys) {
      final parts = <String>[];
      for (final k in keys) {
        final v = m[k] ?? const <String>[];
        if (v.isNotEmpty) parts.add('$k:${v.join("/")}');
      }
      return parts.join(' · ');
    }

    String surfLine() {
      final buf = <String>[];
      for (final surf in interp.kToothSurfaces) {
        final f = (s[surf]?['fillings'] ?? const <String>[]);
        final pds = (s[surf]?['periodontium'] ?? const <String>[]);
        if (f.isEmpty && pds.isEmpty) continue;
        final inner = [
          if (f.isNotEmpty) 'F:${f.join("/")}',
          if (pds.isNotEmpty) 'P:${pds.join("/")}',
        ].join(',');
        buf.add('$surf($inner)');
      }
      return buf.join(' · ');
    }

    final gLine = joinMapList(g, ['bite', 'position', 'status', 'root', 'crown', 'crown pathology']);
    final sLine = surfLine();

    // 아무 것도 없으면 감춤
    if (gLine.isEmpty && sLine.isEmpty && toothNote.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.06),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('현재 저장 상태', style: TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(height: 6),
          if (gLine.isNotEmpty) Text('전역: $gLine', style: const TextStyle(fontSize: 12)),
          if (sLine.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Text('표면: $sLine', style: const TextStyle(fontSize: 12)),
            ),
          if (toothNote.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Text('메모: ${_ellipsis(toothNote, 80)}',
                  style: const TextStyle(fontSize: 12, color: Colors.black87)),
            ),
        ],
      ),
    );
  }
}

class _ToothPreviewLarge extends StatelessWidget {
  final int fdi;
  final double size;
  const _ToothPreviewLarge({super.key, required this.fdi, required this.size});

  bool get _mesialOnRight {
    final q = fdi ~/ 10;
    if (q == 1 || q == 4 || q == 5 || q == 8) return true;
    if (q == 2 || q == 3 || q == 6 || q == 7) return false;
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final p = context.watch<DentalDataProvider>();
    final spec = p.getSpecRead(fdi);

    final Map<String, _SurfaceFill> fill = {
      for (final s in interp.kToothSurfaces) s: _SurfaceFill.none,
    };
    if (spec != null) {
      for (final s in interp.kToothSurfaces) {
        final list = spec.surface[s]!['fillings']!;
        final hasCaries = list.any(_isCariesThree);
        if (hasCaries) {
          fill[s] = _SurfaceFill.cariesRed;
        } else if (list.isNotEmpty) {
          fill[s] = _SurfaceFill.fillingBlue;
        }
      }
    }

    final bool ringCrown = (spec?.global['crown'] ?? const <String>[]).isNotEmpty;
    final bool markStatusMissing = (spec?.global['status'] ?? const <String>[])
        .map((e) => e.toUpperCase())
        .any((c) => c == 'MIS' || c.startsWith('MIS') || c == 'MAM' || c == 'MPM' || c == 'EXT' || c == 'SOX' || c == 'MJA');
    final bool markRootImplant = (spec?.global['root'] ?? const <String>[])
        .map((e) => e.toUpperCase())
        .any((c) => c == 'IPX' || c.startsWith('IPX'));

    bool markDenture = false, markAbut = false, markPontic = false;
    for (final sp in p.spans) {
      if (!sp.teeth.contains(fdi)) continue;
      if (sp.type == DentalSpanType.dentureOrtho) {
        markDenture = true;
      } else {
        if (sp.abutments.contains(fdi)) markAbut = true;
        if (sp.pontics.contains(fdi)) markPontic = true;
      }
    }

    bool hasAnyInput = false;
    if (spec != null) {
      for (final s in interp.kToothSurfaces) {
        final f = (spec.surface[s]?['fillings'] ?? const <String>[]);
        final pr = (spec.surface[s]?['periodontium'] ?? const <String>[]);
        if (f.isNotEmpty || pr.isNotEmpty) {
          hasAnyInput = true;
          break;
        }
      }
      if (!hasAnyInput) {
        for (final g in const ['bite', 'crown', 'root', 'status', 'position', 'crown pathology']) {
          if ((spec.global[g] ?? const <String>[]).isNotEmpty) {
            hasAnyInput = true;
            break;
          }
        }
      }
      if (!hasAnyInput) {
        if ((spec.toothNote ?? '').trim().isNotEmpty ||
            spec.surfaceNote.values.any((v) => v.trim().isNotEmpty)) {
          hasAnyInput = true;
        }
      }
    }

    final hasSurfacePaint = fill.values.any((f) => f != _SurfaceFill.none);
    final hasBlueRing = ringCrown || markAbut;
    final hasBlueLines = markPontic || markStatusMissing || markRootImplant;
    final hasOwnVisual = hasSurfacePaint || hasBlueRing || hasBlueLines || markDenture;
    final highlightAny = hasAnyInput && !hasOwnVisual;

    return Column(
      children: [
        Text('$fdi', style: const TextStyle(fontWeight: FontWeight.w700)),
        const SizedBox(height: 6),
        SizedBox(
          width: size,
          height: size,
          child: CustomPaint(
            painter: _FiveSurfacePainter(
              mesialOnRight: _mesialOnRight,
              fill: fill,
              abut: markAbut,
              pontic: markPontic,
              ringCrown: ringCrown,
              twoHorizontal: markStatusMissing,
              oneVertical: markRootImplant,
              highlightAny: highlightAny,
            ),
          ),
        ),
      ],
    );
  }
}

typedef _QuickPick = void Function(String category, String code);

class _FrequentlyUsedPanel extends StatelessWidget {
  final _EditMode mode;
  final _QuickPick onPick;
  const _FrequentlyUsedPanel({super.key, required this.mode, required this.onPick});

  @override
  Widget build(BuildContext context) {
    final groups = (mode == _EditMode.surface) ? kFavSurfaceGroups() : kFavGlobalGroups();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Frequently Used', style: TextStyle(fontWeight: FontWeight.w700)),
        const SizedBox(height: 6),
        ...groups.entries.map((e) => _groupChips(context, e.key, e.value)),
      ],
    );
  }

  Widget _groupChips(BuildContext context, String category, List<String> codes) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(category, style: const TextStyle(fontSize: 12, color: Colors.black54)),
          const SizedBox(height: 4),
          Wrap(
            spacing: 8,
            runSpacing: 6,
            children: codes.map((code) {
              final label = _labelFor(context, category, code) ?? '';
              final text = label.isEmpty ? code : '$code — $label';
              return ActionChip(
                label: Text(text, overflow: TextOverflow.ellipsis),
                onPressed: () => onPick(category, code),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  /// 코드 → 시스템 텍스트 조회 (카테고리 트리 BFS)
  String? _labelFor(BuildContext context, String category, String code) {
    final p = context.read<DentalDataProvider>();
    final want = code.toUpperCase();
    final visited = <String>{};
    List<CodeNode> childrenOf(List<String> prefix) => p.listChildren(category, prefix);

    String? search(List<String> prefix) {
      final key = '${prefix.join(">")}';
      if (!visited.add(key)) return null;

      for (final n in childrenOf(prefix)) {
        if (n.code.toUpperCase() == want) return n.label;
        final lab = search([...prefix, n.code]);
        if (lab != null) return lab;
      }
      return null;
    }

    try {
      return search(const []);
    } catch (_) {
      return null;
    }
  }
}


// import 'dart:math' show min, max;
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// import '../providers/dental_data_provider.dart';
// import '../data/codes_635.dart';
// import '../data/surface_fill.dart';
//
// /// (레거시 보존용) 다른 곳에서 참조할 수 있는 stub
// enum _EditMode { global, surface }
//
// /// ─────────────────────────────────────────────────────────────────
// /// 공통: 충치 3종 판단
// bool _isCariesThree(String c) {
//   final u = c.toUpperCase();
//   return u == 'CAR' || u == 'ACA' || u == 'CCA';
// }
//
// /// ─────────────────────────────────────────────────────────────────
// /// 즐겨찾기(스프레드시트 재분류 반영)
// Map<String, List<String>> kFavSurfaceGroups() => {
//   'Fillings': ['CAR', 'UIF', 'CAV', 'AMF', 'TCF', 'COF', 'FIS', 'GOI', 'POI'],
//   // Periodontium 자주 쓰는 항목이 있으면 여기에 추가
// };
//
// Map<String, List<String>> kFavGlobalGroups() => {
//   // CAR는 Fillings로, ROV는 Status로, IPX는 Root로 분류
//   'Status': ['INT', 'MAM', 'MPM', 'CFR', 'IMX', 'IMV', 'ERU', 'ROV'],
//   'Root': ['RFX', 'IPX'],
//   'Crowns': ['UIC', 'MTC', 'GOC', 'MEC', 'TCC', 'MCC', 'POC', 'TEC'],
// };
//
// Set<String> favCodesUpperForMode(_EditMode mode) {
//   final m = (mode == _EditMode.surface) ? kFavSurfaceGroups() : kFavGlobalGroups();
//   return m.values.expand((e) => e).map((c) => c.toUpperCase()).toSet();
// }
//
// /// ─────────────────────────────────────────────────────────────────
// /// 사분면(축소) 화면: 핀치 줌 제거, 치아 탭 시 단일치아 에디터로 이동
// class QuadrantZoomScreen extends StatelessWidget {
//   final String title;
//   final bool isUpper; // 상악 true
//   final bool isPermanent; // 라벨/표시용
//   final List<int> teeth; // 예: [18..11], [21..28] 등
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
//   Widget build(BuildContext context) {
//     final numbersOnTop = isUpper;
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(title),
//         actions: [
//           IconButton(
//             tooltip: '도움말',
//             icon: const Icon(Icons.help_outline),
//             onPressed: () => _showHelp(context),
//           ),
//         ],
//       ),
//       body: LayoutBuilder(
//         builder: (context, c) {
//           const spacing = 12.0;
//           final n = teeth.length; // 8 or 5
//           final tile = ((c.maxWidth - spacing * (n - 1)) / n).clamp(28.0, 90.0);
//           final rowWidth = n * tile + (n - 1) * spacing;
//
//           return Stack(
//             children: [
//               // 치아 행
//               Center(
//                 child: SizedBox(
//                   width: rowWidth,
//                   child: Stack(
//                     children: [
//                       Positioned.fill(
//                         child: _RowDentureOverlayPainterWidget(
//                           teeth: teeth,
//                           tile: tile,
//                           spacing: spacing,
//                         ),
//                       ),
//                       Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           for (final fdi in teeth) ...[
//                             SizedBox(
//                               width: tile,
//                               child: Column(
//                                 mainAxisSize: MainAxisSize.min,
//                                 children: [
//                                   if (numbersOnTop)
//                                     GestureDetector(
//                                       behavior: HitTestBehavior.opaque,
//                                       onLongPress: () => _openOneToothEditor(context, fdi),
//                                       child: _ToothNumber(fdi, tile),
//                                     ),
//                                   _BigToothTileSimple(
//                                     fdi: fdi,
//                                     size: tile,
//                                     onOpenEditor: _openOneToothEditor,
//                                   ),
//                                   if (!numbersOnTop)
//                                     GestureDetector(
//                                       behavior: HitTestBehavior.opaque,
//                                       onLongPress: () => _openOneToothEditor(context, fdi),
//                                       child: _ToothNumber(fdi, tile),
//                                     ),
//                                 ],
//                               ),
//                             ),
//                             if (fdi != teeth.last) const SizedBox(width: spacing),
//                           ],
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//
//               // 우상단 요약 패널(기록 있으면 표시)
//               Positioned(
//                 top: 4,
//                 right: 4,
//                 child: ConstrainedBox(
//                   constraints: const BoxConstraints(maxWidth: 280),
//                   child: _QuadrantInfoOverlay(teeth: teeth),
//                 ),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }
//
//   void _showHelp(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       showDragHandle: true,
//       builder: (_) => const Padding(
//         padding: EdgeInsets.fromLTRB(16, 12, 16, 16),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('화면 사용법', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
//             SizedBox(height: 8),
//             Text("• 치아 한 번 탭: 단일치아 편집 화면으로 이동합니다."),
//             Text("• 숫자(치아 번호) 길게 누르기: 동일하게 단일치아 편집 화면으로 이동합니다."),
//             SizedBox(height: 12),
//             Align(
//               alignment: Alignment.centerRight,
//               child: Text('닫으려면 바깥을 탭하세요', style: TextStyle(color: Colors.black54)),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Future<void> _openOneToothEditor(BuildContext context, int fdi) async {
//     await Navigator.of(context).push(
//       MaterialPageRoute(builder: (_) => SingleToothEditorScreen(fdi: fdi)),
//     );
//   }
// }
//
// /// ─────────────────────────────────────────────────────────────────
// /// 우상단 요약 패널: 입력 있는 치아/스팬만 요약
// class _QuadrantInfoOverlay extends StatelessWidget {
//   final List<int> teeth;
//   const _QuadrantInfoOverlay({required this.teeth});
//
//   @override
//   Widget build(BuildContext context) {
//     final p = context.watch<DentalDataProvider>();
//     final specs = <int, _SpecView>{
//       for (final t in teeth) t: _SpecView(t, p.getSpecRead(t))
//     };
//
//     final items = specs.entries
//         .where((e) {
//       final s = e.value;
//       final anyGlobal = s.global.values.any((lst) => lst.isNotEmpty);
//       final anySurf = interp.kToothSurfaces.any((x) {
//         final m = s.surface[x];
//         if (m == null) return false;
//         return (m['fillings'] ?? const <String>[]).isNotEmpty ||
//             (m['periodontium'] ?? const <String>[]).isNotEmpty;
//       });
//       final anyNote =
//           s.toothNote.isNotEmpty || s.surfaceNote.values.any((v) => v.trim().isNotEmpty);
//       return anyGlobal || anySurf || anyNote;
//     })
//         .toList()
//       ..sort((a, b) => a.key.compareTo(b.key));
//
//     final spans = p.spans.where((sp) => sp.teeth.any(teeth.contains)).toList();
//
//     if (items.isEmpty && spans.isEmpty) return const SizedBox.shrink();
//
//     return Card(
//       elevation: 2,
//       margin: const EdgeInsets.only(top: 4, right: 4),
//       child: Padding(
//         padding: const EdgeInsets.fromLTRB(12, 8, 12, 10),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text('요약', style: TextStyle(fontWeight: FontWeight.w700)),
//             const SizedBox(height: 6),
//
//             if (spans.isNotEmpty) ...[
//               Row(
//                 children: [
//                   const Icon(Icons.linear_scale, size: 16),
//                   const SizedBox(width: 6),
//                   Text('스팬 ${spans.length}개', style: const TextStyle(fontWeight: FontWeight.w600)),
//                 ],
//               ),
//               const SizedBox(height: 4),
//               ...spans.map((sp) => Padding(
//                 padding: const EdgeInsets.only(bottom: 2),
//                 child: Text(_spanLine(sp, teeth), style: const TextStyle(fontSize: 12)),
//               )),
//               const Divider(),
//             ],
//
//             ...items.map((e) {
//               final fdi = e.key;
//               final s = e.value;
//               final globals = _pickGlobalsOneLine(s.global);
//               final surfaces = _pickSurfacesOneLine(s.surface);
//               final note = s.toothNote;
//
//               return Padding(
//                 padding: const EdgeInsets.only(bottom: 8),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text('[$fdi]', style: const TextStyle(fontWeight: FontWeight.w700)),
//                     if (globals.isNotEmpty) Text('전역: $globals', style: const TextStyle(fontSize: 12)),
//                     if (surfaces.isNotEmpty)
//                       Text('표면: $surfaces', style: const TextStyle(fontSize: 12)),
//                     if (note.isNotEmpty)
//                       Text('메모: ${_ellipsis(note, 60)}',
//                           style: const TextStyle(fontSize: 12, color: Colors.black87)),
//                   ],
//                 ),
//               );
//             }),
//           ],
//         ),
//       ),
//     );
//   }
//
//   String _spanLine(DentalSpan sp, List<int> visible) {
//     final typ = sp.type == DentalSpanType.dentureOrtho ? 'Denture/Ortho' : 'Bridge';
//     final range = _fmtSpanTeeth(sp.teeth.where(visible.contains));
//     String ap = '';
//     if (sp.type != DentalSpanType.dentureOrtho) {
//       ap =
//       ' · Abut:${_fmtSpanTeeth(sp.abutments)} · Pontic:${_fmtSpanTeeth(sp.pontics)}';
//     }
//     return '$typ  $range$ap';
//   }
//
//   String _fmtSpanTeeth(Iterable<int> it) {
//     final ts = it.toList()..sort();
//     if (ts.isEmpty) return '-';
//     final buf = <String>[];
//     int start = ts.first, prev = ts.first;
//     for (int i = 1; i < ts.length; i++) {
//       if (ts[i] == prev + 1) {
//         prev = ts[i];
//       } else {
//         buf.add(start == prev ? '$start' : '$start–$prev');
//         start = prev = ts[i];
//       }
//     }
//     buf.add(start == prev ? '$start' : '$start–$prev');
//     return buf.join(', ');
//   }
//
//   String _pickGlobalsOneLine(Map<String, List<String>> g) {
//     const keys = ['bite', 'position', 'status', 'root', 'crown', 'crown pathology'];
//     final parts = <String>[];
//     for (final k in keys) {
//       final v = g[k] ?? const <String>[];
//       if (v.isNotEmpty) parts.add('$k:${v.join("/")}');
//     }
//     return parts.join(' · ');
//   }
//
//   String _pickSurfacesOneLine(Map<String, Map<String, List<String>>> m) {
//     final parts = <String>[];
//     for (final s in interp.kToothSurfaces) {
//       final f = (m[s]?['fillings'] ?? const <String>[]) as List<String>;
//       final p = (m[s]?['periodontium'] ?? const <String>[]) as List<String>;
//       if (f.isEmpty && p.isEmpty) continue;
//       final join = [
//         if (f.isNotEmpty) 'F:${f.join("/")}',
//         if (p.isNotEmpty) 'P:${p.join("/")}',
//       ].join(',');
//       parts.add('$s($join)');
//     }
//     return parts.join(' · ');
//   }
//
//   String _ellipsis(String s, int n) => s.length <= n ? s : '${s.substring(0, n)}…';
// }
//
// /// ─────────────────────────────────────────────────────────────────
// /// 덴쳐 스팬 오버레이(축소 행 전체에 파란 캡슐)
// class _RowDentureOverlayPainterWidget extends StatelessWidget {
//   final List<int> teeth;
//   final double tile;
//   final double spacing;
//   const _RowDentureOverlayPainterWidget({
//     required this.teeth,
//     required this.tile,
//     required this.spacing,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     final p = context.watch<DentalDataProvider>();
//     final spans =
//     p.spans.where((sp) => sp.type == DentalSpanType.dentureOrtho).toList();
//     return CustomPaint(
//       painter: _RowDentureOverlayPainter(
//         teeth: teeth,
//         tile: tile,
//         spacing: spacing,
//         spans: spans,
//       ),
//     );
//   }
// }
//
// class _RowDentureOverlayPainter extends CustomPainter {
//   final List<int> teeth;
//   final double tile;
//   final double spacing;
//   final List<DentalSpan> spans;
//   _RowDentureOverlayPainter({
//     required this.teeth,
//     required this.tile,
//     required this.spacing,
//     required this.spans,
//   });
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     if (teeth.isEmpty) return;
//
//     final rects = <int, Rect>{};
//     for (int i = 0; i < teeth.length; i++) {
//       final x = i * (tile + spacing);
//       rects[teeth[i]] = Rect.fromLTWH(x, 0, tile, tile);
//     }
//
//     final paintBlue = Paint()
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = (tile * .12).clamp(1.6, 3.2)
//       ..color = Colors.blueAccent;
//
//     for (final sp in spans) {
//       final inside = teeth.where(sp.teeth.contains).toList();
//       if (inside.isEmpty) continue;
//
//       // 연속 클러스터
//       final clusters = <List<int>>[];
//       List<int> cur = [];
//       for (int i = 0; i < inside.length; i++) {
//         if (cur.isEmpty) {
//           cur = [inside[i]];
//         } else {
//           final prevIdx = teeth.indexOf(cur.last);
//           final thisIdx = teeth.indexOf(inside[i]);
//           if (thisIdx == prevIdx + 1) {
//             cur.add(inside[i]);
//           } else {
//             clusters.add(cur);
//             cur = [inside[i]];
//           }
//         }
//       }
//       if (cur.isNotEmpty) clusters.add(cur);
//
//       for (final cluster in clusters) {
//         final left = rects[cluster.first]!;
//         final right = rects[cluster.last]!;
//         Rect union =
//         Rect.fromLTRB(left.left, left.top, right.right, right.bottom);
//
//         final marginX = tile * .18, marginY = tile * .12;
//         final rr = RRect.fromRectAndRadius(
//           union.inflate(marginX).deflate(0).inflate(0).deflate(-marginY),
//           Radius.circular(union.height),
//         );
//         canvas.drawRRect(rr, paintBlue);
//       }
//     }
//   }
//
//   @override
//   bool shouldRepaint(covariant _RowDentureOverlayPainter old) =>
//       old.teeth != teeth ||
//           old.tile != tile ||
//           old.spacing != spacing ||
//           old.spans != spans;
// }
//
// /// ─────────────────────────────────────────────────────────────────
// /// 번호/그리기(축소)
// class _ToothNumber extends StatelessWidget {
//   final int fdi;
//   final double size;
//   const _ToothNumber(this.fdi, this.size);
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: size * .6,
//       child: Center(
//         child: Text('$fdi', style: const TextStyle(fontWeight: FontWeight.w700)),
//       ),
//     );
//   }
// }
//
// /// 축소 그리기 + 탭 시 단일치아 에디터로 이동
// class _BigToothTileSimple extends StatelessWidget {
//   final int fdi;
//   final double size;
//   final void Function(BuildContext, int) onOpenEditor;
//
//   const _BigToothTileSimple({
//     required this.fdi,
//     required this.size,
//     required this.onOpenEditor,
//   });
//
//   bool get _mesialOnRight {
//     final q = fdi ~/ 10;
//     if (q == 1 || q == 4 || q == 5 || q == 8) return true; // 우측군
//     if (q == 2 || q == 3 || q == 6 || q == 7) return false; // 좌측군
//     return true;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final p = context.watch<DentalDataProvider>();
//     final spec = p.getSpecRead(fdi);
//
//     // 면 채우기
//     final Map<String, _SurfaceFill> fill = {
//       for (final s in kToothSurfaces) s: _SurfaceFill.none,
//     };
//     if (spec != null) {
//       for (final s in kToothSurfaces) {
//         final list = spec.surface[s]!['fillings']!;
//         final hasCaries = list.any(_isCariesThree);
//         if (hasCaries) {
//           fill[s] = _SurfaceFill.cariesRed;
//         } else if (list.isNotEmpty) {
//           fill[s] = _SurfaceFill.fillingBlue;
//         }
//       }
//     }
//
//     final bool ringCrown = (spec?.global['crown'] ?? const <String>[]).isNotEmpty;
//     final bool markStatusMissing = (spec?.global['status'] ?? const <String>[])
//         .map((e) => e.toUpperCase())
//         .any((c) =>
//     c == 'MIS' ||
//         c.startsWith('MIS') ||
//         c == 'MAM' ||
//         c == 'MPM' ||
//         c == 'EXT' ||
//         c == 'SOX' ||
//         c == 'MJA');
//     final bool markRootImplant = (spec?.global['root'] ?? const <String>[])
//         .map((e) => e.toUpperCase())
//         .any((c) => c == 'IPX' || c.startsWith('IPX'));
//
//     bool markDenture = false, markAbut = false, markPontic = false;
//     for (final sp in p.spans) {
//       if (!sp.teeth.contains(fdi)) continue;
//       if (sp.type == DentalSpanType.dentureOrtho) {
//         markDenture = true;
//       } else {
//         if (sp.abutments.contains(fdi)) markAbut = true;
//         if (sp.pontics.contains(fdi)) markPontic = true;
//       }
//     }
//
//     bool hasAnyInput = false;
//     if (spec != null) {
//       for (final s in kToothSurfaces) {
//         final f = (spec.surface[s]?['fillings'] ?? const <String>[]);
//         final pr = (spec.surface[s]?['periodontium'] ?? const <String>[]);
//         if (f.isNotEmpty || pr.isNotEmpty) {
//           hasAnyInput = true;
//           break;
//         }
//       }
//       if (!hasAnyInput) {
//         for (final g in const [
//           'bite',
//           'crown',
//           'root',
//           'status',
//           'position',
//           'crown pathology'
//         ]) {
//           if ((spec.global[g] ?? const <String>[]).isNotEmpty) {
//             hasAnyInput = true;
//             break;
//           }
//         }
//       }
//       if (!hasAnyInput) {
//         if ((spec.toothNote ?? '').trim().isNotEmpty ||
//             spec.surfaceNote.values.any((v) => v.trim().isNotEmpty)) {
//           hasAnyInput = true;
//         }
//       }
//     }
//
//     final hasSurfacePaint = fill.values.any((f) => f != _SurfaceFill.none);
//     final hasBlueRing = ringCrown || markAbut;
//     final hasBlueLines = markPontic || markStatusMissing || markRootImplant;
//     final hasOwnVisual =
//         hasSurfacePaint || hasBlueRing || hasBlueLines || markDenture;
//     final highlightAny = hasAnyInput && !hasOwnVisual;
//
//     return GestureDetector(
//       behavior: HitTestBehavior.opaque,
//       onTap: () => onOpenEditor(context, fdi),
//       onLongPress: () => onOpenEditor(context, fdi),
//       child: CustomPaint(
//         size: Size.square(size),
//         painter: _FiveSurfacePainter(
//           mesialOnRight: _mesialOnRight,
//           fill: fill,
//           abut: markAbut,
//           pontic: markPontic,
//           ringCrown: ringCrown,
//           twoHorizontal: markStatusMissing,
//           oneVertical: markRootImplant,
//           highlightAny: highlightAny,
//         ),
//       ),
//     );
//   }
// }
//
// /// ─────────────────────────────────────────────────────────────────
// /// (새 UI) 단일치아 편집 화면: 약어 우선 · 좌측 카테고리 → 우측 트리
// class SingleToothEditorScreen extends StatefulWidget {
//   final int fdi;
//   const SingleToothEditorScreen({super.key, required this.fdi});
//
//   @override
//   State<SingleToothEditorScreen> createState() =>
//       _SingleToothEditorScreenState();
// }
//
// /// 좌측 카테고리(스펙 이미지 구성과 일치)
// enum _Category { status, prosthesis, root, filling, denture, ortho, others }
//
// class _SingleToothEditorScreenState extends State<SingleToothEditorScreen> {
//   _Category cat = _Category.filling; // 기본: Filling
//   final Set<String> _pickedSurfaces = {'O'}; // OMDBL 다중선택(최소 1개)
//
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       context.read<DentalDataProvider>().loadCodeTreeOnce();
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final wide = MediaQuery.of(context).size.width >= 520;
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Tooth ${widget.fdi}'),
//         actions: [
//           IconButton(icon: const Icon(Icons.help_outline), onPressed: _showHelp),
//         ],
//       ),
//       body: SafeArea(
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             if (wide) SizedBox(width: 180, child: _categoryNav(vertical: true)),
//             Expanded(
//               child: ListView(
//                 padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
//                 children: [
//                   if (!wide) _categoryNav(vertical: false),
//
//                   if (cat == _Category.filling) ...[
//                     const SizedBox(height: 8),
//                     _omdblPicker(),
//                     const SizedBox(height: 6),
//                     const Text('※ 선택된 표면(OMDBL)에 아래 코드가 탭 즉시 적용됩니다.',
//                         style: TextStyle(fontSize: 12, color: Colors.black54)),
//                     const SizedBox(height: 12),
//                   ],
//
//                   // 즐겨찾기(약어만)
//                   _favPanel(),
//
//                   const Divider(height: 28),
//
//                   // 카테고리별 코드 트리(약어만, 임의 레벨 선택 가능)
//                   ..._treePanels(),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   // ── 좌측/상단 카테고리 네비 ──
//   Widget _categoryNav({required bool vertical}) {
//     final items = [
//       _NavItem(_Category.status, 'Status', Icons.check_circle_outline),
//       _NavItem(_Category.prosthesis, 'Prosthesis', Icons.workspace_premium_outlined), // Crowns/Bridges
//       _NavItem(_Category.root, 'Root', Icons.vertical_align_center),
//       _NavItem(_Category.filling, 'Filling', Icons.grid_on),
//       _NavItem(_Category.denture, 'Denture', Icons.emoji_people_outlined),
//       _NavItem(_Category.ortho, 'Orthodontic appl.', Icons.emoji_objects_outlined),
//       _NavItem(_Category.others, 'Others', Icons.more_horiz),
//     ];
//
//     if (vertical) {
//       return Card(
//         margin: const EdgeInsets.fromLTRB(12, 12, 8, 12),
//         child: ListView(
//           shrinkWrap: true,
//           children: items.map((it) {
//             final selected = cat == it.cat;
//             return ListTile(
//               leading: Icon(it.icon,
//                   color: selected ? Theme.of(context).colorScheme.primary : null),
//               title: Text(it.label),
//               selected: selected,
//               onTap: () => setState(() => cat = it.cat),
//             );
//           }).toList(),
//         ),
//       );
//     }
//
//     return Wrap(
//       spacing: 8,
//       runSpacing: 6,
//       children: items.map((it) {
//         final selected = cat == it.cat;
//         return ChoiceChip(
//           label: Text(it.label),
//           selected: selected,
//           onSelected: (_) => setState(() => cat = it.cat),
//         );
//       }).toList(),
//     );
//   }
//
//   // ── OMDBL 표면 선택(다중) ──
//   Widget _omdblPicker() {
//     const surfaces = ['O', 'M', 'D', 'B', 'L'];
//     return Wrap(
//       spacing: 8,
//       children: surfaces.map((s) {
//         final sel = _pickedSurfaces.contains(s);
//         return FilterChip(
//           label: Text(s),
//           selected: sel,
//           onSelected: (v) => setState(() {
//             if (v) {
//               _pickedSurfaces.add(s);
//             } else if (_pickedSurfaces.length > 1) {
//               _pickedSurfaces.remove(s);
//             }
//           }),
//         );
//       }).toList(),
//     );
//   }
//
//   // ── 즐겨찾기(약어만 노출, 라벨은 Tooltip) ──
//   Widget _favPanel() {
//     // 스프레드시트 재분류 반영된 기존 그룹 활용
//     final src = {
//       _Category.filling: kFavSurfaceGroups(),
//       _Category.status: {'Status': kFavGlobalGroups()['Status'] ?? const []},
//       _Category.root: {'Root': kFavGlobalGroups()['Root'] ?? const []},
//       _Category.prosthesis: {'Crowns': kFavGlobalGroups()['Crowns'] ?? const []},
//       _Category.denture: const <String, List<String>>{}, // 즐겨찾기 비움
//       _Category.ortho: const <String, List<String>>{},   // 즐겨찾기 비움
//       _Category.others: {
//         'Status': kFavGlobalGroups()['Status'] ?? const [],
//         'Root': kFavGlobalGroups()['Root'] ?? const [],
//         'Crowns': kFavGlobalGroups()['Crowns'] ?? const [],
//       },
//     }[cat]!;
//
//     if (src.isEmpty) return const SizedBox.shrink();
//
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text('Frequently Used', style: TextStyle(fontWeight: FontWeight.w700)),
//         const SizedBox(height: 6),
//         ...src.entries.map((e) => Padding(
//           padding: const EdgeInsets.only(bottom: 10),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(e.key, style: const TextStyle(fontSize: 12, color: Colors.black54)),
//               const SizedBox(height: 4),
//               Wrap(
//                 spacing: 8,
//                 runSpacing: 6,
//                 children: e.value
//                     .map((code) => _abbrChip(_mapGroupToCategory(e.key), code))
//                     .toList(),
//               ),
//             ],
//           ),
//         )),
//       ],
//     );
//   }
//
//   // 그룹 타이틀 → Interpol 카테고리명
//   String _mapGroupToCategory(String groupTitle) {
//     switch (groupTitle) {
//       case 'Fillings':
//         return 'Fillings';
//       case 'Status':
//         return 'Status';
//       case 'Root':
//         return 'Root';
//       case 'Crowns':
//         return 'Crowns';
//       default:
//         return groupTitle;
//     }
//   }
//
//   // ── 카테고리별 코드 트리(약어만) ──
//   List<Widget> _treePanels() {
//     final cats = switch (cat) {
//       _Category.status => const ['Status'],
//       _Category.prosthesis => const ['Crowns', 'Bridges'],
//       _Category.root => const ['Root'],
//       _Category.filling => const ['Fillings', 'Periodontium'],
//       _Category.denture => const ['Denture'],
//       _Category.ortho => const ['Orthodontic appliances'],
//       _Category.others =>
//       const ['Bite and occlusion', 'Tooth position', 'Crown pathology'],
//     };
//
//     return [
//       for (final c in cats)
//         _CodeTree(
//           title: c,
//           category: c,
//           onPick: (code) => _apply(category: c, code: code),
//         ),
//     ];
//   }
//
//   // ── 약어 칩(탭 즉시 저장) ──
//   Widget _abbrChip(String interpolCategory, String code) {
//     final label = _safeLabel(interpolCategory, code) ?? '';
//     return ActionChip(
//       label: Text(code.toUpperCase()),
//       tooltip: label.isEmpty ? null : '$code — $label',
//       onPressed: () => _apply(category: interpolCategory, code: code),
//     );
//   }
//
//   // ── 실제 저장 로직(즉시 반영) ──
//   void _apply({required String category, required String code}) {
//     final upper = code.toUpperCase();
//
//     // 스팬 전용 카테고리(읽기 전용 안내)
//     final isSpanOnly = category.toLowerCase().contains('bridge') ||
//         category.toLowerCase().contains('denture') ||
//         category.toLowerCase().contains('orthodont');
//     if (isSpanOnly) {
//       _toast('[$category] 코드는 스팬 편집 화면에서 설정하세요.');
//       return;
//     }
//
//     if (category == 'Fillings' || category == 'Periodontium') {
//       final sel = CodeSelection(category: category, path: [upper]);
//       for (final s in _pickedSurfaces) {
//         applyInterpolToSurface635WithToggles(context, widget.fdi, s, sel);
//       }
//       _toast('적용됨: ${_pickedSurfaces.join("")} · $upper');
//       return;
//     }
//
//     // Global(단일 그룹 덮어쓰기)
//     final sel = CodeSelection(category: category, path: [upper]);
//     applyInterpolToGlobal635WithToggles(context, widget.fdi, sel);
//     _toast('적용됨: $category · $upper');
//   }
//
//   String? _safeLabel(String category, String code) {
//     try {
//       final p = context.read<DentalDataProvider>();
//       String? dfs(List<String> prefix) {
//         for (final n in p.listChildren(category, prefix)) {
//           if (n.code.toUpperCase() == code.toUpperCase()) return n.label;
//           final got = dfs([...prefix, n.code]);
//           if (got != null) return got;
//         }
//         return null;
//       }
//       return dfs(const []);
//     } catch (_) {
//       return null;
//     }
//   }
//
//   void _toast(String msg) {
//     if (!mounted) return;
//     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
//   }
//
//   void _showHelp() {
//     showModalBottomSheet(
//       context: context,
//       showDragHandle: true,
//       builder: (_) => const Padding(
//         padding: EdgeInsets.fromLTRB(16, 12, 16, 16),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('단일치아 입력', style: TextStyle(fontWeight: FontWeight.w700)),
//             SizedBox(height: 8),
//             Text('• 좌측에서 Status / Prosthesis / Root / Filling / Denture / Orthodontic을 고릅니다.'),
//             Text('• Filling에서는 O·M·D·B·L 표면을 여러 개 선택해 약어 코드를 바로 적용합니다.'),
//             Text('• 선택은 탭 즉시 저장되며 축소 오돈토그램에 즉시 반영됩니다.'),
//             Text('• Bridges / Denture / Orthodontic은 스팬 전용이라 여기선 읽기 전용입니다.'),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// // 네비게이션 아이템
// class _NavItem {
//   final _Category cat;
//   final String label;
//   final IconData icon;
//   const _NavItem(this.cat, this.label, this.icon);
// }
//
// /// ====================== helper: 코드 트리(약어만, 임의 레벨 탭 가능)
// class _CodeTree extends StatefulWidget {
//   final String title;          // 섹션 타이틀
//   final String category;       // Interpol 카테고리명
//   final ValueChanged<String> onPick; // code 약어 선택 시 호출
//
//   const _CodeTree({
//     required this.title,
//     required this.category,
//     required this.onPick,
//   });
//
//   @override
//   State<_CodeTree> createState() => _CodeTreeState();
// }
//
// class _CodeTreeState extends State<_CodeTree> {
//   bool _loaded = false;
//   String _search = '';
//
//   @override
//   void initState() {
//     super.initState();
//     // 트리 데이터가 준비될 때까지 기다렸다가 그리기
//     WidgetsBinding.instance.addPostFrameCallback((_) async {
//       try {
//         await context.read<DentalDataProvider>().loadCodeTreeOnce();
//       } finally {
//         if (mounted) setState(() => _loaded = true);
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final p = context.watch<DentalDataProvider>();
//
//     if (!_loaded) {
//       return Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: const [
//           SizedBox(height: 6),
//           LinearProgressIndicator(),
//           SizedBox(height: 8),
//           Text('코드 트리를 불러오는 중…', style: TextStyle(fontSize: 12, color: Colors.black54)),
//         ],
//       );
//     }
//
//     // prefix 경로의 하위 노드
//     List<CodeNode> childrenOf(List<String> prefix) =>
//         p.listChildren(widget.category, prefix);
//
//     // 검색어가 있으면 간단 필터(코드/라벨 둘 다 검색)
//     bool _matches(CodeNode n) {
//       if (_search.isEmpty) return true;
//       final q = _search.toLowerCase();
//       return n.code.toLowerCase().contains(q) || n.label.toLowerCase().contains(q);
//     }
//
//     List<Widget> buildLevel(List<String> prefix) {
//       final kids = childrenOf(prefix).where(_matches).toList();
//       return kids.map((n) {
//         final next = [...prefix, n.code];
//         final sub = childrenOf(next).where(_matches).toList();
//         final label = n.label;
//
//         // 리프
//         if (sub.isEmpty) {
//           return ListTile(
//             dense: true,
//             contentPadding: const EdgeInsets.symmetric(horizontal: 8),
//             title: Row(
//               children: [
//                 Expanded(child: Text(n.code.toUpperCase())),
//                 Tooltip(
//                   message: label.isEmpty ? n.code : '${n.code} — $label',
//                   child: const Icon(Icons.info_outline, size: 16),
//                 ),
//               ],
//             ),
//             onTap: () => widget.onPick(n.code),
//           );
//         }
//
//         // 내부 노드
//         return ExpansionTile(
//           tilePadding: const EdgeInsets.symmetric(horizontal: 8),
//           childrenPadding: const EdgeInsets.only(left: 12),
//           title: Row(
//             children: [
//               Expanded(child: Text(n.code.toUpperCase())),
//               TextButton(
//                 onPressed: () => widget.onPick(n.code),
//                 child: const Text('선택'),
//               ),
//               Tooltip(
//                 message: label.isEmpty ? n.code : '${n.code} — $label',
//                 child: const Icon(Icons.info_outline, size: 16),
//               ),
//             ],
//           ),
//           children: buildLevel(next),
//         );
//       }).toList();
//     }
//
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(widget.title, style: const TextStyle(fontWeight: FontWeight.w700)),
//         const SizedBox(height: 6),
//         // 간단 검색(선택사항)
//         TextField(
//           decoration: const InputDecoration(
//             isDense: true,
//             prefixIcon: Icon(Icons.search),
//             hintText: '코드/라벨 검색',
//             border: OutlineInputBorder(),
//           ),
//           onChanged: (v) => setState(() => _search = v.trim()),
//         ),
//         const SizedBox(height: 8),
//         ...buildLevel(const []),
//         const SizedBox(height: 8),
//       ],
//     );
//   }
// }
//
// /// ─────────────────────────────────────────────────────────────────
// /// Interpol → 635 전역/표면에 “덮어쓰기” 반영 (토글 API만 사용)
// void applyInterpolToGlobal635WithToggles(
//     BuildContext context,
//     int fdi,
//     CodeSelection sel,
//     ) {
//   final p = context.read<DentalDataProvider>();
//
//   const cat2group = <String, String>{
//     'Bite and occlusion': 'bite',
//     'Tooth position': 'position',
//     'Status': 'status',
//     'Root': 'root',
//     'Crowns': 'crown',
//     'Crown pathology': 'crown pathology'
//   };
//
//   final code = (sel.path.isNotEmpty) ? sel.path.last : null;
//   final group = cat2group[sel.category];
//   if (code == null || group == null) return;
//
//   final prev = p.getSpecRead(fdi)?.global[group] ?? const <String>[];
//   for (final c in prev) {
//     if (c != code) {
//       p.toggleGlobalCode(fdi, group, c);
//     }
//   }
//   final cur = p.getSpecRead(fdi)?.global[group] ?? const <String>[];
//   if (!cur.contains(code)) {
//     p.toggleGlobalCode(fdi, group, code);
//   }
// }
//
// void applyInterpolToSurface635WithToggles(
//     BuildContext context,
//     int fdi,
//     String surface,
//     CodeSelection sel,
//     ) {
//   final p = context.read<DentalDataProvider>();
//
//   String? group;
//   if (sel.category == 'Fillings') {
//     group = 'fillings';
//   } else if (sel.category == 'Periodontium') {
//     group = 'periodontium';
//   } else {
//     return;
//   }
//
//   final code = (sel.path.isNotEmpty) ? sel.path.last : null;
//   if (code == null) return;
//
//   final prev =
//       p.getSpecRead(fdi)?.surface[surface]?[group] ?? const <String>[];
//   for (final c in prev) {
//     if (c != code) {
//       p.toggleSurfaceCode(fdi, surface, group, c);
//     }
//   }
//   final cur =
//       p.getSpecRead(fdi)?.surface[surface]?[group] ?? const <String>[];
//   if (!cur.contains(code)) {
//     p.toggleSurfaceCode(fdi, surface, group, code);
//   }
// }
//
// /// ─────────────────────────────────────────────────────────────────
// /// 그리기 유틸
// enum _SurfaceFill { none, toggleAmber, fillingBlue, cariesRed }
//
// class _FiveSurfacePainter extends CustomPainter {
//   final bool mesialOnRight;
//   final Map<String, _SurfaceFill> fill;
//
//   final bool abut; // 지대치 → 파란 링
//   final bool pontic; // pontic → 수평 2줄
//
//   final bool ringCrown; // crown 선택 시 링
//   final bool twoHorizontal; // status MIS* → 수평 2줄
//   final bool oneVertical; // root IPX* → 수직 1줄
//
//   final bool highlightAny; // 보라색 테두리
//
//   const _FiveSurfacePainter({
//     required this.mesialOnRight,
//     required this.fill,
//     this.abut = false,
//     this.pontic = false,
//     this.ringCrown = false,
//     this.twoHorizontal = false,
//     this.oneVertical = false,
//     this.highlightAny = false,
//   });
//
//   @override
//   void paint(Canvas canvas, Size s) {
//     final g = _Geom(s);
//
//     final outerStroke = Paint()
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = (s.width * .04).clamp(1.0, 2.0)
//       ..color = highlightAny ? Colors.deepPurple : Colors.black87;
//
//     final innerStroke = Paint()
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = (s.width * .032).clamp(0.8, 1.6)
//       ..color = Colors.black54;
//
//     Paint paintOf(_SurfaceFill f) {
//       switch (f) {
//         case _SurfaceFill.cariesRed:
//           return Paint()
//             ..style = PaintingStyle.fill
//             ..color = Colors.red.withOpacity(.35);
//         case _SurfaceFill.fillingBlue:
//           return Paint()
//             ..style = PaintingStyle.fill
//             ..color = Colors.blue.withOpacity(.28);
//         case _SurfaceFill.toggleAmber:
//           return Paint()
//             ..style = PaintingStyle.fill
//             ..color = Colors.amber.withOpacity(.35);
//         case _SurfaceFill.none:
//           return Paint()
//             ..style = PaintingStyle.stroke
//             ..color = Colors.transparent;
//       }
//     }
//
//     final l = fill['L'] ?? _SurfaceFill.none;
//     final b = fill['B'] ?? _SurfaceFill.none;
//     final o = fill['O'] ?? _SurfaceFill.none;
//     final m = fill['M'] ?? _SurfaceFill.none;
//     final d = fill['D'] ?? _SurfaceFill.none;
//
//     if (l != _SurfaceFill.none) canvas.drawPath(g.pathL, paintOf(l));
//     if (b != _SurfaceFill.none) canvas.drawPath(g.pathB, paintOf(b));
//     if (o != _SurfaceFill.none) canvas.drawRect(g.rectO, paintOf(o));
//
//     final leftFill = mesialOnRight ? d : m;
//     final rightFill = mesialOnRight ? m : d;
//     if (leftFill != _SurfaceFill.none) canvas.drawPath(g.pathLeft, paintOf(leftFill));
//     if (rightFill != _SurfaceFill.none) canvas.drawPath(g.pathRight, paintOf(rightFill));
//
//     // 윤곽/내부선
//     canvas.drawRRect(g.outerRRect, outerStroke);
//     canvas.drawRect(g.rectO, innerStroke);
//
//     final oc = [
//       g.outerRect.topLeft,
//       g.outerRect.topRight,
//       g.outerRect.bottomRight,
//       g.outerRect.bottomLeft
//     ];
//     final ic = [
//       g.rectO.topLeft,
//       g.rectO.topRight,
//       g.rectO.bottomRight,
//       g.rectO.bottomLeft
//     ];
//     for (int i = 0; i < 4; i++) {
//       canvas.drawLine(ic[i], oc[i], innerStroke);
//     }
//
//     // 파란 공통
//     final blue = Paint()
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = (s.width * .06).clamp(1.2, 2.4)
//       ..color = Colors.blueAccent;
//
//     if (ringCrown || abut) {
//       final ring = g.outerRect.deflate(s.width * .18);
//       canvas.drawRRect(
//         RRect.fromRectAndRadius(ring, Radius.circular(ring.width * .20)),
//         blue,
//       );
//     }
//
//     if (pontic || twoHorizontal) {
//       final y1 = s.height * .40, y2 = s.height * .60;
//       canvas.drawLine(Offset(s.width * .18, y1), Offset(s.width * .82, y1), blue);
//       canvas.drawLine(Offset(s.width * .18, y2), Offset(s.width * .82, y2), blue);
//     }
//
//     if (oneVertical) {
//       final x = s.width * .50;
//       canvas.drawLine(Offset(x, s.height * .20), Offset(x, s.height * .80), blue);
//     }
//   }
//
//   @override
//   bool shouldRepaint(covariant _FiveSurfacePainter old) =>
//       old.mesialOnRight != mesialOnRight ||
//           !_mapEquals(old.fill, fill) ||
//           old.abut != abut ||
//           old.pontic != pontic ||
//           old.ringCrown != ringCrown ||
//           old.twoHorizontal != twoHorizontal ||
//           old.oneVertical != oneVertical ||
//           old.highlightAny != highlightAny;
//
//   bool _mapEquals(Map<String, _SurfaceFill> a, Map<String, _SurfaceFill> b) {
//     if (identical(a, b)) return true;
//     if (a.length != b.length) return false;
//     for (final k in kToothSurfaces) {
//       if ((a[k] ?? _SurfaceFill.none) != (b[k] ?? _SurfaceFill.none)) return false;
//     }
//     return true;
//   }
// }
//
// class _Geom {
//   late final Rect outerRect;
//   late final RRect outerRRect;
//   late final Rect rectO;
//   late final Path pathL, pathB, pathLeft, pathRight;
//
//   _Geom(Size s) {
//     outerRect = Offset.zero & s;
//     outerRRect =
//         RRect.fromRectAndRadius(outerRect.deflate(1), Radius.circular(s.width * .12));
//
//     final w = s.width, h = s.height;
//     final rectW = w * .54; // 방패연 비율
//     final rectH = h * .36;
//     rectO = Rect.fromCenter(center: outerRect.center, width: rectW, height: rectH);
//
//     pathL = Path()
//       ..moveTo(outerRect.left, outerRect.top)
//       ..lineTo(outerRect.right, outerRect.top)
//       ..lineTo(rectO.right, rectO.top)
//       ..lineTo(rectO.left, rectO.top)
//       ..close();
//
//     pathB = Path()
//       ..moveTo(outerRect.left, outerRect.bottom)
//       ..lineTo(outerRect.right, outerRect.bottom)
//       ..lineTo(rectO.right, rectO.bottom)
//       ..lineTo(rectO.left, rectO.bottom)
//       ..close();
//
//     pathLeft = Path()
//       ..moveTo(outerRect.left, outerRect.top)
//       ..lineTo(rectO.left, rectO.top)
//       ..lineTo(rectO.left, rectO.bottom)
//       ..lineTo(outerRect.left, outerRect.bottom)
//       ..close();
//
//     pathRight = Path()
//       ..moveTo(outerRect.right, outerRect.top)
//       ..lineTo(rectO.right, rectO.top)
//       ..lineTo(rectO.right, rectO.bottom)
//       ..lineTo(outerRect.right, outerRect.bottom)
//       ..close();
//   }
// }
//
// /// getSpecRead가 null이어도 안전한 뷰
// class _SpecView {
//   final int fdi;
//   final dynamic _raw;
//   _SpecView(this.fdi, this._raw);
//
//   Map<String, List<String>> get global {
//     if (_raw?.global != null) return _raw!.global;
//     return <String, List<String>>{
//       'bite': <String>[],
//       'position': <String>[],
//       'status': <String>[],
//       'root': <String>[],
//       'crown': <String>[],
//       'crown pathology': <String>[],
//     };
//   }
//
//   Map<String, Map<String, List<String>>> get surface {
//     if (_raw?.surface != null) return _raw!.surface;
//     return {
//       for (final s in kToothSurfaces)
//         s: <String, List<String>>{
//           'fillings': <String>[],
//           'periodontium': <String>[],
//         }
//     };
//   }
//
//   String get toothNote => (_raw?.toothNote ?? '').trim();
//
//   Map<String, String> get surfaceNote {
//     if (_raw?.surfaceNote != null) return _raw!.surfaceNote;
//     return {for (final s in kToothSurfaces) s: ''};
//   }
// }






