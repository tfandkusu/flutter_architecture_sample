import 'package:flutter_architecture_sample/model/github_repo.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_ui_model.freezed.dart';

@freezed
class HomeUiModel with _$HomeUiModel {
  /// ホーム画面の状態
  /// [progress] 読み込み中表示
  /// [repos] GitHubリポジトリ一覧
  /// [networkError] ネットワークエラー
  /// [serverError] サーバエラー
  const factory HomeUiModel(
      {required bool progress,
      required List<GithubRepo> repos,
      required bool networkError,
      required bool serverError}) = _HomeUiModel;
}
