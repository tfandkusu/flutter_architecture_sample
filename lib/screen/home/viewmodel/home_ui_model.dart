import 'package:flutter_architecture_sample/model/github_repo.dart';
import 'package:flutter_architecture_sample/screen/common/viewmodel/error_ui_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_ui_model.freezed.dart';

@freezed
class HomeUiModel with _$HomeUiModel {
  /// ホーム画面の状態
  /// [progress] 読み込み中表示
  /// [repos] GitHubリポジトリ一覧
  /// [error] エラー状態
  const factory HomeUiModel(
      {required bool progress,
      required List<GithubRepo> repos,
      required ErrorUiModel error}) = _HomeUiModel;
}
