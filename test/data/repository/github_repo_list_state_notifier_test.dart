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
    // 初期状態は空のリストがstateに設定されている
    expect(getState(), <GithubRepo>[]);
    // リポジトリ一覧を設定
    final list = getGithubRepoCatalog();
    stateNotifier.setList(list);
    // 設定したGithubRepoのリストがstateに設定されている
    expect(getState(), list);
    // 「いいね」を更新
    stateNotifier.setFavorite("observe_room", true);
    // 対象のGithubRepoのfavoriteフィールドだけがtrueになっている
    expect(getState()[0].favorite, true);
    expect(getState()[1].favorite, false);
    expect(getState()[2].favorite, false);
  });
}
