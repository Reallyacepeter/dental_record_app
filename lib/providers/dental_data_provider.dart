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
import 'dart:collection';                 // ← 추가
import '../data/codes_635.dart';
import '../services/local_store.dart';    // ← 추가 (Hive 래퍼 사용 시)

import '../models/uploaded_file_meta.dart';

// ✅ ADD: 계층 코드 로딩을 위한 import
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

import 'package:firebase_core/firebase_core.dart';

import '../schema.dart';

// ✅ ADD: 뷰 모드 (축소/확대)
enum ViewMode { zoomOut, zoomIn }

// ✅ ADD: 축소뷰(DentalFindingsScreen)는 이 두 카테고리만 다룸
const spanCategories = <String>{
  'Denture and Orthodontic Appl.',
  'Bridge',
};

// ✅ ADD: 계층 코드 노드
class CodeNode {
  final String code;       // "bridge", "ABU", "UIB", "MTB" ...
  final String label;      // 표시용
  final List<CodeNode> children;
  bool get isLeaf => children.isEmpty;

  CodeNode({required this.code, required this.label, this.children = const []});

  factory CodeNode.fromMap(String code, Map<String, dynamic> m) {
    final Map<String, dynamic> childMap = (m['children'] ?? {}) as Map<String, dynamic>;
    return CodeNode(
      code: code,
      label: (m['label'] ?? code).toString(),
      children: childMap.entries.map((e) => CodeNode.fromMap(e.key, e.value)).toList(),
    );
  }

  Map<String, dynamic> toMap() => {
    'code': code,
    'label': label,
    'children': [for (final c in children) c.toMap()],
  };
}

// ✅ ADD: 어떤 레벨에서든 확정 가능한 선택 경로
class CodeSelection {
  final String category;     // 예: "Bridge" / "Denture and Orthodontic Appl." / 기타
  final List<String> path;   // 루트→선택 노드: ["bridge","ABU","UIB","MTB"] 중 어디서든 종료 가능

  const CodeSelection({required this.category, required this.path});

  String get selected => path.isEmpty ? "" : path.last;
  int get depth => path.length;

  Map<String, dynamic> toMap() => {
    "category": category,
    "path": path,
    "selected": selected,
    "depth": depth,
  };

  factory CodeSelection.fromMap(Map<String, dynamic> m) =>
      CodeSelection(
        category: (m["category"] ?? "").toString(),
        path: List<String>.from((m["path"] as List?) ?? const []),
      );
}

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

// ===== 635 Specific Data =====
class SpecificData {
  SpecificData();
  // 전역 코드: bite/crown/root/status/position/crown pathology
  final Map<String, List<String>> global = {
    'bite': <String>[],
    'crown': <String>[],
    'root': <String>[],
    'status': <String>[],
    'position': <String>[],
    'crown pathology': <String>[],
  };

  // 표면 코드: O/M/D/L/B × (fillings/periodontium)
  final Map<String, Map<String, List<String>>> surface = {
    for (final s in kToothSurfaces)
      s: {
        'fillings': <String>[],
        'periodontium': <String>[],
      }
  };

  String? toothNote;                        // 치아 전역 자연어
  final Map<String, String> surfaceNote = <String, String>{}; // 표면 자연어

  Map<String, dynamic> toJson() => {
    'global': global,
    'surface': surface,
    'toothNote': toothNote,
    'surfaceNote': surfaceNote,
  };

  factory SpecificData.fromJson(Map<String, dynamic> j) {
    final x = SpecificData();
    final g = (j['global'] as Map?) ?? {};
    for (final k in x.global.keys) {
      x.global[k] = List<String>.from((g[k] as List?) ?? const []);
    }
    final sv = (j['surface'] as Map?) ?? {};
    for (final s in kToothSurfaces) {
      final m = (sv[s] as Map?) ?? {};
      x.surface[s]!['fillings']     = List<String>.from((m['fillings'] as List?) ?? const []);
      x.surface[s]!['periodontium'] = List<String>.from((m['periodontium'] as List?) ?? const []);
    }
    x.toothNote = j['toothNote'] as String?;
    final sn = (j['surfaceNote'] as Map?) ?? {};
    x.surfaceNote.addAll(sn.map((k, v) => MapEntry(k.toString(), v.toString())));
    return x;
  }
}

class DentalDataProvider extends ChangeNotifier {

  DentalDataProvider({bool listenIncidentLock = false}) {
    if (listenIncidentLock) startIncidentLockListener();
  }

  // ✅ ADD: Interpol 계층 코드 트리
  final Map<String, CodeNode> _codeRoots = {};   // 카테고리 → 루트 노드
  Set<String> _allCategories = {};               // 로딩된 전체 카테고리

  bool get hasCodeTree => _codeRoots.isNotEmpty;

  /// 앱 시작/최초 진입 시 한 번만 로드
  Future<void> loadCodeTreeOnce() async {
    if (_codeRoots.isNotEmpty) return;

    final raw = await rootBundle.loadString('lib/data/prosthesis_tree.json');
    final Map<String, dynamic> jsonMap = jsonDecode(raw);
    _codeRoots.clear();
    _allCategories = jsonMap.keys.toSet();
    jsonMap.forEach((cat, body) {
      final children = (body as Map<String, dynamic>)
          .map((k, v) => MapEntry(k, CodeNode.fromMap(k, v)));
      _codeRoots[cat] = CodeNode(
        code: cat,
        label: cat,
        children: children.values.toList(),
      );
    });
    notifyListeners();
  }

  /// 뷰에 따라 노출할 카테고리 리스트
  List<String> availableCategories(ViewMode mode) {
    if (_codeRoots.isEmpty) return const [];
    if (mode == ViewMode.zoomOut) {
      // 축소뷰: 스팬 전용 2개 카테고리만
      return _allCategories.where(spanCategories.contains).toList()..sort();
    } else {
      // 확대뷰: 나머지 전체 카테고리
      return _allCategories.where((c) => !spanCategories.contains(c)).toList()..sort();
    }
  }

// ---------- 트리 탐색/검증 ----------
  CodeNode? _findNode(String category, List<String> path) {
    final root = _codeRoots[category];
    if (root == null) return null;
    CodeNode cur = root;
    for (final step in path) {
      final idx = cur.children.indexWhere((n) => n.code.toLowerCase() == step.toLowerCase());
      if (idx < 0) return null;
      cur = cur.children[idx];
    }
    return cur;
  }

  List<CodeNode> listChildren(String category, List<String> path) =>
      _findNode(category, path)?.children ?? const [];

  bool isValidSelection(String category, List<String> path) =>
      _findNode(category, path) != null;

// ---------- 선택 상태(선택 사항) ----------
  CodeSelection? currentSelectionCompact; // 축소뷰(DentalFindingsScreen)
  CodeSelection? currentSelectionZoom;    // 확대뷰(QuadrantZoomScreen)

  void setSelectionFor(ViewMode mode, CodeSelection? sel) {
    if (mode == ViewMode.zoomOut) {
      currentSelectionCompact = sel;
    } else {
      currentSelectionZoom = sel;
    }
    notifyListeners();
  }

  // 635 Specific Data (인스턴스 보관)
  final Map<int, SpecificData> _spec635 = <int, SpecificData>{};
  final List<DentalSpan> _spans = <DentalSpan>[];                 // ← 추가
  UnmodifiableListView<DentalSpan> get spans => UnmodifiableListView(_spans); // ← 추가

