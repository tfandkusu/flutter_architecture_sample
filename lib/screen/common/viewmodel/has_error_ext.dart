import 'package:flutter_architecture_sample/screen/common/viewmodel/error_ui_model.dart';

extension HasErrorExt on ErrorUiModel {
  /// エラーが無ければtrueを返却する
  bool hasError() {
    return this != const ErrorUiModel.noError();
  }
}
