import 'package:flutter_architecture_sample/data/repository/github_repo_list_state_notifier.dart';
import 'package:flutter_architecture_sample/data/repository/github_repo_list_state_notifier_provder.dart';
import 'package:flutter_architecture_sample/screen/common/viewmodel/error_ui_model.dart';
import 'package:flutter_architecture_sample/screen/home/viewmodel/home_ui_model.dart';
import 'package:flutter_architecture_sample/screen/home/viewmodel/home_ui_model_provider.dart';
import 'package:flutter_architecture_sample/screen/home/viewmodel/home_ui_model_state_notifier.dart';
import 'package:flutter_architecture_sample/screen/home/viewmodel/home_ui_model_state_notifier_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_architecture_sample/catalog/github_repo_catalog.dart';

void main() {
  test("homeUiModelProvider", () async {
    final repos = getGithubRepoCatalog();
    // StateNotifierを差し替える
    final container = ProviderContainer(overrides: [
      homeUiModelStateNotifierProvider.overrideWithValue(
          HomeUiModelStateNotifier.override(const HomeUiModel(
              progress: false, repos: [], error: ErrorUiModel.noError()))),
      githubRepoListStateNotifierProvider
          .overrideWithValue(GithubRepoListStateNotifier.override(repos))
    ]);
    // Repository層StateNotifierの値と合成された後の状態を取得する
    final uiModel = container.read(homeUiModelProvider);
    // 状態の正しさを確認する
    expect(
        uiModel,
        HomeUiModel(
            progress: false,
            repos: repos,
            error: const ErrorUiModel.noError()));
  });
}
