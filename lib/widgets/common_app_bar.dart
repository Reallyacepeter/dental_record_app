import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showLogout; // 로그아웃 버튼 표시 여부

  const CommonAppBar({required this.title, this.showLogout = false, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      actions: showLogout
          ? [
        IconButton(
          icon: const Icon(Icons.logout),
          onPressed: () async {
            final shouldLogout = await _showLogoutConfirmationDialog(context);
            if (shouldLogout == true) {
              await FirebaseAuth.instance.signOut(); // 로그아웃 실행
              Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
            }
          },
        ),
      ]
          : null,
    );
  }

  Future<bool?> _showLogoutConfirmationDialog(BuildContext context) async {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("로그아웃"),
          content: const Text("정말로 로그아웃 하시겠습니까?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false), // 아니오
              child: const Text("아니오"),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true), // 예
              child: const Text("예"),
            ),
          ],
        );
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
