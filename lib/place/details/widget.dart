import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nightout/place/place.dart';
import 'package:nightout/scaffold/details.dart';
import 'package:nightout/utils/error.dart';
import 'package:nightout/utils/loading.dart';

class PlaceDetails extends ConsumerWidget {
  final String placeId;

  static final placeProvider = FutureProvider.family<Place, String>(
    (ref, id) => ref.watch(placeRepositoryProvider).getPlaceById(id),
  );

  const PlaceDetails({
    Key? key,
    required this.placeId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(placeProvider(placeId)).when(
          data: (place) => Details(
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
          ),
          error: (error, st) => Error(error, stackTrace: st),
          loading: () => const Loading(),
        );
  }
}
