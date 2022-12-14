import 'package:flutter_architecture_sample/data/local/favorite_local_data_source.dart';
import 'package:flutter_architecture_sample/data/remote/github_repo_remote_data_source.dart';
import 'package:flutter_architecture_sample/data/remote/markdown_remote_data_source.dart';
import 'package:flutter_architecture_sample/data/repository/github_repo_list_state_notifier.dart';
import 'package:flutter_architecture_sample/model/error/api_exceptions.dart';

/// データ層を代表してアプリに表示するGitHubリポジトリ一覧を更新する担当
class GithubRepoRepository {
  /// APIからGitHubの情報を取ってくる担当
  final GithubRepoRemoteDataSource _remoteDataSource;

  /// GitHubからマークダウンテキストを取ってくる担当
  final MarkdownRemoteDataSource _markdownRemoteDataSource;

  /// GitHubリポジトリに対する「いいね」をアプリローカルから読み書きする担当
  final FavoriteLocalDataSource _localDataSource;

  /// Githubリポジトリ一覧をUI層に通知するために保持する担当
  final GithubRepoListStateNotifier _stateNotifier;

  GithubRepoRepository(this._remoteDataSource, this._markdownRemoteDataSource,
      this._localDataSource, this._stateNotifier);

  /// Githubリポジトリ一覧を読み込んでアプリ内に保持する
  Future<void> fetch() async {
    // GitHubリポジトリ一覧をAPIから取得する
    final repoList = await _remoteDataSource.getGithubRepoList();
    // ソートする
    repoList.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
    // 「いいね」を付けたリポジトリ名一覧をローカルから読み込む
    final favoriteRepoNameSet = await _localDataSource.getFavoriteRepoNameSet();
    // 両者を合成する
    final githubRepoListWithFavorite = repoList
        .map((repo) =>
            repo.copyWith(favorite: favoriteRepoNameSet.contains(repo.name)))
        .toList();
    // UI層を更新するためにStateNotifierに設定する
    _stateNotifier.setList(githubRepoListWithFavorite);
  }

  /// いいねを設定する
  /// [name] GitHubリポジトリ名
  /// [favorite] trueの場合は「いいね」を付ける。falseの場合は「いいね」を消す。
  Future<void> setFavorite(String name, bool favorite) async {
    // UI層を更新するためにStateNotifierに設定する
    _stateNotifier.setFavorite(name, favorite);
    // アプリローカルのデータを更新する
    await _localDataSource.setFavorite(name, favorite);
  }

  /// README.mdをダウンロードする
  ///
  /// [name] GitHubリポジトリ名
  /// [defaultBranch] GitHubリポジトリのデフォルトブランチ
  Future<String> getReadme(String name, String defaultBranch) async {
    // README.mdが無ければreadme.mdをダウンロードする。
    final paths = [
      "/README.md",
      "/readme.md",
    ];
    for (final path in paths) {
      try {
        return await _markdownRemoteDataSource.getMarkdown(
            name, defaultBranch, path);
      } on NotFoundException catch (_) {
        //
      }
    }
    throw NotFoundException();
  }
}
