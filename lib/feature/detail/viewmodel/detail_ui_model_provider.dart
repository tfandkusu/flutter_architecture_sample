import 'package:flutter_architecture_sample/data/repository/github_repo_list_state_notifier_provder.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'detail_ui_model.dart';

/// 詳細画面の状態を提供するProvider
final detailUiModelProvider = Provider.family<DetailUiModel, int>((ref, id) {
  // Repository層のGitHubリポジトリ一覧を取得する
  final repos = ref.watch(githubRepoListStateNotifierProvider);
  final repo = repos.firstWhere((repo) => repo.id == id);
  // Repository層のGitHubリポジトリ一覧を設定して返却する
  return DetailUiModel(
      progress: false,
      repo: repo,
      readme: "",
      networkError: false,
      serverError: false);
});
