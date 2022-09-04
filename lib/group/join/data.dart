import 'package:appwrite/models.dart';

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
