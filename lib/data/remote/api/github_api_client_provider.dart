import 'package:dio/dio.dart';
import 'package:flutter_architecture_sample/data/remote/api/github_api_client.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// シングルトンなGithubApiClientのインスタンスを作成して取得するためのProvider
final githubApiClientProvider = Provider((ref) {
  /// Dart向けのHTTPクライアント
  final dio = Dio();

  /// GithubApiClientに渡す
  final client = GithubApiClient(dio);
  return client;
});
