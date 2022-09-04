import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nightout/geolocalization/geolocalization.dart';
import 'package:nightout/party/near_by/filters/filters.dart';

final cameraPositionProvider = FutureProvider((ref) async {
  debugPrint("cameraPositionProvider");

  final position = await ref.watch(positionProvider.future);
  final radius = ref.watch(radiusProvider);

  return CameraPosition(
    target: LatLng(position.latitude, position.longitude),
    zoom: MapUtils.getZoomLevel(radius.toDouble()),
  );
});

final googleMapControllerProvider =
    StateProvider<GoogleMapController?>((ref) => null);

class MapUtils {
  static double getZoomLevel(double radius) {
    double zoomLevel = 11;
    if (radius > 0) {
      double radiusElevated = radius + radius / 2;
      double scale = radiusElevated / 500;
      zoomLevel = 16 - math.log(scale) / math.log(2);
    }

    zoomLevel = num.parse(zoomLevel.toStringAsFixed(2)).toDouble();
    return zoomLevel;
  }
}
