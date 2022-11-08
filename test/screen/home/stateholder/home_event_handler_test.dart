import 'package:flutter_architecture_sample/catalog/github_repo_catalog.dart';
import 'package:flutter_architecture_sample/data/repository/github_repo_repository.dart';
import 'package:flutter_architecture_sample/data/repository/github_repo_repository_provider.dart';
import 'package:flutter_architecture_sample/model/error/api_exceptions.dart';
import 'package:flutter_architecture_sample/screen/common/stateholder/error_ui_model.dart';
import 'package:flutter_architecture_sample/screen/home/stateholder/home_event_handler_provider.dart';
import 'package:flutter_architecture_sample/screen/home/stateholder/home_ui_model_state_notifier.dart';
import 'package:flutter_architecture_sample/screen/home/stateholder/home_ui_model_state_notifier_provider.dart';
import 'package:flutter_architecture_sample/util/fa.dart';
import 'package:flutter_architecture_sample/util/fa_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'home_event_handler_test.mocks.dart';

// モック実装をMockitoに作らせる設定
@GenerateNiceMocks([
  MockSpec<GithubRepoRepository>(),
  MockSpec<HomeUiModelStateNotifier>(),
  MockSpec<FA>()
])
void main() {
  // 画面を開いたときの処理が成功
  test("HomeEventHandler#onCreate success", () async {
    // 依存するインスタンスのモック実装を作成する
    final repository = MockGithubRepoRepository();
    final stateNotifier = MockHomeUiModelStateNotifier();
    // Providerが提供するインスタンスをモック実装に差し替える
    final container = ProviderContainer(overrides: [
      githubRepoRepositoryProvider.overrideWithValue(repository),
      homeUiModelStateNotifierProvider.overrideWithValue(stateNotifier)
    ]);
    // テスト対象を取得
    final eventHandler = container.read(homeEventHandlerProvider);
    // テスト対象メソッドを呼び出し
    await eventHandler.onCreate();
    verifyInOrder([repository.fetch(), stateNotifier.onLoadSuccess()]);
  });
  // 再読込ボタンが押されたときの処理が成功
  test("HomeEventHandler#onClickReload success", () async {
    // 依存するインスタンスのモック実装を作成する
    final repository = MockGithubRepoRepository();
    final stateNotifier = MockHomeUiModelStateNotifier();
    // Providerが提供するインスタンスをモック実装に差し替える
    final container = ProviderContainer(overrides: [
      githubRepoRepositoryProvider.overrideWithValue(repository),
      homeUiModelStateNotifierProvider.overrideWithValue(stateNotifier)
    ]);
    // テスト対象を取得
    final eventHandler = container.read(homeEventHandlerProvider);
    // テスト対象メソッドを呼び出し
    await eventHandler.onClickReload();
    verifyInOrder([
      stateNotifier.onReload(),
      repository.fetch(),
      stateNotifier.onLoadSuccess()
    ]);
  });
  // 画面を開いたときの処理(読み込み処理)がネットワークエラーのケース
  test("HomeEventHandler#onCreate networkError", () async {
    // 依存するインスタンスのモック実装を作成する
    final repository = MockGithubRepoRepository();
    when(repository.fetch()).thenThrow(NetworkErrorException());
    final stateNotifier = MockHomeUiModelStateNotifier();
    // Providerが提供するインスタンスをモック実装に差し替える
    final container = ProviderContainer(overrides: [
      githubRepoRepositoryProvider.overrideWithValue(repository),
      homeUiModelStateNotifierProvider.overrideWithValue(stateNotifier)
    ]);
    // テスト対象を取得
    final eventHandler = container.read(homeEventHandlerProvider);
    // テスト対象メソッドを呼び出し
    await eventHandler.onCreate();
    verifyInOrder([
      repository.fetch(),
      stateNotifier.onMyError(const ErrorUiModel.network())
    ]);
  });
  // 「いいね」ボタンが押された
  test("HomeEventHandler#onClickFavorite", () async {
    // 依存するインスタンスのモック実装を作成する
    final repository = MockGithubRepoRepository();
    final stateNotifier = MockHomeUiModelStateNotifier();
    // Providerが提供するインスタンスをモック実装に差し替える
    final container = ProviderContainer(overrides: [
      githubRepoRepositoryProvider.overrideWithValue(repository),
      homeUiModelStateNotifierProvider.overrideWithValue(stateNotifier)
    ]);
    // テスト対象を取得
    final eventHandler = container.read(homeEventHandlerProvider);
    // テスト対象メソッドを呼び出し
    await eventHandler.onClickFavorite("flutter_architecture_sample", true);
    verifyInOrder(
        [repository.setFavorite("flutter_architecture_sample", true)]);
  });
  // GitHubリポジトリ項目が押された
  test("HomeEventHandler#onClickRepo", () async {
    // 依存するインスタンスのモック実装を作成する
    final stateNotifier = MockHomeUiModelStateNotifier();
    final fa = MockFA();
    // Providerが提供するインスタンスをモック実装に差し替える
    final container = ProviderContainer(overrides: [
      homeUiModelStateNotifierProvider.overrideWithValue(stateNotifier),
      faProvider.overrideWithValue(fa)
    ]);
    // テスト対象を取得
    final eventHandler = container.read(homeEventHandlerProvider);
    // テスト対象メソッドを呼び出し
    final repo = getGithubRepoCatalog()[0];
    eventHandler.onClickRepo(repo);
    eventHandler.onDetailScreenCalled();
    verifyInOrder([
      fa.send("callDetailScreen", {"name": repo.name}),
      stateNotifier.callDetailScreen(repo),
      stateNotifier.onDetailScreenCalled()
    ]);
  });
}
