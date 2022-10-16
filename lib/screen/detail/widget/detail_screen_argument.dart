import 'package:freezed_annotation/freezed_annotation.dart';
part 'detail_screen_argument.freezed.dart';

@freezed
class DetailScreenArgument with _$DetailScreenArgument {
  /// 詳細画面呼び出しパラメータ
  ///
  /// [id] GitHubのリポジトリのID
  /// [name] GitHubのリポジトリ名
  /// [defaultBranch] GitHubリポジトリのデフォルトブランチ
  const factory DetailScreenArgument(
      {required int id,
      required String name,
      required String defaultBranch}) = _DetailScreenArgument;
}
