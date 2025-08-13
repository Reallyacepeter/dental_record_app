// import 'package:flutter/material.dart';
//
// class DentalDataProvider extends ChangeNotifier {
//   // 📌 FDI 치아별 데이터
//   final Map<int, Map<String, dynamic>> fdiToothData = {};
//
//   // 📌 640: 기타 소견
//   String otherFindings = "";
//
//   // 📌 645: 치열 유형
//   String dentitionType = "";
//
//   // 📌 647: 나이 추정
//   int? ageMin;
//   int? ageMax;
//
//   // 📌 650: 품질 확인
//   String qualityCheckSignature = "";
//   DateTime? qualityCheckDate;
//
//   // 📌 610: Materials Available
//   bool upperJawWithTeeth = false;
//   bool lowerJawWithTeeth = false;
//   bool upperJawWithoutTeeth = false;
//   bool lowerJawWithoutTeeth = false;
//   bool fragments = false;
//   String teethOnly = '';
//   String otherMaterials = '';
//
//   bool paDigital = false;
//   bool paNonDigital = false;
//   bool bwDigital = false;
//   bool bwNonDigital = false;
//   bool opgDigital = false;
//   bool opgNonDigital = false;
//   bool ctDigital = false;
//   bool ctNonDigital = false;
//   bool otherDigital = false;
//   bool otherNonDigital = false;
//   bool photographsDigital = false;
//   bool photographsNonDigital = false;
//   String otherRadiographs = '';
//   List<String> uploadedFiles = [];
//
//   String conditionOfJaws = '';
//   String otherDetails = '';
//
//   // 📌 RecordScreen 관련 필드
//   String placeOfDisaster = '';
//   String natureOfDisaster = '';
//   String pmNumber = '';
//   DateTime? dateOfDisaster;
//   String gender = '';
//
//   // ===============================
//   //           SETTERS
//   // ===============================
//
//   void setToothDetail(int tooth, String detail) {
//     fdiToothData[tooth] = {"detail": detail};
//     notifyListeners();
//   }
//
//   void setOtherFindings(String value) {
//     otherFindings = value;
//     notifyListeners();
//   }
//
//   void setDentitionType(String value) {
//     dentitionType = value;
//     notifyListeners();
//   }
//
//   void setAgeRange(int? min, int? max) {
//     ageMin = min;
//     ageMax = max;
//     notifyListeners();
//   }
//
//   void setQualityCheck(String signature, DateTime? date) {
//     qualityCheckSignature = signature;
//     qualityCheckDate = date;
//     notifyListeners();
//   }
//
//   void setMaterialsAvailable({
//     required bool upperWith,
//     required bool lowerWith,
//     required bool upperWithout,
//     required bool lowerWithout,
//     required bool hasFragments,
//     required String teethText,
//     required String otherText,
//   }) {
//     upperJawWithTeeth = upperWith;
//     lowerJawWithTeeth = lowerWith;
//     upperJawWithoutTeeth = upperWithout;
//     lowerJawWithoutTeeth = lowerWithout;
//     fragments = hasFragments;
//     teethOnly = teethText;
//     otherMaterials = otherText;
//     notifyListeners();
//   }
//
//   void setEachMaterial({
//     bool? upperWith,
//     bool? lowerWith,
//     bool? upperWithout,
//     bool? lowerWithout,
//     bool? hasFragments,
//     String? teethText,
//     String? otherText,
//   }) {
//     if (upperWith != null) upperJawWithTeeth = upperWith;
//     if (lowerWith != null) lowerJawWithTeeth = lowerWith;
//     if (upperWithout != null) upperJawWithoutTeeth = upperWithout;
//     if (lowerWithout != null) lowerJawWithoutTeeth = lowerWithout;
//     if (hasFragments != null) fragments = hasFragments;
//     if (teethText != null) teethOnly = teethText;
//     if (otherText != null) otherMaterials = otherText;
//     notifyListeners();
//   }
//
//   void setDentalImages({
//     bool? paD, bool? paND,
//     bool? bwD, bool? bwND,
//     bool? opgD, bool? opgND,
//     bool? ctD, bool? ctND,
//     bool? otherD, bool? otherND,
//     bool? photoD, bool? photoND,
//     String? otherRadio,
//     List<String>? uploads,
//   }) {
//     if (paD != null) paDigital = paD;
//     if (paND != null) paNonDigital = paND;
//     if (bwD != null) bwDigital = bwD;
//     if (bwND != null) bwNonDigital = bwND;
//     if (opgD != null) opgDigital = opgD;
//     if (opgND != null) opgNonDigital = opgND;
//     if (ctD != null) ctDigital = ctD;
//     if (ctND != null) ctNonDigital = ctND;
//     if (otherD != null) otherDigital = otherD;
//     if (otherND != null) otherNonDigital = otherND;
//     if (photoD != null) photographsDigital = photoD;
//     if (photoND != null) photographsNonDigital = photoND;
//     if (otherRadio != null) otherRadiographs = otherRadio;
//     if (uploads != null) uploadedFiles = uploads;
//     notifyListeners();
//   }
//
//   void setConditionOfJaws(String value) {
//     conditionOfJaws = value;
//     notifyListeners();
//   }
//
//   void setOtherDetails(String value) {
//     otherDetails = value;
//     notifyListeners();
//   }
//
//   void updateToothDetail(int toothNumber, String detail) {
//     fdiToothData[toothNumber] = {'detail': detail};
//     notifyListeners();
//   }
//
//   void updateOtherFindings(String value) {
//     otherFindings = value;
//     notifyListeners();
//   }
//
//   void updateDentitionType(String type) {
//     dentitionType = type;
//     notifyListeners();
//   }
//
//   void updateAgeMin(int? value) {
//     ageMin = value;
//     notifyListeners();
//   }
//
//   void updateAgeMax(int? value) {
//     ageMax = value;
//     notifyListeners();
//   }
//
//   void updateQualitySignature(String value) {
//     qualityCheckSignature = value;
//     notifyListeners();
//   }
//
//   void updateQualityDate(DateTime date) {
//     qualityCheckDate = date;
//     notifyListeners();
//   }
//
//   // 📌 RecordScreen 관련 setter들
//   void updatePlace(String place) {
//     placeOfDisaster = place;
//     notifyListeners();
//   }
//
//   void updateNature(String nature) {
//     natureOfDisaster = nature;
//     notifyListeners();
//   }
//
//   void updatePmNumber(String pm) {
//     pmNumber = pm;
//     notifyListeners();
//   }
//
//   void updateDisasterDate(DateTime date) {
//     dateOfDisaster = date;
//     notifyListeners();
//   }
//
//   void updateGender(String selectedGender) {
//     gender = selectedGender;
//     notifyListeners();
//   }
//
//   // ===============================
//   //         FIREBASE 저장용
//   // ===============================
//
//   Map<String, dynamic> toMap() {
//     return {
//       'placeOfDisaster': placeOfDisaster,
//       'natureOfDisaster': natureOfDisaster,
//       'pmNumber': pmNumber,
//       'dateOfDisaster': dateOfDisaster?.toIso8601String(),
//       'gender': gender,
//
//       'fdiToothData': fdiToothData.map((k, v) => MapEntry(k.toString(), v)),
//       'otherFindings': otherFindings,
//       'dentitionType': dentitionType,
//       'ageMin': ageMin,
//       'ageMax': ageMax,
//       'qualityCheckSignature': qualityCheckSignature,
//       'qualityCheckDate': qualityCheckDate?.toIso8601String(),
//
//       // Materials Available
//       'upperJawWithTeeth': upperJawWithTeeth,
//       'lowerJawWithTeeth': lowerJawWithTeeth,
//       'upperJawWithoutTeeth': upperJawWithoutTeeth,
//       'lowerJawWithoutTeeth': lowerJawWithoutTeeth,
//       'fragments': fragments,
//       'teethOnly': teethOnly,
//       'otherMaterials': otherMaterials,
//
//       // Dental Images
//       'paDigital': paDigital,
//       'paNonDigital': paNonDigital,
//       'bwDigital': bwDigital,
//       'bwNonDigital': bwNonDigital,
//       'opgDigital': opgDigital,
//       'opgNonDigital': opgNonDigital,
//       'ctDigital': ctDigital,
//       'ctNonDigital': ctNonDigital,
//       'otherDigital': otherDigital,
//       'otherNonDigital': otherNonDigital,
//       'photographsDigital': photographsDigital,
//       'photographsNonDigital': photographsNonDigital,
//       'otherRadiographs': otherRadiographs,
//       'uploadedFiles': uploadedFiles,
//
//       // Jaws and Additional Notes
//       'conditionOfJaws': conditionOfJaws,
//       'otherDetails': otherDetails,
//     };
//   }
// }

