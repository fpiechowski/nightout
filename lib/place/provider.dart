import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nightout/place/place.dart';

final placeRepositoryProvider = Provider((ref) => PlaceRepository());

final placesByIdInProvider = FutureProvider.family<List<Place>, List<String>>((ref, ids) {
    final placeRepository = ref.watch(placeRepositoryProvider);
    return placeRepository.getPlacesByIdIn(ids);
});