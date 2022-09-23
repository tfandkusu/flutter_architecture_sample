import 'package:dio/dio.dart';
import 'package:flutter_architecture_sample/data/remote/github_api_client.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final githubApiClientProvider = Provider((ref) {
  final dio = Dio();
  final client = GithubApiClient(dio);
  return client;
});
