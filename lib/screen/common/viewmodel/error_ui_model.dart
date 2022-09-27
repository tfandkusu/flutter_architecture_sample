import 'package:freezed_annotation/freezed_annotation.dart';

part 'error_ui_model.freezed.dart';

/// エラー情報
@freezed
class ErrorUiModel with _$ErrorUiModel {
  /// ネットワークエラー
  const factory ErrorUiModel.network() = Network;

  /// リソース無し(ステータスコード404)
  const factory ErrorUiModel.notFound() = NotFound;

  /// サーバエラー
  const factory ErrorUiModel.server() = Server;

  /// 未知エラー
  const factory ErrorUiModel.unknown() = Unknown;
}
