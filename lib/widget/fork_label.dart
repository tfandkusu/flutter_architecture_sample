import 'package:flutter/material.dart';
import 'package:flutter_architecture_sample/resource/my_colors.dart';
import 'package:flutter_architecture_sample/resource/strings.dart';

/// フォークラベル
class ForkLabel extends StatelessWidget {
  const ForkLabel({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 28,
      alignment: Alignment.center,
      padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
      decoration: BoxDecoration(
          color: MyColors.forkLabelBackground,
          borderRadius: BorderRadius.circular(8)),
      child: const Text(
        Strings.fork,
        style: TextStyle(
            fontSize: 12, fontWeight: FontWeight.bold, color: MyColors.white),
      ),
    );
  }
}
