import 'package:flutter_architecture_sample/screen/common/stateholder/error_ui_model.dart';
import 'package:flutter_architecture_sample/screen/home/stateholder/home_ui_model.dart';
import 'package:flutter_architecture_sample/screen/home/stateholder/home_ui_model_state_notifier_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// HomeUiModelStateNotifierのテスト
void main() {
  test("HomeUiModelStateNotifier", () async {
    final container = ProviderContainer();
    // テスト対象StateNotifierの取得
    final stateNotifier =
        container.read(homeUiModelStateNotifierProvider.notifier);
    // 現在のStateNotifierのstateを取得するメソッド
    getState() => container.read(homeUiModelStateNotifierProvider);
    // 初期値を確認
    expect(
        getState(),
        const HomeUiModel(
            progress: true, repos: [], error: ErrorUiModel.noError()));
    // ネットワークエラー
    stateNotifier.onMyError(const ErrorUiModel.network());
    expect(
        getState(),
        const HomeUiModel(
            progress: false, repos: [], error: ErrorUiModel.network()));
    // リロード → 読み込み成功
    stateNotifier.onReload();
    expect(
        getState(),
        const HomeUiModel(
            progress: true, repos: [], error: ErrorUiModel.noError()));
    stateNotifier.onLoadSuccess();
    expect(
        getState(),
        const HomeUiModel(
            progress: false, repos: [], error: ErrorUiModel.noError()));
  });
}
