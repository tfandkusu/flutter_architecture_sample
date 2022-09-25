import 'package:flutter/material.dart';
import 'package:flutter_architecture_sample/feature/home/home_event_handler.dart';
import 'package:flutter_architecture_sample/feature/home/home_event_handler_provider.dart';
import 'package:flutter_architecture_sample/feature/home/home_ui_model_provider.dart';
import 'package:flutter_architecture_sample/model/github_repo.dart';
import 'package:flutter_architecture_sample/resource/my_colors.dart';
import 'package:flutter_architecture_sample/resource/strings.dart';
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
      eventHandler.onCreate();
      return () {};
    });
    final items = <Widget>[];
    if (uiModel.progress) {
      items.add(const HomeProgressListItem());
    } else {
      items.addAll(
          uiModel.repos.map((repo) => _buildRepoListItem(eventHandler, repo)));
    }
    return Scaffold(
        appBar: AppBar(
          title: const Text(Strings.homeTitle),
        ),
        body: ListView(
          children: items,
        ));
  }

  /// GitHubリポジトリ1個分のListViewの行Widgetを作成する
  ///
  /// [eventHandler] イベント処理担当オブジェクト
  /// [repo] GitHubリポジトリ
  Widget _buildRepoListItem(HomeEventHandler eventHandler, GithubRepo repo) {
    return Column(
      children: [
        _buildLine1(eventHandler, repo),
        HomeRepoListItemDescription(repo.description),
        const Divider(
          thickness: 1,
        )
      ],
    );
  }

  /// リポジトリ名、フォークラベル、「いいね」ボタンのWidgetを作成する
  Widget _buildLine1(HomeEventHandler eventHandler, GithubRepo repo) {
    return Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
      const SizedBox(width: 16),
      // GitHubリポジトリ名
      Expanded(
        child: Text(
          repo.name,
          style: const TextStyle(fontSize: 16, color: MyColors.textHE),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
      ),
      // フォークラベル
      Visibility(visible: repo.fork, child: const SizedBox(width: 16)),
      Visibility(
          visible: repo.fork,
          child: Container(
            padding: const EdgeInsets.fromLTRB(12, 6, 12, 6),
            decoration: BoxDecoration(
                color: MyColors.forkLabelBackground,
                borderRadius: BorderRadius.circular(8)),
            child: const Text(
              Strings.fork,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: MyColors.white),
            ),
          )),
      // 「いいね」ボタン
      IconButton(
        icon: Icon(Icons.favorite,
            color: repo.favorite ? MyColors.likeOn : MyColors.likeOff),
        tooltip: Strings.like,
        onPressed: () {
          eventHandler.onClickFavorite(repo.name, !repo.favorite);
        },
      ),
    ]);
  }
}

/// 読み込み中プログレス行Widget
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

///説明文Widget
class HomeRepoListItemDescription extends StatelessWidget {
  final String _description;

  const HomeRepoListItemDescription(this._description, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Visibility(
          visible: _description.isNotEmpty,
          child: Container(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
            width: double.infinity,
            child: Text(_description,
                style: const TextStyle(color: MyColors.textME, fontSize: 14)),
          ),
        ),
        const SizedBox(height: 8)
      ],
    );
  }
}
