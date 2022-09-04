import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nightout/router.gr.dart' as router;
import 'package:nightout/sign_in/sign_in.dart';
import 'package:nightout/utils/loading.dart';

import '../party/near_by/filters/filters.dart';

class NightOutBottomNavigationBar extends ConsumerWidget {
  const NightOutBottomNavigationBar.home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BottomAppBar(
      key: key,
      shape: const CircularNotchedRectangle(),
      notchMargin: 5,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
                onPressed: () => showModalBottomSheet(
                      context: context,
                      builder: (_) => const Filters(),
                    ),
                icon: const Icon(Icons.filter_list_alt)),
            ref.watch(userProvider).when(
                  data: (user) => IconButton(
                    onPressed: () => AutoRouter.of(context).push(
                      router.UserGroups(userId: user.$id),
                    ),
                    icon: const Icon(Icons.people),
                  ),
                  error: (error, stackTrace) => Container(),
                  loading: () => const Loading(),
                )
          ],
        ),
      ),
    );
  }
}