// import 'package:flutter/material.dart';
//
// class DentalDataProvider extends ChangeNotifier {
//   // 📌 FDI 치아별 데이터
//   final Map<int, Map<String, dynamic>> fdiToothData = {};
//
//   // 📌 640: 기타 소견
//   String otherFindings = "";
//
//   // 📌 645: 치열 유형
//   String dentitionType = "";
//
//   // 📌 647: 나이 추정
//   int? ageMin;
//   int? ageMax;
//
//   // 📌 650: 품질 확인
//   String qualityCheckSignature = "";
//   DateTime? qualityCheckDate;
//
//   // 📌 610: Materials Available
//   bool upperJawWithTeeth = false;
//   bool lowerJawWithTeeth = false;
//   bool upperJawWithoutTeeth = false;
//   bool lowerJawWithoutTeeth = false;
//   bool fragments = false;
//   String teethOnly = '';
//   String otherMaterials = '';
//
//   bool paDigital = false;
//   bool paNonDigital = false;
//   bool bwDigital = false;
//   bool bwNonDigital = false;
//   bool opgDigital = false;
//   bool opgNonDigital = false;
//   bool ctDigital = false;
//   bool ctNonDigital = false;
//   bool otherDigital = false;
//   bool otherNonDigital = false;
//   bool photographsDigital = false;
//   bool photographsNonDigital = false;
//   String otherRadiographs = '';
//   List<String> uploadedFiles = [];
//
//   String conditionOfJaws = '';
//   String otherDetails = '';
//
//   // 📌 RecordScreen 관련 필드
//   String placeOfDisaster = '';
//   String natureOfDisaster = '';
//   String pmNumber = '';
//   DateTime? dateOfDisaster;
//   String gender = '';
//
//   // ===============================
//   //           SETTERS
//   // ===============================
//
//   void setToothDetail(int tooth, String detail) {
//     fdiToothData[tooth] = {"detail": detail};
//     notifyListeners();
//   }
//
//   void setOtherFindings(String value) {
//     otherFindings = value;
//     notifyListeners();
//   }
//
//   void setDentitionType(String value) {
//     dentitionType = value;
//     notifyListeners();
//   }
//
//   void setAgeRange(int? min, int? max) {
//     ageMin = min;
//     ageMax = max;
//     notifyListeners();
//   }
//
//   void setQualityCheck(String signature, DateTime? date) {
//     qualityCheckSignature = signature;
//     qualityCheckDate = date;
//     notifyListeners();
//   }
//
//   void setMaterialsAvailable({
//     required bool upperWith,
//     required bool lowerWith,
//     required bool upperWithout,
//     required bool lowerWithout,
//     required bool hasFragments,
//     required String teethText,
//     required String otherText,
//   }) {
//     upperJawWithTeeth = upperWith;
//     lowerJawWithTeeth = lowerWith;
//     upperJawWithoutTeeth = upperWithout;
//     lowerJawWithoutTeeth = lowerWithout;
//     fragments = hasFragments;
//     teethOnly = teethText;
//     otherMaterials = otherText;
//     notifyListeners();
//   }
//
//   void setEachMaterial({
//     bool? upperWith,
//     bool? lowerWith,
//     bool? upperWithout,
//     bool? lowerWithout,
//     bool? hasFragments,
//     String? teethText,
//     String? otherText,
//   }) {
//     if (upperWith != null) upperJawWithTeeth = upperWith;
//     if (lowerWith != null) lowerJawWithTeeth = lowerWith;
//     if (upperWithout != null) upperJawWithoutTeeth = upperWithout;
//     if (lowerWithout != null) lowerJawWithoutTeeth = lowerWithout;
//     if (hasFragments != null) fragments = hasFragments;
//     if (teethText != null) teethOnly = teethText;
//     if (otherText != null) otherMaterials = otherText;
//     notifyListeners();
//   }
//
//   void setDentalImages({
//     bool? paD, bool? paND,
//     bool? bwD, bool? bwND,
//     bool? opgD, bool? opgND,
//     bool? ctD, bool? ctND,
//     bool? otherD, bool? otherND,
//     bool? photoD, bool? photoND,
//     String? otherRadio,
//     List<String>? uploads,
//   }) {
//     if (paD != null) paDigital = paD;
//     if (paND != null) paNonDigital = paND;
//     if (bwD != null) bwDigital = bwD;
//     if (bwND != null) bwNonDigital = bwND;
//     if (opgD != null) opgDigital = opgD;
//     if (opgND != null) opgNonDigital = opgND;
//     if (ctD != null) ctDigital = ctD;
//     if (ctND != null) ctNonDigital = ctND;
//     if (otherD != null) otherDigital = otherD;
//     if (otherND != null) otherNonDigital = otherND;
//     if (photoD != null) photographsDigital = photoD;
//     if (photoND != null) photographsNonDigital = photoND;
//     if (otherRadio != null) otherRadiographs = otherRadio;
//     if (uploads != null) uploadedFiles = uploads;
//     notifyListeners();
//   }
//
//   void setConditionOfJaws(String value) {
//     conditionOfJaws = value;
//     notifyListeners();
//   }
//
//   void setOtherDetails(String value) {
//     otherDetails = value;
//     notifyListeners();
//   }
//
//   void updateToothDetail(int toothNumber, String detail) {
//     fdiToothData[toothNumber] = {'detail': detail};
//     notifyListeners();
//   }
//
//   void updateOtherFindings(String value) {
//     otherFindings = value;
//     notifyListeners();
//   }
//
//   void updateDentitionType(String type) {
//     dentitionType = type;
//     notifyListeners();
//   }
//
//   void updateAgeMin(int? value) {
//     ageMin = value;
//     notifyListeners();
//   }
//
//   void updateAgeMax(int? value) {
//     ageMax = value;
//     notifyListeners();
//   }
//
//   void updateQualitySignature(String value) {
//     qualityCheckSignature = value;
//     notifyListeners();
//   }
//
//   void updateQualityDate(DateTime date) {
//     qualityCheckDate = date;
//     notifyListeners();
//   }
//
//   // 📌 RecordScreen 관련 setter들
//   void updatePlace(String place) {
//     placeOfDisaster = place;
//     notifyListeners();
//   }
//
//   void updateNature(String nature) {
//     natureOfDisaster = nature;
//     notifyListeners();
//   }
//
//   void updatePmNumber(String pm) {
//     pmNumber = pm;
//     notifyListeners();
//   }
//
//   void updateDisasterDate(DateTime date) {
//     dateOfDisaster = date;
//     notifyListeners();
//   }
//
//   void updateGender(String selectedGender) {
//     gender = selectedGender;
//     notifyListeners();
//   }
//
//   void setFdiToothData(Map<int, Map<String, String>> newData) {
//     fdiToothData.clear();
//     fdiToothData.addAll(newData);
//     notifyListeners();
//   }
//
//   void resetAll() {
//     // FDI 치아별 데이터 초기화
//     fdiToothData.clear();
//
//     // 구강 정보
//     otherFindings = "";
//     dentitionType = "";
//     ageMin = null;
//     ageMax = null;
//     qualityCheckSignature = "";
//     qualityCheckDate = null;
//
//     // Materials Available
//     upperJawWithTeeth = false;
//     lowerJawWithTeeth = false;
//     upperJawWithoutTeeth = false;
//     lowerJawWithoutTeeth = false;
//     fragments = false;
//     teethOnly = '';
//     otherMaterials = '';
//
//     // Radiographs
//     paDigital = false;
//     paNonDigital = false;
//     bwDigital = false;
//     bwNonDigital = false;
//     opgDigital = false;
//     opgNonDigital = false;
//     ctDigital = false;
//     ctNonDigital = false;
//     otherDigital = false;
//     otherNonDigital = false;
//     photographsDigital = false;
//     photographsNonDigital = false;
//     otherRadiographs = '';
//     uploadedFiles = [];
//
//     // 턱 상태 및 기타
//     conditionOfJaws = '';
//     otherDetails = '';
//
//     // RecordScreen 관련 필드
//     placeOfDisaster = '';
//     natureOfDisaster = '';
//     pmNumber = '';
//     dateOfDisaster = null;
//     gender = '';
//
//     notifyListeners();
//   }
//
//   void addUploadedFile(String fileUrl) {
//     uploadedFiles.add(fileUrl);
//     notifyListeners();
//   }
//
//   void removeUploadedFile(String fileUrl) {
//     uploadedFiles.remove(fileUrl);
//     notifyListeners();
//   }
//
//   // ===============================
//   //         FIREBASE 저장용
//   // ===============================
//
//   Map<String, dynamic> toMap() {
//     return {
//       'placeOfDisaster': placeOfDisaster,
//       'natureOfDisaster': natureOfDisaster,
//       'pmNumber': pmNumber,
//       'dateOfDisaster': dateOfDisaster?.toIso8601String(),
//       'gender': gender,
//
//       'fdiToothData': fdiToothData.map((k, v) => MapEntry(k.toString(), v)),
//       'otherFindings': otherFindings,
//       'dentitionType': dentitionType,
//       'ageMin': ageMin,
//       'ageMax': ageMax,
//       'qualityCheckSignature': qualityCheckSignature,
//       'qualityCheckDate': qualityCheckDate?.toIso8601String(),
//
//       'upperJawWithTeeth': upperJawWithTeeth,
//       'lowerJawWithTeeth': lowerJawWithTeeth,
//       'upperJawWithoutTeeth': upperJawWithoutTeeth,
//       'lowerJawWithoutTeeth': lowerJawWithoutTeeth,
//       'fragments': fragments,
//       'teethOnly': teethOnly,
//       'otherMaterials': otherMaterials,
//
//       'paDigital': paDigital,
//       'paNonDigital': paNonDigital,
//       'bwDigital': bwDigital,
//       'bwNonDigital': bwNonDigital,
//       'opgDigital': opgDigital,
//       'opgNonDigital': opgNonDigital,
//       'ctDigital': ctDigital,
//       'ctNonDigital': ctNonDigital,
//       'otherDigital': otherDigital,
//       'otherNonDigital': otherNonDigital,
//       'photographsDigital': photographsDigital,
//       'photographsNonDigital': photographsNonDigital,
//       'otherRadiographs': otherRadiographs,
//       'uploadedFiles': uploadedFiles,
//
//       'conditionOfJaws': conditionOfJaws,
//       'otherDetails': otherDetails,
//     };
//   }
// }

