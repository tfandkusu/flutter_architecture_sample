import 'package:flutter_architecture_sample/data/repository/github_repo_repository.dart';
import 'package:flutter_architecture_sample/feature/home/home_ui_model_state_notifier.dart';
import 'package:flutter_architecture_sample/model/error/api_exceptions.dart';

/// ホーム画面のイベント処理担当クラス
class HomeEventHandler {
  /// ホーム画面の状態を更新する担当
  final HomeUiModelStateNotifier _stateNotifier;

  /// Repository層を操作する担当
  final GithubRepoRepository _repository;

  HomeEventHandler(this._stateNotifier, this._repository);

  /// 画面が作られた時、または再読込ボタンが押されたときに呼ばれる
  Future<void> load() async {
    try {
      // 読み込み開始
      _stateNotifier.onLoadStart();
      // フェッチ処理
      await _repository.fetch();
      // 処理成功
      _stateNotifier.onLoadSuccess();
    } on NetworkErrorException catch (_) {
      // ネットワークエラー
      _stateNotifier.onNetworkError();
    } on ServerErrorException catch (_) {
      // サーバエラー
      _stateNotifier.onServerError();
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
