// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// // class LoginScreen extends StatefulWidget {
// //   @override
// //   _LoginScreenState createState() => _LoginScreenState();
// // }
// //
// // class _LoginScreenState extends State<LoginScreen> {
// //   final TextEditingController emailController = TextEditingController();
// //   final TextEditingController passwordController = TextEditingController();
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     checkFirebaseAuthState(); // ✅ Firebase 로그인 상태 확인
// //     checkAutoLogout(); // ✅ 자동 로그아웃 체크
// //   }
// //
// //   // ✅ 로그인 시간을 SharedPreferences에 저장
// //   Future<void> saveLoginTime() async {
// //     final prefs = await SharedPreferences.getInstance();
// //     await prefs.setInt('last_login_time', DateTime.now().millisecondsSinceEpoch);
// //   }
// //
// //   // ✅ 마지막 로그인 시간이 1시간 초과했는지 확인
// //   Future<bool> isLoginExpired() async {
// //     final prefs = await SharedPreferences.getInstance();
// //     int? lastLoginTime = prefs.getInt('last_login_time');
// //
// //     if (lastLoginTime == null) return true; // 로그인 기록 없으면 로그아웃
// //
// //     int currentTime = DateTime.now().millisecondsSinceEpoch;
// //     int timeDifference = (currentTime - lastLoginTime) ~/ 1000; // 초 단위 변환
// //
// //     return timeDifference > 3600; // 1시간(3600초) 초과 시 true 반환
// //   }
// //
// //   // ✅ Firebase Auth 로그인 상태 확인
// //   Future<void> checkFirebaseAuthState() async {
// //     User? user = FirebaseAuth.instance.currentUser;
// //     if (user != null) {
// //       print("✅ Firebase 로그인 유지됨: ${user.email}");
// //       await updateLoginTime(); // 로그인 상태가 유지되면 로그인 시간 갱신
// //     } else {
// //       print("🚨 Firebase 로그아웃됨!");
// //     }
// //   }
// //
// //   // ✅ 앱 실행 시 1시간 지나면 자동 로그아웃
// //   Future<void> checkAutoLogout() async {
// //     bool expired = await isLoginExpired();
// //
// //     if (expired) {
// //       print("🚨 1시간 초과로 자동 로그아웃됨.");
// //       await FirebaseAuth.instance.signOut(); // Firebase 로그아웃
// //       final prefs = await SharedPreferences.getInstance();
// //       await prefs.remove('last_login_time'); // 저장된 로그인 시간 삭제
// //       if (mounted) {
// //         Navigator.pushReplacementNamed(context, '/login'); // 로그인 화면으로 이동
// //       }
// //     } else {
// //       print("✅ 로그인 유지됨");
// //     }
// //   }
// //
// //   // ✅ 사용자가 앱을 사용할 때마다 로그인 시간 갱신
// //   Future<void> updateLoginTime() async {
// //     final prefs = await SharedPreferences.getInstance();
// //     await prefs.setInt('last_login_time', DateTime.now().millisecondsSinceEpoch);
// //     print("✅ 로그인 시간 갱신됨!");
// //   }
// //
// //   // ✅ 로그인 버튼 클릭 시 동작
// //   Future<void> handleLogin() async {
// //     try {
// //       final userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
// //         email: emailController.text.trim(),
// //         password: passwordController.text.trim(),
// //       );
// //
// //       await saveLoginTime(); // 로그인 시간 저장
// //
// //       // 로그인 성공 시 화면 이동
// //       Navigator.pushReplacementNamed(context, '/record');
// //     } catch (e) {
// //       // 로그인 실패 시 에러 메시지 출력
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         SnackBar(content: Text("로그인 실패: $e")),
// //       );
// //     }
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text("로그인"),
// //       ),
// //       body: Padding(
// //         padding: const EdgeInsets.all(16.0),
// //         child: Column(
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           children: [
// //             // 이메일 입력 필드
// //             TextField(
// //               controller: emailController,
// //               decoration: const InputDecoration(
// //                 labelText: "Email",
// //                 border: OutlineInputBorder(),
// //               ),
// //             ),
// //             const SizedBox(height: 16),
// //             // 비밀번호 입력 필드
// //             TextField(
// //               controller: passwordController,
// //               obscureText: true,
// //               decoration: const InputDecoration(
// //                 labelText: "Password",
// //                 border: OutlineInputBorder(),
// //               ),
// //             ),
// //             const SizedBox(height: 24),
// //             // 로그인 버튼
// //             ElevatedButton(
// //               onPressed: handleLogin,
// //               child: const Text("로그인"),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
//
// // class LoginScreen extends StatefulWidget {
// //   @override
// //   _LoginScreenState createState() => _LoginScreenState();
// // }
// //
// // class _LoginScreenState extends State<LoginScreen> {
// //   final emailController = TextEditingController();
// //   final passwordController = TextEditingController();
// //
// //   Future<void> handleLogin() async {
// //     try {
// //       await FirebaseAuth.instance.signInWithEmailAndPassword(
// //         email: emailController.text.trim(),
// //         password: passwordController.text.trim(),
// //       );
// //
// //       final prefs = await SharedPreferences.getInstance();
// //       await prefs.setInt('last_login_time', DateTime.now().millisecondsSinceEpoch);
// //
// //       Navigator.pushReplacementNamed(context, '/recordSetup');
// //     } catch (e) {
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         SnackBar(content: Text('로그인 실패: $e')),
// //       );
// //     }
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(title: const Text("로그인"),
// //         automaticallyImplyLeading: false,),
// //       body: Padding(
// //         padding: const EdgeInsets.all(16.0),
// //         child: Column(
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           children: [
// //             TextField(controller: emailController, decoration: InputDecoration(labelText: "Email")),
// //             SizedBox(height: 16),
// //             TextField(controller: passwordController, obscureText: true, decoration: InputDecoration(labelText: "Password")),
// //             SizedBox(height: 24),
// //             ElevatedButton(onPressed: handleLogin, child: Text("로그인")),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
//
// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// // DefaultFirebaseOptions 쓰시는 경우:
// // import 'firebase_options.dart';
//
// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});
//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }
//
// class _LoginScreenState extends State<LoginScreen> {
//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();
//   bool _busy = false;
//
//   @override
//   void dispose() {
//     emailController.dispose();
//     passwordController.dispose();
//     super.dispose();
//   }
//
//   Future<void> _ensureFirebase() async {
//     try {
//       // DefaultFirebaseOptions를 쓰고 있다면 아래처럼:
//       // await Firebase.initializeApp(
//       //   options: DefaultFirebaseOptions.currentPlatform,
//       // ).timeout(const Duration(seconds: 3));
//       await Firebase.initializeApp().timeout(const Duration(seconds: 3));
//     } catch (_) {
//       // 초기화 실패/타임아웃이어도 여기서는 사용자에게 에러를 보여주고 종료
//       rethrow;
//     }
//   }
//
//   Future<void> handleLogin() async {
//     if (_busy) return; // 중복 탭 방지
//     setState(() => _busy = true);
//
//     try {
//       // 1) Firebase 초기화 보장(미초기화 상태 대비)
//       await _ensureFirebase();
//
//       // 2) 간단 검증
//       final email = emailController.text.trim();
//       final pw = passwordController.text;
//       if (email.isEmpty || pw.isEmpty) {
//         throw const FormatException('이메일/비밀번호를 입력해 주세요.');
//       }
//
//       // 3) 로그인 시도
//       final cred = await FirebaseAuth.instance
//           .signInWithEmailAndPassword(email: email, password: pw)
//           .timeout(const Duration(seconds: 8)); // 네트워크 지연 보호
//
//       // 4) 성공 시 마지막 로그인 시간 저장
//       final prefs = await SharedPreferences.getInstance();
//       await prefs.setInt('last_login_time', DateTime.now().millisecondsSinceEpoch);
//
//       // 5) 화면 전환 (mounted 확인 필수)
//       if (!mounted) return;
//       Navigator.pushReplacementNamed(context, '/recordSetup');
//     } on FirebaseAuthException catch (e) {
//       // 인증 에러 코드별 메시지
//       String msg = '로그인 실패';
//       switch (e.code) {
//         case 'invalid-email': msg = '이메일 형식이 올바르지 않습니다.'; break;
//         case 'user-not-found': msg = '가입된 이메일이 아닙니다.'; break;
//         case 'wrong-password': msg = '비밀번호가 올바르지 않습니다.'; break;
//         case 'user-disabled': msg = '비활성화된 계정입니다.'; break;
//         case 'too-many-requests': msg = '요청이 많습니다. 잠시 후 다시 시도해 주세요.'; break;
//         default: msg = '로그인 실패: ${e.message ?? e.code}';
//       }
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
//       }
//     } on TimeoutException {
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('네트워크 지연으로 로그인에 실패했습니다. 다시 시도해 주세요.')),
//         );
//       }
//     } on FormatException catch (e) {
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message)));
//       }
//     } catch (e) {
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('오류: $e')));
//       }
//     } finally {
//       if (mounted) setState(() => _busy = false);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("로그인"),
//         automaticallyImplyLeading: false,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
//           TextField(
//             controller: emailController,
//             keyboardType: TextInputType.emailAddress,
//             decoration: const InputDecoration(labelText: "Email"),
//             enabled: !_busy,
//           ),
//           const SizedBox(height: 16),
//           TextField(
//             controller: passwordController,
//             obscureText: true,
//             decoration: const InputDecoration(labelText: "Password"),
//             onSubmitted: (_) => handleLogin(),
//             enabled: !_busy,
//           ),
//           const SizedBox(height: 24),
//           SizedBox(
//             width: double.infinity,
//             child: ElevatedButton(
//               onPressed: _busy ? null : handleLogin,
//               child: _busy
//                   ? const SizedBox(
//                   height: 18, width: 18, child: CircularProgressIndicator(strokeWidth: 2))
//                   : const Text("로그인"),
//             ),
//           ),
//         ]),
//       ),
//     );
//   }
// }

// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:flutter/foundation.dart' show kIsWeb;
//
// import '../firebase_options.dart';
//
// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});
//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }
//
// class _LoginScreenState extends State<LoginScreen> {
//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();
//   bool _busy = false;
//
//   @override
//   void dispose() {
//     emailController.dispose();
//     passwordController.dispose();
//     super.dispose();
//   }
//
//   Future<void> _ensureFirebase() async {
//     if (Firebase.apps.isNotEmpty) return;
//     if (kIsWeb) {
//       await Firebase.initializeApp(
//         options: DefaultFirebaseOptions.web,
//       ).timeout(const Duration(seconds: 10));
//     } else {
//       await Firebase.initializeApp().timeout(const Duration(seconds: 10));
//     }
//   }
//
//   Future<void> handleLogin() async {
//     if (_busy) return;
//     setState(() => _busy = true);
//
//     try {
//       await _ensureFirebase();
//
//       // 사파리/PWA 저장소 이슈: SESSION 실패 시 NONE으로 폴백
//       if (kIsWeb) {
//         try {
//           await FirebaseAuth.instance.setPersistence(Persistence.SESSION);
//         } catch (_) {
//           try {
//             await FirebaseAuth.instance.setPersistence(Persistence.NONE);
//           } catch (_) {}
//         }
//       }
//
//       final email = emailController.text.trim();
//       final pw = passwordController.text;
//       if (email.isEmpty || pw.isEmpty) {
//         throw const FormatException('이메일/비밀번호를 입력해 주세요.');
//       }
//
//       final cred = await FirebaseAuth.instance
//           .signInWithEmailAndPassword(email: email, password: pw)
//           .timeout(const Duration(seconds: 15));
//
//       final user = cred.user;
//       if (user == null) {
//         ScaffoldMessenger.maybeOf(context)?.showSnackBar(
//           const SnackBar(content: Text('로그인 실패(사용자 정보 없음)')),
//         );
//         return;
//       }
//
//       if (!kIsWeb) {
//         final prefs = await SharedPreferences.getInstance();
//         await prefs.setInt('last_login_time', DateTime.now().millisecondsSinceEpoch);
//       }
//
//       if (!mounted) return;
//       Navigator.pushReplacementNamed(context, '/recordSetup');
//     } on FirebaseAuthException catch (e) {
//       String msg = '로그인 실패';
//       switch (e.code) {
//         case 'invalid-email': msg = '이메일 형식이 올바르지 않습니다.'; break;
//         case 'user-not-found': msg = '가입된 이메일이 아닙니다.'; break;
//         case 'wrong-password': msg = '비밀번호가 올바르지 않습니다.'; break;
//         case 'user-disabled': msg = '비활성화된 계정입니다.'; break;
//         case 'too-many-requests': msg = '요청이 많습니다. 잠시 후 다시 시도해 주세요.'; break;
//         default: msg = '로그인 실패: ${e.message ?? e.code}';
//       }
//       ScaffoldMessenger.maybeOf(context)?.showSnackBar(SnackBar(content: Text(msg)));
//     } on TimeoutException {
//       ScaffoldMessenger.maybeOf(context)?.showSnackBar(
//         const SnackBar(content: Text('네트워크 지연으로 로그인에 실패했습니다. 다시 시도해 주세요.')),
//       );
//     } on FormatException catch (e) {
//       ScaffoldMessenger.maybeOf(context)?.showSnackBar(SnackBar(content: Text(e.message)));
//     } catch (e) {
//       ScaffoldMessenger.maybeOf(context)
//           ?.showSnackBar(SnackBar(content: Text('오류: $e')));
//     } finally {
//       if (mounted) setState(() => _busy = false);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("로그인"),
//         automaticallyImplyLeading: false,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
//           TextField(
//             controller: emailController,
//             keyboardType: TextInputType.emailAddress,
//             decoration: const InputDecoration(labelText: "Email"),
//             enabled: !_busy,
//           ),
//           const SizedBox(height: 16),
//           TextField(
//             controller: passwordController,
//             obscureText: true,
//             decoration: const InputDecoration(labelText: "Password"),
//             onSubmitted: (_) => handleLogin(),
//             enabled: !_busy,
//           ),
//           const SizedBox(height: 24),
//           SizedBox(
//             width: double.infinity,
//             child: ElevatedButton(
//               onPressed: _busy ? null : handleLogin,
//               child: _busy
//                   ? const SizedBox(
//                   height: 18, width: 18, child: CircularProgressIndicator(strokeWidth: 2))
//                   : const Text("로그인"),
//             ),
//           ),
//         ]),
//       ),
//     );
//   }
// }

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import '../firebase_options.dart';

