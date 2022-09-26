import 'package:flutter_architecture_sample/model/github_repo.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'detail_ui_model.freezed.dart';

@freezed
class DetailUiModel with _$DetailUiModel {
  /// 詳細画面の状態
  /// [progress] readme読み込み中表示
  /// [repo] GitHubリポジトリ
  /// [readme] readme.mdの文字列
  /// [networkError] ネットワークエラー
  /// [serverError] サーバエラー
  const factory DetailUiModel(
      {required bool progress,
      required GithubRepo repo,
      required String readme,
      required bool networkError,
      required bool serverError}) = _DetailUiModel;
}
