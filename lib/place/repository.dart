import 'package:appwrite/appwrite.dart';
import 'package:nightout/appwrite/appwrite.dart';
import 'package:nightout/place/place.dart';

const placesCollectionId = "63111e71ae3c7e177871";

class PlaceRepository {
  Future<List<Place>> getPlacesByIdIn(List<String> ids) async {
    final documentList = await  databases.listDocuments(
      collectionId: placesCollectionId,
      queries: [Query.equal("\$id", ids)],
    );

    return documentList.documents.map((e) => Place.fromDocument(e)).toList();
  }
}
