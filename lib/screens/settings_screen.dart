import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../widgets/custom_bottom_nav_bar.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('설정'),
        automaticallyImplyLeading: false,
      ),
      body: ListView(
        children: [
          const SizedBox(height: 20),

          const ListTile(
            leading: Icon(Icons.person),
            title: Text("계정 정보", style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          ListTile(
            leading: const Icon(Icons.email),
            title: const Text("이메일"),
            subtitle: Text(user?.email ?? "로그인 정보 없음"),
          ),

          const Divider(),

          const ListTile(
            leading: Icon(Icons.settings),
            title: Text("앱 설정", style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text("앱 버전"),
            subtitle: const Text("v1.0.0"),
          ),

          const Divider(),

          const ListTile(
            leading: Icon(Icons.lock),
            title: Text("보안", style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text("로그아웃"),
            onTap: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushNamedAndRemoveUntil(context, '/login', (_) => false);
            },
          ),

          const Divider(),

          const ListTile(
            leading: Icon(Icons.policy),
            title: Text("기타", style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          ListTile(
            leading: const Icon(Icons.contact_support),
            title: const Text("개발자 연락처"),
            subtitle: const Text("moon_1673@naver.com"),
          ),
        ],
      ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 2),
    );
  }
}
