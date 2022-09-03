import 'package:appwrite/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nightout/geolocalization/geolocalization.dart';
import 'package:nightout/group/group.dart';
import 'package:nightout/place/place.dart';
import 'package:nightout/tag/tag.dart';
import 'package:uuid/uuid.dart';

export 'widget.dart';

class Party {
  String id = const Uuid().v4();
  String name;
  List<Place> places;
  List<Group> groups;
  List<Tag> tags;
  Crowdedness? crowdedness;
  LatLng position;

  Party({
    required this.id,
    required this.name,
    required this.places,
    required this.groups,
    required this.tags,
    this.crowdedness,
    required this.position,
  });

  factory Party.fromDocument(Document e, Ref ref) {
    throw "not implemented";
  }
}

class Crowdedness {
  final int capacity;
  final int occupied;

  Crowdedness(this.capacity, this.occupied);

  double get crowdedness => occupied / capacity;
}
