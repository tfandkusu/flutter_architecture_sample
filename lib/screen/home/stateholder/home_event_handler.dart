import 'package:flutter_architecture_sample/data/repository/github_repo_repository.dart';
import 'package:flutter_architecture_sample/model/github_repo.dart';
import 'package:flutter_architecture_sample/screen/common/stateholder/map_error.dart';
import 'package:flutter_architecture_sample/screen/home/stateholder/home_ui_model_state_notifier.dart';
import 'package:flutter_architecture_sample/util/fa.dart';

/// ホーム画面のイベント処理担当クラス
class HomeEventHandler {
  /// ホーム画面の状態を更新する担当
  final HomeUiModelStateNotifier _stateNotifier;

  /// Repositoryを操作する担当
  final GithubRepoRepository _repository;

  /// Firebase Analyticsのトラッキング情報を送信する担当
  final FA fa;

  HomeEventHandler(this._stateNotifier, this._repository, this.fa);

  /// 画面が開かれた時に呼ばれる
  Future<void> onCreate() async {
    // 読み込み処理
    _load();
  }

  /// 再読込ボタンが押されたときに呼ばれる
  Future<void> onClickReload() async {
    // エラー表示を消す
    _stateNotifier.onReload();
    // 読み込み処理
    _load();
  }

  /// GitHubリポジトリ項目がクリックされたときに呼ばれる
  void onClickRepo(GithubRepo repo) {
    // トラッキング情報を送る
    fa.send("callDetailScreen", {"name": repo.name});
    // 詳細画面を呼び出す
    _stateNotifier.callDetailScreen(repo);
  }

  /// 詳細画面の呼び出しが完了したときに呼ばれる
  void onDetailScreenCalled() {
    _stateNotifier.onDetailScreenCalled();
  }

  /// 読み込み処理
  Future<void> _load() async {
    try {
      // フェッチ処理
      await _repository.fetch();
      // 処理成功
      _stateNotifier.onLoadSuccess();
    } on Exception catch (e) {
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
