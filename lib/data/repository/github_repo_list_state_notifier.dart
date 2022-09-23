import 'package:flutter_architecture_sample/model/github_repo.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// GitHubリポジトリ一覧のStateNotifier
class GithubRepoListStateNotifier extends StateNotifier<List<GithubRepo>> {
  GithubRepoListStateNotifier() : super([]);

  /// 読み込んだGithubリポジトリ一覧を設定する
  void setList(List<GithubRepo> list) {
    state = list;
  }

  /// 「いいね」を更新する
  ///
  /// [name] GitHubリポジトリの名前
  /// [favorite] trueの場合は「いいね」を付ける。falseの場合は消す
  void setFavorite(String name, bool favorite) {
    state = state.map((repo) {
      if (repo.name == name) {
        // 更新対象の場合はfavoriteフィールドだけ変更してコピーしたものを返却する
        return repo.copyWith(favorite: favorite);
      } else {
        // 更新対象でないときは、そのまま返却する
        return repo;
      }
    }).toList();
  }
}
