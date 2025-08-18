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

// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class DentalDataProvider extends ChangeNotifier {
//
//   // 📌 기록 유형(PM/AM) + AM 번호
//   String recordType = 'PM';   // 'PM' 또는 'AM'
//   String amNumber = '';
//
//   // 📌 FDI 치아별 데이터
//   final Map<int, Map<String, dynamic>> fdiToothData = {};
//
//   // DentalDataProvider 생성자에 로드 호출
//   DentalDataProvider() {
//     _loadIncidentPrefs(); // 앱 시작 시 저장된 잠금 상태/값 복구
//   }
//
// // 키 상수
//   static const _kLockEnabledKey = 'incidentLockEnabled';
//   static const _kLockedPlaceKey = 'lockedPlace';
//   static const _kLockedNatureKey = 'lockedNature';
//
// // 저장된 값 불러오기
//   Future<void> _loadIncidentPrefs() async {
//     final prefs = await SharedPreferences.getInstance();
//     incidentLockEnabled = prefs.getBool(_kLockEnabledKey) ?? false;
//     lockedPlace = prefs.getString(_kLockedPlaceKey) ?? '';
//     lockedNature = prefs.getString(_kLockedNatureKey) ?? '';
//     notifyListeners();
//   }
//
// // 저장하기
//   Future<void> _saveIncidentPrefs() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setBool(_kLockEnabledKey, incidentLockEnabled);
//     await prefs.setString(_kLockedPlaceKey, lockedPlace);
//     await prefs.setString(_kLockedNatureKey, lockedNature);
//   }
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
//   // 📌 RecordScreen 관련 필드 (사용자 입력 원본)
//   String placeOfDisaster = '';
//   String natureOfDisaster = '';
//   String pmNumber = '';
//   DateTime? dateOfDisaster;
//   String gender = '';
//
//   // ===============================
//   //  Incident Lock (초기 OFF, 값 비어있음)
//   // ===============================
//   bool incidentLockEnabled = false;
//   String lockedPlace = '';
//   String lockedNature = '';
//
//   /// UI/저장용: 잠금+고정값 존재 시 고정값, 아니면 사용자 입력값
//   String get placeForUi =>
//       (incidentLockEnabled && lockedPlace.isNotEmpty) ? lockedPlace : placeOfDisaster;
//   String get natureForUi =>
//       (incidentLockEnabled && lockedNature.isNotEmpty) ? lockedNature : natureOfDisaster;
//
//   /// 고정값 설정
//   void setLockedValues({String? place, String? nature}) {
//     if (place != null) lockedPlace = place;
//     if (nature != null) lockedNature = nature;
//     notifyListeners();
//     _saveIncidentPrefs();
//   }
//
//   void setLockedPlace(String v) {
//     lockedPlace = v;
//     notifyListeners();
//   }
//
//   void setLockedNature(String v) {
//     lockedNature = v;
//     notifyListeners();
//   }
//
//   /// 잠금 ON (고정값이 모두 있어야 true)
//   bool enableIncidentLock({String? place, String? nature}) {
//     if (place != null) lockedPlace = place;
//     if (nature != null) lockedNature = nature;
//     if (lockedPlace.isEmpty || lockedNature.isEmpty) {
//       return false; // 값 없으면 실패
//     }
//     incidentLockEnabled = true;
//     notifyListeners();
//     _saveIncidentPrefs();
//     return true;
//   }
//
//   /// 잠금 OFF
//   void disableIncidentLock() {
//     incidentLockEnabled = false;
//     notifyListeners();
//     _saveIncidentPrefs();
//   }
//
//   void updateRecordType(String type) {
//     if (type != 'PM' && type != 'AM') return; // 유효성 체크
//     if (recordType == type) return;           // 동일 값이면 무시
//     recordType = type;
//     notifyListeners();
//   }
//
//   void updateAmNumber(String value) {
//     if (amNumber == value) return;            // 동일 값이면 무시
//     amNumber = value;
//     notifyListeners();
//   }
//
//   // ===============================
//   //           SETTERS
//   // ===============================
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
//     bool? paD,
//     bool? paND,
//     bool? bwD,
//     bool? bwND,
//     bool? opgD,
//     bool? opgND,
//     bool? ctD,
//     bool? ctND,
//     bool? otherD,
//     bool? otherND,
//     bool? photoD,
//     bool? photoND,
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
//     if (incidentLockEnabled) return; // 잠금 시 무시
//     placeOfDisaster = place;
//     notifyListeners();
//   }
//
//   void updateNature(String nature) {
//     if (incidentLockEnabled) return; // 잠금 시 무시
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
//
//     recordType = 'PM';
//     amNumber = '';
//
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
//     // ⚠ incidentLockEnabled / lockedPlace / lockedNature 는 유지
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
//   Map<String, dynamic> toMap() {
//     return {
//       'recordType': recordType,
//       'amNumber': amNumber,
//
//       // ✅ 잠금 반영 값으로 저장
//       'placeOfDisaster': placeForUi,
//       'natureOfDisaster': natureForUi,
//
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

// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
//
// class DentalDataProvider extends ChangeNotifier {
//   // ===============================
//   //  Record type (PM/AM)
//   // ===============================
//   String recordType = 'PM'; // 'PM' or 'AM'
//   String amNumber = '';
//   String pmNumber = '';
//
//   // ===============================
//   //  Incident Lock (원격 Firestore 연동)
//   // ===============================
//   bool incidentLockEnabled = false;
//   String lockedPlace = '';
//   String lockedNature = '';
//
//   /// 잠금 적용 시: 고정값, 아니면 사용자 입력값
//   String get placeForUi =>
//       (incidentLockEnabled && lockedPlace.isNotEmpty) ? lockedPlace : placeOfDisaster;
//   String get natureForUi =>
//       (incidentLockEnabled && lockedNature.isNotEmpty) ? lockedNature : natureOfDisaster;
//
//   // Firestore 문서 구독
//   final DocumentReference<Map<String, dynamic>> _lockDoc =
//   FirebaseFirestore.instance.collection('config').doc('incidentLock');
//   StreamSubscription<DocumentSnapshot<Map<String, dynamic>>>? _lockSub;
//
//   DentalDataProvider() {
//     _listenIncidentLock(); // 앱 시작 시 원격 잠금 상태를 구독
//   }
//
//   void _listenIncidentLock() {
//     _lockSub = _lockDoc.snapshots().listen((snap) {
//       final d = snap.data();
//       if (d == null) return;
//       incidentLockEnabled = (d['enabled'] ?? false) as bool;
//       lockedPlace = (d['place'] ?? '') as String;
//       lockedNature = (d['nature'] ?? '') as String;
//       notifyListeners();
//     });
//   }
//
//   /// 원격에 잠금/고정값 저장(모든 기기에 반영)
//   Future<void> setIncidentLockRemote({
//     required bool enabled,
//     required String place,
//     required String nature,
//   }) async {
//     if (enabled && (place.isEmpty || nature.isEmpty)) {
//       throw ArgumentError('Place/Nature required to enable incident lock.');
//     }
//     await _lockDoc.set({
//       'enabled': enabled,
//       'place': place,
//       'nature': nature,
//       'updatedAt': FieldValue.serverTimestamp(),
//       'byUid': FirebaseAuth.instance.currentUser?.uid,
//     }, SetOptions(merge: true));
//   }
//
//   @override
//   void dispose() {
//     _lockSub?.cancel();
//     super.dispose();
//   }
//
//   // ===============================
//   //  FDI 치아 데이터 & 기타 필드
//   // ===============================
//   final Map<int, Map<String, dynamic>> fdiToothData = {};
//
//   String otherFindings = "";
//   String dentitionType = "";
//
//   int? ageMin;
//   int? ageMax;
//
//   String qualityCheckSignature = "";
//   DateTime? qualityCheckDate;
//
//   // 610: Materials Available
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
//   // RecordScreen 관련 사용자 입력 원본
//   String placeOfDisaster = '';
//   String natureOfDisaster = '';
//   DateTime? dateOfDisaster;
//   String gender = '';
//
//   // ===============================
//   //  Setters / Updaters
//   // ===============================
//   void updateRecordType(String type) {
//     if (type != 'PM' && type != 'AM') return;
//     if (recordType == type) return;
//     recordType = type;
//     notifyListeners();
//   }
//
//   void updateAmNumber(String value) {
//     if (amNumber == value) return;
//     amNumber = value;
//     notifyListeners();
//   }
//
//   void updatePmNumber(String pm) {
//     if (pmNumber == pm) return;
//     pmNumber = pm;
//     notifyListeners();
//   }
//
//   void updatePlace(String place) {
//     if (incidentLockEnabled) return; // 잠금 시 무시
//     placeOfDisaster = place;
//     notifyListeners();
//   }
//
//   void updateNature(String nature) {
//     if (incidentLockEnabled) return; // 잠금 시 무시
//     natureOfDisaster = nature;
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
//     bool? paD,
//     bool? paND,
//     bool? bwD,
//     bool? bwND,
//     bool? opgD,
//     bool? opgND,
//     bool? ctD,
//     bool? ctND,
//     bool? otherD,
//     bool? otherND,
//     bool? photoD,
//     bool? photoND,
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
//   void setFdiToothData(Map<int, Map<String, String>> newData) {
//     fdiToothData.clear();
//     fdiToothData.addAll(newData);
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
//   //  Reset / Save
//   // ===============================
//   void resetAll() {
//     recordType = 'PM';
//     amNumber = '';
//     pmNumber = '';
//
//     fdiToothData.clear();
//
//     otherFindings = "";
//     dentitionType = "";
//     ageMin = null;
//     ageMax = null;
//     qualityCheckSignature = "";
//     qualityCheckDate = null;
//
//     upperJawWithTeeth = false;
//     lowerJawWithTeeth = false;
//     upperJawWithoutTeeth = false;
//     lowerJawWithoutTeeth = false;
//     fragments = false;
//     teethOnly = '';
//     otherMaterials = '';
//
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
//     conditionOfJaws = '';
//     otherDetails = '';
//
//     placeOfDisaster = '';
//     natureOfDisaster = '';
//     dateOfDisaster = null;
//     gender = '';
//
//     // incidentLockEnabled / lockedPlace / lockedNature 는 Firestore에서 유지/동기화
//     notifyListeners();
//   }
//
//   Map<String, dynamic> toMap() {
//     return {
//       'recordType': recordType,
//       'amNumber': amNumber,
//       'pmNumber': pmNumber,
//
//       // 잠금 반영 값으로 저장
//       'placeOfDisaster': placeForUi,
//       'natureOfDisaster': natureForUi,
//
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

// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
//
// /// 5면 키 고정 (중앙 O, 위 L, 아래 B, 좌/우는 M/D)
// const List<String> kToothSurfaces = ['O', 'M', 'D', 'L', 'B'];
//
// /// 치식 표기(635)에서 사용할 마크 타입
// enum ToothMarkType { lesion, restoration, prosthesis, status, other }
//
// /// 하나의 코드 항목 (예: "ABR", "AMF", "UIC" 등)
// class ToothMark {
//   final String code;                 // 필수 코드 문자열
//   final ToothMarkType type;          // 분류
//   final bool isParent;               // 상위 레벨만 알 때 true (예: UIC, TCC)
//   final String? note;                // 선택 메모
//
//   const ToothMark({
//     required this.code,
//     this.type = ToothMarkType.other,
//     this.isParent = false,
//     this.note,
//   });
//
//   Map<String, dynamic> toJson() => {
//     'code': code,
//     'type': type.name,
//     'isParent': isParent,
//     'note': note,
//   };
//
//   factory ToothMark.fromJson(Map<String, dynamic> j) => ToothMark(
//     code: j['code'] as String,
//     type: ToothMarkType.values.firstWhere(
//           (e) => e.name == (j['type'] as String? ?? 'other'),
//       orElse: () => ToothMarkType.other,
//     ),
//     isParent: (j['isParent'] ?? false) as bool,
//     note: j['note'] as String?,
//   );
// }
//
// /// 한 치아의 모든 데이터(정규 구조)
// class ToothFinding {
//   ToothFinding();
//   /// 면별 코드 목록 (O/M/D/L/B)
//   final Map<String, List<ToothMark>> surfaces = {
//     for (final s in kToothSurfaces) s: <ToothMark>[],
//   };
//
//   /// 확대 화면에서 단순 채색/선택만을 위한 표면 토글 상태
//   final Set<String> selected = <String>{};
//
//   /// 치아 전체(표면 무관) 코드 목록 (Status 등)
//   final List<ToothMark> global = <ToothMark>[];
//
//   /// 면별 메모
//   final Map<String, String> surfaceNote = <String, String>{};
//
//   /// 치아 전체 메모
//   String? toothNote;
//
//   Map<String, dynamic> toJson() => {
//     'surfaces': {
//       for (final e in surfaces.entries)
//         e.key: e.value.map((m) => m.toJson()).toList(),
//     },
//     'selected': selected.toList(),
//     'global': global.map((m) => m.toJson()).toList(),
//     'surfaceNote': surfaceNote,
//     'toothNote': toothNote,
//   };
//
//   factory ToothFinding.fromJson(Map<String, dynamic> j) {
//     final tf = ToothFinding();
//     final surf = (j['surfaces'] as Map?) ?? {};
//     for (final s in kToothSurfaces) {
//       final list = (surf[s] as List?) ?? const [];
//       tf.surfaces[s]!.addAll(list.map((e) => ToothMark.fromJson(Map<String, dynamic>.from(e))));
//     }
//     final sel = (j['selected'] as List?) ?? const [];
//     tf.selected.addAll(sel.map((e) => e.toString()));
//     final gl = (j['global'] as List?) ?? const [];
//     tf.global.addAll(gl.map((e) => ToothMark.fromJson(Map<String, dynamic>.from(e))));
//     final sn = (j['surfaceNote'] as Map?) ?? {};
//     tf.surfaceNote.addAll(sn.map((k, v) => MapEntry(k.toString(), v.toString())));
//     tf.toothNote = j['toothNote'] as String?;
//     return tf;
//   }
// }
//
// class DentalDataProvider extends ChangeNotifier {
//   // ----------------- Record / Incident lock -----------------
//   String recordType = 'PM';
//   String amNumber = '';
//   String pmNumber = '';
//
//   bool incidentLockEnabled = false;
//   String lockedPlace = '';
//   String lockedNature = '';
//   String get placeForUi =>
//       (incidentLockEnabled && lockedPlace.isNotEmpty) ? lockedPlace : placeOfDisaster;
//   String get natureForUi =>
//       (incidentLockEnabled && lockedNature.isNotEmpty) ? lockedNature : natureOfDisaster;
//
//   final DocumentReference<Map<String, dynamic>> _lockDoc =
//   FirebaseFirestore.instance.collection('config').doc('incidentLock');
//   StreamSubscription<DocumentSnapshot<Map<String, dynamic>>>? _lockSub;
//
//   DentalDataProvider() {
//     _listenIncidentLock();
//   }
//
//   void _listenIncidentLock() {
//     _lockSub = _lockDoc.snapshots().listen((snap) {
//       final d = snap.data();
//       if (d == null) return;
//       incidentLockEnabled = (d['enabled'] ?? false) as bool;
//       lockedPlace = (d['place'] ?? '') as String;
//       lockedNature = (d['nature'] ?? '') as String;
//       notifyListeners();
//     });
//   }
//
//   Future<void> setIncidentLockRemote({
//     required bool enabled,
//     required String place,
//     required String nature,
//   }) async {
//     if (enabled && (place.isEmpty || nature.isEmpty)) {
//       throw ArgumentError('Place/Nature required to enable incident lock.');
//     }
//     await _lockDoc.set(
//       {
//         'enabled': enabled,
//         'place': place,
//         'nature': nature,
//         'updatedAt': FieldValue.serverTimestamp(),
//         'byUid': FirebaseAuth.instance.currentUser?.uid,
//       },
//       SetOptions(merge: true),
//     );
//   }
//
//   @override
//   void dispose() {
//     _lockSub?.cancel();
//     super.dispose();
//   }
//
//   // ----------------- Odontogram 데이터 -----------------
//
//   /// (하위 호환) 간단 문자열 저장용 – 일부 화면이 사용 중일 수 있어 유지
//   final Map<int, Map<String, dynamic>> fdiToothData = <int, Map<String, dynamic>>{};
//
//   /// 정규 구조
//   final Map<int, ToothFinding> teethFindings = <int, ToothFinding>{};
//
//   ToothFinding _getOrCreate(int fdi) =>
//       teethFindings.putIfAbsent(fdi, () => ToothFinding());
//
//   // ----- 5면 선택(채색) API -----
//   Set<String> getSelectedSurfaces(int fdi) {
//     final t = teethFindings[fdi];
//     if (t == null) return {};
//     // 선택 토글 + 실데이터 존재면 선택으로 간주
//     final hasData = kToothSurfaces.where((s) => (t.surfaces[s]!.isNotEmpty) || t.surfaceNote.containsKey(s));
//     return {...t.selected, ...hasData};
//   }
//
//   void toggleSurface(int fdi, String surfaceKey) {
//     if (!kToothSurfaces.contains(surfaceKey)) return;
//     final t = _getOrCreate(fdi);
//     if (t.selected.contains(surfaceKey)) {
//       t.selected.remove(surfaceKey);
//     } else {
//       t.selected.add(surfaceKey);
//     }
//     notifyListeners();
//   }
//
//   void clearSurfaces(int fdi) {
//     final t = _getOrCreate(fdi);
//     t.selected.clear();
//     notifyListeners();
//   }
//
//   // ----- 코드(635) / 메모 -----
//   /// 표면에 코드 추가 (surface == null 이면 치아 전역)
//   void addMark({
//     required int fdi,
//     String? surface,
//     required ToothMark mark,
//   }) {
//     final t = _getOrCreate(fdi);
//     if (surface == null) {
//       t.global.add(mark);
//     } else {
//       if (!kToothSurfaces.contains(surface)) return;
//       t.surfaces[surface]!.add(mark);
//     }
//     notifyListeners();
//   }
//
//   /// 특정 표면의 코드/메모 전체 삭제 (선택 토글은 유지)
//   void clearSurfaceData(int fdi, String surface) {
//     final t = _getOrCreate(fdi);
//     if (!kToothSurfaces.contains(surface)) return;
//     t.surfaces[surface]!.clear();
//     t.surfaceNote.remove(surface);
//     notifyListeners();
//   }
//
//   /// 치아 전체 초기화(선택/코드/메모 모두)
//   void clearTooth(int fdi) {
//     teethFindings.remove(fdi);
//     fdiToothData.remove(fdi);
//     notifyListeners();
//   }
//
//   void setSurfaceNote(int fdi, String surface, String note) {
//     if (!kToothSurfaces.contains(surface)) return;
//     final t = _getOrCreate(fdi);
//     t.surfaceNote[surface] = note;
//     notifyListeners();
//   }
//
//   void setToothNote(int fdi, String? note) {
//     final t = _getOrCreate(fdi);
//     final n = note?.trim();
//     t.toothNote = (n == null || n.isEmpty) ? null : n;
//     notifyListeners();
//   }
//
//   /// 635 출력용 문자열 한 줄 생성 (예: "ABR(M) · AMF(O) · UIC · note:…")
//   String build635Line(int fdi) {
//     final t = teethFindings[fdi];
//     if (t == null) return '';
//     final out = <String>[];
//
//     for (final s in kToothSurfaces) {
//       final list = t.surfaces[s]!;
//       if (list.isEmpty) continue;
//       final codes = list.map((m) => m.code).join(',');
//       out.add('$codes($s)');
//     }
//     if (t.global.isNotEmpty) {
//       out.addAll(t.global.map((m) => m.code));
//     }
//     if (t.toothNote != null && t.toothNote!.isNotEmpty) {
//       out.add('note:${t.toothNote}');
//     }
//     return out.join(' · ');
//   }
//
//   // ----- (하위 호환) 간단 문자열 메모 -----
//   void setToothDetail(int tooth, String detail) {
//     fdiToothData[tooth] = {'detail': detail};
//     notifyListeners();
//   }
//
//   void bulkSetToothDetail(Iterable<int> teeth, String detail) {
//     for (final t in teeth) {
//       fdiToothData[t] = {'detail': detail};
//     }
//     notifyListeners();
//   }
//
//   void clearToothDetail(int tooth) {
//     fdiToothData.remove(tooth);
//     notifyListeners();
//   }
//
//   // ----------------- 나머지 폼 필드 -----------------
//   String otherFindings = "";
//   String dentitionType = "";
//   int? ageMin;
//   int? ageMax;
//   String qualityCheckSignature = "";
//   DateTime? qualityCheckDate;
//
//   // 610 Materials Available
//   bool upperJawWithTeeth = false;
//   bool lowerJawWithTeeth = false;
//   bool upperJawWithoutTeeth = false;
//   bool lowerJawWithoutTeeth = false;
//   bool fragments = false;
//   String teethOnly = '';
//   String otherMaterials = '';
//
//   // Radiographs
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
//   // RecordScreen 원본 입력
//   String placeOfDisaster = '';
//   String natureOfDisaster = '';
//   DateTime? dateOfDisaster;
//   String gender = '';
//
//   // ----------------- Updaters -----------------
//   void updateRecordType(String type) {
//     if (type != 'PM' && type != 'AM') return;
//     if (recordType == type) return;
//     recordType = type;
//     notifyListeners();
//   }
//
//   void updateAmNumber(String value) {
//     if (amNumber == value) return;
//     amNumber = value;
//     notifyListeners();
//   }
//
//   void updatePmNumber(String pm) {
//     if (pmNumber == pm) return;
//     pmNumber = pm;
//     notifyListeners();
//   }
//
//   void updatePlace(String place) {
//     if (incidentLockEnabled) return;
//     placeOfDisaster = place;
//     notifyListeners();
//   }
//
//   void updateNature(String nature) {
//     if (incidentLockEnabled) return;
//     natureOfDisaster = nature;
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
//     bool? paD,
//     bool? paND,
//     bool? bwD,
//     bool? bwND,
//     bool? opgD,
//     bool? opgND,
//     bool? ctD,
//     bool? ctND,
//     bool? otherD,
//     bool? otherND,
//     bool? photoD,
//     bool? photoND,
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
//   void setFdiToothData(Map<int, Map<String, String>> newData) {
//     fdiToothData.clear();
//     fdiToothData.addAll(newData);
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
//   // ----------------- Reset / Save -----------------
//   void resetAll() {
//     recordType = 'PM';
//     amNumber = '';
//     pmNumber = '';
//
//     fdiToothData.clear();
//     teethFindings.clear();
//
//     otherFindings = "";
//     dentitionType = "";
//     ageMin = null;
//     ageMax = null;
//     qualityCheckSignature = "";
//     qualityCheckDate = null;
//
//     upperJawWithTeeth = false;
//     lowerJawWithTeeth = false;
//     upperJawWithoutTeeth = false;
//     lowerJawWithoutTeeth = false;
//     fragments = false;
//     teethOnly = '';
//     otherMaterials = '';
//
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
//     conditionOfJaws = '';
//     otherDetails = '';
//
//     placeOfDisaster = '';
//     natureOfDisaster = '';
//     dateOfDisaster = null;
//     gender = '';
//
//     notifyListeners();
//   }
//
//   Map<String, dynamic> toMap() {
//     return {
//       'recordType': recordType,
//       'amNumber': amNumber,
//       'pmNumber': pmNumber,
//       'placeOfDisaster': placeForUi,
//       'natureOfDisaster': natureForUi,
//       'dateOfDisaster': dateOfDisaster?.toIso8601String(),
//       'gender': gender,
//
//       // 정규 구조 저장
//       'teethFindings': {
//         for (final e in teethFindings.entries) e.key.toString(): e.value.toJson(),
//       },
//
//       // (하위 호환) 간단 문자열
//       'fdiToothData': {for (final e in fdiToothData.entries) e.key.toString(): e.value},
//
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

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// 5면 키 (중앙 O, 위 L, 아래 B, 좌/우는 M/D)
const List<String> kToothSurfaces = ['O', 'M', 'D', 'L', 'B'];

