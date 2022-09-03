import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nightout/appwrite/appwrite.dart';
import 'package:nightout/group/group.dart';
import 'package:nightout/group/userGroups/user_groups.dart';
import 'package:nightout/utils/fake/main.dart';

final fakeUserGroupsProvider = FutureProvider(
  (ref) async {
    return generateGroups();
  },
);

final userGroupsProvider = FutureProvider<List<Group>>((ref) async {
  final user = await account.get();
  final groupRepository = ref.watch(groupRepositoryProvider);
  final userGroups = await groupRepository.getByMember(user.$id, ref);

  return (userGroups.toList()..sort()).reversed.toList();
});

final groupRepositoryProvider = Provider((ref) => GroupRepository());
