// // lib/data/codes_635.dart
// import '../models/code_node.dart';
// import 'prosthesis_tree.dart' as tree;
//
// /// 표면 상수: 이 파일을 '단일 출처'로 사용
// const List<String> kToothSurfaces = ['O','M','D','B','L'];
//
// /// 프로바이더에서 interp.availableCategories() 로 부르던 구 API를 제공
// List<String> availableCategories() => tree.availableCategories();
//
// /// 프로바이더에서 interp.listChildren(cat, prefix) 로 부르던 구 API를 제공
// List<CodeNode> listChildren(String category, List<String> prefix) {
//   return tree.listChildrenInTree(category, prefix);
// }

import '../models/code_node.dart';
import 'prosthesis_tree.dart' as tree;

/// 표면 상수: 이 파일을 '단일 출처'로 사용
const List<String> kToothSurfaces = ['O','M','D','B','L'];

/// 카테고리 목록
List<String> availableCategories() => tree.availableCategories();

/// 카테고리/경로의 자식 목록
List<CodeNode> listChildren(String category, List<String> prefix) =>
    tree.listChildrenInTree(category, prefix);
