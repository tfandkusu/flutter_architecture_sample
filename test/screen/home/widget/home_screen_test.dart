import 'package:flutter/material.dart';
import 'package:flutter_architecture_sample/catalog/github_repo_catalog.dart';
import 'package:flutter_architecture_sample/data/remote/github_repo_remote_data_source.dart';
import 'package:flutter_architecture_sample/data/remote/github_repo_remote_data_source_provider.dart';
import 'package:flutter_architecture_sample/screen/home/widget/home_screen.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_screen_test.mocks.dart';

@GenerateNiceMocks([MockSpec<GithubRepoRemoteDataSource>()])
void main() {
  testWidgets('To import all files', (tester) async {
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
  });
}
