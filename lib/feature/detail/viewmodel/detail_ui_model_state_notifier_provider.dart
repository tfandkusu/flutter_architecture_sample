import 'package:flutter_architecture_sample/feature/detail/viewmodel/detail_ui_model.dart';
import 'package:flutter_architecture_sample/feature/detail/viewmodel/detail_ui_model_state_notifier.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final detailUiModelStateNotifierProvider =
    StateNotifierProvider<DetailUiModelStateNotifier, DetailUiModel>(
        (ref) => DetailUiModelStateNotifier());
