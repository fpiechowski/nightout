import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nightout/party/details/party_details.dart';
import 'package:nightout/party/party.dart';
import 'package:nightout/scaffold/details.dart';
import 'package:nightout/utils/error.dart';
import 'package:nightout/utils/loading.dart';

class PartyDetails extends ConsumerWidget {
  final String partyId;

  const PartyDetails({
    Key? key,
    required this.partyId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(partyDetailsPartyProvider(partyId)).when(
          data: (data) => Details(
            title: data.name,
            appBarBackground: const DetailsPhotosGridBackground(
              crossAxisCount: 3,
              children: [],
            ),
            appBarChild: partyDetailsAppBarChild(data, ref),
          ),
          error: (Object error, StackTrace? stackTrace) =>
              Error(error, stackTrace: stackTrace),
          loading: () => const Loading(),
        );
  }

  Widget partyDetailsAppBarChild(Party data, WidgetRef ref) {
    throw "";
  }
}