// ===== 스팬 모델 =====
enum DentalSpanType { dentureOrtho, bridge }

class DentalSpan {
  final String id;
  final DentalSpanType type;
  final Set<int> teeth;     // 이 스팬에 속한 모든 FDI
  final Set<int> abutments; // bridge 전용
  final Set<int> pontics;   // bridge 전용
  final String? code;       // denture/ortho 코드(예: CLA, FUD ...)

  DentalSpan({
    required this.id,
    required this.type,
    required Set<int> teeth,
    Set<int>? abutments,
    Set<int>? pontics,
    this.code,
  })  : teeth = {...teeth},
        abutments = {...(abutments ?? const <int>{})},
        pontics = {...(pontics ?? const <int>{})};

  Map<String, dynamic> toJson() => {
    'id': id,
    'type': type.name,
    'teeth': teeth.toList(),
    'abutments': abutments.toList(),
    'pontics': pontics.toList(),
    'code': code,
  };

  factory DentalSpan.fromJson(Map<String, dynamic> j) => DentalSpan(
    id: (j['id'] ?? '').toString(),
    type: DentalSpanType.values.firstWhere(
          (e) => e.name == (j['type'] as String? ?? 'dentureOrtho'),
      orElse: () => DentalSpanType.dentureOrtho,
    ),
    teeth: Set<int>.from(
      ((j['teeth'] as List?) ?? const [])
          .map((e) => int.parse(e.toString())),
    ),
    abutments: Set<int>.from(
      ((j['abutments'] as List?) ?? const [])
          .map((e) => int.parse(e.toString())),
    ),
    pontics: Set<int>.from(
      ((j['pontics'] as List?) ?? const [])
          .map((e) => int.parse(e.toString())),
    ),
    code: j['code'] as String?,
  );
}

