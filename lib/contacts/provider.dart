import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final contactsProvider = FutureProvider<List<Contact>>((ref) async {
  // See installation notes below regarding AndroidManifest.xml and Info.plist

// Request contact permission
  if (await FlutterContacts.requestPermission()) {
// Get all contacts (lightly fetched)
    return await FlutterContacts.getContacts();
  } else {
    return Future.error("permissions_needed");
  }
});
