import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/record_screen.dart';
import 'screens/view_screen.dart';
import 'screens/materials_available_screen.dart';
import 'screens/dental_images_screen.dart';
import 'screens/dental_findings_screen.dart';
import 'screens/supplementary_details_screen.dart';
import 'screens/additional_details_screen.dart';
import 'screens/final_review_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // 디버그 배너 비활성화
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginScreen(),
        '/record': (context) => RecordScreen(),
        '/view': (context) => ViewScreen(),
        '/materialsAvailable': (context) => MaterialsAvailableScreen(
          arguments: ModalRoute.of(context)?.settings.arguments
          as Map<String, dynamic>? ??
              {},
        ),
        '/dentalImages': (context) => DentalImagesScreen(
          arguments: ModalRoute.of(context)?.settings.arguments
          as Map<String, dynamic>? ??
              {},
        ),
        '/dentalFindings': (context) => DentalFindingsScreen(
          arguments: ModalRoute.of(context)?.settings.arguments
          as Map<String, dynamic>? ??
              {},
        ),
        '/supplementaryDetails': (context) => SupplementaryDetailsScreen(
          arguments: ModalRoute.of(context)?.settings.arguments
          as Map<String, dynamic>? ??
              {},
        ),
        '/additionalDetails': (context) => AdditionalDetailsScreen(
          arguments: ModalRoute.of(context)?.settings.arguments
          as Map<String, dynamic>? ??
              {},
        ),
        '/finalReview': (context) => FinalReviewScreen(
          arguments: ModalRoute.of(context)?.settings.arguments
          as Map<String, dynamic>? ??
              {},
        ),
      },
    );
  }
}