class DentalDataProvider extends ChangeNotifier {
  // ----------------- Record / Incident lock -----------------
  String recordType = 'PM';
  String amNumber = '';
  String pmNumber = '';

  bool incidentLockEnabled = false;
  String lockedPlace = '';
  String lockedNature = '';
  String get placeForUi =>
      (incidentLockEnabled && lockedPlace.isNotEmpty) ? lockedPlace : placeOfDisaster;
  String get natureForUi =>
      (incidentLockEnabled && lockedNature.isNotEmpty) ? lockedNature : natureOfDisaster;

  final DocumentReference<Map<String, dynamic>> _lockDoc =
  FirebaseFirestore.instance.collection('config').doc('incidentLock');
  StreamSubscription<DocumentSnapshot<Map<String, dynamic>>>? _lockSub;

  DentalDataProvider() {
    _listenIncidentLock();
  }

  void _listenIncidentLock() {
    _lockSub = _lockDoc.snapshots().listen((snap) {
      final d = snap.data();
      if (d == null) return;
      incidentLockEnabled = (d['enabled'] ?? false) as bool;
      lockedPlace = (d['place'] ?? '') as String;
      lockedNature = (d['nature'] ?? '') as String;
      notifyListeners();
    });
  }

  Future<void> setIncidentLockRemote({
    required bool enabled,
    required String place,
    required String nature,
  }) async {
    if (enabled && (place.isEmpty || nature.isEmpty)) {
      throw ArgumentError('Place/Nature required to enable incident lock.');
    }
    await _lockDoc.set(
      {
        'enabled': enabled,
        'place': place,
        'nature': nature,
        'updatedAt': FieldValue.serverTimestamp(),
        'byUid': FirebaseAuth.instance.currentUser?.uid,
      },
      SetOptions(merge: true),
    );
  }

