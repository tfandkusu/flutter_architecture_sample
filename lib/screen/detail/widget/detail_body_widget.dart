import 'package:flutter/material.dart';
import 'package:flutter_architecture_sample/resource/strings.dart';
import 'package:flutter_architecture_sample/screen/common/stateholder/error_ui_model.dart';
import 'package:flutter_architecture_sample/screen/common/stateholder/has_error_ext.dart';
import 'package:flutter_architecture_sample/screen/common/widget/error_list_item.dart';
import 'package:flutter_architecture_sample/screen/common/widget/progress_list_item.dart';
import 'package:flutter_architecture_sample/screen/detail/stateholder/detail_body_ui_model.dart';
import 'package:flutter_architecture_sample/screen/detail/stateholder/detail_body_ui_model_provider.dart';
import 'package:flutter_architecture_sample/screen/detail/stateholder/detail_event_handler.dart';
import 'package:flutter_architecture_sample/screen/detail/stateholder/detail_event_handler_provider.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

/// 詳細画面のreadme.md部分ウィジット
class DetailBodyWidget extends HookConsumerWidget {
  /// GitHubリポジトリのid
  final int id;

  /// GitHubリポジトリの名前
  final String name;

  /// GitHubリポジトリのデフォルトブランチ
  final String defaultBranch;

  const DetailBodyWidget(this.id, this.name, this.defaultBranch, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 画面状態
    final uiModel = ref.watch(detailBodyUiModelProvider(id));
    // イベント処理担当
    final eventHandler = ref.read(detailEventHandlerProvider);
    useEffect(() {
      eventHandler.onCreate(name, defaultBranch);
      return () {};
    }, const []);
    return _buildReadme(uiModel, eventHandler);
  }

  /// README.md表示部分を作成する
  ///
  /// [uiModel] UI状態
  /// [eventHandler] イベント処理担当
  Widget _buildReadme(
      DetailBodyUiModel uiModel, DetailEventHandler eventHandler) {
    if (uiModel.progress) {
      // 読み込み中
      return const ProgressListItem();
    } else if (uiModel.error.hasError()) {
      if (uiModel.error == const ErrorUiModel.notFound()) {
        // README.mdがありませんエラー
        return buildErrorListItemWithMessage(Strings.readmeNotFound, null);
      } else {
        // ネットワークエラー等それ以外のエラー
        return buildErrorListItem(uiModel.error,
            () => eventHandler.onClickReload(name, defaultBranch));
      }
    } else {
      // README.md表示
      return Expanded(
          child: Markdown(
        selectable: true,
        data: uiModel.readme,
        onTapLink: (text, href, title) async {
          if (href != null) {
            await launchUrl(Uri.parse(href),
                mode: LaunchMode.externalApplication);
          }
        },
      ));
    }
  }
}
