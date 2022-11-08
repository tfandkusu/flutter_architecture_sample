import 'package:flutter/material.dart';
import 'package:flutter_architecture_sample/screen/common/stateholder/has_error_ext.dart';
import 'package:flutter_architecture_sample/resource/strings.dart';
import 'package:flutter_architecture_sample/screen/detail/widget/detail_screen.dart';
import 'package:flutter_architecture_sample/screen/detail/widget/detail_screen_argument.dart';
import 'package:flutter_architecture_sample/screen/home/stateholder/home_event_handler_provider.dart';
import 'package:flutter_architecture_sample/screen/home/stateholder/home_ui_model_provider.dart';
import 'package:flutter_architecture_sample/screen/home/widget/home_list_item.dart';
import 'package:flutter_architecture_sample/screen/common/widget/error_list_item.dart';
import 'package:flutter_architecture_sample/screen/common/widget/progress_list_item.dart';
import 'package:flutter_architecture_sample/util/check_one_shot_operation.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// ホーム画面
class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 状態を取得する
    final uiModel = ref.watch(homeUiModelProvider);
    // イベント処理担当を取得する
    final eventHandler = ref.read(homeEventHandlerProvider);
    // ワンショットオペレーションの対応
    ref.listen(homeUiModelProvider, (previous, next) {
      // 詳細画面への遷移要求があるか確認する
      checkOneShotOperation(previous, next, (state) => state.callDetailScreen,
          (repo) {
        // 詳細画面に遷移する
        Navigator.pushNamed(context, DetailScreen.routeName,
            arguments: DetailScreenArgument(
                id: repo.id,
                name: repo.name,
                defaultBranch: repo.defaultBranch));
        // 遷移した場合は完了報告を行う
        eventHandler.onDetailScreenCalled();
      });
    });
    // 画面が作られた時の処理を行う
    useEffect(() {
      eventHandler.onCreate();
      return () {};
    }, const [] /* 1回だけ実行する */);
    // ListViewの要素数
    int itemCount = 1;
    if (!uiModel.progress && !uiModel.error.hasError()) {
      itemCount = uiModel.repos.length;
    }
    // ListView本体
    final listView = ListView.builder(
        itemCount: itemCount,
        itemBuilder: (context, index) {
          if (uiModel.progress) {
            return const ProgressListItem();
          } else if (uiModel.error.hasError()) {
            return buildErrorListItem(uiModel.error, () {
              eventHandler.onClickReload();
            });
          } else {
            return buildRepoListItem(context, eventHandler,
                uiModel.repos[index], index == uiModel.repos.length - 1);
          }
        });
    return Scaffold(
        appBar: AppBar(
          title: const Text(Strings.homeTitle),
        ),
        body: listView);
  }
}
