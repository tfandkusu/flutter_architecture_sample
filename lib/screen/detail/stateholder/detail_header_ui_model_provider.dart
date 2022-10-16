import 'package:flutter_architecture_sample/screen/detail/stateholder/detail_header_ui_model.dart';
import 'package:flutter_architecture_sample/screen/detail/stateholder/detail_ui_model_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// 詳細画面のヘッダー部分の状態を提供するProvider
final detailHeaderUiModelProvider =
    Provider.autoDispose.family<DetailHeaderUiModel, int>((ref, id) {
  final detailUiModel = ref.watch(detailUiModelProvider(id));
  return DetailHeaderUiModel(repo: detailUiModel.repo);
});
