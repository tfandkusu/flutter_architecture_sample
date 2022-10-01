import 'package:flutter_architecture_sample/catalog/github_repo_catalog.dart';
import 'package:flutter_architecture_sample/model/github_repo.dart';

import 'github_repo_remote_data_source.dart';

/// APIからGitHubの情報を取ってくる担当の開発中のダミー実装
class GitHubRepoRemoteDataSourceDummy implements GitHubRepoRemoteDataSource {
  @override
  Future<List<GithubRepo>> getGitHubRepoList() async {
    // プログレス表示の確認のために2秒待つ
    await Future.delayed(const Duration(seconds: 2));
    // throw NetworkErrorException();
    return getGithubRepoCatalog();
  }
}
