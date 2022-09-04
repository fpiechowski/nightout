import 'package:appwrite/appwrite.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nightout/appwrite/appwrite.dart';
import 'package:nightout/profile/profile.dart';
import 'package:nightout/profile/repository.dart';

final profileByIdProvider =
    FutureProvider.family<Profile, String>((ref, id) async {
  final document = await databases.getDocument(
      collectionId: "6304f0f90cdcfa4a3eb5", documentId: id);
  return Profile.fromDocument(document, ref);
});

final profileByIdInProvider =
    FutureProvider.family<List<Profile>, List<String>>((ref, ids) async {
  final documentList = await databases.listDocuments(
      collectionId: "6304f0f90cdcfa4a3eb5",
      queries: [Query.equal("\$id", ids)]);
  return await Future.wait(
      documentList.documents.map((e) async => Profile.fromDocument(e, ref)));
});

final profileByPhoneNumberProvider =
    FutureProvider.family<Profile, String>((ref, phoneNumber) async {
  final documentList = await databases.listDocuments(
    collectionId: "6304f0f90cdcfa4a3eb5",
    queries: [Query.equal("phoneNumber", phoneNumber)],
  );

  final document = documentList.documents.first;

  return await Profile.fromDocument(document, ref);
});

final profileRepositoryProvider = Provider((ref) => ProfileRepository());
