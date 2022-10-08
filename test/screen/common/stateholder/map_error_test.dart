import 'package:flutter_architecture_sample/model/error/api_exceptions.dart';
import 'package:flutter_architecture_sample/screen/common/stateholder/error_ui_model.dart';
import 'package:flutter_architecture_sample/screen/common/stateholder/map_error.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("mapError", () async {
    expect(mapError(NetworkErrorException()), const ErrorUiModel.network());
    expect(mapError(NotFoundException()), const ErrorUiModel.notFound());
    expect(mapError(ServerErrorException()), const ErrorUiModel.server());
    expect(mapError(const FormatException("")), const ErrorUiModel.unknown());
  });
}
