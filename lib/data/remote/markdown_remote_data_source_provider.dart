import 'package:flutter_architecture_sample/data/remote/markdown_remote_data_source.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// シングルトンなMarkdownRepoRemoteDataSourceのインスタンスを取得する
final markdownRemoteDataSourceProvider = Provider((ref) {
  return MarkdownRemoteDataSource();
});