  Timer? _saveDebounce;                                           // ← 추가(자동 저장 디바운스)
  static int _idSeed = 0;                                         // ← 추가

  void _scheduleAutosave() {                                       // ← 추가
    _saveDebounce?.cancel();
    _saveDebounce = Timer(const Duration(milliseconds: 300), () async {
      await LocalStore.saveDentalState(toMap());
    });
  }

  void _markDirty() {                                              // ← 추가
    _scheduleAutosave();
    notifyListeners();
  }

  /// 읽기 전용 getter (없으면 null)
  SpecificData? getSpecRead(int fdi) => _spec635[fdi];

  /// 쓰기용: 없으면 생성해서 반환
  SpecificData ensureSpec(int fdi) =>
      _spec635.putIfAbsent(fdi, () => SpecificData());

  // 전역 코드 토글
  void toggleGlobalCode(int fdi, String group, String code) {
    final s = ensureSpec(fdi).global[group];
    if (s == null) return;
    if (s.contains(code)) { s.remove(code); } else { s.add(code); }
    notifyListeners();
  }

  // 표면 코드 토글
  void toggleSurfaceCode(int fdi, String surface, String group, String code) {
    if (!kToothSurfaces.contains(surface)) return;
    final s = ensureSpec(fdi).surface[surface]?[group];
    if (s == null) return;
    if (s.contains(code)) { s.remove(code); } else { s.add(code); }
    notifyListeners();
  }

  // 자연어 메모
  void setToothNote635(int fdi, String? note) {
    ensureSpec(fdi).toothNote = (note?.trim().isEmpty ?? true) ? null : note!.trim();
    notifyListeners();
  }

  void setSurfaceNote635(int fdi, String surface, String note) {
    if (!kToothSurfaces.contains(surface)) return;
    ensureSpec(fdi).surfaceNote[surface] = note;
    notifyListeners();
  }

  // 표면 데이터 전체 삭제 (코드+메모)
  void clearSurface635(int fdi, String surface) {
    if (!kToothSurfaces.contains(surface)) return;
    final s = _spec635[fdi];
    if (s == null) return;
    s.surface[surface]?['fillings']?.clear();
    s.surface[surface]?['periodontium']?.clear();
    s.surfaceNote.remove(surface);
    notifyListeners();
  }

  void clearGlobalAll635(int fdi) {
    final spec = getSpecRead(fdi);
    if (spec == null) return;

    // ✅ 전역 그룹 초기화
    for (final g in k635GlobalCodes.keys) {
      spec.global[g] = <String>[];   // 전역 코드 모두 비움
    }

    // ✅ 전역 메모 초기화
    spec.toothNote = '';

    notifyListeners();
  }

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

  DocumentReference<Map<String, dynamic>>? _lockDoc;
  StreamSubscription<DocumentSnapshot<Map<String, dynamic>>>? _lockSub;

  bool get _firebaseReady => Firebase.apps.isNotEmpty;

  /// Firebase init 완료 후에만 호출 (중복 호출 안전)
  void startIncidentLockListener() {
    if (_lockSub != null) return;          // 이미 붙어있음
    if (!_firebaseReady) return;            // 아직 Firebase 초기화 전

    _lockDoc ??= FirebaseFirestore.instance
        .collection('config')
        .doc('incidentLock');

    _lockSub = _lockDoc!.snapshots().listen(
          (snap) {
        if (!snap.exists) return; // 초기엔 없을 수 있음
        final d = snap.data();
        if (d == null) return;
        _withoutAutosave(() {
          incidentLockEnabled = (d['enabled'] ?? false) as bool;
          lockedPlace = (d['place'] ?? '') as String;
          lockedNature = (d['nature'] ?? '') as String;
          super.notifyListeners(); // 저장 안 함
        });
      },
      onError: (e, [st]) {
        debugPrint('incidentLock listen error: $e');
      },
    );
  }

  void stopIncidentLockListener() {
    _lockSub?.cancel();
    _lockSub = null;
  }

  Future<void> setIncidentLockRemote({
    required bool enabled,
    required String place,
    required String nature,
  }) async {
    try {
      if (!_firebaseReady) {
        throw StateError('Firebase is not initialized yet.');
      }
      if (enabled && (place.isEmpty || nature.isEmpty)) {
        throw ArgumentError('Place/Nature required to enable incident lock.');
      }
      _lockDoc ??= FirebaseFirestore.instance
          .collection('config')
          .doc('incidentLock');

      await _lockDoc!.set(
        {
          'enabled': enabled,
          'place': place,
          'nature': nature,
          'updatedAt': FieldValue.serverTimestamp(),
          'byUid': FirebaseAuth.instance.currentUser?.uid,
        },
        SetOptions(merge: true),
      );
    } on FirebaseException catch (e) {
      debugPrint('setIncidentLockRemote failed: ${e.code} ${e.message}');
      rethrow;
    }
  }

