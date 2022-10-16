import 'package:flutter_architecture_sample/data/repository/github_repo_repository.dart';
import 'package:flutter_architecture_sample/screen/common/stateholder/map_error.dart';
import 'package:flutter_architecture_sample/screen/detail/stateholder/detail_ui_model_state_notifier.dart';

/// 詳細画面のイベント処理担当クラス
class DetailEventHandler {
  /// 詳細画面の状態を更新する担当
  final DetailUiModelStateNotifier _stateNotifier;

  /// Repository層を操作する担当
  final GithubRepoRepository _repository;

  DetailEventHandler(this._stateNotifier, this._repository);

  /// 画面が開かれた時に呼ばれる
  ///
  /// [name] 対象GitHubリポジトリ名
  /// [defaultBranch] 対象GitHubリポジトリのデフォルトブランチ
  Future<void> onCreate(String name, String defaultBranch) async {
    await _load(name, defaultBranch);
  }

  /// 再読込ボタンが押されたときに呼ばれる
  ///
  /// [name] 対象GitHubリポジトリ名
  /// [defaultBranch] 対象GitHubリポジトリのデフォルトブランチ
  Future<void> onClickReload(String name, String defaultBranch) async {
    _stateNotifier.onReload();
    await _load(name, defaultBranch);
  }

  /// 読み込み処理
  ///
  /// [name] Githubリポジトリ名
  /// [defaultBranch] デフォルトブランチ
  Future<void> _load(String name, String defaultBranch) async {
    try {
      final readme = await _repository.getReadme(name, defaultBranch);
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