  @override
  void dispose() {
    _lockSub?.cancel();
    super.dispose();
  }

  // ----------------- Odontogram (STEP 2 전용 경량 상태) -----------------

  /// (하위 호환) 간단 문자열 메모 — 그대로 유지
  final Map<int, Map<String, dynamic>> fdiToothData = <int, Map<String, dynamic>>{};

  /// 표면 선택 토글 상태만 간단 보관 (STEP 1/2)
  final Map<int, Set<String>> _selectedSurfaces = <int, Set<String>>{};

  Set<String> getSelectedSurfaces(int fdi) => _selectedSurfaces[fdi] ?? <String>{};

  void toggleSurface(int fdi, String surfaceKey) {
    if (!kToothSurfaces.contains(surfaceKey)) return;
    final s = _selectedSurfaces.putIfAbsent(fdi, () => <String>{});
    if (s.contains(surfaceKey)) {
      s.remove(surfaceKey);
    } else {
      s.add(surfaceKey);
    }
    notifyListeners();
  }

  void clearSurfaces(int fdi) {
    final s = _selectedSurfaces[fdi];
    if (s == null) return;
    s.clear();
    notifyListeners();
  }

  // ----------------- STEP 2: Denture/Bridge 스팬 -----------------
  final List<DentalSpan> spans = <DentalSpan>[];

