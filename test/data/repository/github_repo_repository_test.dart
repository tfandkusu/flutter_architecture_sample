import 'package:flutter_architecture_sample/data/local/favorite_local_data_store.dart';
import 'package:flutter_architecture_sample/data/local/favorite_local_data_store_provider.dart';
import 'package:flutter_architecture_sample/data/remote/github_repo_remote_data_store.dart';
import 'package:flutter_architecture_sample/data/remote/github_repo_remote_data_store_provider.dart';
import 'package:flutter_architecture_sample/data/remote/markdown_remote_data_store.dart';
import 'package:flutter_architecture_sample/data/remote/markdown_remote_data_store_provider.dart';
import 'package:flutter_architecture_sample/data/repository/github_repo_list_state_notifier.dart';
import 'package:flutter_architecture_sample/data/repository/github_repo_list_state_notifier_provder.dart';
import 'package:flutter_architecture_sample/data/repository/github_repo_repository_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_architecture_sample/catalog/github_repo_catalog.dart';

// Mockitoによって作られたモック実装
import 'github_repo_repository_test.mocks.dart';

// モック実装をMockitoに作らせる設定
@GenerateNiceMocks([
  MockSpec<GitHubRepoRemoteDataStore>(),
  MockSpec<MarkdownRemoteDataStore>(),
  MockSpec<FavoriteLocalDataStore>(),
  MockSpec<GithubRepoListStateNotifier>()
])
void main() {
  test("GithubRepoRepository#fetch", () async {
    // 依存するインスタンスのモック実装を作成する
    final remoteDataStore = MockGitHubRepoRemoteDataStore();
    final localDataStore = MockFavoriteLocalDataStore();
    final stateNotifier = MockGithubRepoListStateNotifier();
    // GitHubRepoRemoteDataStoreのモックレスポンスを設定する
    final repoList = getGithubRepoCatalog();
    // 更新日降順にソートする件のテストのために逆順にする
    final repoListForSortTest = repoList.reversed.toList();
    when(remoteDataStore.getGitHubRepoList())
        .thenAnswer((_) async => repoListForSortTest);
    // FavoriteLocalDataStoreのモックレスポンスを作成する
    when(localDataStore.getFavoriteRepoNameSet())
        .thenAnswer((_) async => {"observe_room"});
    // Providerが提供するインスタンスをモック実装に差し替える
    final container = ProviderContainer(overrides: [
      githubRepoRemoteDataStoreProvider.overrideWithValue(remoteDataStore),
      favoriteLocalDataStoreProvider.overrideWithValue(localDataStore),
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
      remoteDataStore.getGitHubRepoList(),
      localDataStore.getFavoriteRepoNameSet(),
      stateNotifier.setList(repoListWithFavorite)
    ]);
  });

  test("GithubRepoRepository#favorite", () async {
    // 依存するインスタンスのモック実装を作成する
    final remoteDataStore = MockGitHubRepoRemoteDataStore();
    final localDataStore = MockFavoriteLocalDataStore();
    final stateNotifier = MockGithubRepoListStateNotifier();
    // Providerが提供するインスタンスをモック実装に差し替える
    final container = ProviderContainer(overrides: [
      githubRepoRemoteDataStoreProvider.overrideWithValue(remoteDataStore),
      favoriteLocalDataStoreProvider.overrideWithValue(localDataStore),
      githubRepoListStateNotifierProvider.overrideWithValue(stateNotifier)
    ]);
    // テスト対象インスタンスを取得
    final repository = container.read(githubRepoRepositoryProvider);
    // テスト対象メソッドを呼び出す
    await repository.setFavorite("observe_room", true);
    // 依存するインスタンスのメソッドの呼ばれ方を確認する
    verifyInOrder([
      stateNotifier.setFavorite("observe_room", true),
      localDataStore.setFavorite("observe_room", true)
    ]);
  });

  test("GithubRepoRepository#getReadme", () async {
    final remoteDataStore = MockMarkdownRemoteDataStore();
    // Providerが提供するインスタンスをモック実装に差し替える
    final container = ProviderContainer(overrides: [
      markdownRemoteDataStoreProvider.overrideWithValue(remoteDataStore)
    ]);
    // テスト対象インスタンスを取得
    final repository = container.read(githubRepoRepositoryProvider);
    final repo = getGithubRepoCatalog()[2];
    await repository.getReadme(repo);
    verifyInOrder([
      remoteDataStore.getMarkdown(
          "groupie_sticky_header_sample", "main", "/README.md")
    ]);
  });
}
