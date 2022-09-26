import 'package:flutter/material.dart';
import 'package:flutter_architecture_sample/feature/detail/widget/detail_screen_argument.dart';
import 'package:flutter_architecture_sample/resource/my_colors.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DetailScreen extends HookConsumerWidget {
  const DetailScreen({super.key});

  static const routeName = '/detail';
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final argment =
        ModalRoute.of(context)!.settings.arguments as DetailScreenArgument;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.transparent,
        shadowColor: MyColors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: MyColors.textHE),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: const Center(
        child: Text("Detail Screen"),
      ),
    );
  }
}
