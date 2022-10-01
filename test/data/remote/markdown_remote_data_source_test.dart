import 'package:flutter_architecture_sample/data/remote/markdown_remote_data_source_provider.dart';
import 'package:flutter_architecture_sample/model/error/api_exceptions.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// MarkdownRemoteDataSourceのテスト
void main() {
  // マークダウンファイルダウンロードが成功
  test("MarkdownRemoteDataSource success", () async {
    final container = ProviderContainer();
    final remoteDataSource = container.read(markdownRemoteDataSourceProvider);
    final markdown = await remoteDataSource.getMarkdown(
        "android_app_template", "main", "/README.md");
    expect(markdown.contains("Android app template"), true);
  });
  // 存在しないファイルへのアクセス
  test("MarkdownRemoteDataSource notFound", () async {
    final container = ProviderContainer();
    final remoteDataSource = container.read(markdownRemoteDataSourceProvider);
    expect(
        () async => await remoteDataSource.getMarkdown(
            "android_app_template", "main", "/readme.md"),
        throwsA(isA<NotFoundException>()));
  });
}
