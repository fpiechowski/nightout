import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nightout/party/party.dart';

final selectedPartyProvider = StateProvider<Party?>((ref) => null);