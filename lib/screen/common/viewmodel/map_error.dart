import 'package:flutter_architecture_sample/model/error/api_exceptions.dart';
import 'package:flutter_architecture_sample/screen/common/viewmodel/error_ui_model.dart';

/// 例外をErrorUiModelに変換する
ErrorUiModel mapError(Exception e) {
  if (e is NetworkErrorException) {
    return const ErrorUiModel.network();
  } else if (e is NotFoundException) {
    return const ErrorUiModel.notFound();
  } else if (e is ServerErrorException) {
    return const ErrorUiModel.server();
  } else {
    return const ErrorUiModel.unknown();
  }
}
