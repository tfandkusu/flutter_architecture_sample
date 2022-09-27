import 'package:flutter_architecture_sample/catalog/github_repo_catalog.dart';
import 'package:flutter_architecture_sample/screen/common/viewmodel/error_ui_model.dart';
import 'package:flutter_architecture_sample/screen/detail/viewmodel/detail_ui_model.dart';
import 'package:flutter_architecture_sample/screen/detail/viewmodel/detail_ui_model_state_notifier_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// DetailUiModelStateNotifierのテスト
void main() {
  test("DetailUiModelStateNotifier", () async {
    final container = ProviderContainer();
    // テスト対象StateNotifierの取得
    final stateNotifier =
        container.read(detailUiModelStateNotifierProvider.notifier);
    // 現在のStateNotifierのstateを取得するメソッド
    getState() => container.read(detailUiModelStateNotifierProvider);
    // 初期値を確認
    final repo = getEmptyGithubRepo();
    final initialState = DetailUiModel(
        progress: true,
        repo: repo,
        readme: "",
        error: const ErrorUiModel.noError());
    expect(getState(), initialState);
    // 読み込み失敗時の状態変化を確認
    stateNotifier.onMyError(const ErrorUiModel.network());
    expect(
        getState(),
        initialState.copyWith(
            progress: false,
            repo: repo,
            readme: "",
            error: const ErrorUiModel.network()));
    // 再読込の時の状態変化を確認
    stateNotifier.onReload();
    expect(
        getState(),
        initialState.copyWith(
            progress: true,
            repo: repo,
            readme: "",
            error: const ErrorUiModel.noError()));
    // 読み込み成功時の状態変化を確認
    const readme = "# flutter_architecture_sample";
    stateNotifier.onLoadSuccess(readme);
    expect(
        getState(),
        initialState.copyWith(
            progress: false,
            repo: repo,
            readme: readme,
            error: const ErrorUiModel.noError()));
  });
}
