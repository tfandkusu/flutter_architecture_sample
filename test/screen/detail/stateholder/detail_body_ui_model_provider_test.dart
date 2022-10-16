import 'package:flutter_architecture_sample/catalog/github_repo_catalog.dart';
import 'package:flutter_architecture_sample/screen/common/stateholder/error_ui_model.dart';
import 'package:flutter_architecture_sample/screen/detail/stateholder/detail_body_ui_model.dart';
import 'package:flutter_architecture_sample/screen/detail/stateholder/detail_body_ui_model_provider.dart';
import 'package:flutter_architecture_sample/screen/detail/stateholder/detail_ui_model.dart';
import 'package:flutter_architecture_sample/screen/detail/stateholder/detail_ui_model_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final mockDetailUiModelProvider =
    Provider.autoDispose.family<DetailUiModel, int>((ref, id) {
  final repo = getGithubRepoCatalog()[0];
  return DetailUiModel(
      progress: false,
      repo: repo,
      readme: "# observe_room",
      error: const ErrorUiModel.noError());
});

void main() {
  test("detailBodyUiModelProvider", () async {
    final repo = getGithubRepoCatalog()[0];
    final container = ProviderContainer(overrides: [
      detailUiModelProvider.overrideWithProvider(
          (argument) => mockDetailUiModelProvider(repo.id))
    ]);
    final uiModel = container.read(detailBodyUiModelProvider(repo.id));
    expect(
        uiModel,
        const DetailBodyUiModel(
            progress: false,
            readme: "# observe_room",
            error: ErrorUiModel.noError()));
  });
}
