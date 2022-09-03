import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nightout/place/place.dart';
import 'package:nightout/scaffold/details.dart';

class PlaceDetails extends ConsumerWidget {
  final Place place;

  const PlaceDetails(
    this.place, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Details(
      title: place.name,
      appBarBackground: DetailsPhotosGridBackground(
        crossAxisCount: 3,
        children: [
          ...List.generate(
            10,
            (index) => Image.network(
              "https://picsum.photos/seed/${faker.lorem.word()}/200",
            ),
          )
        ],
      ),
      appBarChild: Wrap(
        spacing: 5,
        children: [
          ...place.tags.map((tag) => Chip(
                label: Text(tag.name),
              )),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.emoji_people),
        onPressed: () {},
      ),
    );
  }
}
