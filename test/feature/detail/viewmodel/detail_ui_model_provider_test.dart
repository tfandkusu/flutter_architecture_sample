import 'package:flutter_architecture_sample/catalog/github_repo_catalog.dart';
import 'package:flutter_architecture_sample/data/repository/github_repo_list_state_notifier.dart';
import 'package:flutter_architecture_sample/data/repository/github_repo_list_state_notifier_provder.dart';
import 'package:flutter_architecture_sample/feature/detail/viewmodel/detail_ui_model.dart';
import 'package:flutter_architecture_sample/feature/detail/viewmodel/detail_ui_model_provider.dart';
import 'package:flutter_architecture_sample/feature/detail/viewmodel/detail_ui_model_state_notifier.dart';
import 'package:flutter_architecture_sample/feature/detail/viewmodel/detail_ui_model_state_notifier_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  test("detailUiModelProvider", () async {
    final repos = getGithubRepoCatalog();
    final container = ProviderContainer(overrides: [
      detailUiModelStateNotifierProvider.overrideWithValue(
          DetailUiModelStateNotifier.override(DetailUiModel(
              progress: false, repo: getEmptyGithubRepo(), readme: ""))),
      githubRepoListStateNotifierProvider
          .overrideWithValue(GithubRepoListStateNotifier.override(repos))
    ]);
    // Repository層StateNotifierの値と合成された後の状態を取得する
    final uiModel = container.read(detailUiModelProvider(229475311));
    // 状態の正しさを確認する
    expect(uiModel, DetailUiModel(progress: false, repo: repos[0], readme: ""));
  });
}