import '../utils/auth_persistence.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool _busy = false;

  String? _lastStep;
  String? _lastError;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<T> _runStep<T>(String name, Future<T> Function() fn) async {
    setState(() => _lastStep = 'STEP $name');
    try {
      return await fn();
    } catch (e) {
      setState(() => _lastError = '$e');
      rethrow;
    }
  }

  Future<void> _ensureFirebase() async {
    if (Firebase.apps.isNotEmpty) return;
    await _runStep('0 ensureFirebase', () async {
      if (kIsWeb) {
        await Firebase.initializeApp(
          options: DefaultFirebaseOptions.web,
        ).timeout(const Duration(seconds: 10));
      } else {
        await Firebase.initializeApp().timeout(const Duration(seconds: 10));
      }
    });
  }

  Future<void> handleLogin() async {
    if (_busy) return;
    setState(() { _busy = true; _lastError = null; _lastStep = 'ready'; });

    try {
      await _ensureFirebase();

      // ✅ 환경별 퍼시스턴스 세팅 (웹에서만 동작)
      await setBestWebPersistence();

      final email = emailController.text.trim();
      final pw = passwordController.text;
      if (email.isEmpty || pw.isEmpty) {
        throw const FormatException('이메일/비밀번호를 입력해 주세요.');
      }

      final cred = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: pw)
          .timeout(const Duration(seconds: 15));

      if (cred.user == null && FirebaseAuth.instance.currentUser == null) {
        throw StateError('로그인 실패(사용자 정보 없음)');
      }

      if (!mounted) return;
      Navigator.pushReplacementNamed(context, '/recordSetup');
    } catch (e) {
      // (네 기존 에러 처리 그대로)
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("로그인"), automaticallyImplyLeading: false),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(labelText: "Email"),
                enabled: !_busy,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: "Password"),
                onSubmitted: (_) => handleLogin(),
                enabled: !_busy,
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _busy ? null : handleLogin,
                  child: _busy
                      ? const SizedBox(height: 18, width: 18,
                      child: CircularProgressIndicator(strokeWidth: 2))
                      : const Text("로그인"),
                ),
              ),
            ]),
          ),
          if (kIsWeb && (_lastStep != null || _lastError != null))
            Positioned(
              left: 8, right: 8, bottom: 8,
              child: Container(
                padding: const EdgeInsets.all(10),
                color: Colors.black87,
                child: Text(
                  '$_lastStep | ${_lastError ?? ""}',
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

