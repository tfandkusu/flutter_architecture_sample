import 'package:flutter_architecture_sample/data/local/favorite_local_data_store_provider.dart';
import 'package:flutter_architecture_sample/data/remote/github_repo_remote_data_store_provider.dart';
import 'package:flutter_architecture_sample/data/remote/markdown_remote_data_store_provider.dart';
import 'package:flutter_architecture_sample/data/repository/github_repo_list_state_notifier_provder.dart';
import 'package:flutter_architecture_sample/data/repository/github_repo_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// GithubRepoRepositoryを作成して提供するProvider
final githubRepoRepositoryProvider = Provider((ref) {
  final remoteDataStore = ref.read(githubRepoRemoteDataStoreProvider);
  final markdownRemoteDataStore = ref.read(markdownRemoteDataStoreProvider);
  final favoriteLocalDataStore = ref.read(favoriteLocalDataStoreProvider);
  final stateNotifier = ref.read(githubRepoListStateNotifierProvider.notifier);
  return GithubRepoRepository(remoteDataStore, markdownRemoteDataStore,
      favoriteLocalDataStore, stateNotifier);
});
