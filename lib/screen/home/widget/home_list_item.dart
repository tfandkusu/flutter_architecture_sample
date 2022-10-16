import 'package:flutter/material.dart';
import 'package:flutter_architecture_sample/model/github_repo.dart';
import 'package:flutter_architecture_sample/resource/my_colors.dart';
import 'package:flutter_architecture_sample/screen/common/widget/favorite_button.dart';
import 'package:flutter_architecture_sample/screen/common/widget/fork_label.dart';
import 'package:flutter_architecture_sample/screen/common/widget/language_label.dart';
import 'package:flutter_architecture_sample/screen/detail/widget/detail_screen.dart';
import 'package:flutter_architecture_sample/screen/detail/widget/detail_screen_argument.dart';
import 'package:flutter_architecture_sample/screen/home/stateholder/home_event_handler.dart';
import 'package:flutter_architecture_sample/util/make_date_string.dart';

/// GitHubリポジトリ1個分のListViewの項目Widgetを作成する
///
/// [eventHandler] イベント処理担当オブジェクト
/// [repo] GitHubリポジトリ
Widget buildRepoListItem(BuildContext context, HomeEventHandler eventHandler,
    GithubRepo repo, bool isLast) {
  return InkWell(
    key: Key(repo.name),
    child: Column(
      children: [
        _buildLine1(eventHandler, repo),
        _HomeRepoListItemDescription(repo.description),
        _HomeRepoListItemLine3(repo.language, repo.updatedAt),
        const SizedBox(height: 16),
        Visibility(
          visible: !isLast,
          child: const Divider(thickness: 1, height: 1),
        )
      ],
    ),
    onTap: () {
      // 項目がクリックされたときの画面遷移処理
      Navigator.pushNamed(context, DetailScreen.routeName,
          arguments: DetailScreenArgument(id: repo.id));
    },
  );
}

/// リポジトリ名、フォークラベル、「いいね」ボタンのWidgetを作成する
Widget _buildLine1(HomeEventHandler eventHandler, GithubRepo repo) {
  return Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
    const SizedBox(width: 16),
    // GitHubリポジトリ名
    Expanded(
      child: Text(
        repo.name,
        style: const TextStyle(fontSize: 16, color: MyColors.textHE),
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
    ),
    // フォークラベル
    Visibility(visible: repo.fork, child: const SizedBox(width: 16)),
    Visibility(visible: repo.fork, child: const ForkLabel()),
    // 「いいね」ボタン
    buildFavoriteButton(repo.favorite, () {
      // 「いいね」ボタンが押されたときの処理
      eventHandler.onClickFavorite(repo.name, !repo.favorite);
    }),
  ]);
}

/// 説明文Widget
class _HomeRepoListItemDescription extends StatelessWidget {
  final String _description;

  const _HomeRepoListItemDescription(this._description);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Visibility(
          visible: _description.isNotEmpty,
          child: Container(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
            width: double.infinity,
            child: Text(_description,
                style: const TextStyle(color: MyColors.textME, fontSize: 14)),
          ),
        ),
        const SizedBox(height: 8)
      ],
    );
  }
}

/// プログラミング言語と更新日Widget
class _HomeRepoListItemLine3 extends StatelessWidget {
  /// プログラミング言語
  final String _language;

  /// 更新日
  final DateTime _updatedAt;

  const _HomeRepoListItemLine3(this._language, this._updatedAt);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(width: 16),
        // プログラミング言語ラベル
        Visibility(
            visible: _language.isNotEmpty, child: LanguageLabel(_language)),
        const Spacer(),
        // 更新日
        Text(makeDateString(_updatedAt),
            style: const TextStyle(fontSize: 12, color: MyColors.textME)),
        const SizedBox(width: 16),
      ],
    );
  }
}
