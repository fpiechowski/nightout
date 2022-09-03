import 'package:appwrite/appwrite.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nightout/appwrite/appwrite.dart';
import 'package:nightout/profile/profile.dart';

const profilesCollectionId = "6304f0f90cdcfa4a3eb5";

class ProfileRepository {
  Future<Profile> getById(String id, Ref ref) async {
    return await databases.getDocument(
      collectionId: profilesCollectionId,
      documentId: id,
    ).then(
          (value) => Profile.fromDocument(value, ref),
    );
  }

  Future<List<Profile>> getByIdIn(List<String> ids, Ref ref)  async{
    final documentsList =  await databases.listDocuments(
      collectionId: "6304f0f90cdcfa4a3eb5",
      queries: [
        Query.equal("\$id", ids),
      ],
    );

    return await Future.wait(documentsList.documents.map((e) async => Profile.fromDocument(e, ref)));
  }
}