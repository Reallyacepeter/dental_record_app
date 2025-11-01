// lib/data/codes_635_short.dart
// 약어 중심의 간단 트리: 이후 Excel(full name)과 매핑 확장 가능.

final Map<String, dynamic> interpolShortTree = {
  // 전역(글로벌) 그룹들
  'Status': {
    'INT': 'Intact tooth',
    'MAM': 'Missing ante mortem',
    'MPM': 'Missing post mortem',
    'CFR': 'Crown fractured',
    'IMX': 'Impacted (x)',
    'IMV': 'Impacted (v)',
    'ERU': 'Erupted',
    'ROV': 'Root only visible',
  },
  'Root': {
    'RFX': 'Root filling',
    'IPX': 'Implant present',
  },

  // 보철(Prothesis) 안에 Crowns / Bridges
  'Prothesis': {
    'Crowns': {
      'UIC': 'Unidentified crown',
      'MTC': 'Metal crown',
      'GOC': 'Gold crown',
      'MEC': 'Metal-ceramic crown',
      'TCC': 'Temporary crown',
      'MCC': 'Metal-ceramic (alt)',
      'POC': 'Porcelain crown',
      'TEC': 'Temporary esthetic crown',
    },
    // Bridges는 “스팬” 작업(지대치/pontic)을 동반하므로
    // 여기서는 항목만 노출하고 실제 스팬 편집은 기존 화면을 사용하도록 훅만 둡니다.
    'Bridges': {
      'ABU': 'Abutment (select span in bridge dialog)',
      'PON': 'Pontic (select span in bridge dialog)',
      'TEB': 'Temporary bridge (use span UI)',
    },
  },

  // 표면(Surface) 계열 → Fillings (OMDBL에 적용)
  'Filling': {
    'UIF': 'Unidentified filling',
    'CAV': 'Cavity',
    'AMF': 'Amalgam filling',
    'TCF': 'Temporary filling',
    'COF': 'Composite filling',
    'FIS': 'Fissure sealant',
    'GOI': 'Gold inlay',
    'POI': 'Porcelain inlay',
  },

  // 옵션 슬롯 (원하시면 추후 채우기)
  'Denture / Orthodontic appl.': {
    'Denture': 'Use denture/ortho span UI',
    'Orthodontic appl.': 'Use denture/ortho span UI',
  },
  'Others': {},
};
