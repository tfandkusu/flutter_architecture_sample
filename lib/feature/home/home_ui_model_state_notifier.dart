import 'package:flutter_architecture_sample/feature/home/home_ui_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeUiModelStateNotifier extends StateNotifier<HomeUiModel> {
  HomeUiModelStateNotifier()
      : super(const HomeUiModel(
            progress: true,
            repos: [],
            networkError: false,
            serverError: false));

  void onLoadStart() {
    state =
        state.copyWith(progress: true, networkError: false, serverError: false);
  }

  void onLoadSuccess() {
    state = state.copyWith(progress: false);
  }

  void onNetworkError() {
    state = state.copyWith(progress: false, networkError: true);
  }

  void onServerError() {
    state = state.copyWith(progress: false, serverError: true);
  }
}
