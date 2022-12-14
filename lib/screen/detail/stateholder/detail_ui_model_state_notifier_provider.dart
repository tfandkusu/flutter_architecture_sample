import 'package:flutter_architecture_sample/screen/detail/stateholder/detail_ui_model.dart';
import 'package:flutter_architecture_sample/screen/detail/stateholder/detail_ui_model_state_notifier.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final detailUiModelStateNotifierProvider = StateNotifierProvider.autoDispose<
    DetailUiModelStateNotifier,
    DetailUiModel>((ref) => DetailUiModelStateNotifier());
