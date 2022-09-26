import 'package:freezed_annotation/freezed_annotation.dart';
part 'detail_screen_argument.freezed.dart';

/// 詳細画面を
@freezed
class DetailScreenArgument with _$DetailScreenArgument {
  ///
  /// [id] GitHubのリポジトリのID
  const factory DetailScreenArgument({required int id}) = _DetailScreenArgument;
}
