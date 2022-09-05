import 'package:faker/faker.dart';
import 'package:nightout/appwrite/appwrite.dart';
import 'package:nightout/geolocalization/geolocalization.dart';
import 'package:nightout/group/group.dart';
import 'package:nightout/tag/tag.dart';
import 'package:nightout/profile/data.dart';
import 'package:uuid/uuid.dart';

void createFakeGroups() {
  generateGroups().map(
    (e) => databases.createDocument(
      collectionId: "6304ecf5c1b63cc9b76f",
      documentId: const Uuid().v4(),
      data: e.toMap(),
    ),
  );
}

List<Group> generateGroups() {
  return List.generate(
    random.integer(15, min: 3),
    (index) => Group(
      id: faker.guid.toString(),
      leader: Profile(
        id: faker.guid.guid(),
        firstName: faker.person.firstName(),
        phoneNumber: faker.phoneNumber.us(),
        favoritePlaces: [],
      ),
      members: List.generate(
        random.integer(10, min: 2),
        (index) => Profile(
          id: faker.guid.toString(),
          firstName: faker.person.firstName(),
          phoneNumber: faker.phoneNumber.us(),
          favoritePlaces: [],
        ),
      ),
      groupStatus: random.element([
        GroupStatus.unknown(),
        GroupStatus.hangingOut(),
        GroupStatus.goingOut(
            DateTime.now().add(Duration(minutes: random.integer(500))))
      ]),
      lastActivity: DateTime.now().subtract(const Duration(minutes: 100)),
      tags: <Tag>[],
    ),
  );
}
