import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("로그인"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 이메일 입력 필드
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            // 비밀번호 입력 필드
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Password",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            // 로그인 버튼
            ElevatedButton(
              onPressed: () async {
                try {
                  final userCredential =
                  await FirebaseAuth.instance.signInWithEmailAndPassword(
                    email: emailController.text.trim(),
                    password: passwordController.text.trim(),
                  );

                  // 성공적으로 로그인 시 화면 이동
                  Navigator.pushReplacementNamed(context, '/record');
                } catch (e) {
                  // 로그인 실패 시 에러 메시지 출력
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("로그인 실패: $e")),
                  );
                }
              },
              child: const Text("로그인"),
            ),
          ],
        ),
      ),
    );
  }
}
