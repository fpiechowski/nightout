import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nightout/party/near_by/map/map.dart';
import 'package:nightout/scaffold/scaffold.dart';

class NearByParties extends ConsumerWidget {
  const NearByParties({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return NightOutScaffold.home(
      body: const Map(),
    );
  }
}
