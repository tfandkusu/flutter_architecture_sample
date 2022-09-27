import 'package:flutter_architecture_sample/data/repository/github_repo_list_state_notifier_provder.dart';
import 'package:flutter_architecture_sample/screen/detail/viewmodel/detail_ui_model_state_notifier_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'detail_ui_model.dart';

/// 詳細画面の状態を提供するProvider
final detailUiModelProvider =
    Provider.autoDispose.family<DetailUiModel, int>((ref, id) {
  final uiModel = ref.watch(detailUiModelStateNotifierProvider);
  // Repository層のGitHubリポジトリ一覧を取得する
  final repos = ref.watch(githubRepoListStateNotifierProvider);
  // そこからidが一致するGitHubリポジトリを取得する
  final repo = repos.firstWhere((repo) => repo.id == id);
  // それを画面状態に設定する
  return uiModel.copyWith(repo: repo);
});
