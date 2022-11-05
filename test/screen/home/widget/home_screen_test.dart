import 'package:flutter/material.dart';
import 'package:flutter_architecture_sample/catalog/github_repo_catalog.dart';
import 'package:flutter_architecture_sample/data/remote/github_repo_remote_data_source.dart';
import 'package:flutter_architecture_sample/data/remote/github_repo_remote_data_source_provider.dart';
import 'package:flutter_architecture_sample/model/error/api_exceptions.dart';
import 'package:flutter_architecture_sample/screen/home/widget/home_screen.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_screen_test.mocks.dart';

/// ホーム画面のWidgetテスト
@GenerateNiceMocks([MockSpec<GithubRepoRemoteDataSource>()])
void main() {
  // 読込成功ケース
  testWidgets('HomeScreen success', (tester) async {
    SharedPreferences.setMockInitialValues({});
    final remoteDataStore = MockGithubRepoRemoteDataSource();
    final repos = getGithubRepoCatalog();
    when(remoteDataStore.getGithubRepoList()).thenAnswer((_) async => repos);
    await tester.pumpWidget(ProviderScope(
      overrides: [
        githubRepoRemoteDataSourceProvider.overrideWithValue(remoteDataStore)
      ],
      child: const MaterialApp(home: HomeScreen()),
    ));
    final titleFinder = find.text("GitHub Repository List");
    expect(titleFinder, findsOneWidget);
    await tester.pumpAndSettle();
    final repo1Finder = find.text("observe_room");
    expect(repo1Finder, findsOneWidget);
    final repo3Finder = find.text("groupie_sticky_header_sample");
    expect(repo3Finder, findsOneWidget);
    final langFinder = find.text("Kotlin");
    expect(langFinder, findsWidgets);
  });
  // ネットワークエラーケース
  testWidgets('HomeScreen network error', (tester) async {
    SharedPreferences.setMockInitialValues({});
    final remoteDataStore = MockGithubRepoRemoteDataSource();
    when(remoteDataStore.getGithubRepoList())
        .thenThrow(NetworkErrorException());
    await tester.pumpWidget(ProviderScope(
      overrides: [
        githubRepoRemoteDataSourceProvider.overrideWithValue(remoteDataStore)
      ],
      child: const MaterialApp(home: HomeScreen()),
    ));
    final titleFinder = find.text("GitHub Repository List");
    expect(titleFinder, findsOneWidget);
    await tester.pumpAndSettle();
    final messageFinder = find.text("インターネット接続がありません。");
    final reloadFinder = find.text("再読込");
    expect(messageFinder, findsOneWidget);
    expect(reloadFinder, findsOneWidget);
  });
}
