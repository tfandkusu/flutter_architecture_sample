import 'package:flutter_architecture_sample/data/remote/github_repo_remote_data_store_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  test("GithubRepoRemoteDataStore", () async {
    final container = ProviderContainer();
    final remoteDataStore = container.read(githubRepoRemoteDataStoreProvider);
    final repoList = await remoteDataStore.getGitHubRepoList();
    expect(repoList.length, greaterThan(30));
    final repo =
        repoList.firstWhere((repo) => repo.name == 'try_graphql_android');
    expect(repo.id, 446192239);
    expect(repo.name, 'try_graphql_android');
    expect(repo.description.length, greaterThanOrEqualTo(1));
    expect(repo.updatedAt,
        greaterThanOrEqualTo(DateTime.parse('2022-01-10T19:33:46Z')));
    expect(repo.language, 'Kotlin');
    expect(repo.htmlUrl, 'https://github.com/tfandkusu/try_graphql_android');
    expect(repo.fork, false);
    expect(repo.favorite, false);
  });
}
