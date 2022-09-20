import 'package:flutter_architecture_sample/home/home_state_notifier_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  test("homeStateNotifierProvider", () {
    final container = ProviderContainer();
    final stateNotifier = container.read(homeStateNotifierProvider.notifier);
    getState() => container.read(homeStateNotifierProvider);
    expect(getState(), 0);
    stateNotifier.countUp();
    expect(getState(), 1);
    stateNotifier.countUp();
    expect(getState(), 2);
  });
}