import 'package:flutter/material.dart';

class DentalDataProvider extends ChangeNotifier {
  // 📌 FDI 치아별 데이터
  final Map<int, Map<String, dynamic>> fdiToothData = {};

  // 📌 640: 기타 소견
  String otherFindings = "";

  // 📌 645: 치열 유형
  String dentitionType = "";

  // 📌 647: 나이 추정
  int? ageMin;
  int? ageMax;

  // 📌 650: 품질 확인
  String qualityCheckSignature = "";
  DateTime? qualityCheckDate;

  // 📌 610: Materials Available
  bool upperJawWithTeeth = false;
  bool lowerJawWithTeeth = false;
  bool upperJawWithoutTeeth = false;
  bool lowerJawWithoutTeeth = false;
  bool fragments = false;
  String teethOnly = '';
  String otherMaterials = '';

  bool paDigital = false;
  bool paNonDigital = false;
  bool bwDigital = false;
  bool bwNonDigital = false;
  bool opgDigital = false;
  bool opgNonDigital = false;
  bool ctDigital = false;
  bool ctNonDigital = false;
  bool otherDigital = false;
  bool otherNonDigital = false;
  bool photographsDigital = false;
  bool photographsNonDigital = false;
  String otherRadiographs = '';
  List<String> uploadedFiles = [];

