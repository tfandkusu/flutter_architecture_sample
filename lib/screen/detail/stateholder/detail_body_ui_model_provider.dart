import 'package:flutter_architecture_sample/screen/detail/stateholder/detail_body_ui_model.dart';
import 'package:flutter_architecture_sample/screen/detail/stateholder/detail_ui_model_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// 詳細画面のreadme.md部分の状態を提供するProvider
/// ヘッダー部分だけの更新では、readme.md部分が更新されないように、ここだけ切り出した。
final detailBodyUiModelProvider =
    Provider.autoDispose.family<DetailBodyUiModel, int>((ref, id) {
  final detailUiModel = ref.watch(detailUiModelProvider(id));

  return DetailBodyUiModel(
      progress: detailUiModel.progress,
      readme: detailUiModel.readme,
      error: detailUiModel.error);
});
