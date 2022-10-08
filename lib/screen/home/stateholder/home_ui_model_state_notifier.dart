import 'package:flutter_architecture_sample/screen/common/stateholder/error_ui_model.dart';
import 'package:flutter_architecture_sample/screen/home/stateholder/home_ui_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// ホーム画面状態のStateNotifier
class HomeUiModelStateNotifier extends StateNotifier<HomeUiModel> {
  HomeUiModelStateNotifier()
      : super(const HomeUiModel(
            progress: true, repos: [], error: ErrorUiModel.noError()));

  /// 単体テスト向けに状態を設定して作成する
  ///
  /// [homeUiModel] 単体テスト向けの状態
  HomeUiModelStateNotifier.override(HomeUiModel uiModel) : super(uiModel);

  /// リロードするときに呼ばれる
  void onReload() {
    state = state.copyWith(progress: true, error: const ErrorUiModel.noError());
  }

  /// 読み込みが成功したときに呼ばれる
  void onLoadSuccess() {
    state = state.copyWith(progress: false);
  }

  /// エラーの時に呼ばれる
  ///
  /// [error] エラー情報
  void onMyError(ErrorUiModel error) {
    state = state.copyWith(progress: false, error: error);
  }
}
