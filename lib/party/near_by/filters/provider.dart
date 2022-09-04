import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nightout/party/near_by/filters/filters.dart';
import 'package:nightout/tag/tag.dart';

const _defaultRadius = 3000;
const minRadiusInMeters = 500;
const maxRadiusInMeters = 50000;

final radiusProvider = StateProvider<int>((ref) => _defaultRadius);

final radiusKmProvider = Provider((ref) => ref.watch(radiusProvider) / 1000);

final radiusSliderValueProvider = StateProvider<double>((ref) {
  final radius = ref.watch(radiusProvider);
  return (radius / (maxRadiusInMeters - minRadiusInMeters)).clamp(0, 1);
});
final radiusTextDataVariableProvider = StateProvider<int>((ref) {
  return ref.watch(radiusProvider);
});
final radiusKmTextDataVariableProvider = StateProvider<double>((ref) {
  return ref.watch(radiusTextDataVariableProvider) / 1000;
});

final excludedPartyTypesProvider = StateProvider<Set<PartyType>>((ref) => {});
final excludedTagsProvider = StateProvider<Set<Tag>>((ref) => {});