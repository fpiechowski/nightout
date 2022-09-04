import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nightout/geolocalization/geolocalization.dart';
import 'package:nightout/party/near_by/filters/filters.dart';

import '../party.dart';

final filteredNearByPartiesProvider = FutureProvider((ref) async {
  final nearByParties = await ref.watch(nearByPartiesProvider.future);
  final excludedTags = ref.watch(excludedTagsProvider);

  final filteredNearByParties = nearByParties
      .where(
        (element) => !element.tags.any((tag) => excludedTags.contains(tag)),
      )
      .toList();

  return filteredNearByParties;
});

final nearByPartiesProvider = FutureProvider((ref) async {
  debugPrint("nearByPartiesProvider");
  final partiesRepository = ref.read(partiesRepositoryProvider);

  final radius = ref.watch(radiusProvider);
  final position = await ref.watch(positionProvider.future);

  final allParties = await partiesRepository.getNearByParties(
    position: position,
    radius: radius,
  );

  return allParties;
});
