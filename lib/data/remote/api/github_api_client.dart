import 'package:flutter_architecture_sample/data/remote/api/github_repo_list_response_item.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'github_api_client.g.dart';

/// Retrofit For DartによるAPIクライアントの定義
@RestApi(baseUrl: "https://api.github.com/")
abstract class GithubApiClient {
  factory GithubApiClient(Dio dio, {String baseUrl}) = _GithubApiClient;

  /// ユーザtfandkusuの公開GitHubリポジトリ一覧を取得する
  /// [page] ページインデックス。1が最初。
  @GET("/users/tfandkusu/repos")
  Future<List<GithubRepoListResponseItem>> getGitHubRepoList(
      @Query("page") int page);
}
