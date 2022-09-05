import 'package:appwrite/models.dart';
import 'package:nightout/group/group.dart';
import 'package:nightout/profile/data.dart';

class GroupInvitation {
  final String id;
  final String phoneNumber;
  final String groupId;

  GroupInvitation({required this.id, required this.phoneNumber, required this.groupId});

  factory GroupInvitation.fromDocument(Document e) {
    return GroupInvitation(
      id: e.$id,
      phoneNumber: e.data["phoneNumber"] as String,
      groupId: e.data["groupId"] as String,
    );
  }
}

class JoinGroupAggregate {
  final GroupInvitation invitation;
  final Profile profile;
  final Group group;

  JoinGroupAggregate(this.invitation, this.profile, this.group);
}