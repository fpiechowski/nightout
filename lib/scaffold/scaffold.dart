import 'package:flutter/material.dart';
import 'package:nightout/scaffold/app_bar.dart';
import 'package:nightout/scaffold/bottom_app_bar.dart';
import 'package:nightout/utils/glowing_fab.dart';

class NightOutScaffold extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Widget? body;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation floatingActionButtonLocation;
  final Widget? bottomNavigationBar;

  NightOutScaffold.home({Key? key, this.body})
      : appBar = NightOutAppBar.home(),
        bottomNavigationBar = const NightOutBottomNavigationBar.home(),
        floatingActionButtonLocation =
            FloatingActionButtonLocation.centerDocked,
        floatingActionButton = GlowingFloatingActionButton(onPressed: () {}),
        super(key: key);

  NightOutScaffold.poppable({
    Key? key,
    this.body,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.floatingActionButtonLocation = FloatingActionButtonLocation.endFloat,
  })  : appBar = NightOutAppBar.popable(),
        super(key: key);

  const NightOutScaffold.poppableSliver({
    Key? key,
    this.body,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.floatingActionButtonLocation = FloatingActionButtonLocation.endFloat,
  })  : appBar = null,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: body,
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
