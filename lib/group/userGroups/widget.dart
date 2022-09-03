import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nightout/group/userGroups/user_groups.dart';
import 'package:nightout/group/group.dart';
import 'package:nightout/scaffold/scaffold.dart';
import 'package:nightout/utils/error.dart';
import 'package:nightout/utils/glowing_fab.dart';
import 'package:nightout/utils/loading.dart';

class UserGroups extends ConsumerWidget {
  const UserGroups({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return NightOutScaffold.poppable(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: GlowingFloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      body: ref.watch(userGroupsProvider).when(
          data: (userGroups) {
            userGroups.sort();

            return ListView(
              children: userGroups.map(
                (group) {
                  final Color color;
                  switch (group.groupStatus.runtimeType) {
                    case HangingOutGroupStatus:
                      color = Theme.of(context).colorScheme.primary;
                      break;
                    default:
                      color = Theme.of(context).colorScheme.background;
                  }

                  Widget? trailing;
                  if (group.groupStatus.runtimeType != UnknownGroupStatus) {
                    trailing = Chip(
                      backgroundColor: color,
                      label: Text(group.groupStatus.label),
                    );
                  }

                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                          "https://picsum.photos/seed/${faker.lorem.word()}/100/100"),
                    ),
                    title: Text(
                      group.name,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: trailing,
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        "/groups/${group.id}",
                        arguments: GroupRouteArguments(group),
                      );
                    },
                  );
                },
              ).toList(),
            );
          },
          error: (error, st) => Error(
                error,
                stackTrace: st,
              ),
          loading: () => const Center(child: Loading())),
    );
  }
}

class GroupStatusChip extends StatelessWidget {
  final GroupStatus groupStatus;

  const GroupStatusChip(this.groupStatus, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color backgroundColor;
    switch (groupStatus.runtimeType) {
      case HangingOutGroupStatus:
        backgroundColor = Theme.of(context).colorScheme.primary;
        break;
      case GoingOutGroupStatus:
        backgroundColor = Theme.of(context).colorScheme.secondary;
        break;
      default:
        throw "unknown group status type";
    }

    return Chip(
      backgroundColor: backgroundColor,
      label: Text(groupStatus.label),
    );
  }
}
