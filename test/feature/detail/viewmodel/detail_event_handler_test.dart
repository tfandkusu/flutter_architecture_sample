import 'package:flutter_architecture_sample/data/repository/github_repo_repository.dart';
import 'package:flutter_architecture_sample/data/repository/github_repo_repository_provider.dart';
import 'package:flutter_architecture_sample/feature/home/viewmodel/home_event_handler_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'detail_event_handler_test.mocks.dart';

// モック実装をMockitoに作らせる設定
@GenerateNiceMocks([MockSpec<GithubRepoRepository>()])
void main() {
  // 「いいね」ボタンが押された
  test("DetailEventHandler#onClickFavorite", () async {
    // 依存するインスタンスのモック実装を作成する
    final repository = MockGithubRepoRepository();
    final container = ProviderContainer(overrides: [
      githubRepoRepositoryProvider.overrideWithValue(repository)
    ]);
    // テスト対象を取得
    final eventHandler = container.read(homeEventHandlerProvider);
    // テスト対象メソッドを呼び出し
    await eventHandler.onClickFavorite("flutter_architecture_sample", true);
    verifyInOrder(
        [repository.setFavorite("flutter_architecture_sample", true)]);
  });
}
