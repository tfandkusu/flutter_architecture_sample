import 'package:flutter/material.dart';
import 'package:flutter_architecture_sample/catalog/github_repo_catalog.dart';
import 'package:flutter_architecture_sample/data/remote/markdown_remote_data_source.dart';
import 'package:flutter_architecture_sample/data/remote/markdown_remote_data_source_provider.dart';
import 'package:flutter_architecture_sample/data/repository/github_repo_list_state_notifier.dart';
import 'package:flutter_architecture_sample/data/repository/github_repo_list_state_notifier_provder.dart';
import 'package:flutter_architecture_sample/model/error/api_exceptions.dart';
import 'package:flutter_architecture_sample/screen/detail/widget/detail_screen.dart';
import 'package:flutter_architecture_sample/screen/detail/widget/detail_screen_argument.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'detail_screen_test.mocks.dart';

/// 詳細画面のWidgetテスト
@GenerateNiceMocks([MockSpec<MarkdownRemoteDataSource>()])
void main() {
  // 読込成功ケース
  testWidgets('DetailScreen success', (tester) async {
    SharedPreferences.setMockInitialValues({});
    final remoteDataSource = MockMarkdownRemoteDataSource();
    final repos = getGithubRepoCatalog();
    final stateNotifier = GithubRepoListStateNotifier.override(repos);
    when(remoteDataSource.getMarkdown(
            "conference-app-2021", "main", "/README.md"))
        .thenAnswer((_) async => "# DroidKaigi 2021 official app");
    await tester.pumpWidget(ProviderScope(
        overrides: [
          markdownRemoteDataSourceProvider.overrideWithValue(remoteDataSource),
          githubRepoListStateNotifierProvider.overrideWithValue(stateNotifier)
        ],
        child: MaterialApp(
            onGenerateRoute: (settings) => MaterialPageRoute(
                settings: const RouteSettings(
                    arguments: DetailScreenArgument(
                        id: 343133709,
                        name: "conference-app-2021",
                        defaultBranch: "main")),
                builder: (BuildContext context) => const DetailScreen()))));
    final titleFinder = find.text("conference-app-2021");
    expect(titleFinder, findsOneWidget);
    await tester.pumpAndSettle();
    final readmeFinder = find.text("DroidKaigi 2021 official app");
    expect(readmeFinder, findsOneWidget);
  });
  // 読込失敗ケース
  testWidgets('DetailScreen network error', (tester) async {
    SharedPreferences.setMockInitialValues({});
    final remoteDataSource = MockMarkdownRemoteDataSource();
    final repos = getGithubRepoCatalog();
    final stateNotifier = GithubRepoListStateNotifier.override(repos);
    when(remoteDataSource.getMarkdown(
            "conference-app-2021", "main", "/README.md"))
        .thenThrow(NetworkErrorException());
    await tester.pumpWidget(ProviderScope(
        overrides: [
          markdownRemoteDataSourceProvider.overrideWithValue(remoteDataSource),
          githubRepoListStateNotifierProvider.overrideWithValue(stateNotifier)
        ],
        child: MaterialApp(
            onGenerateRoute: (settings) => MaterialPageRoute(
                settings: const RouteSettings(
                    arguments: DetailScreenArgument(
                        id: 343133709,
                        name: "conference-app-2021",
                        defaultBranch: "main")),
                builder: (BuildContext context) => const DetailScreen()))));
    final titleFinder = find.text("conference-app-2021");
    expect(titleFinder, findsOneWidget);
    await tester.pumpAndSettle();
    final messageFinder = find.text("インターネット接続がありません。");
    final reloadFinder = find.text("再読込");
    expect(messageFinder, findsOneWidget);
    expect(reloadFinder, findsOneWidget);
  });
  // 「いいね」を付けて消すテスト
  testWidgets('DetailScreen favorite', (tester) async {
    SharedPreferences.setMockInitialValues({});
    final remoteDataSource = MockMarkdownRemoteDataSource();
    final repos = getGithubRepoCatalog();
    final stateNotifier = GithubRepoListStateNotifier.override(repos);
    when(remoteDataSource.getMarkdown(
            "conference-app-2021", "main", "/README.md"))
        .thenAnswer((_) async => "# DroidKaigi 2021 official app");
    await tester.pumpWidget(ProviderScope(
        overrides: [
          markdownRemoteDataSourceProvider.overrideWithValue(remoteDataSource),
          githubRepoListStateNotifierProvider.overrideWithValue(stateNotifier)
        ],
        child: MaterialApp(
            onGenerateRoute: (settings) => MaterialPageRoute(
                settings: const RouteSettings(
                    arguments: DetailScreenArgument(
                        id: 343133709,
                        name: "conference-app-2021",
                        defaultBranch: "main")),
                builder: (BuildContext context) => const DetailScreen()))));
    await tester.pumpAndSettle();
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
  });
}
