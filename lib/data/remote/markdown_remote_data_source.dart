import 'package:dio/dio.dart';
import 'package:flutter_architecture_sample/model/error/api_exceptions.dart';

/// APIからマークダウンテキストをダウンロードする担当
///
/// [client] Retrofit for Dartで作成したAPIクライアント
class MarkdownRemoteDataSource {
  final _dio = Dio();

  /// マークダウンファイルをダウンロードする
  ///
  /// [name] リポジトリ名
  /// [defaultBranch] デフォルトブランチ名
  /// [path] ダウンロードファイルのフルパス
  Future<String> getMarkdown(
      String name, String defaultBranch, String path) async {
    final url =
        "https://raw.githubusercontent.com/tfandkusu/$name/$defaultBranch$path";
    try {
      final response = await _dio.get(url);
      return response.data.toString();
    } on DioError catch (e) {
      // HTTPクライアントDioで例外が発生した
      if (e.type == DioErrorType.connectTimeout ||
          e.type == DioErrorType.receiveTimeout ||
          e.type == DioErrorType.sendTimeout ||
          e.type == DioErrorType.other) {
        // 圏外などのネットワークエラー
        throw NetworkErrorException();
      } else if (e.type == DioErrorType.response) {
        if (e.response?.statusCode == 404) {
          // 存在しないリソースへのアクセス
          throw NotFoundException();
        } else {
          // メンテナンス中などのサーバエラー
          throw ServerErrorException();
        }
      } else {
        // それ以外のエラーは想定していないので、ここでは処理しない。
        rethrow;
      }
    }
  }
}
