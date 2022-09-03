import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';

export 'package:geolocator/geolocator.dart';
export 'package:google_maps_flutter/google_maps_flutter.dart';
export 'package:custom_map_markers/custom_map_markers.dart';

final geolocalizationRepositoryProvider =
    Provider((ref) => GeolocalizationRepository());

final FutureProvider<Stream<Position>> positionStreamProvider = FutureProvider<Stream<Position>>((ref) async {
  final geolocalizationRepository = ref.read(geolocalizationRepositoryProvider);
  return geolocalizationRepository.positionStream;
});

final StreamProvider<Position> positionProvider = StreamProvider<Position>((ref) async* {
  debugPrint("positionProvider");
  yield* await ref.watch(positionStreamProvider.future);
});

class GeolocalizationRepository {
  Future<Stream<Position>> get positionStream async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return Geolocator.getPositionStream(locationSettings: locationSettings);
  }

  static const LocationSettings locationSettings = LocationSettings(
    accuracy: LocationAccuracy.high,
    distanceFilter: 100,
  );
}

