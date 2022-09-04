import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nightout/group/join/provider.dart';
import 'package:nightout/group/provider.dart';
import 'package:nightout/router.gr.dart' as router;
import 'package:nightout/scaffold/scaffold.dart';
import 'package:nightout/scaffold/secured.dart';
import 'package:nightout/utils/error.dart';
import 'package:nightout/utils/loading.dart';

class JoinGroup extends ConsumerWidget {
  final String groupId;
  final String phoneNumber;

  const JoinGroup({
    Key? key,
    @pathParam required this.groupId,
    @pathParam required this.phoneNumber,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Secured(
      builder: (context, session, ref) {
        return ref.watch(groupProvider(groupId)).when(
              data: (group) => ref
                  .watch(groupInvitationsProvider(groupId))
                  .when(
                    data: (invitations) {
                      final invitation = invitations
                          .where((it) => it.phoneNumber == phoneNumber)
                          .first;

                      return NightOutScaffold.home(
                        body: Column(
                          children: [
                            Text("Do you want to join group ${group.name}"),
                            ButtonBar(
                              children: [
                                TextButton(
                                  onPressed: () {
                                    ref.read(
                                      acceptGroupInvitation(invitation),
                                    );
                                    AutoRouter.of(context).replace(
                                      router.GroupDetails(groupId: group.id),
                                    );
                                  },
                                  child: const Text("Yes"),
                                ),
                                TextButton(
                                  onPressed: () {
                                    ref.read(rejectGroupInvitation(invitation));
                                    AutoRouter.of(context)
                                        .replace(const router.NearByParties());
                                  },
                                  child: const Text("Reject"),
                                )
                              ],
                            )
                          ],
                        ),
                      );
                    },
                    error: (invitationError, stackTrace) =>
                        Error(invitationError, stackTrace: stackTrace),
                    loading: () => Loading(),
                  ),
              error: (groupError, stackTrace) =>
                  Error(groupError, stackTrace: stackTrace),
              loading: () => Loading(),
            );
      },
    );
  }
}
