import 'package:appwrite/appwrite.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nightout/appwrite/appwrite.dart';
import 'package:nightout/group/group.dart';
import 'package:nightout/utils/also.dart';

const groupCollectionId = "6304ecf5c1b63cc9b76f";

class GroupRepository {
  static update(Group group) async {
    await databases.updateDocument(
        collectionId: groupCollectionId,
        documentId: group.id,
        data: group.toMap());
  }

  Future<List<Group>> getByMember(String id, Ref ref) async {
    return (await databases.listDocuments(
      collectionId: groupCollectionId,
      queries: [Query.search("members", id)],
    ))
        .documents
        .map((e) => Group.fromDocument(e, ref))
        .toList()
        .let((it) => Future.wait(it));
  }
}
