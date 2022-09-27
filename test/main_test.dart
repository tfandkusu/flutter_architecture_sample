import 'package:flutter_architecture_sample/screen/home/viewmodel/home_event_handler.dart';
import 'package:flutter_architecture_sample/screen/home/viewmodel/home_event_handler_provider.dart';
import 'package:flutter_architecture_sample/main.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mockito/annotations.dart';
import 'main_test.mocks.dart';

/// カバレッジレポートにすべてのdartファイルを含めるために、Widgetテストを追加した。
@GenerateNiceMocks([MockSpec<HomeEventHandler>()])
void main() {
  testWidgets('To import all files', (tester) async {
    // 読み込みが発生しないようにEventHandlerはモックに差し替える。
    await tester.pumpWidget(ProviderScope(
      overrides: [
        homeEventHandlerProvider.overrideWithValue(MockHomeEventHandler())
      ],
      child: const MyApp(),
    ));
  });
}
