import 'package:flutter_architecture_sample/data/remote/markdown_remote_data_store_provider.dart';
import 'package:flutter_architecture_sample/model/error/api_exceptions.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// MarkdownRemoteDataStoreのテスト
void main() {
  // マークダウンファイルダウンロードが成功
  test("MarkdownRemoteDataStore success", () async {
    final container = ProviderContainer();
    final remoteDataStore = container.read(markdownRemoteDataStoreProvider);
    final markdown = await remoteDataStore.getMarkdown(
        "android_app_template", "main", "/README.md");
    expect(markdown.contains("Android app template"), true);
  });
  // 存在しないファイルへのアクセス
  test("MarkdownRemoteDataStore notFound", () async {
    final container = ProviderContainer();
    final remoteDataStore = container.read(markdownRemoteDataStoreProvider);
    expect(
        () async => await remoteDataStore.getMarkdown(
            "android_app_template", "main", "/readme.md"),
        throwsA(isA<NotFoundException>()));
  });
}
