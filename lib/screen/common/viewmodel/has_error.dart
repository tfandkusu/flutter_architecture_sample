import 'package:flutter_architecture_sample/screen/common/viewmodel/error_ui_model.dart';

bool hasError(ErrorUiModel error) {
  return error != const ErrorUiModel.noError();
}