  String conditionOfJaws = '';
  String otherDetails = '';

  // 📌 RecordScreen 관련 필드 (사용자 입력 원본)
  String placeOfDisaster = '';
  String natureOfDisaster = '';
  String pmNumber = '';
  DateTime? dateOfDisaster;
  String gender = '';

  // ===============================
  //  Incident Lock (초기 OFF, 값 비어있음)
  // ===============================
  bool incidentLockEnabled = false;
  String lockedPlace = '';
  String lockedNature = '';

  /// UI/저장용: 잠금+고정값 존재 시 고정값, 아니면 사용자 입력값
  String get placeForUi =>
      (incidentLockEnabled && lockedPlace.isNotEmpty) ? lockedPlace : placeOfDisaster;
  String get natureForUi =>
      (incidentLockEnabled && lockedNature.isNotEmpty) ? lockedNature : natureOfDisaster;

  /// 고정값 설정
  void setLockedValues({String? place, String? nature}) {
    if (place != null) lockedPlace = place;
    if (nature != null) lockedNature = nature;
    notifyListeners();
  }

  void setLockedPlace(String v) {
    lockedPlace = v;
    notifyListeners();
  }

  void setLockedNature(String v) {
    lockedNature = v;
    notifyListeners();
  }

  /// 잠금 ON (고정값이 모두 있어야 true)
  bool enableIncidentLock({String? place, String? nature}) {
    if (place != null) lockedPlace = place;
    if (nature != null) lockedNature = nature;
    if (lockedPlace.isEmpty || lockedNature.isEmpty) {
      return false; // 값 없으면 실패
    }
    incidentLockEnabled = true;
    notifyListeners();
    return true;
  }

