import 'package:flutter_architecture_sample/data/repository/github_repo_repository.dart';
import 'package:flutter_architecture_sample/feature/home/home_ui_model_state_notifier.dart';
import 'package:flutter_architecture_sample/model/error/api_exceptions.dart';

class HomeEventHandler {
  final HomeUiModelStateNotifier _stateNotifier;

  final GithubRepoRepository _repository;

  HomeEventHandler(this._stateNotifier, this._repository);

  /// 画面が作られた時、または再読込ボタンが押されたときに呼ばれる
  Future<void> load() async {
    try {
      _stateNotifier.onLoadStart();
      await _repository.fetch();
      _stateNotifier.onLoadSuccess();
    } on NetworkErrorException catch (_) {
      _stateNotifier.onNetworkError();
    } on ServerErrorException catch (_) {
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
