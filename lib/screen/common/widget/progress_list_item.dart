import 'package:flutter/material.dart';

/// 読み込み中プログレス行Widget
class ProgressListItem extends StatelessWidget {
  const ProgressListItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(16),
      child: const SizedBox(
          width: 48, height: 48, child: CircularProgressIndicator()),
    );
  }
}
