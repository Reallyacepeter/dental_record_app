// lib/models/code_node.dart
class CodeNode {
  final String code;
  final String label;
  final List<CodeNode> children;
  const CodeNode(this.code, this.label, [this.children = const []]);
}

/// 화면/저장 로직에서 쓰는 선택 모델(유일 출처)
class CodeSelection {
  final String category;         // 예: 'Root', 'Crowns', 'Fillings'
  final List<String> path;       // 예: ['IPX'] 또는 ['MEC'] ...
  const CodeSelection({required this.category, required this.path});
}
