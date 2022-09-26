import 'package:flutter/material.dart';
import 'package:flutter_architecture_sample/data/remote/github_repo_remote_data_store_dummy.dart';
import 'package:flutter_architecture_sample/data/remote/github_repo_remote_data_store_provider.dart';
import 'package:flutter_architecture_sample/feature/detail/widget/detail_screen.dart';
import 'package:flutter_architecture_sample/resource/strings.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'feature/home/widget/home_screen.dart';

void main() {
  final overrides = <Override>[
    githubRepoRemoteDataStoreProvider
        .overrideWithValue(GitHubRepoRemoteDataStoreDummy())
  ];
  runApp(ProviderScope(
    overrides: overrides,
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: Strings.appTitle,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: {
          "/": (context) => const HomeScreen(),
          DetailScreen.routeName: (context) => const DetailScreen()
        });
  }
}
