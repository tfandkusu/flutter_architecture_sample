import 'package:freezed_annotation/freezed_annotation.dart';

part 'github_repo_list_response_item.g.dart';

/// GitHubのREST APIから取得できるリポジトリの情報
///
/// [id] GitHubのリポジトリのID
/// [name] リポジトリ名
/// [description] 説明文
/// [updatedAt] 更新日時
/// [language] プログラミング言語
/// [htmlUrl] ブラウザで開くときのURL
/// [fork] フォークされたリポジトリであるフラグ
@JsonSerializable()
class GithubRepoListResponseItem {
  int id;
  String name;
  String? description;
  @JsonKey(name: "updated_at")
  String updatedAt;
  String? language;
  @JsonKey(name: "html_url")
  String htmlUrl;
  bool fork;

  GithubRepoListResponseItem(
      {required this.id,
      required this.name,
      this.description,
      required this.updatedAt,
      this.language,
      required this.htmlUrl,
      required this.fork});

  factory GithubRepoListResponseItem.fromJson(Map<String, dynamic> json) =>
      _$GithubRepoListResponseItemFromJson(json);

  Map<String, dynamic> toJson() => _$GithubRepoListResponseItemToJson(this);
}