  @override
  void dispose() {
    stopIncidentLockListener();  // ✅ 구독 정리
    _saveDebounce?.cancel();
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

  String _randId() => 'sp_${DateTime.now().microsecondsSinceEpoch}_${_idSeed++}';

  List<DentalSpan> spansIntersecting(Iterable<int> fdis) {
    final set = fdis.toSet();
    return _spans.where((sp) => sp.teeth.any(set.contains)).toList();
  }

  bool _isUpperFdi(int fdi) {
    final q = fdi ~/ 10;
    return q == 1 || q == 2 || q == 5 || q == 6;
  }

  bool _allSameArch(Iterable<int> fdis) {
    bool? first;
    for (final f in fdis) {
      final up = _isUpperFdi(f);
      first ??= up;
      if (up != first) return false;
    }
    return true;
  }

  bool _hasTypeConflictInternal(Iterable<int> teeth, DentalSpanType creating) {
    final set = teeth.toSet();
    return _spans.any((sp) => sp.type != creating && sp.teeth.any(set.contains));
  }

  void addDentureSpan(List<int> selectedFdi, {String? code}) {
    if (selectedFdi.isEmpty) return;
    if (!_allSameArch(selectedFdi)) {
      debugPrint('❌ 상/하악 혼합 스팬 금지');
      return;
    }
    // ▼ 추가: Bridge와 충돌 방지
    if (_hasTypeConflictInternal(selectedFdi, DentalSpanType.dentureOrtho)) {
      debugPrint('❌ Denture/Ortho 생성 실패: 이미 Bridge 스팬과 겹칩니다.');
      return;
    }

    _spans.add(DentalSpan(
      id: _randId(),
      type: DentalSpanType.dentureOrtho,
      teeth: Set<int>.from(selectedFdi),
      code: code,
    ));
    _markDirty(); // notifyListeners() 대신
  }

  void addBridgeSpan({
    required List<int> selectedFdi,
    required Set<int> abutments,
    required Set<int> pontics,
    String? code,
  }) {
    if (selectedFdi.isEmpty || abutments.isEmpty || pontics.isEmpty) return;

    // 전체 치아(지대치+pontic 포함) 같은 악궁만 허용
    final union = {...selectedFdi, ...abutments, ...pontics};
    if (!_allSameArch(union)) {
      debugPrint('❌ 상/하악 혼합 브리지 금지');
      return;
    }

    // ▼ 추가: Denture와 충돌 방지
    if (_hasTypeConflictInternal(union, DentalSpanType.bridge)) {
      debugPrint('❌ Bridge 생성 실패: 이미 Denture/Ortho 스팬과 겹칩니다.');
      return;
    }

    _spans.add(DentalSpan(
      id: _randId(),
      type: DentalSpanType.bridge,
      teeth: Set<int>.from(selectedFdi),
      abutments: abutments,
      pontics: pontics,
      code: code,
    ));
    _markDirty(); // notifyListeners() 대신
  }

  void removeSpan(String id) {
    _spans.removeWhere((e) => e.id == id);
    _markDirty(); // notifyListeners() 대신
  }

  /// 선택된 치아와 교집합이 있는 스팬 일괄 삭제 (툴바의 '스팬 삭제'에서 사용)
  int removeSpansIntersecting(Set<int> targets,
      {bool removeDenture = true, bool removeBridge = true}) {
    final before = _spans.length;
    _spans.removeWhere((sp) {
      final hit = sp.teeth.any(targets.contains);
      if (!hit) return false;
      if (sp.type == DentalSpanType.dentureOrtho && !removeDenture) return false;
      if (sp.type == DentalSpanType.bridge && !removeBridge) return false;
      return true;
    });
    final removed = before - _spans.length;
    if (removed > 0) _markDirty(); // notifyListeners() 대신
    return removed;
  }

// 635 한 줄 프리뷰
  String build635Line(int fdi) {
    final s = _spec635[fdi];
    if (s == null) return '';
    final out = <String>[];
    for (final surf in kToothSurfaces) {
      for (final grp in const ['fillings', 'periodontium']) {
        final list = s.surface[surf]![grp]!;
        if (list.isNotEmpty) out.add('${list.join(",")}($surf)');
      }
    }
    for (final g in const ['bite','crown','root','status','position','crown pathology']) {
      final list = s.global[g]!;
      if (list.isNotEmpty) out.add(list.join(','));
    }
    if (s.toothNote != null && s.toothNote!.isNotEmpty) out.add('note:${s.toothNote}');
    return out.join(' · ');
  }

  // 전체 내보내기
  Map<String, dynamic> exportSpecAll() => {
    for (final e in _spec635.entries) e.key.toString(): e.value.toJson(),
  };

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
  final Map<String, UploadedFileMeta> uploadedFilesMeta = <String, UploadedFileMeta>{};

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

  // 메타 upsert
  void setUploadedFileMeta(UploadedFileMeta meta) {
    uploadedFilesMeta[meta.url] = meta;
    notifyListeners();
  }

// 메타 삭제
  void removeUploadedFileMeta(String url) {
    uploadedFilesMeta.remove(url);
    notifyListeners();
  }


  // ----------------- Reset / Save -----------------
  Map<String, dynamic> toMap() {

    final effectivePlace  = (incidentLockEnabled && lockedPlace.isNotEmpty)
        ? lockedPlace : placeOfDisaster;
    final effectiveNature = (incidentLockEnabled && lockedNature.isNotEmpty)
        ? lockedNature : natureOfDisaster;

    return {

      '_v': Schema.current,

      'recordType': recordType,
      'amNumber': amNumber,
      'pmNumber': pmNumber,
      'placeOfDisaster': effectivePlace,   // ← 스탬핑
      'placeNorm': (effectivePlace).trim().toLowerCase(),
      'natureOfDisaster': effectiveNature, // ← 스탬핑
      'dateOfDisaster': dateOfDisaster?.toIso8601String(),
      'gender': gender,

      'fdiToothData': {
        for (final e in fdiToothData.entries) e.key.toString(): e.value
      },

      'spans': _spans.map((e) => e.toJson()).toList(),
      'spec635': {
        for (final e in _spec635.entries) e.key.toString(): e.value.toJson()
      },

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
      'uploadedMeta': {
        for (final e in uploadedFilesMeta.entries) e.key: e.value.toMap(),
      },

      'conditionOfJaws': conditionOfJaws,
      'otherDetails': otherDetails,

      // ✅ PATCH: toMap() 반환 맵에 추가
      'codeSelectionCompact': currentSelectionCompact?.toMap(),
      'codeSelectionZoom': currentSelectionZoom?.toMap(),
    };
  }

  void fromMap(Map<String, dynamic> m) {

    final ver = (m['_v'] is int) ? m['_v'] as int : 1;

    if (ver < Schema.current) {
      // ✅ 여기서 버전에 따른 변환/보정 로직 추가 가능
      // 예: if (ver < 2) { m['codeSelectionCompact'] ??= null; }
    }

    // 기본값 처리 유틸
    T _get<T>(String k, T fallback) {
      final v = m[k];
      return (v is T) ? v : fallback;
    }

    recordType = _get<String>('recordType', 'PM');
    amNumber = _get<String>('amNumber', '');
    pmNumber = _get<String>('pmNumber', '');
    placeOfDisaster = _get<String>('placeOfDisaster', '');
    natureOfDisaster = _get<String>('natureOfDisaster', '');
    final dateStr = m['dateOfDisaster'] as String?;
    dateOfDisaster = (dateStr == null || dateStr.isEmpty) ? null : DateTime.tryParse(dateStr);
    gender = _get<String>('gender', '');

    // 하위 호환 fdiToothData
    fdiToothData
      ..clear()
      ..addAll(((m['fdiToothData'] as Map?) ?? const {}).map(
            (k, v) => MapEntry(int.parse(k.toString()), Map<String, dynamic>.from(v as Map)),
      ));

    // spec635
    _spec635
      ..clear()
      ..addAll(((m['spec635'] as Map?) ?? const {}).map(
            (k, v) => MapEntry(int.parse(k.toString()), SpecificData.fromJson(Map<String, dynamic>.from(v as Map))),
      ));

    // spans
    _spans
      ..clear()
      ..addAll(((m['spans'] as List?) ?? const [])
          .whereType<Map>()
          .map((e) => DentalSpan.fromJson(e.map((k, v) => MapEntry(k.toString(), v)))));

    otherFindings = _get<String>('otherFindings', '');
    dentitionType = _get<String>('dentitionType', '');
    ageMin = m['ageMin'] is int ? m['ageMin'] as int : null;
    ageMax = m['ageMax'] is int ? m['ageMax'] as int : null;
    qualityCheckSignature = _get<String>('qualityCheckSignature', '');
    final qDateStr = m['qualityCheckDate'] as String?;
    qualityCheckDate = (qDateStr == null || qDateStr.isEmpty) ? null : DateTime.tryParse(qDateStr);

    upperJawWithTeeth    = _get<bool>('upperJawWithTeeth', false);
    lowerJawWithTeeth    = _get<bool>('lowerJawWithTeeth', false);
    upperJawWithoutTeeth = _get<bool>('upperJawWithoutTeeth', false);
    lowerJawWithoutTeeth = _get<bool>('lowerJawWithoutTeeth', false);
    fragments            = _get<bool>('fragments', false);
    teethOnly            = _get<String>('teethOnly', '');
    otherMaterials       = _get<String>('otherMaterials', '');

    paDigital       = _get<bool>('paDigital', false);
    paNonDigital    = _get<bool>('paNonDigital', false);
    bwDigital       = _get<bool>('bwDigital', false);
    bwNonDigital    = _get<bool>('bwNonDigital', false);
    opgDigital      = _get<bool>('opgDigital', false);
    opgNonDigital   = _get<bool>('opgNonDigital', false);
    ctDigital       = _get<bool>('ctDigital', false);
    ctNonDigital    = _get<bool>('ctNonDigital', false);
    otherDigital    = _get<bool>('otherDigital', false);
    otherNonDigital = _get<bool>('otherNonDigital', false);
    photographsDigital    = _get<bool>('photographsDigital', false);
    photographsNonDigital = _get<bool>('photographsNonDigital', false);
    otherRadiographs      = _get<String>('otherRadiographs', '');
    uploadedFiles         = List<String>.from((m['uploadedFiles'] as List?) ?? const []);

    // ✅ 메타 (없어도 안전)
    final metaMap = (m['uploadedMeta'] as Map?) ?? const {};
    uploadedFilesMeta
      ..clear()
      ..addAll(metaMap.map((k, v) => MapEntry(
        k.toString(),
        UploadedFileMeta.fromMap(Map<String, dynamic>.from(v as Map)),
      )));

    conditionOfJaws = _get<String>('conditionOfJaws', '');
    otherDetails    = _get<String>('otherDetails', '');

    _validateSpanConflicts();

    // ✅ PATCH: fromMap()에 추가 (선택 상태 복원)
    final csc = m['codeSelectionCompact'];
    currentSelectionCompact = (csc is Map) ? CodeSelection.fromMap(csc.map((k,v)=>MapEntry(k.toString(), v))) : null;

    final csz = m['codeSelectionZoom'];
    currentSelectionZoom = (csz is Map) ? CodeSelection.fromMap(csz.map((k,v)=>MapEntry(k.toString(), v))) : null;
  }

  Future<void> hydrate() async {
    final data = LocalStore.loadDentalState();
    if (data != null) {
      _withoutAutosave(() {
        fromMap(data);
        super.notifyListeners(); // ← 여기서는 저장 안 함
      });
    }
  }

  Future<void> resetAll() async {
    _withoutAutosave(() {
    recordType = 'PM';
    amNumber = '';
    pmNumber = '';

    fdiToothData.clear();
    _selectedSurfaces.clear();
    _spans.clear();

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

    _spec635.clear();

    super.notifyListeners(); // ← 저장 안 함
    });
    await LocalStore.resetDentalState();
  }

  bool _autosavePaused = false;

  T _withoutAutosave<T>(T Function() run) {
    final prev = _autosavePaused;
    _autosavePaused = true;
    try {
      return run();
    } finally {
      _autosavePaused = prev;
    }
  }

  @override
  void notifyListeners() {
    if (!_autosavePaused) {
      _scheduleAutosave(); // ← 디바운스 로컬 저장
    }
    super.notifyListeners();
  }

  void _validateSpanConflicts() {
    final dent = <int>{};
    final br = <int>{};
    for (final sp in _spans) {
      final t = sp.teeth;
      if (sp.type == DentalSpanType.dentureOrtho) {
        final clash = t.where(br.contains).toList();
        if (clash.isNotEmpty) {
          debugPrint('⚠️ 로드된 데이터에 Denture/Bridge 충돌 있음: ${clash.join(", ")}');
        }
        dent.addAll(t);
      } else {
        final clash = t.where(dent.contains).toList();
        if (clash.isNotEmpty) {
          debugPrint('⚠️ 로드된 데이터에 Bridge/Denture 충돌 있음: ${clash.join(", ")}');
        }
        br.addAll(t);
      }
    }
  }
}

// import 'dart:async';
// import 'dart:collection';
// import 'dart:convert';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/services.dart' show rootBundle;
//
// import '../data/codes_635.dart';
// import '../schema.dart';
// import '../services/local_store.dart';
//
// // ✅ 뷰 모드 (축소/확대)
// enum ViewMode { zoomOut, zoomIn }
//
// // ✅ 축소뷰(DentalFindingsScreen)는 이 두 카테고리만 다룸
// const spanCategories = <String>{
//   'Denture and Orthodontic Appl.',
//   'Bridge',
// };
//
// // ✅ 계층 코드 노드
// class CodeNode {
//   final String code;
//   final String label;
//   final List<CodeNode> children;
//   bool get isLeaf => children.isEmpty;
//
//   CodeNode({required this.code, required this.label, this.children = const []});
//
//   factory CodeNode.fromMap(String code, Map<String, dynamic> m) {
//     final Map<String, dynamic> childMap = (m['children'] ?? {}) as Map<String, dynamic>;
//     return CodeNode(
//       code: code,
//       label: (m['label'] ?? code).toString(),
//       children: childMap.entries.map((e) => CodeNode.fromMap(e.key, e.value)).toList(),
//     );
//   }
//
//   Map<String, dynamic> toMap() => {
//     'code': code,
//     'label': label,
//     'children': [for (final c in children) c.toMap()],
//   };
// }
//
// // ✅ 어떤 레벨에서든 확정 가능한 선택 경로
// class CodeSelection {
//   final String category; // 예: "Bridge", "Crowns", ...
//   final List<String> path; // ["ABU","UIB","MTB"] 등. level1만 써도 OK
//
//   const CodeSelection({required this.category, required this.path});
//
//   String get selected => path.isEmpty ? "" : path.last;
//   int get depth => path.length;
//
//   Map<String, dynamic> toMap() => {
//     "category": category,
//     "path": path,
//     "selected": selected,
//     "depth": depth,
//   };
//
//   factory CodeSelection.fromMap(Map<String, dynamic> m) =>
//       CodeSelection(
//         category: (m["category"] ?? "").toString(),
//         path: List<String>.from((m["path"] as List?) ?? const []),
//       );
// }
//
// /// 5면 키
// const List<String> kToothSurfaces = ['O', 'M', 'D', 'L', 'B'];
//
// // ===== 스팬 모델 =====
// enum DentalSpanType { dentureOrtho, bridge }
//
// class DentalSpan {
//   final String id;
//   final DentalSpanType type;
//   final Set<int> teeth;
//   final Set<int> abutments;
//   final Set<int> pontics;
//   final String? code;
//
//   DentalSpan({
//     required this.id,
//     required this.type,
//     required Set<int> teeth,
//     Set<int>? abutments,
//     Set<int>? pontics,
//     this.code,
//   })  : teeth = {...teeth},
//         abutments = {...(abutments ?? const <int>{})},
//         pontics = {...(pontics ?? const <int>{})};
//
//   Map<String, dynamic> toJson() => {
//     'id': id,
//     'type': type.name,
//     'teeth': teeth.toList(),
//     'abutments': abutments.toList(),
//     'pontics': pontics.toList(),
//     'code': code,
//   };
//
//   factory DentalSpan.fromJson(Map<String, dynamic> j) => DentalSpan(
//     id: (j['id'] ?? '').toString(),
//     type: DentalSpanType.values.firstWhere(
//           (e) => e.name == (j['type'] as String? ?? 'dentureOrtho'),
//       orElse: () => DentalSpanType.dentureOrtho,
//     ),
//     teeth: Set<int>.from(((j['teeth'] as List?) ?? const []).map((e) => int.parse(e.toString()))),
//     abutments: Set<int>.from(((j['abutments'] as List?) ?? const []).map((e) => int.parse(e.toString()))),
//     pontics: Set<int>.from(((j['pontics'] as List?) ?? const []).map((e) => int.parse(e.toString()))),
//     code: j['code'] as String?,
//   );
// }
//
// // ===== 635 Specific Data =====
// class SpecificData {
//   SpecificData();
//
//   final Map<String, List<String>> global = {
//     'bite': <String>[],
//     'crown': <String>[],
//     'root': <String>[],
//     'status': <String>[],
//     'position': <String>[],
//     'crown pathology': <String>[],
//   };
//
//   final Map<String, Map<String, List<String>>> surface = {
//     for (final s in kToothSurfaces)
//       s: {
//         'fillings': <String>[],
//         'periodontium': <String>[],
//       }
//   };
//
//   String? toothNote;
//   final Map<String, String> surfaceNote = <String, String>{};
//
//   Map<String, dynamic> toJson() => {
//     'global': global,
//     'surface': surface,
//     'toothNote': toothNote,
//     'surfaceNote': surfaceNote,
//   };
//
//   factory SpecificData.fromJson(Map<String, dynamic> j) {
//     final x = SpecificData();
//     final g = (j['global'] as Map?) ?? {};
//     for (final k in x.global.keys) {
//       x.global[k] = List<String>.from((g[k] as List?) ?? const []);
//     }
//     final sv = (j['surface'] as Map?) ?? {};
//     for (final s in kToothSurfaces) {
//       final m = (sv[s] as Map?) ?? {};
//       x.surface[s]!['fillings'] = List<String>.from((m['fillings'] as List?) ?? const []);
//       x.surface[s]!['periodontium'] = List<String>.from((m['periodontium'] as List?) ?? const []);
//     }
//     x.toothNote = j['toothNote'] as String?;
//     final sn = (j['surfaceNote'] as Map?) ?? {};
//     x.surfaceNote.addAll(sn.map((k, v) => MapEntry(k.toString(), v.toString())));
//     return x;
//   }
// }
//
// class DentalDataProvider extends ChangeNotifier {
//   DentalDataProvider({bool listenIncidentLock = true}) {
//     if (listenIncidentLock) _listenIncidentLock();
//   }
//
//   // ---------- Interpol 코드 트리 ----------
//   final Map<String, CodeNode> _codeRoots = {}; // 카테고리 → 루트
//   Set<String> _allCategories = {};
//   bool get hasCodeTree => _codeRoots.isNotEmpty;
//
//   Future<void> loadCodeTreeOnce() async {
//     if (_codeRoots.isNotEmpty) return;
//     final raw = await rootBundle.loadString('lib/data/prosthesis_tree.json');
//     final Map<String, dynamic> jsonMap = jsonDecode(raw);
//     _codeRoots.clear();
//     _allCategories = jsonMap.keys.toSet();
//     jsonMap.forEach((cat, body) {
//       final children = (body as Map<String, dynamic>).map((k, v) => MapEntry(k, CodeNode.fromMap(k, v)));
//       _codeRoots[cat] = CodeNode(code: cat, label: cat, children: children.values.toList());
//     });
//     notifyListeners();
//   }
//
//   List<String> availableCategories(ViewMode mode) {
//     if (_codeRoots.isEmpty) return const [];
//     if (mode == ViewMode.zoomOut) {
//       return _allCategories.where(spanCategories.contains).toList()..sort();
//     } else {
//       return _allCategories.where((c) => !spanCategories.contains(c)).toList()..sort();
//     }
//   }
//
//   CodeNode? _findNode(String category, List<String> path) {
//     final root = _codeRoots[category];
//     if (root == null) return null;
//     CodeNode cur = root;
//     for (final step in path) {
//       final idx = cur.children.indexWhere((n) => n.code.toLowerCase() == step.toLowerCase());
//       if (idx < 0) return null;
//       cur = cur.children[idx];
//     }
//     return cur;
//   }
//
//   List<CodeNode> listChildren(String category, List<String> path) =>
//       _findNode(category, path)?.children ?? const [];
//
//   bool isValidSelection(String category, List<String> path) => _findNode(category, path) != null;
//
//   // ---------- 선택 상태 ----------
//   CodeSelection? currentSelectionCompact; // 축소뷰
//   CodeSelection? currentSelectionZoom; // 확대뷰
//   void setSelectionFor(ViewMode mode, CodeSelection? sel) {
//     if (mode == ViewMode.zoomOut) {
//       currentSelectionCompact = sel;
//     } else {
//       currentSelectionZoom = sel;
//     }
//     notifyListeners();
//   }
//
//   // ---------- 즐겨찾기 (프리셋 + 유저) ----------
//   // 프리셋(네가 준 목록을 실제 카테고리로 매핑)
//   // * Prosthesis(ipx)는 트리상 Root의 implant 계열이므로 Root로 배치
//   static final Map<String, List<List<String>>> _defaultFavByCat = {
//     // Status
//     'Status': [
//       ['int'], // intentional?
//       ['mam'],
//       ['mpm'],
//       ['car'],
//       ['cfr'],
//       ['imx'],
//       ['imv'],
//       ['eru'],
//     ],
//     // Root
//     'Root': [
//       ['rfx'],
//       ['rov'],
//       ['ipx'], // implant (프리셋: Prothesis → Root로 매핑)
//     ],
//     // Fillings
//     'Fillings': [
//       ['uif'],
//       ['cav'],
//       ['amf'],
//       ['tcf'],
//       ['cof'],
//       ['fis'],
//       ['goi'],
//       ['poi'],
//     ],
//     // Crowns
//     'Crowns': [
//       ['uic'],
//       ['mtc'],
//       ['goc'],
//       ['mec'],
//       ['tcc'],
//       ['mcc'],
//       ['poc'],
//       ['tec'],
//     ],
//     // Bridge
//     'Bridge': [
//       // ABU / MTB / GOB / MEB / TCB / MCB / POB / TEB / PON / CAN ...
//       ['abu'],
//       ['mtb'],
//       ['gob'],
//       ['meb'],
//       ['tcb'],
//       ['mcb'],
//       ['pob'],
//       ['teb'],
//       ['pon'],
//       ['can'],
//       // 브릿지 재료군도 일부 포함
//       ['mtc'],
//       ['goc'],
//       ['mec'],
//       ['tcc'],
//       ['mcc'],
//       ['poc'],
//       ['tec'],
//     ],
//     // Denture + Orthodontics 는 하나의 카테고리로 관리됨
//     'Denture and Orthodontic Appl.': [
//       // Denture
//       ['fld'],
//       ['fud'],
//       ['pld'],
//       ['pud'],
//       // Orthodontics
//       ['foa'],
//       ['roa'],
//     ],
//   };
//
//   // 유저 즐겨찾기 저장(카테고리 → pathKey Set)
//   final Map<String, Set<String>> _favUserByCat = {};
//
//   // key 조합(카테고리 + 경로, 코드 대소문자 무시)
//   String _favKey(String category, List<String> path) =>
//       '${category.trim()}|${path.map((e) => e.trim().toLowerCase()).join(">")}';
//
//   // 현재 경로가 즐겨찾기인지(프리셋 or 유저)
//   bool isFavoritePath(String category, List<String> path) {
//     final key = _favKey(category, path);
//     final preset = (_defaultFavByCat[category] ?? const [])
//         .map((p) => _favKey(category, p))
//         .contains(key);
//     final user = _favUserByCat[category]?.contains(key) ?? false;
//     return preset || user;
//   }
//
//   // 유저 즐겨찾기 토글
//   void toggleFavoritePath(String category, List<String> path) {
//     final key = _favKey(category, path);
//     final set = _favUserByCat.putIfAbsent(category, () => <String>{});
//     if (set.contains(key)) {
//       set.remove(key);
//     } else {
//       set.add(key);
//     }
//     notifyListeners();
//   }
//
//   // 현재 prefix에서 보이는 children을 "즐겨찾기 우선"으로 정렬
//   List<CodeNode> sortNodesWithFavorites({
//     required String category,
//     required List<String> currentPrefix,
//     required List<CodeNode> items,
//   }) {
//     // level1만 쓸 거라면 currentPrefix는 보통 []
//     final presetKeys = {
//       for (final p in (_defaultFavByCat[category] ?? const [])) _favKey(category, [...currentPrefix, ...p])
//     };
//     final userKeys = _favUserByCat[category] ?? const <String>{};
//
//     int favScoreFor(String code) {
//       final key = _favKey(category, [...currentPrefix, code]);
//       // 프리셋 최우선(2), 유저(1), 일반(0)
//       if (presetKeys.contains(key)) return 2;
//       if (userKeys.contains(key)) return 1;
//       return 0;
//     }
//
//     final sorted = [...items];
//     sorted.sort((a, b) {
//       final sa = favScoreFor(a.code);
//       final sb = favScoreFor(b.code);
//       if (sa != sb) return sb.compareTo(sa); // 높은 점수(즐겨찾기) 먼저
//       return a.code.compareTo(b.code);
//     });
//     return sorted;
//   }
//
//   // 즐겨찾기(프리셋+유저) 합친 목록을 level1 코드 리스트로 제공 (트리 UI에서 “즐겨찾기 섹션” 만들 때 사용)
//   List<List<String>> effectiveFavoritesLevel1(String category) {
//     final preset = (_defaultFavByCat[category] ?? const <List<String>>[]);
//     final userKeys = _favUserByCat[category] ?? const <String>{};
//     final user = userKeys
//         .map((k) => k.split('|').last) // path 부분만
//         .where((p) => p.isNotEmpty)
//         .map((p) => p.split('>'))
//         .where((path) => path.length >= 1)
//         .map((path) => <String>[path.first])
//         .toList();
//
//     // 중복 제거
//     final seen = <String>{};
//     List<List<String>> out = [];
//     for (final p in [...preset, ...user]) {
//       final k = _favKey(category, [p.first]);
//       if (seen.add(k)) out.add([p.first]);
//     }
//     return out;
//   }
//
//   // ---------- 635 데이터/스팬/저장 ----------
//   final Map<int, SpecificData> _spec635 = <int, SpecificData>{};
//   final List<DentalSpan> _spans = <DentalSpan>[];
//   UnmodifiableListView<DentalSpan> get spans => UnmodifiableListView(_spans);
//
//   Timer? _saveDebounce;
//   static int _idSeed = 0;
//
//   void _scheduleAutosave() {
//     _saveDebounce?.cancel();
//     _saveDebounce = Timer(const Duration(milliseconds: 300), () async {
//       await LocalStore.saveDentalState(toMap());
//     });
//   }
//
//   void _markDirty() {
//     _scheduleAutosave();
//     notifyListeners();
//   }
//
//   SpecificData? getSpecRead(int fdi) => _spec635[fdi];
//
//   SpecificData ensureSpec(int fdi) => _spec635.putIfAbsent(fdi, () => SpecificData());
//
//   void toggleGlobalCode(int fdi, String group, String code) {
//     final s = ensureSpec(fdi).global[group];
//     if (s == null) return;
//     if (s.contains(code)) {
//       s.remove(code);
//     } else {
//       s.add(code);
//     }
//     notifyListeners();
//   }
//
//   void toggleSurfaceCode(int fdi, String surface, String group, String code) {
//     if (!kToothSurfaces.contains(surface)) return;
//     final s = ensureSpec(fdi).surface[surface]?[group];
//     if (s == null) return;
//     if (s.contains(code)) {
//       s.remove(code);
//     } else {
//       s.add(code);
//     }
//     notifyListeners();
//   }
//
//   void setToothNote635(int fdi, String? note) {
//     ensureSpec(fdi).toothNote = (note?.trim().isNotEmpty ?? false) ? note!.trim() : null;
//     notifyListeners();
//   }
//
//   void setSurfaceNote635(int fdi, String surface, String note) {
//     if (!kToothSurfaces.contains(surface)) return;
//     ensureSpec(fdi).surfaceNote[surface] = note;
//     notifyListeners();
//   }
//
//   void clearSurface635(int fdi, String surface) {
//     if (!kToothSurfaces.contains(surface)) return;
//     final s = _spec635[fdi];
//     if (s == null) return;
//     s.surface[surface]?['fillings']?.clear();
//     s.surface[surface]?['periodontium']?.clear();
//     s.surfaceNote.remove(surface);
//     notifyListeners();
//   }
//
//   void clearGlobalAll635(int fdi) {
//     final spec = getSpecRead(fdi);
//     if (spec == null) return;
//     for (final g in k635GlobalCodes.keys) {
//       spec.global[g] = <String>[];
//     }
//     spec.toothNote = '';
//     notifyListeners();
//   }
//
//   // --- Incident Lock(remote) ---
//   String recordType = 'PM';
//   String amNumber = '';
//   String pmNumber = '';
//
//   bool incidentLockEnabled = false;
//   String lockedPlace = '';
//   String lockedNature = '';
//   String get placeForUi => (incidentLockEnabled && lockedPlace.isNotEmpty) ? lockedPlace : placeOfDisaster;
//   String get natureForUi => (incidentLockEnabled && lockedNature.isNotEmpty) ? lockedNature : natureOfDisaster;
//
//   final DocumentReference<Map<String, dynamic>> _lockDoc =
//   FirebaseFirestore.instance.collection('config').doc('incidentLock');
//   StreamSubscription<DocumentSnapshot<Map<String, dynamic>>>? _lockSub;
//
//   void _listenIncidentLock() {
//     _lockSub = _lockDoc.snapshots().listen((snap) {
//       final d = snap.data();
//       if (d == null) return;
//       _withoutAutosave(() {
//         incidentLockEnabled = (d['enabled'] ?? false) as bool;
//         lockedPlace = (d['place'] ?? '') as String;
//         lockedNature = (d['nature'] ?? '') as String;
//         super.notifyListeners();
//       });
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
//     _saveDebounce?.cancel();
//     super.dispose();
//   }
//
//   // ---------- Odontogram (경량 상태) ----------
//   final Map<int, Map<String, dynamic>> fdiToothData = <int, Map<String, dynamic>>{};
//   final Map<int, Set<String>> _selectedSurfaces = <int, Set<String>>{};
//
//   Set<String> getSelectedSurfaces(int fdi) => _selectedSurfaces[fdi] ?? <String>{};
//
//   void toggleSurface(int fdi, String surfaceKey) {
//     if (!kToothSurfaces.contains(surfaceKey)) return;
//     final s = _selectedSurfaces.putIfAbsent(fdi, () => <String>{});
//     if (s.contains(surfaceKey)) {
//       s.remove(surfaceKey);
//     } else {
//       s.add(surfaceKey);
//     }
//     notifyListeners();
//   }
//
//   void clearSurfaces(int fdi) {
//     final s = _selectedSurfaces[fdi];
//     if (s == null) return;
//     s.clear();
//     notifyListeners();
//   }
//
//   // ---------- STEP 2: Denture/Bridge 스팬 ----------
//   String _randId() => 'sp_${DateTime.now().microsecondsSinceEpoch}_$_idSeed';
//
//   List<DentalSpan> spansIntersecting(Iterable<int> fdis) {
//     final set = fdis.toSet();
//     return _spans.where((sp) => sp.teeth.any(set.contains)).toList();
//   }
//
//   bool _isUpperFdi(int fdi) {
//     final q = fdi ~/ 10;
//     return q == 1 || q == 2 || q == 5 || q == 6;
//   }
//
//   bool _allSameArch(Iterable<int> fdis) {
//     bool? first;
//     for (final f in fdis) {
//       final up = _isUpperFdi(f);
//       first ??= up;
//       if (up != first) return false;
//     }
//     return true;
//   }
//
//   bool _hasTypeConflictInternal(Iterable<int> teeth, DentalSpanType creating) {
//     final set = teeth.toSet();
//     return _spans.any((sp) => sp.type != creating && sp.teeth.any(set.contains));
//   }
//
//   void addDentureSpan(List<int> selectedFdi, {String? code}) {
//     if (selectedFdi.isEmpty) return;
//     if (!_allSameArch(selectedFdi)) {
//       debugPrint('❌ 상/하악 혼합 스팬 금지');
//       return;
//     }
//     if (_hasTypeConflictInternal(selectedFdi, DentalSpanType.dentureOrtho)) {
//       debugPrint('❌ Denture/Ortho 생성 실패: 이미 Bridge 스팬과 겹칩니다.');
//       return;
//     }
//     _spans.add(DentalSpan(
//       id: _randId(),
//       type: DentalSpanType.dentureOrtho,
//       teeth: Set<int>.from(selectedFdi),
//       code: code,
//     ));
//     _markDirty();
//   }
//
//   void addBridgeSpan({
//     required List<int> selectedFdi,
//     required Set<int> abutments,
//     required Set<int> pontics,
//     String? code,
//   }) {
//     if (selectedFdi.isEmpty || abutments.isEmpty || pontics.isEmpty) return;
//     final union = {...selectedFdi, ...abutments, ...pontics};
//     if (!_allSameArch(union)) {
//       debugPrint('❌ 상/하악 혼합 브리지 금지');
//       return;
//     }
//     if (_hasTypeConflictInternal(union, DentalSpanType.bridge)) {
//       debugPrint('❌ Bridge 생성 실패: 이미 Denture/Ortho 스팬과 겹칩니다.');
//       return;
//     }
//     _spans.add(DentalSpan(
//       id: _randId(),
//       type: DentalSpanType.bridge,
//       teeth: Set<int>.from(selectedFdi),
//       abutments: abutments,
//       pontics: pontics,
//       code: code,
//     ));
//     _markDirty();
//   }
//
//   void removeSpan(String id) {
//     _spans.removeWhere((e) => e.id == id);
//     _markDirty();
//   }
//
//   int removeSpansIntersecting(Set<int> targets, {bool removeDenture = true, bool removeBridge = true}) {
//     final before = _spans.length;
//     _spans.removeWhere((sp) {
//       final hit = sp.teeth.any(targets.contains);
//       if (!hit) return false;
//       if (sp.type == DentalSpanType.dentureOrtho && !removeDenture) return false;
//       if (sp.type == DentalSpanType.bridge && !removeBridge) return false;
//       return true;
//     });
//     final removed = before - _spans.length;
//     if (removed > 0) _markDirty();
//     return removed;
//   }
//
//   // 635 한 줄 프리뷰
//   String build635Line(int fdi) {
//     final s = _spec635[fdi];
//     if (s == null) return '';
//     final out = <String>[];
//     for (final surf in kToothSurfaces) {
//       for (final grp in const ['fillings', 'periodontium']) {
//         final list = s.surface[surf]![grp]!;
//         if (list.isNotEmpty) out.add('${list.join(",")}($surf)');
//       }
//     }
//     for (final g in const ['bite', 'crown', 'root', 'status', 'position', 'crown pathology']) {
//       final list = s.global[g]!;
//       if (list.isNotEmpty) out.add(list.join(','));
//     }
//     if (s.toothNote != null && s.toothNote!.isNotEmpty) out.add('note:${s.toothNote}');
//     return out.join(' · ');
//   }
//
//   Map<String, dynamic> exportSpecAll() => {
//     for (final e in _spec635.entries) e.key.toString(): e.value.toJson(),
//   };
//
//   // ---------- 나머지 폼 필드 ----------
//   String otherFindings = "";
//   String dentitionType = "";
//   int? ageMin;
//   int? ageMax;
//   String qualityCheckSignature = "";
//   DateTime? qualityCheckDate;
//
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
//   String placeOfDisaster = '';
//   String natureOfDisaster = '';
//   DateTime? dateOfDisaster;
//   String gender = '';
//
//   // ---------- Updaters ----------
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
//   // ---------- Reset / Save ----------
//   Map<String, dynamic> toMap() {
//     final effectivePlace = (incidentLockEnabled && lockedPlace.isNotEmpty) ? lockedPlace : placeOfDisaster;
//     final effectiveNature = (incidentLockEnabled && lockedNature.isNotEmpty) ? lockedNature : natureOfDisaster;
//
//     return {
//       '_v': Schema.current,
//       'recordType': recordType,
//       'amNumber': amNumber,
//       'pmNumber': pmNumber,
//       'placeOfDisaster': effectivePlace,
//       'placeNorm': (effectivePlace).trim().toLowerCase(),
//       'natureOfDisaster': effectiveNature,
//       'dateOfDisaster': dateOfDisaster?.toIso8601String(),
//       'gender': gender,
//
//       'fdiToothData': {for (final e in fdiToothData.entries) e.key.toString(): e.value},
//       'spans': _spans.map((e) => e.toJson()).toList(),
//       'spec635': {for (final e in _spec635.entries) e.key.toString(): e.value.toJson()},
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
//
//       'codeSelectionCompact': currentSelectionCompact?.toMap(),
//       'codeSelectionZoom': currentSelectionZoom?.toMap(),
//
//       // ✅ 유저 즐겨찾기 저장 (카테고리 → 경로리스트(리스트형))
//       'favoritesUser': {
//         for (final entry in _favUserByCat.entries)
//           entry.key: entry.value
//               .map((key) => key.split('|').last) // "a>b>c"
//               .map((p) => p.split('>')) // ["a","b","c"]
//               .toList(),
//       },
//     };
//   }
//
//   void fromMap(Map<String, dynamic> m) {
//     final ver = (m['_v'] is int) ? m['_v'] as int : 1;
//
//     T _get<T>(String k, T fallback) {
//       final v = m[k];
//       return (v is T) ? v : fallback;
//     }
//
//     recordType = _get<String>('recordType', 'PM');
//     amNumber = _get<String>('amNumber', '');
//     pmNumber = _get<String>('pmNumber', '');
//     placeOfDisaster = _get<String>('placeOfDisaster', '');
//     natureOfDisaster = _get<String>('natureOfDisaster', '');
//     final dateStr = m['dateOfDisaster'] as String?;
//     dateOfDisaster = (dateStr == null || dateStr.isEmpty) ? null : DateTime.tryParse(dateStr);
//     gender = _get<String>('gender', '');
//
//     fdiToothData
//       ..clear()
//       ..addAll(((m['fdiToothData'] as Map?) ?? const {}).map(
//             (k, v) => MapEntry(int.parse(k.toString()), Map<String, dynamic>.from(v as Map)),
//       ));
//
//     _spec635
//       ..clear()
//       ..addAll(((m['spec635'] as Map?) ?? const {}).map(
//             (k, v) => MapEntry(int.parse(k.toString()), SpecificData.fromJson(Map<String, dynamic>.from(v as Map))),
//       ));
//
//     _spans
//       ..clear()
//       ..addAll(((m['spans'] as List?) ?? const [])
//           .whereType<Map>()
//           .map((e) => DentalSpan.fromJson(e.map((k, v) => MapEntry(k.toString(), v)))));
//
//     otherFindings = _get<String>('otherFindings', '');
//     dentitionType = _get<String>('dentitionType', '');
//     ageMin = m['ageMin'] is int ? m['ageMin'] as int : null;
//     ageMax = m['ageMax'] is int ? m['ageMax'] as int : null;
//     qualityCheckSignature = _get<String>('qualityCheckSignature', '');
//     final qDateStr = m['qualityCheckDate'] as String?;
//     qualityCheckDate = (qDateStr == null || qDateStr.isEmpty) ? null : DateTime.tryParse(qDateStr);
//
//     upperJawWithTeeth = _get<bool>('upperJawWithTeeth', false);
//     lowerJawWithTeeth = _get<bool>('lowerJawWithTeeth', false);
//     upperJawWithoutTeeth = _get<bool>('upperJawWithoutTeeth', false);
//     lowerJawWithoutTeeth = _get<bool>('lowerJawWithoutTeeth', false);
//     fragments = _get<bool>('fragments', false);
//     teethOnly = _get<String>('teethOnly', '');
//     otherMaterials = _get<String>('otherMaterials', '');
//
//     paDigital = _get<bool>('paDigital', false);
//     paNonDigital = _get<bool>('paNonDigital', false);
//     bwDigital = _get<bool>('bwDigital', false);
//     bwNonDigital = _get<bool>('bwNonDigital', false);
//     opgDigital = _get<bool>('opgDigital', false);
//     opgNonDigital = _get<bool>('opgNonDigital', false);
//     ctDigital = _get<bool>('ctDigital', false);
//     ctNonDigital = _get<bool>('ctNonDigital', false);
//     otherDigital = _get<bool>('otherDigital', false);
//     otherNonDigital = _get<bool>('otherNonDigital', false);
//     photographsDigital = _get<bool>('photographsDigital', false);
//     photographsNonDigital = _get<bool>('photographsNonDigital', false);
//     otherRadiographs = _get<String>('otherRadiographs', '');
//     uploadedFiles = List<String>.from((m['uploadedFiles'] as List?) ?? const []);
//
//     conditionOfJaws = _get<String>('conditionOfJaws', '');
//     otherDetails = _get<String>('otherDetails', '');
//
//     // 코드 선택 복원
//     final csc = m['codeSelectionCompact'];
//     currentSelectionCompact = (csc is Map) ? CodeSelection.fromMap(csc.map((k, v) => MapEntry(k.toString(), v))) : null;
//     final csz = m['codeSelectionZoom'];
//     currentSelectionZoom = (csz is Map) ? CodeSelection.fromMap(csz.map((k, v) => MapEntry(k.toString(), v))) : null;
//
//     // 유저 즐겨찾기 복원
//     _favUserByCat.clear();
//     final fav = (m['favoritesUser'] as Map?) ?? {};
//     fav.forEach((cat, list) {
//       final catStr = cat.toString();
//       final paths = (list as List? ?? const [])
//           .whereType<List>()
//           .map((p) => List<String>.from(p))
//           .map((path) => _favKey(catStr, path))
//           .toSet();
//       if (paths.isNotEmpty) {
//         _favUserByCat[catStr] = paths;
//       }
//     });
//
//     _validateSpanConflicts();
//   }
//
//   Future<void> hydrate() async {
//     final data = LocalStore.loadDentalState();
//     if (data != null) {
//       _withoutAutosave(() {
//         fromMap(data);
//         super.notifyListeners();
//       });
//     }
//   }
//
//   Future<void> resetAll() async {
//     _withoutAutosave(() {
//       recordType = 'PM';
//       amNumber = '';
//       pmNumber = '';
//
//       fdiToothData.clear();
//       _selectedSurfaces.clear();
//       _spans.clear();
//
//       otherFindings = "";
//       dentitionType = "";
//       ageMin = null;
//       ageMax = null;
//       qualityCheckSignature = "";
//       qualityCheckDate = null;
//
//       upperJawWithTeeth = false;
//       lowerJawWithTeeth = false;
//       upperJawWithoutTeeth = false;
//       lowerJawWithoutTeeth = false;
//       fragments = false;
//       teethOnly = '';
//       otherMaterials = '';
//
//       paDigital = false;
//       paNonDigital = false;
//       bwDigital = false;
//       bwNonDigital = false;
//       opgDigital = false;
//       opgNonDigital = false;
//       ctDigital = false;
//       ctNonDigital = false;
//       otherDigital = false;
//       otherNonDigital = false;
//       photographsDigital = false;
//       photographsNonDigital = false;
//       otherRadiographs = '';
//       uploadedFiles = [];
//
//       conditionOfJaws = '';
//       otherDetails = '';
//
//       placeOfDisaster = '';
//       natureOfDisaster = '';
//       dateOfDisaster = null;
//       gender = '';
//
//       _spec635.clear();
//       _favUserByCat.clear();
//
//       super.notifyListeners();
//     });
//     await LocalStore.resetDentalState();
//   }
//
//   bool _autosavePaused = false;
//
//   T _withoutAutosave<T>(T Function() run) {
//     final prev = _autosavePaused;
//     _autosavePaused = true;
//     try {
//       return run();
//     } finally {
//       _autosavePaused = prev;
//     }
//   }
//
//   @override
//   void notifyListeners() {
//     if (!_autosavePaused) {
//       _scheduleAutosave();
//     }
//     super.notifyListeners();
//   }
//
//   void _validateSpanConflicts() {
//     final dent = <int>{};
//     final br = <int>{};
//     for (final sp in _spans) {
//       final t = sp.teeth;
//       if (sp.type == DentalSpanType.dentureOrtho) {
//         final clash = t.where(br.contains).toList();
//         if (clash.isNotEmpty) {
//           debugPrint('⚠️ 로드된 데이터에 Denture/Bridge 충돌 있음: ${clash.join(", ")}');
//         }
//         dent.addAll(t);
//       } else {
//         final clash = t.where(dent.contains).toList();
//         if (clash.isNotEmpty) {
//           debugPrint('⚠️ 로드된 데이터에 Bridge/Denture 충돌 있음: ${clash.join(", ")}');
//         }
//         br.addAll(t);
//       }
//     }
//   }
// }
