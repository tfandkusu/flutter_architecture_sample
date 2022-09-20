import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeStateNotifier extends StateNotifier<int> {
  HomeStateNotifier() : super(0);

  void countUp() {
    ++state;
  }
}

final homeStateNotifierProvider =
    StateNotifierProvider<HomeStateNotifier, int>((ref) => HomeStateNotifier());
