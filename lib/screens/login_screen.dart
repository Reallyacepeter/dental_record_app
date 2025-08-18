import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

// class LoginScreen extends StatefulWidget {
//   @override
//   _LoginScreenState createState() => _LoginScreenState();
// }
//
// class _LoginScreenState extends State<LoginScreen> {
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//
//   @override
//   void initState() {
//     super.initState();
//     checkFirebaseAuthState(); // ✅ Firebase 로그인 상태 확인
//     checkAutoLogout(); // ✅ 자동 로그아웃 체크
//   }
//
//   // ✅ 로그인 시간을 SharedPreferences에 저장
//   Future<void> saveLoginTime() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setInt('last_login_time', DateTime.now().millisecondsSinceEpoch);
//   }
//
//   // ✅ 마지막 로그인 시간이 1시간 초과했는지 확인
//   Future<bool> isLoginExpired() async {
//     final prefs = await SharedPreferences.getInstance();
//     int? lastLoginTime = prefs.getInt('last_login_time');
//
//     if (lastLoginTime == null) return true; // 로그인 기록 없으면 로그아웃
//
//     int currentTime = DateTime.now().millisecondsSinceEpoch;
//     int timeDifference = (currentTime - lastLoginTime) ~/ 1000; // 초 단위 변환
//
//     return timeDifference > 3600; // 1시간(3600초) 초과 시 true 반환
//   }
//
//   // ✅ Firebase Auth 로그인 상태 확인
//   Future<void> checkFirebaseAuthState() async {
//     User? user = FirebaseAuth.instance.currentUser;
//     if (user != null) {
//       print("✅ Firebase 로그인 유지됨: ${user.email}");
//       await updateLoginTime(); // 로그인 상태가 유지되면 로그인 시간 갱신
//     } else {
//       print("🚨 Firebase 로그아웃됨!");
//     }
//   }
//
//   // ✅ 앱 실행 시 1시간 지나면 자동 로그아웃
//   Future<void> checkAutoLogout() async {
//     bool expired = await isLoginExpired();
//
//     if (expired) {
//       print("🚨 1시간 초과로 자동 로그아웃됨.");
//       await FirebaseAuth.instance.signOut(); // Firebase 로그아웃
//       final prefs = await SharedPreferences.getInstance();
//       await prefs.remove('last_login_time'); // 저장된 로그인 시간 삭제
//       if (mounted) {
//         Navigator.pushReplacementNamed(context, '/login'); // 로그인 화면으로 이동
//       }
//     } else {
//       print("✅ 로그인 유지됨");
//     }
//   }
//
//   // ✅ 사용자가 앱을 사용할 때마다 로그인 시간 갱신
//   Future<void> updateLoginTime() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setInt('last_login_time', DateTime.now().millisecondsSinceEpoch);
//     print("✅ 로그인 시간 갱신됨!");
//   }
//
//   // ✅ 로그인 버튼 클릭 시 동작
//   Future<void> handleLogin() async {
//     try {
//       final userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
//         email: emailController.text.trim(),
//         password: passwordController.text.trim(),
//       );
//
//       await saveLoginTime(); // 로그인 시간 저장
//
//       // 로그인 성공 시 화면 이동
//       Navigator.pushReplacementNamed(context, '/record');
//     } catch (e) {
//       // 로그인 실패 시 에러 메시지 출력
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("로그인 실패: $e")),
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("로그인"),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             // 이메일 입력 필드
//             TextField(
//               controller: emailController,
//               decoration: const InputDecoration(
//                 labelText: "Email",
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             const SizedBox(height: 16),
//             // 비밀번호 입력 필드
//             TextField(
//               controller: passwordController,
//               obscureText: true,
//               decoration: const InputDecoration(
//                 labelText: "Password",
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             const SizedBox(height: 24),
//             // 로그인 버튼
//             ElevatedButton(
//               onPressed: handleLogin,
//               child: const Text("로그인"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> handleLogin() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt('last_login_time', DateTime.now().millisecondsSinceEpoch);

      Navigator.pushReplacementNamed(context, '/recordSetup');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('로그인 실패: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("로그인"),
        automaticallyImplyLeading: false,),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(controller: emailController, decoration: InputDecoration(labelText: "Email")),
            SizedBox(height: 16),
            TextField(controller: passwordController, obscureText: true, decoration: InputDecoration(labelText: "Password")),
            SizedBox(height: 24),
            ElevatedButton(onPressed: handleLogin, child: Text("로그인")),
          ],
        ),
      ),
    );
  }
}
