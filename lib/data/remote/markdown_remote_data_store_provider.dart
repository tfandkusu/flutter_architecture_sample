import 'package:flutter_architecture_sample/data/remote/markdown_remote_data_store.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// シングルトンなMarkdownRepoRemoteDataStoreのインスタンスを取得する
final markdownRemoteDataStoreProvider = Provider((ref) {
  return MarkdownRemoteDataStore();
});
