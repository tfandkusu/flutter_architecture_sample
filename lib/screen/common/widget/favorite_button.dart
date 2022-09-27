import 'package:flutter/material.dart';
import 'package:flutter_architecture_sample/resource/my_colors.dart';
import 'package:flutter_architecture_sample/resource/strings.dart';

/// 「いいね」ボタンをWidgetを作成する
Widget buildFavoriteButton(bool favorite, Function() onPressed) {
  return IconButton(
      icon: Icon(Icons.favorite,
          color: favorite ? MyColors.likeOn : MyColors.likeOff),
      tooltip: Strings.like,
      onPressed: onPressed);
}
