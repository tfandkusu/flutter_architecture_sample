import 'package:flutter/material.dart';
import 'package:flutter_architecture_sample/screen/detail/widget/detail_body_widget.dart';
import 'package:flutter_architecture_sample/screen/detail/widget/detail_header_widget.dart';
import 'package:flutter_architecture_sample/screen/detail/widget/detail_screen_argument.dart';
import 'package:flutter_architecture_sample/resource/my_colors.dart';

/// 詳細画面。
/// 1画面にひとつのHookConsumerWidgetだと、状態が変わる度に画面内のすべてがリビルドされる。
/// 単純な画面ならば、それでも描画パフォーマンス上ほ問題は出ないが
/// 仮に問題が出た場合は、画面はStatelessWidgetにして、一部分だけを担当する
/// HookConsumerWidgetを設置する。
class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  /// 画面遷移で使うNamed route
  static const routeName = '/detail';

  @override
  Widget build(BuildContext context) {
    // 詳細画面呼び出し引数
    final argument =
        ModalRoute.of(context)!.settings.arguments as DetailScreenArgument;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.transparent,
        shadowColor: MyColors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // 左上「←」ボタンで前の画面に戻る
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Column(
        children: [
          // ヘッダー部分
          DetailHeaderWidget(argument.id),
          // 区切り線
          const SizedBox(height: 16),
          const Divider(thickness: 1, height: 1),
          // README.md表示
          DetailBodyWidget(argument.id, argument.name, argument.defaultBranch)
        ],
      ),
    );
  }
}
