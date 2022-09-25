import 'package:flutter/material.dart';
import 'package:flutter_architecture_sample/resource/my_colors.dart';
import 'package:flutter_architecture_sample/resource/strings.dart';

/// ネットワークエラーを表示するWidgetを作成する
///
/// [reload] 再読込ボタンが押されたときの処理
Widget makeNetworkErrorListItem(Function() reload) {
  return _makeErrorListItem(Strings.networkError, reload);
}

/// サーバエラーを表示するWidgetを作成する
///
/// [reload] 再読込ボタンが押されたときの処理
Widget makeServerErrorListItem(Function() reload) {
  return _makeErrorListItem(Strings.serverError, reload);
}

/// エラーメッセージと「再読込」ボタンを作成する
///
/// [message] メッセージ
/// [reload] 再読込ボタンが押されたときの処理
///
Widget _makeErrorListItem(String message, Function() reload) {
  return Column(children: [
    Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(message,
          style: const TextStyle(color: MyColors.textME, fontSize: 14)),
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
