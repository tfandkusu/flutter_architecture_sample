import 'package:flutter_architecture_sample/data/repository/github_repo_list_state_notifier_provder.dart';
import 'package:flutter_architecture_sample/feature/home/viewmodel/home_ui_model_state_notifier_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// ホーム画面の状態を提供するProvider
final homeUiModelProvider = Provider((ref) {
  // Repository層のGitHubリポジトリ一覧を取得する
  final repos = ref.watch(githubRepoListStateNotifierProvider);
  // 現在のユーザ操作によるホーム画面の状態を取得する
  final homeUiModel = ref.watch(homeUiModelStateNotifierProvider);
  // Repository層のGitHubリポジトリ一覧を設定して返却する
  return homeUiModel.copyWith(repos: repos);
});
