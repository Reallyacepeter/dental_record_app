// lib/data/codes_635.dart
// TODO: 추후 interpol_dental_code.xlsx에서 로드하도록 교체

/// 단일치아(전역) 그룹
const Map<String, List<String>> k635GlobalCodes = {
  'bite':       ['OCC_OPN','OCC_CLS','OCC_CRSS'], // 예시
  'crown':      ['CAR','AMF','COM','GIC','CRN'],
  'root':       ['RCT','APX','RES','IPX'],
  'status':     ['MIS','MOB','IMP','DECID'],
  'position':   ['ROT','TIP','DISP'],
};

/// 표면(5분할) 그룹
const Map<String, List<String>> k635SurfaceCodes = {
  'fillings':     ['AMF','COM','GIC','INL','ONL','CRN','CAR'], // 'CAR' 포함 → 우식
  'periodontium': ['CAL','PIO','REC','PCK','BOP'],
};

/// 우식(=빨간색) 판정 키워드
bool isCariesThree(String c) {
  final u = c.toUpperCase();
  return u == 'CAR' || u == 'ACA' || u == 'CCA';
}