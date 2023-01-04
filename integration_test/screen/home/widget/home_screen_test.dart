import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter_architecture_sample/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  testWidgets('HomeScreen', (tester) async {
    app.main();
    await tester.pumpAndSettle();
    // 表示を確認
    final titleFinder = find.text("GitHub Repository List");
    expect(titleFinder, findsOneWidget);
    await tester.pumpAndSettle();
    final repo1Finder = find.text("fas_contents_deploy");
    expect(repo1Finder, findsOneWidget);
    final langFinder = find.text("Python");
    expect(langFinder, findsWidgets);
    // テーマの取得
    final BuildContext context = tester.element(find.byType(Scaffold));
    final themeData = Theme.of(context);
    // 1件目の「いいね」ボタン
    final favoriteFinder = find.byIcon(Icons.favorite).first;
    // 「いいね」ボタンが灰色であることを確認
    expect((tester.firstWidget(favoriteFinder) as Icon).color,
        themeData.colorScheme.surfaceVariant);
    // 「いいね」ボタンを押す
    await tester.tap(favoriteFinder);
    await tester.pumpAndSettle();
    // 「いいね」ボタンが赤くなっていることを確認
    expect((tester.firstWidget(favoriteFinder) as Icon).color,
        themeData.colorScheme.secondary);
    // 「いいね」ボタンを押す
    await tester.tap(favoriteFinder);
    await tester.pumpAndSettle();
    // 「いいね」ボタンが灰色に戻ることを確認
    expect((tester.firstWidget(favoriteFinder) as Icon).color,
        themeData.colorScheme.surfaceVariant);
    // 詳細画面を開く
    await tester.tap(repo1Finder);
    await tester.pumpAndSettle();
  });
}
