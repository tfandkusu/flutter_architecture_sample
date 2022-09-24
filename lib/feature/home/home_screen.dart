import 'package:flutter/material.dart';
import 'package:flutter_architecture_sample/feature/home/home_event_handler.dart';
import 'package:flutter_architecture_sample/feature/home/home_event_handler_provider.dart';
import 'package:flutter_architecture_sample/feature/home/home_ui_model_provider.dart';
import 'package:flutter_architecture_sample/model/github_repo.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// ホーム画面
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
    final items = <Widget>[];
    if (uiModel.progress) {
      items.add(const HomeProgressListItem());
    } else {
      items.addAll(
          uiModel.repos.map((repo) => buildRepoListItem(eventHandler, repo)));
    }
    return Scaffold(
        appBar: AppBar(
          title: const Text("GitHub Repository List"),
        ),
        body: ListView(
          children: items,
        ));
  }

  Widget buildRepoListItem(HomeEventHandler eventHandler, GithubRepo repo) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              repo.name,
              style: const TextStyle(fontSize: 16),
            )
          ],
        )
      ],
    );
  }
}

/// 読み込み中プログレス行
class HomeProgressListItem extends StatelessWidget {
  const HomeProgressListItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(16),
      child: const SizedBox(
          width: 48, height: 48, child: CircularProgressIndicator()),
    );
  }
}

///
