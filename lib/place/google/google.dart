import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_place/google_place.dart';
import 'package:http/http.dart' as http;
import 'package:nightout/geolocalization/geolocalization.dart';
import 'package:nightout/place/place.dart';

final googlePlacesRepositoryProvider =
    Provider((ref) => GooglePlacesRepository());

class GooglePlacesRepository {
  static const apiKey = "AIzaSyBMS-yX_sDHkpntyOwGoi5qjjetN7ByFec";

  final googlePlaces = GooglePlace(apiKey);

  Future<List<Place>> getNearByPlaces(Position position, int radius) async {
    debugPrint("getNearByPlaces($position, $radius)");

    GooglePlace.timeout = const Duration(milliseconds: 5000);

    final nightClubs = _getNearByPlacesByType(position, radius, "night_club");
    final bars = _getNearByPlacesByType(position, radius, "bar");
    final cafes = _getNearByPlacesByType(position, radius, "cafe");
    final searchResultsFutures = [
      nightClubs,
      bars,
      cafes,
    ];
    final searchResults =
        (await Future.wait(searchResultsFutures)).expand((element) => element);

    return searchResults.map((e) => Place.fromSearchResults(e)).toList();
  }

  Future<List<SearchResult>> _getNearByPlacesByType(
      Position position, int radius, String type) async {
    final searchResults = <SearchResult>[];
    NearBySearchResponse nearBySearchResponse;
    String? nextPageToken;
    do {
      nearBySearchResponse = await _getNearBySearch(
          Location(lat: position.latitude, lng: position.longitude), radius,
          pagetoken: nextPageToken, type: type);

      debugPrint("nearBySearch = $nearBySearchResponse");

      searchResults.addAll(nearBySearchResponse.results ?? []);

      nextPageToken = nearBySearchResponse.nextPageToken;
    } while (nextPageToken != null);

    return searchResults;
  }

  Future<NearBySearchResponse> _getNearBySearch(
    Location location,
    int radius, {
    String? keyword,
    String? language,
    int? minprice,
    int? maxprice,
    String? name,
    bool? opennow,
    RankBy? rankby,
    String? type,
    String? pagetoken,
  }) async {
    var queryParameters = _createNearBySearchParameters(
      apiKey,
      location,
      radius,
      keyword,
      language,
      minprice,
      maxprice,
      name,
      opennow,
      rankby,
      type,
      pagetoken,
    );

    const authority = 'maps.googleapis.com';
    const unencodedPathNearBySearch = 'maps/api/place/nearbysearch/json';

    var uri = Uri.https(authority, unencodedPathNearBySearch, queryParameters);
    var response = await fetchUrl(uri, headers: const {});
    return NearBySearchResponse.parseNearBySearchResult(response);
  }

  Future<String> fetchUrl(
    Uri uri, {
    Map<String, String>? headers,
  }) async {
    try {
      final response =
          await http.get(uri, headers: headers).timeout(GooglePlace.timeout);
      if (response.statusCode == 200) {
        return response.body;
      }
      return Future.error(response);
    } catch (e) {
      return Future.error(e);
    }
  }

  Map<String, String?> _createNearBySearchParameters(
    apiKEY,
    Location location,
    int radius,
    String? keyword,
    String? language,
    int? minprice,
    int? maxprice,
    String? name,
    bool? opennow,
    RankBy? rankby,
    String? type,
    String? pagetoken,
  ) {
    Map<String, String?> queryParameters = {
      'location': '${location.lat},${location.lng}',
      'key': apiKEY,
      'radius': radius.toString(),
    };

    if (keyword != null && keyword != '') {
      var item = {
        'keyword': keyword,
      };
      queryParameters.addAll(item);
    }

    if (language != null && language != '') {
      var item = {
        'language': language,
      };
      queryParameters.addAll(item);
    }

    if (minprice != null) {
      var item = {
        'minprice': minprice.toString(),
      };
      queryParameters.addAll(item);
    }

    if (maxprice != null) {
      var item = {
        'maxprice': maxprice.toString(),
      };
      queryParameters.addAll(item);
    }

    if (name != null && name != '') {
      var item = {
        'name': name,
      };
      queryParameters.addAll(item);
    }

    if (opennow != null && opennow) {
      var item = {
        'opennow': 'opennow',
      };
      queryParameters.addAll(item);
    }

    if (rankby != null) {
      String? value;
      if (rankby == RankBy.Prominence) {
        value = 'prominence';
      }
      if (rankby == RankBy.Distance) {
        value = 'distance';
        queryParameters.remove('radius');
      }

      var item = {
        'rankby': value,
      };
      queryParameters.addAll(item);
    }

    if (type != null && type != '') {
      var item = {
        'type': type,
      };
      queryParameters.addAll(item);
    }

    if (pagetoken != null && pagetoken != '') {
      var item = {
        'pagetoken': pagetoken,
      };
      queryParameters.addAll(item);
    }

    return queryParameters;
  }
}

extension LocationConversion on Location {
  LatLng toLatLng() {
    return LatLng(lat!, lng!);
  }
}
