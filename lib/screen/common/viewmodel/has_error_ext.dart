import 'package:flutter_architecture_sample/screen/common/viewmodel/error_ui_model.dart';

extension HasErrorExt on ErrorUiModel {
  bool hasError() {
    return this != const ErrorUiModel.noError();
  }
}
