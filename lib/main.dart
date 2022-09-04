import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nightout/router.gr.dart';
import 'package:nightout/theme.dart';
import 'package:nightout/utils/fake/main.dart';

void main() async {
  createFakeGroups();
  runApp(ProviderScope(child: App()));
}

class App extends StatelessWidget {
  App({Key? key}) : super(key: key);

  final AppRouter router = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: router.delegate(),
      routeInformationParser: router.defaultRouteParser(),
      themeMode: ThemeMode.dark,
      title: 'NightOut',
      theme: nightoutTheme(context),
    );
  }
}
