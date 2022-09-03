import 'package:flutter/material.dart';

class GradientCard extends StatelessWidget {
  final Widget? child;
  final double? elevation;
  final Color? color;
  final EdgeInsetsGeometry? padding;

  const GradientCard({Key? key, this.child, this.elevation, this.color, this.padding}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color ?? Theme.of(context).colorScheme.surface,
      elevation: elevation ?? 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      clipBehavior: Clip.antiAlias,
      child: Container(
        padding: padding,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Colors.transparent,
            Theme.of(context).colorScheme.background.withOpacity(0.5),
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
        ),
        child: child,
      ),
    );
  }
}
