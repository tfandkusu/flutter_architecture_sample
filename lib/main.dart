import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'feature/home/home_screen.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Architecture Sample',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: {"/": (context) => const HomeScreen()});
  }
}
