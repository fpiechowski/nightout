import 'package:appwrite/appwrite.dart';

final client = Client(
  endPoint: "https://appwrite.nightout.party/v1",
  selfSigned: true,
).setProject("62fa5c7cd2edd3973403");

final account = Account(client);

final databases = Databases(client, databaseId: "62ffaf9c0ec084fbd9bc");

final functions = Functions(client);