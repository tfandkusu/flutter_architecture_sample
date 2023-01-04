import 'package:flutter/material.dart';
import 'package:flutter_architecture_sample/resource/my_colors.dart';
import 'package:flutter_architecture_sample/resource/strings.dart';

/// フォークラベル
class ForkLabel extends StatelessWidget {
  const ForkLabel({super.key});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Container(
      height: 28,
      alignment: Alignment.center,
      padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
      decoration: BoxDecoration(
          color: themeData.colorScheme.outline,
          borderRadius: BorderRadius.circular(8)),
      child: Text(
        Strings.fork,
        style: themeData.typography.englishLike.labelSmall
            ?.copyWith(color: MyColors.white),
      ),
    );
  }
}
