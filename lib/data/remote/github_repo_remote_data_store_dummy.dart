import 'package:flutter_architecture_sample/catalog/github_repo_catalog.dart';
import 'package:flutter_architecture_sample/model/github_repo.dart';

import 'github_repo_remote_data_store.dart';

/// APIからGitHubの情報を取ってくる担当
///
/// [client] Retrofit for Dartで作成したAPIクライアント
class GitHubRepoRemoteDataStoreDummy implements GitHubRepoRemoteDataStore {
  /// ユーザtfandkusuの公開GitHubリポジトリ一覧を取得する
  @override
  Future<List<GithubRepo>> getGitHubRepoList() async {
    await Future.delayed(const Duration(seconds: 2));
    return getGithubRepoCatalog();
  }
}
