import 'package:flutter_architecture_sample/data/repository/github_repo_repository.dart';
import 'package:flutter_architecture_sample/model/github_repo.dart';
import 'package:flutter_architecture_sample/screen/common/viewmodel/map_error.dart';
import 'package:flutter_architecture_sample/screen/detail/viewmodel/detail_ui_model_state_notifier.dart';

/// 詳細画面のイベント処理担当クラス
class DetailEventHandler {
  /// 詳細画面の状態を更新する担当
  final DetailUiModelStateNotifier _stateNotifier;

  /// Repository層を操作する担当
  final GithubRepoRepository _repository;

  DetailEventHandler(this._stateNotifier, this._repository);

  /// 画面が開かれた時に呼ばれる
  ///
  /// [repo] 対象GitHubリポジトリ
  Future<void> onCreate(GithubRepo repo) async {
    await _load(repo);
  }

  /// 再読込ボタンが押されたときに呼ばれる
  ///
  /// [repo] 対象GitHubリポジトリ
  Future<void> onClickReload(GithubRepo repo) async {
    _stateNotifier.onReload();
    _load(repo);
  }

  /// 読み込み処理
  ///
  /// [repo] 対象GitHubリポジトリ
  Future<void> _load(GithubRepo repo) async {
    try {
      final readme = await _repository.getReadme(repo);
      // 成功ケース
      _stateNotifier.onLoadSuccess(readme);
    } on Exception catch (e) {
      // ネットワークエラーなどの失敗ケース
      _stateNotifier.onMyError(mapError(e));
    }
  }

  /// 「いいね」ボタンが押されたときに呼ばれる
  ///
  /// [githubRepoName] 「いいね」が押されたGitHubリポジトリの名前
  /// [favorite] 「いいね」を付ける時はtrue、消すときはfalse。
  Future<void> onClickFavorite(String githubRepoName, bool favorite) async {
    await _repository.setFavorite(githubRepoName, favorite);
  }
}
