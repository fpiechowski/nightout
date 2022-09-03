import 'package:appwrite/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nightout/place/place.dart';
import 'package:nightout/utils/also.dart';

class Profile {
  String firstName;
  String id;
  String phoneNumber;

  List<Place> favoritePlaces = [];

  Profile({required this.id, required this.firstName, required this.phoneNumber, required this.favoritePlaces});

  static Future<Profile> fromDocument(Document document, Ref ref) async {
    final favoritePlaces = await (document.data["favoritePlaces"] as List<dynamic>)
        .map((e) => e as String)
        .toList()
        .let((placesIds) async => await ref.watch(placesByIdInProvider(placesIds).future));
    return Profile(
      id: document.$id,
      firstName: document.data["firstName"],
      phoneNumber: document.data["phoneNumber"],
      favoritePlaces: favoritePlaces,
    );
  }
}
