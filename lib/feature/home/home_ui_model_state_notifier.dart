import 'package:flutter_architecture_sample/feature/home/home_ui_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeUiModelStateNotifier extends StateNotifier<HomeUiModel> {
  HomeUiModelStateNotifier()
      : super(const HomeUiModel(
            progress: true,
            repos: [],
            networkError: false,
            serverError: false));

  /// 単体テスト向けに状態を設定して作成する
  ///
  /// [homeUiModel] 単体テスト向けの状態
  HomeUiModelStateNotifier.override(HomeUiModel homeUiModel)
      : super(homeUiModel);

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
