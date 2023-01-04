import 'package:flutter/material.dart';
import 'package:flutter_architecture_sample/model/github_repo.dart';
import 'package:flutter_architecture_sample/screen/common/widget/favorite_button.dart';
import 'package:flutter_architecture_sample/screen/common/widget/fork_label.dart';
import 'package:flutter_architecture_sample/screen/common/widget/language_label.dart';
import 'package:flutter_architecture_sample/screen/detail/stateholder/detail_event_handler.dart';
import 'package:flutter_architecture_sample/screen/detail/stateholder/detail_event_handler_provider.dart';
import 'package:flutter_architecture_sample/screen/detail/stateholder/detail_header_ui_model_provider.dart';
import 'package:flutter_architecture_sample/util/make_date_string.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// 詳細画面のヘッダー部分ウィジット
class DetailHeaderWidget extends HookConsumerWidget {
  /// GitHubリポジトリのid
  final int id;

  const DetailHeaderWidget(this.id, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 画面状態
    final uiModel = ref.watch(detailHeaderUiModelProvider(id));
    // イベント処理担当
    final eventHandler = ref.read(detailEventHandlerProvider);
    final repo = uiModel.repo;
    return Column(children: [
      // GitHubリポジトリの名前、フォークラベル、「いいね」ボタン
      _buildRow1(context, eventHandler, repo),
      // 言語ラベルと更新日
      _DetailScreenRow3(repo.language, repo.updatedAt),
      // 説明文
      _buildRow3(context, repo.description),
      // 区切り線
      const SizedBox(height: 16),
    ]);
  }

  /// 1行目のWidgetを作成する
  ///
  /// [eventHandler] イベント処理担当
  /// [repo] GitHubリポジトリ情報
  Widget _buildRow1(
      BuildContext context, DetailEventHandler eventHandler, GithubRepo repo) {
    final themeData = Theme.of(context);
    return Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
      // GitHubリポジトリの名前
      Expanded(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            repo.name,
            style: themeData.typography.englishLike.titleLarge
                ?.copyWith(color: themeData.colorScheme.onSurface),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
      // フォークラベル
      Visibility(visible: repo.fork, child: const ForkLabel()),
      // 「いいね」ボタン
      buildFavoriteButton(context, repo.favorite,
          () => eventHandler.onClickFavorite(repo.name, !repo.favorite))
    ]);
  }

  /// 3行目のWidgetを作成する
  ///
  /// [description] 説明文
  Widget _buildRow3(BuildContext context, String description) {
    final themeData = Theme.of(context);
    return Visibility(
        visible: description.isNotEmpty,
        child: Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: Text(description,
                style: themeData.typography.dense.bodyMedium?.copyWith(
                    color: themeData.colorScheme.onSurfaceVariant))));
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
    final themeData = Theme.of(context);
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
            style: themeData.typography.englishLike.bodySmall
                ?.copyWith(color: themeData.colorScheme.onSurfaceVariant)),
        const SizedBox(width: 16),
      ],
    );
  }
}
