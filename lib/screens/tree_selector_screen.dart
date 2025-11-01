// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// import '../providers/dental_data_provider.dart' hide CodeSelection; // 충돌 방지
// import '../data/codes_635.dart' as ic;
// import '../models/code_node.dart';
//
//
//
// /// ─────────────────────────────────────────────────────────────
// /// 이 화면은 "전역(Global)" 카테고리 전용 트리 피커입니다.
// /// (Fillings/Periodontium/Bridge/Denture/Orthodontics 등은 숨김)
// /// 아이템 우측의 ⬇(저장) 버튼을 누르면 선택한 코드가 해당 치아(Global)에
// /// "덮어쓰기 방식"으로 즉시 저장됩니다.
// /// ─────────────────────────────────────────────────────────────
//
// class TreeSelectorScreen extends StatefulWidget {
//   final int fdi;
//   const TreeSelectorScreen({super.key, required this.fdi});
//
//   @override
//   State<TreeSelectorScreen> createState() => _TreeSelectorScreenState();
// }
//
// class _TreeSelectorScreenState extends State<TreeSelectorScreen> {
//   String? _category;              // 현재 펼친 카테고리
//   String _search = '';            // 검색어
//   final Set<String> _expandedCats = {}; // 여러 카테고리 동시 확장 허용
//
//   @override
//   void initState() {
//     super.initState();
//     // 코드 트리를 미리 로드 (캐시됨)
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       context.read<DentalDataProvider>().loadCodeTreeOnce();
//       setState(() {});
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final p = context.watch<DentalDataProvider>();
//
//     // 보여줄 카테고리: Global 전용
//     final allCats = ic.availableCategories(); // ← 정적 트리에서 직접
//     final cats = allCats.where((c) {
//       final u = c.toLowerCase();
//       final isSurface = (u == 'fillings' || u == 'periodontium');
//       final isSpan    = u.contains('bridge');
//       final isDentOrtho = u.contains('denture') || u.contains('orthodont');
//       return !(isSurface || isSpan || isDentOrtho);
//     }).toList();
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('#${widget.fdi} · Code picker (Tree)'),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.help_outline),
//             onPressed: _showHelp,
//             tooltip: '도움말',
//           ),
//         ],
//       ),
//       body: ListView(
//         padding: const EdgeInsets.fromLTRB(14, 6, 14, 16),
//         children: [
//           _buildSearchField(),
//           const SizedBox(height: 8),
//           ...cats.map(_buildCategoryTile),
//         ],
//       ),
//     );
//   }
//
//   // ─────────────────────────────────────────────────────────
//   // 검색창
//   Widget _buildSearchField() {
//     return TextField(
//       decoration: const InputDecoration(
//         prefixIcon: Icon(Icons.search),
//         hintText: '코드 또는 라벨 검색',
//         border: OutlineInputBorder(),
//       ),
//       onChanged: (t) => setState(() => _search = t),
//     );
//   }
//
//   // ─────────────────────────────────────────────────────────
//   // 카테고리 1개 타일 (루트 ExpansionTile)
//   Widget _buildCategoryTile(String cat) {
//     final opened = _expandedCats.contains(cat);
//     return Theme(
//       data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
//       child: ExpansionTile(
//         initiallyExpanded: opened,
//         onExpansionChanged: (v) {
//           setState(() {
//             if (v) {
//               _expandedCats.add(cat);
//               _category = cat;
//             } else {
//               _expandedCats.remove(cat);
//               if (_category == cat) _category = null;
//             }
//           });
//         },
//         tilePadding: const EdgeInsets.symmetric(horizontal: 0),
//         childrenPadding: const EdgeInsets.only(left: 0, right: 0, bottom: 4),
//         title: Text(
//           cat,
//           style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
//         ),
//         trailing: Icon(opened ? Icons.expand_less : Icons.expand_more),
//         children: [
//           const SizedBox(height: 4),
//           ..._buildTreeLevel(cat, const []),
//         ],
//       ),
//     );
//   }
//
//   // ─────────────────────────────────────────────────────────
//   // provider에 정식 API 유무와 관계없이 children을 안전하게 얻는다
//   List<CodeNode> _listChildrenSafe(
//       DentalDataProvider p,
//       String category,
//       List<String> prefix,
//       ) {
//     // 1) 자주 쓰는 이름들 시도
//     try {
//       final dyn = p as dynamic;
//       final res = dyn.listChildren635(category, prefix);
//       if (res is List<CodeNode>) return res;
//     } catch (_) {}
//
//     try {
//       final dyn = p as dynamic;
//       final res = dyn.getChildrenForCategory(category, prefix);
//       if (res is List<CodeNode>) return res;
//     } catch (_) {}
//
//     try {
//       final dyn = p as dynamic;
//       final res = dyn.codeChildren(category, prefix);
//       if (res is List<CodeNode>) return res;
//     } catch (_) {}
//
//     // 2) 실패 시 빈 리스트
//     return const <CodeNode>[];
//   }
//
//   // 현재 검색어를 적용한 children 목록
//   List<CodeNode> _childrenOf(String cat, List<String> prefix) {
//     final p = context.read<DentalDataProvider>();
//     var list = _listChildrenSafe(p, cat, prefix);
//     if (_search.trim().isNotEmpty) {
//       final kw = _search.trim().toLowerCase();
//       list = list
//           .where((n) =>
//       n.code.toLowerCase().contains(kw) ||
//           (n.label).toLowerCase().contains(kw))
//           .toList();
//     }
//     return list;
//   }
//
//   // ─────────────────────────────────────────────────────────
//   // 트리 한 레벨을 위젯 리스트로 생성 (무한 재귀)
//   List<Widget> _buildTreeLevel(String cat, List<String> prefix) {
//     final items = _childrenOf(cat, prefix);
//     if (items.isEmpty) {
//       // 최상위에 아무 것도 없으면, "비어 있음" 표시
//       if (prefix.isEmpty) {
//         return [
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 8),
//             child: Text(
//               '항목이 없습니다.',
//               style: TextStyle(color: Colors.black.withOpacity(.6)),
//             ),
//           )
//         ];
//       }
//       return const [];
//     }
//
//     return items.map((n) {
//       final next = [...prefix, n.code];
//       final kids = _childrenOf(cat, next);
//       final title = Text('${n.code} — ${n.label}', overflow: TextOverflow.ellipsis);
//
//       // 말단(leaf): 저장 버튼 하나만
//       if (kids.isEmpty) {
//         return ListTile(
//           dense: true,
//           contentPadding: const EdgeInsets.only(left: 0, right: 0),
//           title: title,
//           trailing: IconButton(
//             icon: const Icon(Icons.download_rounded),
//             tooltip: '이 코드 저장',
//             onPressed: () => _saveGlobal(cat, next),
//           ),
//         );
//       }
//
//       // 중간 노드: "선택(저장)" 버튼 + expand 하위
//       return ExpansionTile(
//         tilePadding: const EdgeInsets.only(left: 0, right: 0),
//         childrenPadding: const EdgeInsets.only(left: 16),
//         title: Row(
//           children: [
//             Expanded(child: title),
//             IconButton(
//               icon: const Icon(Icons.download_rounded),
//               tooltip: '이 노드로 저장',
//               onPressed: () => _saveGlobal(cat, next),
//             ),
//           ],
//         ),
//         children: _buildTreeLevel(cat, next),
//       );
//     }).toList();
//   }
//
//   // ─────────────────────────────────────────────────────────
//   // 저장: 전역(Global) 그룹에 덮어쓰기 반영
//   void _saveGlobal(String category, List<String> fullPath) {
//     final p = context.read<DentalDataProvider>();
//     final sel = CodeSelection(category: category, path: fullPath);
//     _applyInterpolToGlobal635WithToggles(p, widget.fdi, sel);
//
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(
//           '저장됨 · [$category] ${fullPath.join(" > ")}',
//           overflow: TextOverflow.ellipsis,
//         ),
//       ),
//     );
//   }
//
//   // ─────────────────────────────────────────────────────────
//   // Global 저장 로직(덮어쓰기) — toggle API만 사용
//   void _applyInterpolToGlobal635WithToggles(
//       DentalDataProvider p,
//       int fdi,
//       CodeSelection sel,
//       ) {
//     const cat2group = <String, String>{
//       'Bite and occlusion': 'bite',
//       'Tooth position': 'position',
//       'Status': 'status',
//       'Root': 'root',
//       'Crowns': 'crown',
//       'Crown pathology': 'crown pathology',
//     };
//
//     final code = (sel.path.isNotEmpty) ? sel.path.last : null;
//     final group = cat2group[sel.category];
//     if (code == null || group == null) return;
//
//     final prev = p.getSpecRead(fdi)?.global[group] ?? const <String>[];
//     for (final c in prev) {
//       if (c != code) {
//         p.toggleGlobalCode(fdi, group, c);
//       }
//     }
//     final cur = p.getSpecRead(fdi)?.global[group] ?? const <String>[];
//     if (!cur.contains(code)) {
//       p.toggleGlobalCode(fdi, group, code);
//     }
//   }
//
//   // ─────────────────────────────────────────────────────────
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
//             Text('사용법', style: TextStyle(fontWeight: FontWeight.w700)),
//             SizedBox(height: 8),
//             Text('• 카테고리를 펼친 뒤 항목 우측의 ⬇ 버튼을 누르면 해당 코드가 즉시 저장됩니다.'),
//             Text('• 본 화면은 전역(Global) 전용입니다. Fillings/Periodontium/Bridge/Denture 등은 숨깁니다.'),
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
// }

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/dental_data_provider.dart' hide CodeSelection; // 충돌 방지
import '../data/codes_635.dart' as ic;
import '../models/code_node.dart';

/// ─────────────────────────────────────────────────────────────
/// 전역(Global) 카테고리 전용 트리 피커
/// (Fillings/Periodontium/Bridge/Denture/Orthodontics 숨김)
/// 항목 우측 ⬇ 버튼: 해당 치아(Global)에 "덮어쓰기 저장"
/// ─────────────────────────────────────────────────────────────
class TreeSelectorScreen extends StatefulWidget {
  final int fdi;
  const TreeSelectorScreen({super.key, required this.fdi});

  @override
  State<TreeSelectorScreen> createState() => _TreeSelectorScreenState();
}

class _TreeSelectorScreenState extends State<TreeSelectorScreen>
    with AutomaticKeepAliveClientMixin {
  // UI state
  String? _category;                     // 현재 펼친 카테고리
  String _search = '';                   // 검색어(디바운스 적용)
  final Set<String> _expandedCats = {};  // 여러 카테고리 동시 확장 허용

  // 부하/ANR 방지용
  bool _primed = false;                  // addPostFrameCallback 1회 가드
  Timer? _searchDebounce;                // 검색 디바운스

  @override
  void initState() {
    super.initState();
    // 최초 1회만 코드 트리 캐시 로드 + 가벼운 리빌드
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || _primed) return;
      _primed = true;
      context.read<DentalDataProvider>().loadCodeTreeOnce();
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _searchDebounce?.cancel();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    // 저장 상태 변화 시 트리의 trailing(저장 버튼)만 변해도 리빌드될 수 있으므로 watch는 유지
    context.watch<DentalDataProvider>();

    // Global 전용 카테고리
    final allCats = ic.availableCategories();
    final cats = allCats.where((c) {
      final u = c.toLowerCase();
      final isSurface = (u == 'fillings' || u == 'periodontium');
      final isSpan = u.contains('bridge');
      final isDentOrtho = u.contains('denture') || u.contains('orthodont');
      return !(isSurface || isSpan || isDentOrtho);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('#${widget.fdi} · Code picker (Tree)'),
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline),
            onPressed: _showHelp,
            tooltip: '도움말',
          ),
        ],
      ),
      body: ListView.builder(
        key: const PageStorageKey('tree_selector_list'),
        padding: const EdgeInsets.fromLTRB(14, 6, 14, 16),
        itemCount: 2 + cats.length, // 검색창 + 간격 + 카테고리들
        itemBuilder: (context, index) {
          if (index == 0) return _buildSearchField();
          if (index == 1) return const SizedBox(height: 8);
          final cat = cats[index - 2];
          return _buildCategoryTile(cat);
        },
      ),
    );
  }

  // ─────────────────────────────────────────────────────────
  // 검색창 (디바운스)
  Widget _buildSearchField() {
    return TextField(
      key: const ValueKey('tree_search'),
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.search),
        hintText: '코드 또는 라벨 검색',
        border: OutlineInputBorder(),
      ),
      onChanged: (t) {
        _searchDebounce?.cancel();
        _searchDebounce = Timer(const Duration(milliseconds: 180), () {
          if (!mounted) return;
          setState(() => _search = t);
        });
      },
    );
  }

  // ─────────────────────────────────────────────────────────
  // 카테고리 1개 타일 (루트 ExpansionTile)
  Widget _buildCategoryTile(String cat) {
    final opened = _expandedCats.contains(cat);
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        key: PageStorageKey('cat_$cat'),
        maintainState: true, // 복귀/리빌드 시 펼친 상태 보존
        initiallyExpanded: opened,
        onExpansionChanged: (v) {
          setState(() {
            if (v) {
              _expandedCats.add(cat);
              _category = cat;
            } else {
              _expandedCats.remove(cat);
              if (_category == cat) _category = null;
            }
          });
        },
        tilePadding: const EdgeInsets.symmetric(horizontal: 0),
        childrenPadding: const EdgeInsets.only(left: 0, right: 0, bottom: 4),
        title: Text(
          cat,
          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
        ),
        trailing: Icon(opened ? Icons.expand_less : Icons.expand_more),
        children: [
          const SizedBox(height: 4),
          ..._buildTreeLevel(cat, const []),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────────────────
  // 현재 검색어를 적용한 children 목록 — 정적 트리 직결
  List<CodeNode> _childrenOf(String cat, List<String> prefix) {
    var list = ic.listChildren(cat, prefix); // 프로바이더 경유하지 않음(가볍게)
    final kw = _search.trim().toLowerCase();
    if (kw.isNotEmpty) {
      list = list
          .where((n) =>
      n.code.toLowerCase().contains(kw) ||
          n.label.toLowerCase().contains(kw))
          .toList();
    }
    return list;
  }

  // ─────────────────────────────────────────────────────────
  // 트리 한 레벨을 위젯 리스트로 생성 (무한 재귀)
  List<Widget> _buildTreeLevel(String cat, List<String> prefix) {
    final items = _childrenOf(cat, prefix);
    if (items.isEmpty) {
      if (prefix.isEmpty) {
        return [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(
              '항목이 없습니다.',
              style: TextStyle(color: Colors.black.withOpacity(.6)),
            ),
          )
        ];
      }
      return const [];
    }

    return items.map((n) {
      final next = [...prefix, n.code];
      final kids = _childrenOf(cat, next);
      final title =
      Text('${n.code} — ${n.label}', overflow: TextOverflow.ellipsis);

      // 말단(leaf): 저장 버튼만
      if (kids.isEmpty) {
        return ListTile(
          key: ValueKey('leaf_${cat}_${next.join("_")}'),
          dense: true,
          contentPadding: const EdgeInsets.only(left: 0, right: 0),
          title: title,
          trailing: IconButton(
            icon: const Icon(Icons.download_rounded),
            tooltip: '이 코드 저장',
            onPressed: () => _saveGlobal(cat, next),
          ),
        );
      }

      // 중간 노드: "선택(저장)" 버튼 + expand 하위
      return ExpansionTile(
        key: PageStorageKey('node_${cat}_${next.join("_")}'),
        maintainState: true,
        tilePadding: const EdgeInsets.only(left: 0, right: 0),
        childrenPadding: const EdgeInsets.only(left: 16),
        title: Row(
          children: [
            Expanded(child: title),
            IconButton(
              icon: const Icon(Icons.download_rounded),
              tooltip: '이 노드로 저장',
              onPressed: () => _saveGlobal(cat, next),
            ),
          ],
        ),
        children: _buildTreeLevel(cat, next),
      );
    }).toList();
  }

  // ─────────────────────────────────────────────────────────
  // 저장: 전역(Global) 그룹에 덮어쓰기 반영
  void _saveGlobal(String category, List<String> fullPath) {
    final p = context.read<DentalDataProvider>();
    final sel = CodeSelection(category: category, path: fullPath);
    _applyInterpolToGlobal635WithToggles(p, widget.fdi, sel);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '저장됨 · [$category] ${fullPath.join(" > ")}',
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  // ─────────────────────────────────────────────────────────
  // Global 저장 로직(덮어쓰기) — toggle API만 사용
  void _applyInterpolToGlobal635WithToggles(
      DentalDataProvider p,
      int fdi,
      CodeSelection sel,
      ) {
    const cat2group = <String, String>{
      'Bite and occlusion': 'bite',
      'Tooth position': 'position',
      'Status': 'status',
      'Root': 'root',
      'Crowns': 'crown',
      'Crown pathology': 'crown pathology',
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

  // ─────────────────────────────────────────────────────────
  void _showHelp() {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      builder: (_) => const Padding(
        padding: EdgeInsets.fromLTRB(16, 12, 16, 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('사용법', style: TextStyle(fontWeight: FontWeight.w700)),
            SizedBox(height: 8),
            Text('• 카테고리를 펼친 뒤 항목 우측의 ⬇ 버튼을 누르면 해당 코드가 즉시 저장됩니다.'),
            Text('• 본 화면은 전역(Global) 전용입니다. Fillings/Periodontium/Bridge/Denture 등은 숨깁니다.'),
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
}

