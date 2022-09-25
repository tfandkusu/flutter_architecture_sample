import 'package:flutter_architecture_sample/util/make_date_string.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("makeDateString", () async {
    final dateTime = DateTime.parse("2022-07-09T15:20:53Z");
    expect(makeDateString(dateTime), "2022/07/10");
  });
}
