import 'package:flutter/material.dart';
import 'package:flutter_architecture_sample/resource/my_colors.dart';
import 'package:flutter_architecture_sample/resource/strings.dart';
import 'package:flutter_architecture_sample/screen/common/viewmodel/error_ui_model.dart';

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

/// エラーの時のWidgetを作成する
/// [error] エラーの状態
/// [reload] 再読込ボタンが押されたときの処理
Widget makeErrorListItem(ErrorUiModel error, Function() reload) {
  return error.when(
      noError: () => throw ArgumentError(),
      network: () => _makeErrorListItem(Strings.networkError, reload),
      notFound: () => _makeErrorListItem(Strings.networkError, null),
      server: () => _makeErrorListItem(Strings.networkError, reload),
      unknown: () => _makeErrorListItem(Strings.unknownError, null));
}

/// エラーメッセージと「再読込」ボタンを作成する
///
/// [message] メッセージ
/// [reload] 再読込ボタンが押されたときの処理。nullの時は非表示
///
Widget _makeErrorListItem(String message, Function()? reload) {
  return Column(children: [
    Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
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
