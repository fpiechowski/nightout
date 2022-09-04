import 'dart:convert';

import 'package:appwrite/appwrite.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nightout/appwrite/appwrite.dart';
import 'package:nightout/party/data.dart';
import 'package:nightout/place/google/google.dart';

import '../geolocalization/geolocalization.dart';

const String partiesCollectionId = "63125488d50e148853f0";

final partiesRepositoryProvider = Provider((ref) => PartiesRepository(ref));

class PartiesRepository {
  final Ref ref;

  PartiesRepository(this.ref);

  Future<List<Party>> getNearByParties({
    required Position position,
    required int radius,
  }) async {
    Iterable<Party> googlePlacesParties = await getGooglePlacesParties(
      position,
      radius,
    );

    Iterable<Party> parties = await _getNearByParties(position, radius);

    return parties.followedBy(googlePlacesParties).toList();
  }

  Future<List<Party>> getPartiesByIdIn(List<String> ids) async {
    final listDocuments = await databases.listDocuments(
      collectionId: partiesCollectionId,
      queries: ids.map((e) => Query.equal("id", e)).toList(),
    );

    return listDocuments.documents
        .map((e) => Party.fromDocument(e, ref))
        .toList();
  }

  Future<Iterable<Party>> getGooglePlacesParties(
    Position position,
    int radius,
  ) async {
    final googlePlaces = await ref
        .watch(googlePlacesRepositoryProvider)
        .getNearByPlaces(position, radius);

    final googlePlacesParties = googlePlaces.map(
      (e) => Party(
          id: "place:${e.id}",
          name: e.name,
          places: [e],
          groups: [],
          tags: e.tags,
          position: e.position),
    );

    return googlePlacesParties;
  }

  Future<Iterable<Party>> _getNearByParties(
      Position position, int radius) async {
    Map<String, dynamic> idToDistanceMap =
        await _getNearByPartiesIDs(position, radius);

    final parties = getPartiesByIdIn(idToDistanceMap.keys.toList());

    return parties;
  }

  Future<Map<String, dynamic>> _getNearByPartiesIDs(
      Position position, int radius) async {
    final execution = await functions.createExecution(
        functionId: "getNearByPartiesIDs",
        data: jsonEncode(
          GetNearByPartiesIDsExecutionData(
            GetNearByPartiesIDsExecutionDataPosition(
              position.longitude,
              position.latitude,
            ),
            radius,
          ),
        ),
        xasync: false);

    debugPrint("getNearByPartiesIDs = ${execution.response}");

    final Map<String, dynamic> idToDistanceMap = jsonDecode(execution.response);
    return idToDistanceMap;
  }
}

class GetNearByPartiesIDsExecutionData {
  final GetNearByPartiesIDsExecutionDataPosition position;
  final int radius;

  GetNearByPartiesIDsExecutionData(this.position, this.radius);

  Map<String, dynamic> toJson() {
    return {"position": position.toJson(), "radius": radius};
  }
}

class GetNearByPartiesIDsExecutionDataPosition {
  final double longitude;
  final double latitude;

  GetNearByPartiesIDsExecutionDataPosition(this.longitude, this.latitude);

  Map<String, dynamic> toJson() {
    return {"longitude": longitude, "latitude": latitude};
  }
}
