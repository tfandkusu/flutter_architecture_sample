import 'package:flutter_architecture_sample/catalog/github_repo_catalog.dart';
import 'package:flutter_architecture_sample/feature/detail/viewmodel/detail_ui_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DetailUiModelStateNotifier extends StateNotifier<DetailUiModel> {
  DetailUiModelStateNotifier()
      : super(DetailUiModel(
            progress: true, repo: getEmptyGithubRepo(), readme: ""));

  /// 単体テスト向けに状態を設定して作成する
  ///
  /// [homeUiModel] 単体テスト向けの状態
  DetailUiModelStateNotifier.override(DetailUiModel uiModel) : super(uiModel);

  /// readme.mdのマークダウンを設定する
  ///
  /// [readme] マークダウン文字列
  void setReadme(String readme) {
    state = state.copyWith(progress: false, readme: readme);
  }
}
