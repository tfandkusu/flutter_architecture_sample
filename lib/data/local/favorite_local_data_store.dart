import 'package:shared_preferences/shared_preferences.dart';

/// GitHubリポジトリに対する「いいね」をアプリローカルから読み書きする担当クラス
class FavoriteLocalDataStore {
  /// SharedPreferencesの保存キー
  static const _keyFavoriteGitHubRepoNameList = "favoriteGitHubRepoNameList";

  /// GitHubリポジトリに「いいね」を付けるか消す。
  ///
  /// [githubRepoName] GitHubリポジトリの名前
  /// [favorite] trueの時は「いいね」を付ける。falseの時は「いいね」を消す。
  void setFavorite(String githubRepoName, bool favorite) async {
    // SharedPreferencesのインスタンスを得る
    final prefs = await SharedPreferences.getInstance();
    // 現在の「いいね」を付けたGitHubリポジトリ一覧を得る
    final nameList =
        prefs.getStringList(_keyFavoriteGitHubRepoNameList) ?? <String>[];
    // Setに変換する
    final nameSet = nameList.toSet();
    if (favorite) {
      // 「いいね」を付ける
      // Setに追加する
      nameSet.add(githubRepoName);
    } else {
      // 「いいね」を消す
      // Setから削除する
      nameSet.remove(githubRepoName);
    }
    // 新しい「いいね」を付けたGitHubリポジトリ名一覧をString型のリストとして保存する
    prefs.setStringList(_keyFavoriteGitHubRepoNameList, nameSet.toList());
  }

  /// 「いいね」を付けたリポジトリ一覧を得る
  Future<Set<String>> getFavoriteRepoNameSet() async {
    // SharedPreferencesのインスタンスを得る
    final prefs = await SharedPreferences.getInstance();
    // 現在の「いいね」を付けたGitHubリポジトリ一覧を得る
    final nameList =
        prefs.getStringList(_keyFavoriteGitHubRepoNameList) ?? <String>[];
    // Setに変換して返却する
    return nameList.toSet();
  }
}
