import 'package:flutter/material.dart';

class ImageLabeledButton extends StatelessWidget {
  final ImageProvider image;
  final String label;

  const ImageLabeledButton({required this.image, required this.label, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 3,
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      clipBehavior: Clip.antiAlias,
      onPressed: () {},
      child: Stack(
        children: <Widget>[
          _Image(image: image),
          const _Gradient(),
          _Label(label: label)
        ],
      ),
    );
  }
}

class _Image extends StatelessWidget {
  final ImageProvider image;

  const _Image({required this.image, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        image: DecorationImage(
          fit: BoxFit.fill,
          image: image,
        ),
      ),
      height: 100.0,
    );
  }
}

class _Gradient extends StatelessWidget {
  const _Gradient({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          gradient: LinearGradient(
              begin: FractionalOffset.topCenter,
              end: FractionalOffset.bottomCenter,
              colors: [
                Colors.grey.withOpacity(0.0),
                Colors.black.withOpacity(0.8),
              ],
              stops: const [
                0.0,
                1.0
              ])),
    );
  }
}

class _Label extends StatelessWidget {
  final String label;

  const _Label({required this.label, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      constraints: const BoxConstraints(),
      child: Padding(
        padding: const EdgeInsets.only(left: 12.0, bottom: 9.0, right: 10),
        child: Align(
          alignment: Alignment.bottomRight,
          child: Text(
            label,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.subtitle1?.copyWith(shadows: [
              Shadow(
                color: Theme.of(context).backgroundColor,
                blurRadius: 5,
              )
            ]),
          ),
        ),
      ),
    );
  }
}
