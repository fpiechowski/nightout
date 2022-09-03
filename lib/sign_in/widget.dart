import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:nightout/appwrite/appwrite.dart';
import 'package:nightout/sign_in/data.dart';
import 'package:nightout/sign_in/provider.dart';
import 'package:nightout/utils/error.dart';
import 'package:nightout/utils/loading.dart';

class SignIn extends ConsumerWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue<Session>>(currentSessionProvider, (previous, next) {
      next.whenData(
        (session) =>
            Navigator.pushReplacementNamed(context, "/parties/nearBy/map"),
      );
    });

    return ref.watch(currentSessionProvider).when(
        data: (session) => const Loading(),
        error: (error, st) {
          if (error is AppwriteException && error.code == 401) {
            return _build(context, ref);
          } else {
            return Error(error, stackTrace: st);
          }
        },
        loading: () => const Loading());
  }

  Container _build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: BoxDecoration(color: Theme.of(context).canvasColor),
      child: Center(
        child: SizedBox(
          height: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ...OAuth2Provider.values.map(
                (e) => SignInButton(e.buttons, onPressed: () async {
                  await account
                      .createOAuth2Session(provider: e.id)
                      .then((value) => ref.refresh(currentSessionProvider));
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
