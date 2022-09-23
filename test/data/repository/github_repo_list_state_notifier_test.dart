import 'package:flutter_architecture_sample/data/repository/github_repo_list_state_notifier_provder.dart';
import 'package:flutter_architecture_sample/model/github_repo.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../catalog/github_repo_catalog.dart';

/// GithubRepoListStateNotifierのテスト
void main() {
  test("GithubRepoListStateNotifier", () async {
    final container = ProviderContainer();
    // テスト対象StateNotifierの取得
    final stateNotifier =
        container.read(githubRepoListStateNotifierProvider.notifier);
    // 現在のStateNotifierのstateを取得するメソッド
    getState() => container.read(githubRepoListStateNotifierProvider);
    // 初期状態
    expect(getState(), <GithubRepo>[]);
    // リポジトリ一覧を設定
    final list = getGithubRepoCatalog();
    stateNotifier.setList(list);
    expect(getState(), list);
    // 「いいね」を更新
    stateNotifier.setFavorite("observe_room", true);
    final repo = getState()[0];
    expect(repo.favorite, true);
  });
}
