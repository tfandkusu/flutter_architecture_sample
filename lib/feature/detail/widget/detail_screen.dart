import 'package:flutter/material.dart';
import 'package:flutter_architecture_sample/feature/detail/viewmodel/detail_event_handler.dart';
import 'package:flutter_architecture_sample/feature/detail/viewmodel/detail_event_handler_provider.dart';
import 'package:flutter_architecture_sample/feature/detail/viewmodel/detail_ui_model_provider.dart';
import 'package:flutter_architecture_sample/feature/detail/widget/detail_screen_argument.dart';
import 'package:flutter_architecture_sample/model/github_repo.dart';
import 'package:flutter_architecture_sample/resource/my_colors.dart';
import 'package:flutter_architecture_sample/util/make_date_string.dart';
import 'package:flutter_architecture_sample/widget/favorite_button.dart';
import 'package:flutter_architecture_sample/widget/fork_label.dart';
import 'package:flutter_architecture_sample/widget/language_label.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// 詳細画面
class DetailScreen extends HookConsumerWidget {
  const DetailScreen({super.key});

  /// 画面遷移で使うNamed route
  static const routeName = '/detail';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 詳細画面呼び出し引数
    final argument =
        ModalRoute.of(context)!.settings.arguments as DetailScreenArgument;
    // 画面状態
    final uiModel = ref.watch(detailUiModelProvider(argument.id));
    // イベント処理担当
    final eventHandler = ref.read(detailEventHandlerProvider);
    // 表示するGitHubリポジトリ
    final repo = uiModel.repo;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.transparent,
        shadowColor: MyColors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: MyColors.textHE),
          onPressed: () {
            // 左上「←」ボタンで前の画面に戻る
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Column(
        children: [
          // GitHubリポジトリの名前、フォークラベル、「いいね」ボタン
          _buildRow1(eventHandler, repo),
          // 言語ラベルと更新日
          _DetailScreenRow3(repo.language, repo.updatedAt),
          // 説明文
          _buildRow3(repo.description),
          // 区切り線
          const SizedBox(height: 16),
          const Divider(thickness: 1, height: 1),
          const Expanded(child: Markdown(data: "# タイトル\n本文\n## サブタイトル"))
        ],
      ),
    );
  }

  /// 1行目のWidgetを作成する
  ///
  /// [eventHandler] イベント処理担当
  /// [repo] GitHubリポジトリ情報
  Widget _buildRow1(DetailEventHandler eventHandler, GithubRepo repo) {
    return Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
      // GitHubリポジトリの名前
      Expanded(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            repo.name,
            style: const TextStyle(color: MyColors.textHE, fontSize: 20),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
      // フォークラベル
      Visibility(visible: repo.fork, child: const ForkLabel()),
      // 「いいね」ボタン
      buildFavoriteButton(repo.favorite,
          () => eventHandler.onClickFavorite(repo.name, !repo.favorite))
    ]);
  }

  /// 3行目のWidgetを作成する
  ///
  /// [description] 説明文
  Widget _buildRow3(String description) {
    return Visibility(
      visible: description.isNotEmpty,
      child: Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: Text(description,
              style: const TextStyle(color: MyColors.textME, fontSize: 14))),
    );
  }
}

/// プログラミング言語と更新日Widget
class _DetailScreenRow3 extends StatelessWidget {
  /// プログラミング言語
  final String _language;

  /// 更新日
  final DateTime _updatedAt;

  const _DetailScreenRow3(this._language, this._updatedAt);

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
