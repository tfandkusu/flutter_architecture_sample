import 'package:flutter_architecture_sample/screen/home/stateholder/home_ui_model.dart';
import 'package:flutter_architecture_sample/screen/home/stateholder/home_ui_model_state_notifier.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final homeUiModelStateNotifierProvider =
    StateNotifierProvider<HomeUiModelStateNotifier, HomeUiModel>(
        (ref) => HomeUiModelStateNotifier());
