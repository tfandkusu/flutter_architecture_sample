import 'package:flutter_architecture_sample/screen/common/stateholder/error_ui_model.dart';
import 'package:flutter_architecture_sample/screen/common/stateholder/has_error_ext.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("hasError", () async {
    expect(const ErrorUiModel.noError().hasError(), false);
    expect(const ErrorUiModel.network().hasError(), true);
    expect(const ErrorUiModel.notFound().hasError(), true);
    expect(const ErrorUiModel.server().hasError(), true);
    expect(const ErrorUiModel.unknown().hasError(), true);
  });
}
