import 'package:flutter_architecture_sample/data/remote/github_repo_remote_data_source_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// GithubRepoRemoteDataSourceのテスト
void main() {
  test("GithubRepoRemoteDataSource", () async {
    final container = ProviderContainer();
    final remoteDataSource = container.read(githubRepoRemoteDataSourceProvider);
    // 実際のAPIにアクセスする
    final repoList = await remoteDataSource.getGithubRepoList();
    // GitHub側の変化を想定したチェック項目にする
    // 31件以上リポジトリが取れる
    expect(repoList.length, greaterThan(30));
    // try_graphql_androidが取得できる
    final repo =
        repoList.firstWhere((repo) => repo.name == 'try_graphql_android');
    expect(repo.id, 446192239);
    expect(repo.name, 'try_graphql_android');
    expect(repo.description.length, greaterThanOrEqualTo(1));
    // 更新日時が2022年1月10日以降
    expect(repo.updatedAt,
        greaterThanOrEqualTo(DateTime.parse('2022-01-10T19:33:46Z')));
    expect(repo.language, 'Kotlin');
    expect(repo.fork, false);
    expect(repo.defaultBranch, "main");
    expect(repo.favorite, false);
  });
}
