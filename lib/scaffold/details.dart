import 'package:flutter/material.dart';
import 'package:nightout/scaffold/scaffold.dart';

class Details extends StatelessWidget {
  final List<Widget> slivers;
  final String title;
  final Widget? floatingActionButton;
  final Widget? appBarBackground;
  final Widget? appBarChild;
  final List<Widget> actions;

  Details({
    required this.title,
    required this.appBarBackground,
    required this.appBarChild,
    List<Widget>? actions,
    List<Widget>? slivers,
    this.floatingActionButton,
    Key? key,
  })  : slivers = slivers ?? [],
        actions = actions ?? [],
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return NightOutScaffold.poppableSliver(
      body: CustomScrollView(
        slivers: [
          DetailsAppBar(
            title: title,
            actions: actions,
            background: appBarBackground,
            child: appBarChild,
          ),
          ...slivers,
        ],
      ),
      floatingActionButton: floatingActionButton,
    );
  }
}

class DetailsAppBar extends StatelessWidget {
  final String title;
  final List<Widget> actions;

  final Widget? background;
  final Widget? child;

  DetailsAppBar({
    required this.title,
    this.background,
    this.child,
    List<Widget>? actions,
    Key? key,
  })  : actions = actions ?? [],
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: Icon(
          Icons.arrow_back,
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
      actions: actions,
      expandedHeight: 250,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          children: [
            if (background != null) background!,
            Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.8)),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 16.0, right: 16.0, bottom: 8.0, top: 80),
              child: child,
            )
          ],
        ),
        centerTitle: false,
        title: Text(title,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).appBarTheme.titleTextStyle),
      ),
    );
  }
}

class DetailsPhotosGridBackground extends StatelessWidget {
  final int crossAxisCount;
  final List<Widget> children;

  const DetailsPhotosGridBackground(
      {required this.children, required this.crossAxisCount, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: crossAxisCount,
      children: children,
    );
  }
}

class DetailsActionButton extends StatelessWidget {
  final void Function() onPressed;

  final Widget child;

  const DetailsActionButton({
    required this.onPressed,
    required this.child,
    Key? key,
  }) : super(key: key);

  IconThemeData iconThemeData(BuildContext context) =>
      IconThemeData(color: Theme.of(context).backgroundColor);

  ElevatedButtonThemeData elevatedButtonThemeData(BuildContext context) =>
      ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.onSurface,
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(2),
      ));

  @override
  Widget build(BuildContext context) {
    return ElevatedButtonTheme(
      data: elevatedButtonThemeData(context),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ElevatedButton(
          onPressed: onPressed,
          child: IconTheme(data: iconThemeData(context), child: child),
        ),
      ),
    );
  }
}
