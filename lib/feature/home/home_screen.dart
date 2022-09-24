import 'package:flutter/material.dart';
import 'package:flutter_architecture_sample/feature/home/home_event_handler_provider.dart';
import 'package:flutter_architecture_sample/feature/home/home_ui_model_provider.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uiModel = ref.watch(homeUiModelProvider);
    final eventHandler = ref.read(homeEventHandlerProvider);
    useEffect(() {
      eventHandler.start();
      return () {};
    });
    return Scaffold(
        appBar: AppBar(
          title: const Text("GitHub Repository List"),
        ),
        body: ListView(
          children: uiModel.repos.map((repo) => Text(repo.name)).toList(),
        ));
  }
}
