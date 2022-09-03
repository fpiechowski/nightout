import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nightout/geolocalization/geolocalization.dart';
import 'package:nightout/party/party.dart';

extension PartyMarkerData on Party {
  MarkerData toMarkerData(ThemeData themeData, WidgetRef ref) {
    Widget child = Container(
      width: 42,
      height: 42,
      decoration: BoxDecoration(
        border: Border.all(color: themeData.colorScheme.secondary, width: 1),
        color: themeData.colorScheme.background,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(color: themeData.colorScheme.secondary, blurRadius: 3)
        ],
      ),
      child: Center(
        child: Icon(
          Icons.place,
          color: themeData.colorScheme.secondary,
        ),
      ),
    );

    return MarkerData(
      marker: Marker(
        markerId: MarkerId(id),
        position: position,
        onTap: () {
          debugPrint("Marker.onTap");
          ref.read(selectedPartyProvider.notifier).state = this;
        },
      ),
      child: child,
    );
  }
}
