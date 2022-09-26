import 'package:flutter_architecture_sample/data/repository/github_repo_repository_provider.dart';
import 'package:flutter_architecture_sample/feature/detail/viewmodel/detail_event_handler.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final detailEventHandlerProvider = Provider((ref) {
  final repository = ref.read(githubRepoRepositoryProvider);
  return DetailEventHandler(repository);
});
