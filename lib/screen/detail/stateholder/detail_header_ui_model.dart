import 'package:flutter_architecture_sample/model/github_repo.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'detail_header_ui_model.freezed.dart';

@freezed
class DetailHeaderUiModel with _$DetailHeaderUiModel {
  /// 詳細画面のヘッダー部分の状態
  ///
  /// [repo] GitHubリポジトリ
  const factory DetailHeaderUiModel({required GithubRepo repo}) =
      _DetailHeaderUiModel;
}
