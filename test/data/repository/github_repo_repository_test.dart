import 'package:flutter_architecture_sample/data/local/favorite_local_data_source.dart';
import 'package:flutter_architecture_sample/data/local/favorite_local_data_source_provider.dart';
import 'package:flutter_architecture_sample/data/remote/github_repo_remote_data_source.dart';
import 'package:flutter_architecture_sample/data/remote/github_repo_remote_data_source_provider.dart';
import 'package:flutter_architecture_sample/data/remote/markdown_remote_data_source.dart';
import 'package:flutter_architecture_sample/data/remote/markdown_remote_data_source_provider.dart';
import 'package:flutter_architecture_sample/data/repository/github_repo_list_state_notifier.dart';
import 'package:flutter_architecture_sample/data/repository/github_repo_list_state_notifier_provder.dart';
import 'package:flutter_architecture_sample/data/repository/github_repo_repository_provider.dart';
import 'package:flutter_architecture_sample/model/error/api_exceptions.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_architecture_sample/catalog/github_repo_catalog.dart';

// Mockitoによって作られたモック実装
import 'github_repo_repository_test.mocks.dart';

// モック実装をMockitoに作らせる設定
@GenerateNiceMocks([
  MockSpec<GithubRepoRemoteDataSource>(),
  MockSpec<MarkdownRemoteDataSource>(),
  MockSpec<FavoriteLocalDataSource>(),
  MockSpec<GithubRepoListStateNotifier>()
])
void main() {
  test("GithubRepoRepository#fetch", () async {
    // 依存するインスタンスのモック実装を作成する
    final remoteDataSource = MockGithubRepoRemoteDataSource();
    final localDataSource = MockFavoriteLocalDataSource();
    final stateNotifier = MockGithubRepoListStateNotifier();
    // GitHubRepoRemoteDataSourceのモックレスポンスを設定する
    final repoList = getGithubRepoCatalog();
    // 更新日降順にソートする件のテストのために逆順にする
    final repoListForSortTest = repoList.reversed.toList();
    when(remoteDataSource.getGithubRepoList())
        .thenAnswer((_) async => repoListForSortTest);
    // FavoriteLocalDataSourceのモックレスポンスを作成する
    when(localDataSource.getFavoriteRepoNameSet())
        .thenAnswer((_) async => {"observe_room"});
    // Providerが提供するインスタンスをモック実装に差し替える
    final container = ProviderContainer(overrides: [
      githubRepoRemoteDataSourceProvider.overrideWithValue(remoteDataSource),
      favoriteLocalDataSourceProvider.overrideWithValue(localDataSource),
      githubRepoListStateNotifierProvider.overrideWithValue(stateNotifier)
    ]);
    // テスト対象インスタンスを取得
    final repository = container.read(githubRepoRepositoryProvider);
    // テスト対象メソッドを呼び出し
    await repository.fetch();
    // 依存するインスタンスのメソッドの呼ばれ方を確認する
    final repoListWithFavorite = repoList.map((repo) {
      if (repo.name == "observe_room") {
        return repo.copyWith(favorite: true);
      } else {
        return repo;
      }
    }).toList();
    verifyInOrder([
      remoteDataSource.getGithubRepoList(),
      localDataSource.getFavoriteRepoNameSet(),
      stateNotifier.setList(repoListWithFavorite)
    ]);
  });

  test("GithubRepoRepository#favorite", () async {
    // 依存するインスタンスのモック実装を作成する
    final remoteDataSource = MockGithubRepoRemoteDataSource();
    final localDataSource = MockFavoriteLocalDataSource();
    final stateNotifier = MockGithubRepoListStateNotifier();
    // Providerが提供するインスタンスをモック実装に差し替える
    final container = ProviderContainer(overrides: [
      githubRepoRemoteDataSourceProvider.overrideWithValue(remoteDataSource),
      favoriteLocalDataSourceProvider.overrideWithValue(localDataSource),
      githubRepoListStateNotifierProvider.overrideWithValue(stateNotifier)
    ]);
    // テスト対象インスタンスを取得
    final repository = container.read(githubRepoRepositoryProvider);
    // テスト対象メソッドを呼び出す
    await repository.setFavorite("observe_room", true);
    // 依存するインスタンスのメソッドの呼ばれ方を確認する
    verifyInOrder([
      stateNotifier.setFavorite("observe_room", true),
      localDataSource.setFavorite("observe_room", true)
    ]);
  });

  test("GithubRepoRepository#getReadme README.md", () async {
    final remoteDataSource = MockMarkdownRemoteDataSource();
    // Providerが提供するインスタンスをモック実装に差し替える
    final container = ProviderContainer(overrides: [
      markdownRemoteDataSourceProvider.overrideWithValue(remoteDataSource)
    ]);
    // テスト対象インスタンスを取得
    final repository = container.read(githubRepoRepositoryProvider);
    await repository.getReadme("groupie_sticky_header_sample", "main");
    verifyInOrder([
      remoteDataSource.getMarkdown(
          "groupie_sticky_header_sample", "main", "/README.md")
    ]);
  });

  test("GithubRepoRepository#getReadme readme.md", () async {
    final remoteDataSource = MockMarkdownRemoteDataSource();
    // README.mdが無い
    when(remoteDataSource.getMarkdown(
            "groupie_sticky_header_sample", "main", "/README.md"))
        .thenThrow(NotFoundException());
    // Providerが提供するインスタンスをモック実装に差し替える
    final container = ProviderContainer(overrides: [
      markdownRemoteDataSourceProvider.overrideWithValue(remoteDataSource)
    ]);
    // テスト対象インスタンスを取得
    final repository = container.read(githubRepoRepositoryProvider);
    await repository.getReadme("groupie_sticky_header_sample", "main");
    verifyInOrder([
      remoteDataSource.getMarkdown(
          "groupie_sticky_header_sample", "main", "/README.md"),
      // 代わりにreadme.mdがダウンロードされた
      remoteDataSource.getMarkdown(
          "groupie_sticky_header_sample", "main", "/readme.md")
    ]);
  });

  test("GithubRepoRepository#getReadme notFound", () async {
    final remoteDataSource = MockMarkdownRemoteDataSource();
    // README.mdが無い
    when(remoteDataSource.getMarkdown(
            "groupie_sticky_header_sample", "main", "/README.md"))
        .thenThrow(NotFoundException());
    // readme.mdも無い
    when(remoteDataSource.getMarkdown(
            "groupie_sticky_header_sample", "main", "/readme.md"))
        .thenThrow(NotFoundException());
    // Providerが提供するインスタンスをモック実装に差し替える
    final container = ProviderContainer(overrides: [
      markdownRemoteDataSourceProvider.overrideWithValue(remoteDataSource)
    ]);
    // テスト対象インスタンスを取得
    final repository = container.read(githubRepoRepositoryProvider);
    expect(
        () async =>
            await repository.getReadme("groupie_sticky_header_sample", "main"),
        throwsA(isA<NotFoundException>()));
    verifyInOrder([
      remoteDataSource.getMarkdown(
          "groupie_sticky_header_sample", "main", "/README.md"),
      remoteDataSource.getMarkdown(
          "groupie_sticky_header_sample", "main", "/readme.md")
    ]);
  });
}
