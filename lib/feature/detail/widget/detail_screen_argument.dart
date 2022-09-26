import 'package:freezed_annotation/freezed_annotation.dart';
part 'detail_screen_argument.freezed.dart';

@freezed
class DetailScreenArgument with _$DetailScreenArgument {
  /// 詳細画面呼び出しパラメータ
  ///
  /// [id] GitHubのリポジトリのID
  const factory DetailScreenArgument({required int id}) = _DetailScreenArgument;
}
