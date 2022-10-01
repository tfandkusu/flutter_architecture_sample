// ignore_for_file: dead_code

import 'package:flutter/material.dart';
import 'package:flutter_architecture_sample/data/remote/github_repo_remote_data_source_dummy.dart';
import 'package:flutter_architecture_sample/data/remote/github_repo_remote_data_source_provider.dart';
import 'package:flutter_architecture_sample/resource/strings.dart';
import 'package:flutter_architecture_sample/screen/detail/widget/detail_screen.dart';
import 'package:flutter_architecture_sample/screen/home/widget/home_screen.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  final overrides = false
      ? <Override>[
          githubRepoRemoteDataSourceProvider
              .overrideWithValue(GitHubRepoRemoteDataSourceDummy())
        ]
      : <Override>[];
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