  /// 잠금 OFF
  void disableIncidentLock() {
    incidentLockEnabled = false;
    notifyListeners();
  }

  // ===============================
  //           SETTERS
  // ===============================
  void setToothDetail(int tooth, String detail) {
    fdiToothData[tooth] = {"detail": detail};
    notifyListeners();
  }

  void setOtherFindings(String value) {
    otherFindings = value;
    notifyListeners();
  }

  void setDentitionType(String value) {
    dentitionType = value;
    notifyListeners();
  }

  void setAgeRange(int? min, int? max) {
    ageMin = min;
    ageMax = max;
    notifyListeners();
  }

  void setQualityCheck(String signature, DateTime? date) {
    qualityCheckSignature = signature;
    qualityCheckDate = date;
    notifyListeners();
  }

  void setMaterialsAvailable({
    required bool upperWith,
    required bool lowerWith,
    required bool upperWithout,
    required bool lowerWithout,
    required bool hasFragments,
    required String teethText,
    required String otherText,
  }) {
    upperJawWithTeeth = upperWith;
    lowerJawWithTeeth = lowerWith;
    upperJawWithoutTeeth = upperWithout;
    lowerJawWithoutTeeth = lowerWithout;
    fragments = hasFragments;
    teethOnly = teethText;
    otherMaterials = otherText;
    notifyListeners();
  }

