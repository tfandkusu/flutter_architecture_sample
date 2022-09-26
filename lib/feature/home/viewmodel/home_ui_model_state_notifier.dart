import 'package:flutter_architecture_sample/feature/home/viewmodel/home_ui_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// ホーム画面状態のStateNotifier
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
  HomeUiModelStateNotifier.override(HomeUiModel uiModel) : super(uiModel);

  /// リロードするときに呼ばれる
  void onReload() {
    state =
        state.copyWith(progress: true, networkError: false, serverError: false);
  }

  /// 読み込みが成功したときに呼ばれる
  void onLoadSuccess() {
    state = state.copyWith(progress: false);
  }

  /// ネットワークエラーの時に呼ばれる
  void onNetworkError() {
    state = state.copyWith(progress: false, networkError: true);
  }

  /// サーバエラーの時に呼ばれる
  void onServerError() {
    state = state.copyWith(progress: false, serverError: true);
  }
}
