import 'package:dio/dio.dart';
import 'package:flutter_architecture_sample/data/remote/api/github_api_client.dart';
import 'package:flutter_architecture_sample/model/error/api_exceptions.dart';
import 'package:flutter_architecture_sample/model/github_repo.dart';

/// APIからGitHubの情報を取ってくる担当
///
/// [client] Retrofit for Dartで作成したAPIクライアント
class GithubRepoRemoteDataSource {
  final GithubApiClient _client;

  GithubRepoRemoteDataSource(this._client);

  /// ユーザtfandkusuの公開GitHubリポジトリ一覧を取得する
  Future<List<GithubRepo>> getGithubRepoList() async {
    try {
      // 全ページ取得してJsonをパースした結果のインスタンスから
      // Repository層用のデータクラスのインスタンスに変換する
      final allRepos = <GithubRepo>[];
      int page = 1;
      while (true) {
        final responseList = await _client.getGitHubRepoList(page);
        for (final responseItem in responseList) {
          final repo = GithubRepo(
              id: responseItem.id,
              name: responseItem.name,
              description: responseItem.description ?? "",
              updatedAt: DateTime.parse(responseItem.updatedAt),
              language: responseItem.language ?? "",
              fork: responseItem.fork,
              defaultBranch: responseItem.defaultBranch,
              favorite: false);
          allRepos.add(repo);
        }
        if (responseList.isEmpty) {
          // ページを増やして0件取得になったら終了
          break;
        } else {
          ++page;
        }
      }
      return allRepos;
    } on DioError catch (e) {
      // HTTPクライアントDioで例外が発生した
      if (e.type == DioErrorType.connectTimeout ||
          e.type == DioErrorType.receiveTimeout ||
          e.type == DioErrorType.sendTimeout ||
          e.type == DioErrorType.other) {
        // 圏外などのネットワークエラー
        throw NetworkErrorException();
      } else if (e.type == DioErrorType.response) {
        // メンテナンス中などのサーバエラー
        throw ServerErrorException();
      } else {
        // それ以外のエラーは想定していないので、ここでは処理しない。
        rethrow;
      }
    }
  }
}
