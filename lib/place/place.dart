import 'package:appwrite/models.dart';
import 'package:google_place/google_place.dart';
import 'package:nightout/geolocalization/geolocalization.dart';
import 'package:nightout/place/google/google.dart';
import 'package:nightout/tag/tag.dart';
import 'package:nightout/utils/lat_lng.dart';

export 'provider.dart';
export 'repository.dart';

class Place {
  String id;
  String name;
  LatLng position;
  List<Tag> tags;

  Place({
    required this.id,
    required this.position,
    required this.name,
    required this.tags,
  });

  factory Place.fromDocument(Document document) {
    return Place(
      id: document.$id,
      position: parseLatLng(document.data["position"]),
      name: document.data["name"],
      tags: (document.data["tags"] as List<dynamic>)
          .map((e) => Tag(e as String))
          .toList(),
    );
  }

  factory Place.fromSearchResults(SearchResult e) {
    return Place(
      id: e.id ?? e.placeId!,
      position: e.geometry!.location!.toLatLng(),
      name: e.name!,
      tags: e.types!.map((e) => Tag(e)).toList(),
    );
  }
}
