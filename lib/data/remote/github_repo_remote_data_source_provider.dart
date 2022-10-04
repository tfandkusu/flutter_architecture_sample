import 'package:flutter_architecture_sample/data/remote/api/github_api_client_provider.dart';
import 'package:flutter_architecture_sample/data/remote/github_repo_remote_data_source.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// シングルトンなGithubRepoRemoteDataSourceのインスタンスを取得する
final githubRepoRemoteDataSourceProvider = Provider((ref) {
  final client = ref.read(githubApiClientProvider);
  return GithubRepoRemoteDataSource(client);
});
