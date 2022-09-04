import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nightout/appwrite/appwrite.dart';
import 'package:nightout/group/join/data.dart';
import 'package:nightout/group/join/repository.dart';
import 'package:nightout/group/provider.dart';
import 'package:nightout/profile/provider.dart';

final groupInvitationRepositoryProvider =
    Provider((ref) => GroupInvitationRepository(ref));

final groupInvitationsProvider =
    FutureProvider.family<List<GroupInvitation>, String>((ref, id) {
  return ref.watch(groupInvitationRepositoryProvider).getByGroupId(id);
});

final acceptGroupInvitation =
    Provider.family<void, GroupInvitation>((ref, invitation) async {
  final group = await ref.read(groupProvider(invitation.groupId).future);
  final profile = await ref
      .read(profileByPhoneNumberProvider(invitation.phoneNumber).future);

  group.members.add(profile);
  ref.read(updateGroupProvider(group));

  await databases.deleteDocument(
      collectionId: groupInvitationsCollectionId, documentId: invitation.id);
});

final rejectGroupInvitation =
    Provider.family<void, GroupInvitation>((ref, invitation) async {
  await databases.deleteDocument(
      collectionId: groupInvitationsCollectionId, documentId: invitation.id);
});
