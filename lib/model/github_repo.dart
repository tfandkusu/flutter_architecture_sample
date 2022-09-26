import 'package:freezed_annotation/freezed_annotation.dart';

part 'github_repo.freezed.dart';

@freezed
class GithubRepo with _$GithubRepo {
  /// GitHubのリポジトリと、いいねを付けたフラグ
  ///
  /// [id] GitHubのリポジトリのID
  /// [name] リポジトリ名
  /// [description] 説明文
  /// [updatedAt] 更新日時
  /// [language] プログラミング言語
  /// [htmlUrl] ブラウザで開くときのURL
  /// [fork] フォークされたリポジトリであるフラグ
  /// [defaultBranch] デフォルトブランチ(mainまたはmaster)
  /// [favorite] いいねを付けたフラグ
  const factory GithubRepo(
      {required int id,
      required String name,
      required String description,
      required DateTime updatedAt,
      required String language,
      required String htmlUrl,
      required bool fork,
      required String defaultBranch,
      required bool favorite}) = _GithubRepo;
}
