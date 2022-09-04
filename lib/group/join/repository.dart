import 'package:appwrite/appwrite.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nightout/appwrite/appwrite.dart';
import 'package:nightout/group/join/data.dart';
import 'package:riverpod/src/provider.dart';

const groupInvitationsCollectionId = "6314cbb01e2fa574fe98";

class GroupInvitationRepository {
  final Ref ref;

  GroupInvitationRepository(this.ref);

  Future<List<GroupInvitation>> getByGroupId(String groupId) async {
    return await databases.listDocuments(
      collectionId: groupInvitationsCollectionId,
      queries: [Query.equal("groupId", groupId)],
    ).then(
      (value) =>
          value.documents.map((e) => GroupInvitation.fromDocument(e)).toList(),
    );
  }
}
