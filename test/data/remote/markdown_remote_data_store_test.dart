import 'package:flutter_architecture_sample/data/remote/markdown_remote_data_store_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// MarkdownRepoRemoteDataStoreのテスト
void main() {
  test("MarkdownRepoRemoteDataStore", () async {
    final container = ProviderContainer();
    final remoteDataStore = container.read(markdownRemoteDataStoreProvider);
    final markdown = await remoteDataStore.getMarkdown(
        "android_app_template", "main", "/README.md");
    expect(markdown.contains("Android app template"), true);
  });
}
