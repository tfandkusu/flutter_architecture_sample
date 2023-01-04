import 'package:flutter/material.dart';
import 'package:flutter_architecture_sample/resource/strings.dart';
import 'package:flutter_architecture_sample/screen/common/stateholder/error_ui_model.dart';

/// エラーの時のWidgetを作成する
/// [error] エラーの状態
/// [reload] 再読込ボタンが押されたときの処理
Widget buildErrorListItem(
    BuildContext context, ErrorUiModel error, Function() reload) {
  return error.when(
      noError: () => throw ArgumentError(),
      network: () =>
          buildErrorListItemWithMessage(context, Strings.networkError, reload),
      notFound: () =>
          buildErrorListItemWithMessage(context, Strings.notFoundError, null),
      server: () =>
          buildErrorListItemWithMessage(context, Strings.serverError, reload),
      unknown: () =>
          buildErrorListItemWithMessage(context, Strings.unknownError, null));
}

/// エラーメッセージと「再読込」ボタンを作成する
///
/// [message] メッセージ
/// [reload] 再読込ボタンが押されたときの処理。nullの時は非表示
///
Widget buildErrorListItemWithMessage(
    BuildContext context, String message, Function()? reload) {
  final themeData = Theme.of(context);
  return Column(children: [
    Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      width: double.infinity,
      child: Text(message,
          style: themeData.typography.dense.bodyMedium
              ?.copyWith(color: themeData.colorScheme.onSurfaceVariant)),
    ),
    Visibility(
      visible: reload != null,
      child: TextButton(
          onPressed: reload,
          style: TextButton.styleFrom(
            textStyle: themeData.typography.dense.bodyLarge,
          ),
          child: const Text(Strings.reload)),
    ),
    const SizedBox(height: 8)
  ]);
}
