import 'package:flutter/material.dart';
import 'package:flutter_architecture_sample/resource/strings.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'feature/home/widget/home_screen.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
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
        routes: {"/": (context) => const HomeScreen()});
  }
}
