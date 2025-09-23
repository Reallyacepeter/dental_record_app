// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
//
// import 'package:dental_record_app/main.dart';
// import 'package:dental_record_app/providers/dental_data_provider.dart';
// import 'package:dental_record_app/services/local_store.dart';
//
// void main() {
//   TestWidgetsFlutterBinding.ensureInitialized();
//
//   setUpAll(() async {
//     // 테스트에서 파일 I/O 없이 로컬 상태 저장이 돌아가도록 메모리 모드로 초기화
//     // LocalStore.init(inMemory: true)가 없다면, 여러분 LocalStore에 동일 의미의 초기화 함수를 만들어 주세요.
//     await LocalStore.init(inMemory: true);
//   });
//
//   testWidgets('App builds (smoke test)', (WidgetTester tester) async {
//     // Firestore 실시간 구독(incident lock) 끄기 → Firebase 초기화 없이도 테스트 가능
//     final dental = DentalDataProvider(listenIncidentLock: false);
//
//     // (선택) 이전 저장본을 메모리에서 복원. 저장본이 없으면 그냥 빈 상태로 시작
//     await dental.hydrate();
//
//     // 필수: MyApp에 provider 주입
//     await tester.pumpWidget(MyApp(dental: dental));
//     await tester.pumpAndSettle();
//
//     // 가장 기본적인 빌드 확인
//     expect(find.byType(MaterialApp), findsOneWidget);
//     // 초기 라우트(SplashScreen 등)가 스캐폴드 기반이라면 최소 하나는 존재
//     expect(find.byType(Scaffold), findsWidgets);
//   });
// }

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:provider/provider.dart'; // ⬅️ 추가!
import 'package:dental_record_app/main.dart';
import 'package:dental_record_app/providers/dental_data_provider.dart';
import 'package:dental_record_app/services/local_store.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    await LocalStore.init(inMemory: true);
  });

  testWidgets('App builds (smoke test)', (WidgetTester tester) async {
    // 만약 생성자에 listenIncidentLock가 없다면 그냥 DentalDataProvider()로
    final dental = DentalDataProvider(/* listenIncidentLock: false */);

    await dental.hydrate();

    await tester.pumpWidget(
      ChangeNotifierProvider.value(
        value: dental,
        child: const MyApp(), // ⬅️ 이제 파라미터 없음
      ),
    );

    await tester.pumpAndSettle();

    expect(find.byType(MaterialApp), findsOneWidget);
    expect(find.byType(Scaffold), findsWidgets);
  });
}
