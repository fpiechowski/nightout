import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nightout/appwrite/appwrite.dart';
import 'package:nightout/group/group.dart';
import 'package:nightout/group/userGroups/provider.dart';
import 'package:nightout/group/userGroups/user_groups.dart';

final groupByIdProvider = FutureProvider.family<Group, String>((ref, id) {
  return ref.watch(groupRepositoryProvider).getById(id, ref);
});

final updateGroupProvider = FutureProvider.family<void, Group>(
  (ref, group) => databases.updateDocument(
    collectionId: groupCollectionId,
    documentId: group.id,
    data: group.toMap(),
  ),
);
