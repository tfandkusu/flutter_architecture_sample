import 'package:flutter_architecture_sample/data/repository/github_repo_repository_provider.dart';
import 'package:flutter_architecture_sample/feature/home/viewmodel/home_ui_model_state_notifier_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'home_event_handler.dart';

final homeEventHandlerProvider = Provider((ref) {
  final stateNotifier = ref.read(homeUiModelStateNotifierProvider.notifier);
  final repository = ref.read(githubRepoRepositoryProvider);
  return HomeEventHandler(stateNotifier, repository);
});
