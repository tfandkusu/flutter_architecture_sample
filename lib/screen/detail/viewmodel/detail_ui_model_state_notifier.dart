import 'package:flutter_architecture_sample/catalog/github_repo_catalog.dart';
import 'package:flutter_architecture_sample/screen/common/viewmodel/error_ui_model.dart';
import 'package:flutter_architecture_sample/screen/detail/viewmodel/detail_ui_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// 詳細画面状態のStateNotifier
class DetailUiModelStateNotifier extends StateNotifier<DetailUiModel> {
  DetailUiModelStateNotifier()
      : super(DetailUiModel(
            progress: true,
            repo: getEmptyGithubRepo(),
            readme: "",
            error: const ErrorUiModel.noError()));

  /// 単体テスト向けに状態を設定して作成する
  ///
  /// [homeUiModel] 単体テスト向けの状態
  DetailUiModelStateNotifier.override(DetailUiModel uiModel) : super(uiModel);

  /// README.mdのマークダウン文字列を設定する
  ///
  /// [readme] README.mdのマークダウン文字列
  void onLoadSuccess(String readme) {
    state = state.copyWith(progress: false, readme: readme);
  }

  /// リロードが開始された時の状態変化
  void onReload() {
    state = state.copyWith(progress: true, error: const ErrorUiModel.noError());
  }

  /// エラーが発生した
  ///
  /// [error] エラー情報
  void onMyError(ErrorUiModel error) {
    state = state.copyWith(progress: false, error: error);
  }
}