  void setEachMaterial({
    bool? upperWith,
    bool? lowerWith,
    bool? upperWithout,
    bool? lowerWithout,
    bool? hasFragments,
    String? teethText,
    String? otherText,
  }) {
    if (upperWith != null) upperJawWithTeeth = upperWith;
    if (lowerWith != null) lowerJawWithTeeth = lowerWith;
    if (upperWithout != null) upperJawWithoutTeeth = upperWithout;
    if (lowerWithout != null) lowerJawWithoutTeeth = lowerWithout;
    if (hasFragments != null) fragments = hasFragments;
    if (teethText != null) teethOnly = teethText;
    if (otherText != null) otherMaterials = otherText;
    notifyListeners();
  }

  void setDentalImages({
    bool? paD,
    bool? paND,
    bool? bwD,
    bool? bwND,
    bool? opgD,
    bool? opgND,
    bool? ctD,
    bool? ctND,
    bool? otherD,
    bool? otherND,
    bool? photoD,
    bool? photoND,
    String? otherRadio,
    List<String>? uploads,
  }) {
    if (paD != null) paDigital = paD;
    if (paND != null) paNonDigital = paND;
    if (bwD != null) bwDigital = bwD;
    if (bwND != null) bwNonDigital = bwND;
    if (opgD != null) opgDigital = opgD;
    if (opgND != null) opgNonDigital = opgND;
    if (ctD != null) ctDigital = ctD;
    if (ctND != null) ctNonDigital = ctND;
    if (otherD != null) otherDigital = otherD;
    if (otherND != null) otherNonDigital = otherND;
    if (photoD != null) photographsDigital = photoD;
    if (photoND != null) photographsNonDigital = photoND;
    if (otherRadio != null) otherRadiographs = otherRadio;
    if (uploads != null) uploadedFiles = uploads;
    notifyListeners();
  }

  void setConditionOfJaws(String value) {
    conditionOfJaws = value;
    notifyListeners();
  }

  void setOtherDetails(String value) {
    otherDetails = value;
    notifyListeners();
  }

  void updateToothDetail(int toothNumber, String detail) {
    fdiToothData[toothNumber] = {'detail': detail};
    notifyListeners();
  }

  void updateOtherFindings(String value) {
    otherFindings = value;
    notifyListeners();
  }

  void updateDentitionType(String type) {
    dentitionType = type;
    notifyListeners();
  }

  void updateAgeMin(int? value) {
    ageMin = value;
    notifyListeners();
  }

  void updateAgeMax(int? value) {
    ageMax = value;
    notifyListeners();
  }

  void updateQualitySignature(String value) {
    qualityCheckSignature = value;
    notifyListeners();
  }

