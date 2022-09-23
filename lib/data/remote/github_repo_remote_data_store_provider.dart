import 'package:flutter_architecture_sample/data/remote/api/github_api_client_provider.dart';
import 'package:flutter_architecture_sample/data/remote/github_repo_remote_data_store.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// シングルトンなGithubRepoRemoteDataStoreのインスタンスを取得する
final githubRepoRemoteDataStoreProvider = Provider((ref) {
  final client = ref.read(githubApiClientProvider);
  return GitHubRepoRemoteDataStore(client);
});
