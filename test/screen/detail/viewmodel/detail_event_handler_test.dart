import 'package:flutter_architecture_sample/catalog/github_repo_catalog.dart';
import 'package:flutter_architecture_sample/data/repository/github_repo_repository.dart';
import 'package:flutter_architecture_sample/data/repository/github_repo_repository_provider.dart';
import 'package:flutter_architecture_sample/model/error/api_exceptions.dart';
import 'package:flutter_architecture_sample/screen/common/viewmodel/error_ui_model.dart';
import 'package:flutter_architecture_sample/screen/detail/viewmodel/detail_event_handler_provider.dart';
import 'package:flutter_architecture_sample/screen/detail/viewmodel/detail_ui_model_state_notifier.dart';
import 'package:flutter_architecture_sample/screen/detail/viewmodel/detail_ui_model_state_notifier_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'detail_event_handler_test.mocks.dart';

// モック実装をMockitoに作らせる設定
@GenerateNiceMocks(
    [MockSpec<GithubRepoRepository>(), MockSpec<DetailUiModelStateNotifier>()])
void main() {
  // 画面が開かれた
  test("DetailEventHandler#onCreate success", () async {
    // 依存するインスタンスのモック実装を作成する
    final stateNotifier = MockDetailUiModelStateNotifier();
    final repository = MockGithubRepoRepository();
    final repo = getGithubRepoCatalog()[0];
    const readme = "# some_repository";
    when(repository.getReadme(repo)).thenAnswer((_) => Future.value(readme));
    final container = ProviderContainer(overrides: [
      detailUiModelStateNotifierProvider.overrideWithValue(stateNotifier),
      githubRepoRepositoryProvider.overrideWithValue(repository)
    ]);
    // テスト対象を取得
    final eventHandler = container.read(detailEventHandlerProvider);
    // テスト対象メソッドを呼び出し
    await eventHandler.onCreate(repo);
    verifyInOrder(
        [repository.getReadme(repo), stateNotifier.onLoadSuccess(readme)]);
  });

  // 再読込ボタンが押された
  test("DetailEventHandler#onClickReload", () async {
    // 依存するインスタンスのモック実装を作成する
    final stateNotifier = MockDetailUiModelStateNotifier();
    final repository = MockGithubRepoRepository();
    final repo = getGithubRepoCatalog()[0];
    const readme = "# some_repository";
    when(repository.getReadme(repo)).thenAnswer((_) => Future.value(readme));
    final container = ProviderContainer(overrides: [
      detailUiModelStateNotifierProvider.overrideWithValue(stateNotifier),
      githubRepoRepositoryProvider.overrideWithValue(repository)
    ]);
    // テスト対象を取得
    final eventHandler = container.read(detailEventHandlerProvider);
    // テスト対象メソッドを呼び出し
    await eventHandler.onClickReload(repo);
    verifyInOrder([
      stateNotifier.onReload(),
      repository.getReadme(repo),
      stateNotifier.onLoadSuccess(readme)
    ]);
  });

  // エラーが発生
  test("DetailEventHandler#onCreate error", () async {
    // 依存するインスタンスのモック実装を作成する
    final stateNotifier = MockDetailUiModelStateNotifier();
    final repository = MockGithubRepoRepository();
    final repo = getGithubRepoCatalog()[0];
    when(repository.getReadme(repo)).thenThrow(NetworkErrorException());
    final container = ProviderContainer(overrides: [
      detailUiModelStateNotifierProvider.overrideWithValue(stateNotifier),
      githubRepoRepositoryProvider.overrideWithValue(repository)
    ]);
    // テスト対象を取得
    final eventHandler = container.read(detailEventHandlerProvider);
    // テスト対象メソッドを呼び出し
    await eventHandler.onCreate(repo);
    verifyInOrder([
      repository.getReadme(repo),
      stateNotifier.onMyError(const ErrorUiModel.network())
    ]);
  });

  // 「いいね」ボタンが押された
  test("DetailEventHandler#onClickFavorite", () async {
    // 依存するインスタンスのモック実装を作成する
    final repository = MockGithubRepoRepository();
    final container = ProviderContainer(overrides: [
      githubRepoRepositoryProvider.overrideWithValue(repository)
    ]);
    // テスト対象を取得
    final eventHandler = container.read(detailEventHandlerProvider);
    // テスト対象メソッドを呼び出し
    await eventHandler.onClickFavorite("flutter_architecture_sample", true);
    verifyInOrder(
        [repository.setFavorite("flutter_architecture_sample", true)]);
  });
}