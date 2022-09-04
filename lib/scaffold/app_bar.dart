import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:nightout/utils/lorem_picsum.dart';

class NightOutAppBar extends StatelessWidget implements PreferredSizeWidget {
  final List<Widget> actions;
  final WidgetBuilder leading;

  NightOutAppBar.home({Key? key, List<Widget>? actions})
      : actions = actions ?? [],
        leading = _homeLeadingBuilder,
        super(key: key);

  static Widget _homeLeadingBuilder(BuildContext context) => IconButton(
        onPressed: () => throw "not implemented",
        icon: Padding(
          padding: const EdgeInsets.all(2.0),
          child: CircleAvatar(
            backgroundImage:
                NetworkImage(loremPicsum(size: const Size.square(50))),
            child: const Align(
              alignment: Alignment.bottomRight,
              child: CircleAvatar(
                backgroundColor: Colors.green,
                radius: 6,
              ),
            ),
          ),
        ),
      );

  NightOutAppBar.popable({Key? key, List<Widget>? actions})
      : leading = _poppableLeadingBuilder,
        actions = actions ?? [],
        super(key: key);

  static Widget _poppableLeadingBuilder(BuildContext context) => IconButton(
        onPressed: () => AutoRouter.of(context).pop(),
        icon: const Icon(Icons.arrow_back),
      );

  Widget? get title => const Center(
        child: Text("NightOut"),
      );

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title,
      leading: leading(context),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
