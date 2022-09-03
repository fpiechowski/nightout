import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nightout/appwrite/appwrite.dart';
import 'package:nightout/sign_in/sign_in.dart';

final currentSessionProvider = FutureProvider((ref) async {
  return await account.getSession(sessionId: currentSessionId);
});

final userProvider = FutureProvider((ref) async {
  return await account.get();
});
