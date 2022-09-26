import 'package:dio/dio.dart';

/// APIからマークダウンテキストをダウンロードする担当
///
/// [client] Retrofit for Dartで作成したAPIクライアント
class MarkdownRemoteDataStore {
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
    final response = await _dio.get(url);
    return response.data.toString();
  }
}
