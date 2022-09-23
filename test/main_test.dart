import 'package:flutter_architecture_sample/main.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// カバレッジレポートにすべてのdartファイルを含めるために、Widgetテストを追加した。
void main() {
  testWidgets('To import all files', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: MyApp()));
  });
}
