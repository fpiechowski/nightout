import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nightout/utils/image_labeled_button.dart';
import 'package:nightout/utils/lorem_picsum.dart';

class Catalogue extends ConsumerWidget {
  const Catalogue({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GridView.count(
      crossAxisCount: 2,
      children: [
        ...List.generate(
          10,
          (index) => GridTile(
            child: ImageLabeledButton(
              label: faker.lorem.sentence(),
              image: NetworkImage(
                loremPicsum(size: const Size(300, 300)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
