import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nightout/geolocalization/geolocalization.dart';
import 'package:nightout/party/near_by/map/card/card.dart';
import 'package:nightout/party/near_by/map/marker/marker.dart';
import 'package:nightout/party/near_by/map/provider.dart';
import 'package:nightout/party/near_by/provider.dart';
import 'package:nightout/party/party.dart';
import 'package:nightout/utils/also.dart';

class Map extends ConsumerWidget {
  const Map({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue<CameraPosition>>(cameraPositionProvider,
        (previous, next) {
      final googleMapController = ref.read(googleMapControllerProvider);

      next.when(
        data: (cameraPosition) => googleMapController
            ?.moveCamera(CameraUpdate.newCameraPosition(cameraPosition)),
        error: (error, st) => debugPrint(error.toString()),
        loading: () => debugPrint("loading next cameraPosition"),
      );
    });

    ref.listen(
      filteredNearByPartiesProvider,
      (previous, next) {},
      onError: (error, st) {
        debugPrint(error.toString());
        debugPrintStack(stackTrace: st);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error.toString()),
            action: SnackBarAction(
              label: "Retry",
              onPressed: () => ref.refresh(filteredNearByPartiesProvider),
            ),
          ),
        );
      },
    );

    return Stack(
      children: [
        CustomGoogleMapMarkerBuilder(
          customMarkers: ref.watch(filteredNearByPartiesProvider).when(
              data: (data) => data
                  .map((e) => e.toMarkerData(Theme.of(context), ref))
                  .toList()
                  .also((it) => debugPrint("customMarkers = $it")),
              error: (error, st) {
                return <MarkerData>[];
              },
              loading: () => <MarkerData>[]),
          builder: (BuildContext context, Set<Marker>? markers) {
            return GoogleMap(
              onTap: (_) {
                ref.read(selectedPartyProvider.notifier).state = null;
              },
              markers: markers ?? {},
              initialCameraPosition: ref.watch(cameraPositionProvider).when(
                    data: (data) => data,
                    error: (error, st) =>
                        const CameraPosition(target: LatLng(0, 0)),
                    loading: () => const CameraPosition(target: LatLng(0, 0)),
                  ),
              onMapCreated: (controller) {
                controller.setMapStyle(mapStyle);
                ref.read(googleMapControllerProvider.notifier).state =
                    controller;
              },
              compassEnabled: false,
              mapToolbarEnabled: false,
              myLocationButtonEnabled: true,
              myLocationEnabled: true,
            );
          },
        ),
        Wrap(children: const [PartyCard()])
      ],
    );
  }
}

const String mapStyle = '''[
  {
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#242f3e"
      }
    ]
  },
  {
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#746855"
      }
    ]
  },
  {
    "elementType": "labels.text.stroke",
    "stylers": [
      {
        "color": "#242f3e"
      }
    ]
  },
  {
    "featureType": "administrative.locality",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#d59563"
      }
    ]
  },
  {
    "featureType": "poi",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#d59563"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#263c3f"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#6b9a76"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#38414e"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "geometry.stroke",
    "stylers": [
      {
        "color": "#212a37"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#9ca5b3"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#746855"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "geometry.stroke",
    "stylers": [
      {
        "color": "#1f2835"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#f3d19c"
      }
    ]
  },
  {
    "featureType": "transit",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#2f3948"
      }
    ]
  },
  {
    "featureType": "transit.station",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#d59563"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#17263c"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#515c6d"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "labels.text.stroke",
    "stylers": [
      {
        "color": "#17263c"
      }
    ]
  }
]''';
