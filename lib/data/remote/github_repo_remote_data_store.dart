import 'package:flutter_architecture_sample/data/remote/api/github_api_client.dart';
import 'package:flutter_architecture_sample/model/github_repo.dart';

class GitHubRepoRemoteDataStore {
  final GithubApiClient _client;

  GitHubRepoRemoteDataStore(this._client);

  Future<List<GithubRepo>> getGitHubRepoList() async {
    final allRepos = <GithubRepo>[];
    int page = 1;
    while (true) {
      final responseList = await _client.getGitHubRepoList(page);
      for (final responseItem in responseList) {
        final repo = GithubRepo(
            id: responseItem.id,
            name: responseItem.name,
            description: responseItem.description ?? "",
            updatedAt: DateTime.parse(responseItem.updatedAt),
            language: responseItem.language ?? "",
            htmlUrl: responseItem.htmlUrl,
            fork: responseItem.fork,
            favorite: false);
        allRepos.add(repo);
      }
      if (responseList.isEmpty) {
        break;
      } else {
        ++page;
      }
    }
    return allRepos;
  }
}
