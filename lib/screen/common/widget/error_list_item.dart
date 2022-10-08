import 'package:flutter/material.dart';
import 'package:flutter_architecture_sample/resource/my_colors.dart';
import 'package:flutter_architecture_sample/resource/strings.dart';
import 'package:flutter_architecture_sample/screen/common/stateholder/error_ui_model.dart';

/// エラーの時のWidgetを作成する
/// [error] エラーの状態
/// [reload] 再読込ボタンが押されたときの処理
Widget buildErrorListItem(ErrorUiModel error, Function() reload) {
  return error.when(
      noError: () => throw ArgumentError(),
      network: () =>
          buildErrorListItemWithMessage(Strings.networkError, reload),
      notFound: () =>
          buildErrorListItemWithMessage(Strings.notFoundError, null),
      server: () => buildErrorListItemWithMessage(Strings.serverError, reload),
      unknown: () => buildErrorListItemWithMessage(Strings.unknownError, null));
}

/// エラーメッセージと「再読込」ボタンを作成する
///
/// [message] メッセージ
/// [reload] 再読込ボタンが押されたときの処理。nullの時は非表示
///
Widget buildErrorListItemWithMessage(String message, Function()? reload) {
  return Column(children: [
    Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      width: double.infinity,
      child: Text(message,
          style: const TextStyle(color: MyColors.textME, fontSize: 14)),
    ),
    Visibility(
      visible: reload != null,
      child: TextButton(
          onPressed: reload,
          style: TextButton.styleFrom(
            textStyle: const TextStyle(fontSize: 16),
          ),
          child: const Text(Strings.reload)),
    ),
    const SizedBox(height: 8)
  ]);
}
