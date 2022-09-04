import 'package:nightout/tag/tag.dart';

class FiltersState {
  final Set<PartyType> excludedPartyTypes;
  final Set<Tag> excludedTags;
  final int radiusInMeters;

  FiltersState(this.excludedPartyTypes, this.excludedTags, this.radiusInMeters);
}

enum PartyType {
  place, group
}