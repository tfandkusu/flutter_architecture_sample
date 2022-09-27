import 'package:flutter_architecture_sample/screen/common/viewmodel/error_ui_model.dart';
import 'package:flutter_architecture_sample/screen/common/viewmodel/has_error.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("hasError", () async {
    expect(hasError(const ErrorUiModel.noError()), false);
    expect(hasError(const ErrorUiModel.network()), true);
    expect(hasError(const ErrorUiModel.notFound()), true);
    expect(hasError(const ErrorUiModel.server()), true);
    expect(hasError(const ErrorUiModel.unknown()), true);
  });
}
