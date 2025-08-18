// import 'package:dental_record_app/screens/splash_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'screens/login_screen.dart';
// import 'screens/record_screen.dart';
// import 'screens/view_screen.dart';
// import 'screens/materials_available_screen.dart';
// import 'screens/dental_images_screen.dart';
// import 'screens/supplementary_details_screen.dart';
// import 'screens/dental_findings_screen.dart';
// import 'screens/final_review_screen.dart';
// import 'screens/dental_data_screen.dart'; // DentalDataScreen 정의된 파일 import
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       initialRoute: '/splash', // 시작은 스플래시
//       routes: {
//         '/splash': (_) => SplashScreen(),
//         '/login': (context) => LoginScreen(),
//         '/record': (context) => RecordScreen(),
//         '/view': (context) => ViewScreen(),
//         '/materialsAvailable': (context) {
//           return MaterialsAvailableScreen(
//             arguments: ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>? ?? {},
//           );
//         },
//         '/dentalImages': (context) {
//           return DentalImagesScreen(
//             arguments: ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>? ?? {},
//           );
//         },
//         '/supplementaryDetails': (context) {
//           return SupplementaryDetailsScreen(
//             arguments: ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>? ?? {},
//           );
//         },
//         '/dentalFindings': (context) => DentalFindingsScreen(),
//         '/DentalDataScreen': (context) => DentalDataScreen(),
//         '/finalReview': (context) {
//           return FinalReviewScreen(
//             arguments: ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>? ?? {},
//           );
//         },
//       },
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

// 상태 관리 클래스
import 'providers/dental_data_provider.dart';

// 스크린들
import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/record_setup_screen.dart';
import 'screens/record_screen.dart';
import 'screens/view_screen.dart';
import 'screens/materials_available_screen.dart';
import 'screens/dental_images_screen.dart';
import 'screens/supplementary_details_screen.dart';
import 'screens/dental_findings_screen.dart';
import 'screens/final_review_screen.dart';
import 'screens/dental_data_screen.dart';
import 'screens/settings_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DentalDataProvider()),
        // 향후 RecordDataProvider, AuthProvider 등 추가 가능
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/splash',
        routes: {
          '/splash': (_) => SplashScreen(),
          '/login': (_) => LoginScreen(),
          '/recordSetup': (_) => const RecordSetupScreen(),
          '/record': (_) => RecordScreen(),
          '/view': (_) => ViewScreen(),
          '/materialsAvailable': (_) => MaterialsAvailableScreen(),
          '/dentalImages': (_) => DentalImagesScreen(),
          '/supplementaryDetails': (_) => SupplementaryDetailsScreen(),
          '/dentalFindings': (_) => DentalFindingsScreen(),
          '/DentalDataScreen': (_) => DentalDataScreen(),
          '/finalReview': (_) => FinalReviewScreen(),
          '/settings': (context) => SettingsScreen(),
        },
      ),
    );
  }
}
