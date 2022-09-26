import 'package:flutter_architecture_sample/feature/detail/viewmodel/detail_ui_model.dart';
import 'package:flutter_architecture_sample/model/github_repo.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DetailUiModelStateNotifier extends StateNotifier<DetailUiModel> {
  DetailUiModelStateNotifier()
      : super(DetailUiModel(
            progress: true,
            repo: GithubRepo(
                id: 0,
                name: "",
                description: "",
                updatedAt: DateTime.utc(1970),
                language: "",
                htmlUrl: "",
                fork: false,
                defaultBranch: "",
                favorite: false),
            readme: "",
            networkError: false,
            serverError: false));

  /// readme.mdのマークダウンを設定する
  ///
  /// [readme] マークダウン文字列
  void setReadme(String readme) {
    state = state.copyWith(progress: false, readme: readme);
  }
}
