import 'package:flutter/material.dart';
import 'package:flutter_architecture_sample/feature/detail/viewmodel/detail_ui_model_provider.dart';
import 'package:flutter_architecture_sample/feature/detail/widget/detail_screen_argument.dart';
import 'package:flutter_architecture_sample/resource/my_colors.dart';
import 'package:flutter_architecture_sample/widget/favorite_button.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// 詳細画面
class DetailScreen extends HookConsumerWidget {
  const DetailScreen({super.key});

  /// 画面遷移で使うNamed route
  static const routeName = '/detail';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final argument =
        ModalRoute.of(context)!.settings.arguments as DetailScreenArgument;
    final detailUiModel = ref.watch(detailUiModelProvider(argument.id));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.transparent,
        shadowColor: MyColors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: MyColors.textHE),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Column(
        children: [
          Row(children: [
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                detailUiModel.repo.name,
                style: const TextStyle(color: MyColors.textHE, fontSize: 20),
              ),
            ),
            const SizedBox(width: 16),
            buildFavoriteButton(detailUiModel.repo.favorite, () => {})
          ])
        ],
      ),
    );
  }
}
