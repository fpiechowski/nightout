import 'package:appwrite/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nightout/group/group_status.dart';
import 'package:nightout/place/place.dart';
import 'package:nightout/profile/provider.dart';
import 'package:nightout/utils/lat_lng.dart';
import 'package:uuid/uuid.dart';

import '../../profile/profile.dart';
import '../tag/tag.dart';

export 'group_status.dart';
export 'route.dart';

class Group with Comparable<Group> {
  final String id;

  String get name => members.map((e) => e.firstName).join(", ");

  final List<Profile> members;

  final Profile leader;

  final LatLng position;

  final GroupStatus groupStatus;

  final DateTime lastActivity;

  final List<Tag> tags;

  Group({
    required this.id,
    required this.position,
    required this.leader,
    required this.members,
    required this.groupStatus,
    required this.lastActivity,
    required this.tags,
  });

  List<Place> get favoritePlaces =>
      members.expand((element) => element.favoritePlaces).toList();

  @override
  int compareTo(Group other) {
    final statusComparison = groupStatus.compareTo(other.groupStatus);
    if (statusComparison == 0) {
      return lastActivity.compareTo(other.lastActivity);
    } else {
      return statusComparison;
    }
  }

  Map<String, dynamic> toMap() {
    return {
      "leader": leader,
      "members": members.map((e) => e.id),
      "groupStatus": groupStatus.id,
      "lastActivity": lastActivity.millisecondsSinceEpoch,
      "position": position.toString(),
    };
  }

  static Future<Group> fromDocument(Document e, Ref ref) async {
    return Group(
      id: e.$id,
      position: parseLatLng(e.data["position"] as String),
      leader: Profile(
          id: const Uuid().v4(),
          phoneNumber: "",
          favoritePlaces: [],
          firstName: ''),
      members: await ref.watch(profileRepositoryProvider).getByIdIn(
            (e.data["members"] as List<dynamic>)
                .map((e) => e as String)
                .toList(),
            ref,
          ),
      groupStatus: GroupStatus.hangingOut(),
      lastActivity: DateTime.now(),
      tags: (e.data["tags"] as List<dynamic>)
          .map((e) => Tag(e as String))
          .toList(),
    );
  }
}
