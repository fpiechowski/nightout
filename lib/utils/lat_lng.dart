import 'package:nightout/geolocalization/geolocalization.dart';

LatLng parseLatLng(String string) {
  final split = string.split(",");
  final lat = split[0];
  final lng = split[1];
  return LatLng(double.parse(lat), double.parse(lng));
}
