import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nightout/router.gr.dart' as router;
import 'package:nightout/sign_in/provider.dart';
import 'package:nightout/utils/loading.dart';

class Secured extends ConsumerWidget {
  Widget Function(BuildContext, Session, WidgetRef) builder;

  Secured({
    Key? key,
    required this.builder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(currentSessionProvider, (previous, next) {},
        onError: (error, stackTrace) {
      switch (error) {
        case AppwriteException:
          final appwriteException = (error as AppwriteException);
          if (appwriteException.code == 401 || appwriteException.code == 403) {
            AutoRouter.of(context).popUntilRoot();
            AutoRouter.of(context).push(router.SignIn());
          }
      }
    });

    return ref.watch(currentSessionProvider).when(
          data: (session) =>
              Builder(builder: (context) => builder(context, session, ref)),
          error: (error, stackTrace) => Loading(),
          loading: () => Loading(),
        );
  }
}
