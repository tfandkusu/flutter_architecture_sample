import 'package:flutter_architecture_sample/data/repository/github_repo_list_state_notifier.dart';
import 'package:flutter_architecture_sample/model/github_repo.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final githubRepoListStateNotifierProvider =
    StateNotifierProvider<GithubRepoListStateNotifier, List<GithubRepo>>(
        (ref) => GithubRepoListStateNotifier());