  void updateQualityDate(DateTime date) {
    qualityCheckDate = date;
    notifyListeners();
  }

  // 📌 RecordScreen 관련 setter들
  void updatePlace(String place) {
    if (incidentLockEnabled) return; // 잠금 시 무시
    placeOfDisaster = place;
    notifyListeners();
  }

  void updateNature(String nature) {
    if (incidentLockEnabled) return; // 잠금 시 무시
    natureOfDisaster = nature;
    notifyListeners();
  }

  void updatePmNumber(String pm) {
    pmNumber = pm;
    notifyListeners();
  }

  void updateDisasterDate(DateTime date) {
    dateOfDisaster = date;
    notifyListeners();
  }

  void updateGender(String selectedGender) {
    gender = selectedGender;
    notifyListeners();
  }

  void setFdiToothData(Map<int, Map<String, String>> newData) {
    fdiToothData.clear();
    fdiToothData.addAll(newData);
    notifyListeners();
  }

  void resetAll() {
    // FDI 치아별 데이터 초기화
    fdiToothData.clear();

    // 구강 정보
    otherFindings = "";
    dentitionType = "";
    ageMin = null;
    ageMax = null;
    qualityCheckSignature = "";
    qualityCheckDate = null;

    // Materials Available
    upperJawWithTeeth = false;
    lowerJawWithTeeth = false;
    upperJawWithoutTeeth = false;
    lowerJawWithoutTeeth = false;
    fragments = false;
    teethOnly = '';
    otherMaterials = '';

    // Radiographs
    paDigital = false;
    paNonDigital = false;
    bwDigital = false;
    bwNonDigital = false;
    opgDigital = false;
    opgNonDigital = false;
    ctDigital = false;
    ctNonDigital = false;
    otherDigital = false;
    otherNonDigital = false;
    photographsDigital = false;
    photographsNonDigital = false;
    otherRadiographs = '';
    uploadedFiles = [];

    // 턱 상태 및 기타
    conditionOfJaws = '';
    otherDetails = '';

    // RecordScreen 관련 필드
    placeOfDisaster = '';
    natureOfDisaster = '';
    pmNumber = '';
    dateOfDisaster = null;
    gender = '';

    // ⚠ incidentLockEnabled / lockedPlace / lockedNature 는 유지
    notifyListeners();
  }

  void addUploadedFile(String fileUrl) {
    uploadedFiles.add(fileUrl);
    notifyListeners();
  }

  void removeUploadedFile(String fileUrl) {
    uploadedFiles.remove(fileUrl);
    notifyListeners();
  }

  // ===============================
  //         FIREBASE 저장용
  // ===============================
  Map<String, dynamic> toMap() {
    return {
      // ✅ 잠금 반영 값으로 저장
      'placeOfDisaster': placeForUi,
      'natureOfDisaster': natureForUi,

      'pmNumber': pmNumber,
      'dateOfDisaster': dateOfDisaster?.toIso8601String(),
      'gender': gender,

      'fdiToothData': fdiToothData.map((k, v) => MapEntry(k.toString(), v)),
      'otherFindings': otherFindings,
      'dentitionType': dentitionType,
      'ageMin': ageMin,
      'ageMax': ageMax,
      'qualityCheckSignature': qualityCheckSignature,
      'qualityCheckDate': qualityCheckDate?.toIso8601String(),

      'upperJawWithTeeth': upperJawWithTeeth,
      'lowerJawWithTeeth': lowerJawWithTeeth,
      'upperJawWithoutTeeth': upperJawWithoutTeeth,
      'lowerJawWithoutTeeth': lowerJawWithoutTeeth,
      'fragments': fragments,
      'teethOnly': teethOnly,
      'otherMaterials': otherMaterials,

      'paDigital': paDigital,
      'paNonDigital': paNonDigital,
      'bwDigital': bwDigital,
      'bwNonDigital': bwNonDigital,
      'opgDigital': opgDigital,
      'opgNonDigital': opgNonDigital,
      'ctDigital': ctDigital,
      'ctNonDigital': ctNonDigital,
      'otherDigital': otherDigital,
      'otherNonDigital': otherNonDigital,
      'photographsDigital': photographsDigital,
      'photographsNonDigital': photographsNonDigital,
      'otherRadiographs': otherRadiographs,
      'uploadedFiles': uploadedFiles,

      'conditionOfJaws': conditionOfJaws,
      'otherDetails': otherDetails,
    };
  }
}
