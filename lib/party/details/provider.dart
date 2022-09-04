import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nightout/appwrite/appwrite.dart';
import 'package:nightout/party/near_by/near_by.dart';
import 'package:nightout/party/party.dart';

final partyDetailsPartyProvider =
    FutureProvider.family<Party, String>((ref, id) async {
      final document = await databases.getDocument(collectionId: partiesCollectionId, documentId: id);
      return Party.fromDocument(document, ref);
    });