  String _randId() => DateTime.now().microsecondsSinceEpoch.toString();

  List<DentalSpan> spansIntersecting(Iterable<int> fdis) {
    final set = fdis.toSet();
    return spans.where((sp) => sp.teeth.any(set.contains)).toList();
  }

  void addDentureSpan(List<int> selectedFdi, {String? code}) {
    if (selectedFdi.isEmpty) return;
    spans.add(
      DentalSpan(
        id: _randId(),
        type: DentalSpanType.dentureOrtho,
        teeth: Set<int>.from(selectedFdi),
        code: code,
      ),
    );
    notifyListeners();
  }

  void addBridgeSpan({
    required List<int> selectedFdi,
    required Set<int> abutments,
    required Set<int> pontics,
    String? code,
  }) {
    if (selectedFdi.isEmpty || abutments.isEmpty || pontics.isEmpty) return;
    spans.add(
      DentalSpan(
        id: _randId(),
        type: DentalSpanType.bridge,
        teeth: Set<int>.from(selectedFdi),
        abutments: abutments,
        pontics: pontics,
        code: code,
      ),
    );
    notifyListeners();
  }

  void removeSpan(String id) {
    spans.removeWhere((e) => e.id == id);
    notifyListeners();
  }

  /// 선택된 치아와 교집합이 있는 스팬 일괄 삭제 (툴바의 '스팬 삭제'에서 사용)
  int removeSpansIntersecting(Set<int> targets,
      {bool removeDenture = true, bool removeBridge = true}) {
    final before = spans.length;
    spans.removeWhere((sp) {
      final hit = sp.teeth.any(targets.contains);
      if (!hit) return false;
      if (sp.type == DentalSpanType.dentureOrtho && !removeDenture) return false;
      if (sp.type == DentalSpanType.bridge && !removeBridge) return false;
      return true;
    });
    final removed = before - spans.length;
    if (removed > 0) notifyListeners();
    return removed;
  }

