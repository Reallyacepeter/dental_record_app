import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/login_screen.dart';
import 'screens/record_screen.dart';
import 'screens/view_screen.dart';
import 'screens/materials_available_screen.dart';
import 'screens/dental_images_screen.dart';
import 'screens/supplementary_details_screen.dart';
import 'screens/dental_findings_screen.dart';
import 'screens/final_review_screen.dart';
import 'screens/dental_data_screen.dart'; // DentalDataScreen 정의된 파일 import

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginScreen(),
        '/record': (context) => RecordScreen(),
        '/view': (context) => ViewScreen(),
        '/materialsAvailable': (context) {
          return MaterialsAvailableScreen(
            arguments: ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>? ?? {},
          );
        },
        '/dentalImages': (context) {
          return DentalImagesScreen(
            arguments: ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>? ?? {},
          );
        },
        '/supplementaryDetails': (context) {
          return SupplementaryDetailsScreen(
            arguments: ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>? ?? {},
          );
        },
        '/dentalFindings': (context) => DentalFindingsScreen(),
        '/DentalDataScreen': (context) => DentalDataScreen(),
        '/finalReview': (context) {
          return FinalReviewScreen(
            arguments: ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>? ?? {},
          );
        },
      },
    );
  }
}
