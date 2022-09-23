import 'package:flutter_architecture_sample/data/remote/api/github_repo_list_response_item.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'github_api_client.g.dart';

@RestApi(baseUrl: "https://api.github.com/")
abstract class GithubApiClient {
  factory GithubApiClient(Dio dio, {String baseUrl}) = _GithubApiClient;

  @GET("/users/tfandkusu/repos")
  Future<List<GithubRepoListResponseItem>> getGitHubRepoList(
      @Query("page") int page);
}
