import 'package:flutter/material.dart';
import 'package:nightout/utils/also.dart';

class GlowingFloatingActionButton extends FloatingActionButton {
  const GlowingFloatingActionButton(
      {Key? key, required super.onPressed, super.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.all(
            Radius.elliptical(shape?.dimensions.horizontal ?? 100,
                shape?.dimensions.vertical ?? 100),
          ),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).let((it) => it.floatingActionButtonTheme.backgroundColor ?? it.primaryColor).withOpacity(0.6),
              spreadRadius: 2,
              blurRadius: 4,
            )
          ]),
      child: FloatingActionButton(
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}
