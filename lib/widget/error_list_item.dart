import 'package:flutter/material.dart';
import 'package:flutter_architecture_sample/resource/my_colors.dart';
import 'package:flutter_architecture_sample/resource/strings.dart';

/// サーバエラーを表示するWidgetを作成する
///
/// [reload] 再読み込みボタンが押されたときの処理
Widget makeServerErrorListItem(Function() reload) {
  return Column(children: [
    const Padding(
      padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(Strings.serverError,
          style: TextStyle(color: MyColors.textME, fontSize: 14)),
    ),
    TextButton(
        onPressed: reload,
        style: TextButton.styleFrom(
          textStyle: const TextStyle(fontSize: 16),
        ),
        child: const Text(Strings.reload)),
    const SizedBox(height: 8)
  ]);
}