  // ----------------- (하위 호환) 간단 문자열 메모 조작 -----------------
  void setToothDetail(int tooth, String detail) {
    fdiToothData[tooth] = {'detail': detail};
    notifyListeners();
  }

  void bulkSetToothDetail(Iterable<int> teeth, String detail) {
    for (final t in teeth) {
      fdiToothData[t] = {'detail': detail};
    }
    notifyListeners();
  }

  void clearToothDetail(int tooth) {
    fdiToothData.remove(tooth);
    notifyListeners();
  }

  // ----------------- 나머지 폼 필드 -----------------
  String otherFindings = "";
  String dentitionType = "";
  int? ageMin;
  int? ageMax;
  String qualityCheckSignature = "";
  DateTime? qualityCheckDate;

  // 610 Materials Available
  bool upperJawWithTeeth = false;
  bool lowerJawWithTeeth = false;
  bool upperJawWithoutTeeth = false;
  bool lowerJawWithoutTeeth = false;
  bool fragments = false;
  String teethOnly = '';
  String otherMaterials = '';

  // Radiographs
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

  // RecordScreen 원본 입력
  String placeOfDisaster = '';
  String natureOfDisaster = '';
  DateTime? dateOfDisaster;
  String gender = '';

  // ----------------- Updaters -----------------
  void updateRecordType(String type) {
    if (type != 'PM' && type != 'AM') return;
    if (recordType == type) return;
    recordType = type;
    notifyListeners();
  }

  void updateAmNumber(String value) {
    if (amNumber == value) return;
    amNumber = value;
    notifyListeners();
  }

  void updatePmNumber(String pm) {
    if (pmNumber == pm) return;
    pmNumber = pm;
    notifyListeners();
  }

  void updatePlace(String place) {
    if (incidentLockEnabled) return;
    placeOfDisaster = place;
    notifyListeners();
  }

  void updateNature(String nature) {
    if (incidentLockEnabled) return;
    natureOfDisaster = nature;
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

  void setFdiToothData(Map<int, Map<String, String>> newData) {
    fdiToothData.clear();
    fdiToothData.addAll(newData);
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

  // ----------------- Reset / Save -----------------
  void resetAll() {
    recordType = 'PM';
    amNumber = '';
    pmNumber = '';

    fdiToothData.clear();
    _selectedSurfaces.clear();
    spans.clear();

    otherFindings = "";
    dentitionType = "";
    ageMin = null;
    ageMax = null;
    qualityCheckSignature = "";
    qualityCheckDate = null;

    upperJawWithTeeth = false;
    lowerJawWithTeeth = false;
    upperJawWithoutTeeth = false;
    lowerJawWithoutTeeth = false;
    fragments = false;
    teethOnly = '';
    otherMaterials = '';

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

    conditionOfJaws = '';
    otherDetails = '';

    placeOfDisaster = '';
    natureOfDisaster = '';
    dateOfDisaster = null;
    gender = '';

    notifyListeners();
  }

  Map<String, dynamic> toMap() {
    return {
      'recordType': recordType,
      'amNumber': amNumber,
      'pmNumber': pmNumber,
      'placeOfDisaster': placeForUi,
      'natureOfDisaster': natureForUi,
      'dateOfDisaster': dateOfDisaster?.toIso8601String(),
      'gender': gender,

      // (하위 호환) 간단 문자열
      'fdiToothData': {
        for (final e in fdiToothData.entries) e.key.toString(): e.value
      },

      // STEP 2: 스팬 직렬화
      'spans': spans.map((e) => e.toJson()).toList(),

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




