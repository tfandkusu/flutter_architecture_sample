import 'package:flutter_architecture_sample/data/repository/github_repo_repository.dart';
import 'package:flutter_architecture_sample/feature/detail/viewmodel/detail_ui_model_state_notifier.dart';
import 'package:flutter_architecture_sample/model/github_repo.dart';

/// 詳細画面のイベント処理担当クラス
class DetailEventHandler {
  /// 詳細画面の状態を更新する担当
  final DetailUiModelStateNotifier _stateNotifier;

  /// Repository層を操作する担当
  final GithubRepoRepository _repository;

  DetailEventHandler(this._stateNotifier, this._repository);

  /// 画面が開かれた時に呼ばれる
  Future<void> onCreate(GithubRepo repo) async {
    final readme = await _repository.getReadme(repo);
    _stateNotifier.setReadme(readme);
  }

  /// 再読込ボタンが押されたときに呼ばれる
  Future<void> onClickReload() async {}

  /// 「いいね」ボタンが押されたときに呼ばれる
  ///
  /// [githubRepoName] 「いいね」が押されたGitHubリポジトリの名前
  /// [favorite] 「いいね」を付ける時はtrue、消すときはfalse。
  Future<void> onClickFavorite(String githubRepoName, bool favorite) async {
    await _repository.setFavorite(githubRepoName, favorite);
  }
}
