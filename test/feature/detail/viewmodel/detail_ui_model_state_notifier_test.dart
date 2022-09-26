import 'package:flutter_architecture_sample/feature/detail/viewmodel/detail_ui_model.dart';
import 'package:flutter_architecture_sample/feature/detail/viewmodel/detail_ui_model_state_notifier_provider.dart';
import 'package:flutter_architecture_sample/model/github_repo.dart';
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
    final initialState = DetailUiModel(
        progress: true,
        repo: GithubRepo(
            id: 0,
            name: "",
            description: "",
            updatedAt: DateTime.utc(1970),
            language: "",
            htmlUrl: "",
            fork: false,
            defaultBranch: "",
            favorite: false),
        readme: "",
        networkError: false,
        serverError: false);
    expect(getState(), initialState);
    // README.mdのマークダウン文字列を設定
    const readme = "# flutter_architecture_sample";
    stateNotifier.setReadme(readme);
    expect(getState(), initialState.copyWith(progress: false, readme: readme));
  });
}
