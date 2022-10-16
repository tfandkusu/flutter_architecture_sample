import 'package:flutter_architecture_sample/screen/common/stateholder/error_ui_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'detail_body_ui_model.freezed.dart';

@freezed
class DetailBodyUiModel with _$DetailBodyUiModel {
  /// 詳細画面のreadme.md部分の状態
  ///
  /// [progress] readme読み込み中表示
  /// [readme] readme.mdの文字列
  /// [error] エラー状態
  const factory DetailBodyUiModel(
      {required bool progress,
      required String readme,
      required ErrorUiModel error}) = _DetailBodyUiModel;
}
