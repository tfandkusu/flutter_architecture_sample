import 'package:flutter_architecture_sample/data/repository/github_repo_repository.dart';
import 'package:flutter_architecture_sample/data/repository/github_repo_repository_provider.dart';
import 'package:flutter_architecture_sample/feature/home/home_event_handler_provider.dart';
import 'package:flutter_architecture_sample/feature/home/home_ui_model_state_notifier.dart';
import 'package:flutter_architecture_sample/feature/home/home_ui_model_state_notifier_provider.dart';
import 'package:flutter_architecture_sample/model/error/api_exceptions.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'home_event_handler_test.mocks.dart';

// モック実装をMockitoに作らせる設定
@GenerateNiceMocks(
    [MockSpec<GithubRepoRepository>(), MockSpec<HomeUiModelStateNotifier>()])
void main() {
  // 読み込み処理の成功ケース
  test("HomeEventHandler#start success", () async {
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
    await eventHandler.start();
    verifyInOrder([repository.fetch(), stateNotifier.onLoadSuccess()]);
  });
  // リロード成功ケース
  test("HomeEventHandler#reload success", () async {
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
    await eventHandler.reload();
    verifyInOrder([
      stateNotifier.onReload(),
      repository.fetch(),
      stateNotifier.onLoadSuccess()
    ]);
  });
  // 読み込み処理がネットワークエラーのケース
  test("HomeEventHandler#load networkError", () async {
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
    await eventHandler.start();
    verifyInOrder([repository.fetch(), stateNotifier.onNetworkError()]);
  });
  // 読み込み処理がサーバエラーのケース
  test("HomeEventHandler#load serverError", () async {
    // 依存するインスタンスのモック実装を作成する
    final repository = MockGithubRepoRepository();
    when(repository.fetch()).thenThrow(ServerErrorException());
    final stateNotifier = MockHomeUiModelStateNotifier();
    // Providerが提供するインスタンスをモック実装に差し替える
    final container = ProviderContainer(overrides: [
      githubRepoRepositoryProvider.overrideWithValue(repository),
      homeUiModelStateNotifierProvider.overrideWithValue(stateNotifier)
    ]);
    // テスト対象を取得
    final eventHandler = container.read(homeEventHandlerProvider);
    // テスト対象メソッドを呼び出し
    await eventHandler.start();
    verifyInOrder([repository.fetch(), stateNotifier.onServerError()]);
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
}
