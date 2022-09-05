import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nightout/group/join/provider.dart';
import 'package:nightout/router.gr.dart' as router;
import 'package:nightout/scaffold/scaffold.dart';
import 'package:nightout/scaffold/secured.dart';
import 'package:nightout/utils/error.dart';
import 'package:nightout/utils/loading.dart';

class JoinGroup extends ConsumerWidget {
  final String invitationId;

  const JoinGroup({
    Key? key,
    @pathParam required this.invitationId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Secured(
      builder: (context, session, ref) {
        return ref
            .watch(joinGroupAggregateByInvitationIdProvider(invitationId))
            .when(
                data: (joinGroupAggregate) {
                  return NightOutScaffold.home(
                    body: Column(
                      children: [
                        Text(
                          "Do you want to join group ${joinGroupAggregate.group.name}",
                        ),
                        ButtonBar(
                          children: [
                            TextButton(
                              onPressed: () {
                                ref.read(
                                  acceptGroupInvitation(
                                      joinGroupAggregate.invitation),
                                );
                                AutoRouter.of(context).replace(
                                  router.GroupDetails(
                                      groupId: joinGroupAggregate.group.id),
                                );
                              },
                              child: const Text("Yes"),
                            ),
                            TextButton(
                              onPressed: () {
                                ref.read(rejectGroupInvitation(
                                    joinGroupAggregate.invitation));
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
                error: (error, stackTrace) => Error(
                      error,
                      stackTrace: stackTrace,
                    ),
                loading: () => Loading());
      },
    );
  }
}
