import 'package:flutter/material.dart';
import 'package:flutter_architecture_sample/resource/strings.dart';

/// 「いいね」ボタンをWidgetを作成する
Widget buildFavoriteButton(
    BuildContext context, bool favorite, Function() onPressed) {
  final themeData = Theme.of(context);
  return IconButton(
      icon: Icon(Icons.favorite,
          color: favorite
              ? themeData.colorScheme.secondary
              : themeData.colorScheme.secondaryContainer),
      tooltip: Strings.like,
      onPressed: onPressed);
}
