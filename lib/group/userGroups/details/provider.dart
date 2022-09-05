import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nightout/appwrite/appwrite.dart';
import 'package:nightout/group/group.dart';
import 'package:nightout/tag/tag.dart';
import 'package:nightout/profile/provider.dart';
import 'package:nightout/utils/lat_lng.dart';

final favoriteTagsWrappedProvider = StateProvider<bool>((ref) => true);

final userGroupProvider = FutureProvider.family<Group, String>((ref, id) async {
  final document = await databases.getDocument(
      collectionId: "6304ecf5c1b63cc9b76f", documentId: id);

  return Group(
    id: document.$id,
    leader: await ref
        .watch(profileByIdProvider(document.data["leader"] as String).future),
    members: await ref.watch(profileByIdInProvider(
            (document.data["members"] as List<dynamic>)
                .map((e) => e as String)
                .toList())
        .future),
    groupStatus: GroupStatus.fromId(document.data["groupStatus"] as String,
        goingOutDateTime: DateTime.fromMillisecondsSinceEpoch(
            document.data["goingOutDateTime"])),
    lastActivity: DateTime.fromMillisecondsSinceEpoch(
        document.data["lastActivityDateTime"]),
    tags: (document.data["tags"] as List<dynamic>).map((e) => Tag(e as String)).toList(),
  );
});

