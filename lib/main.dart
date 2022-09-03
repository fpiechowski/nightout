import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nightout/group/group.dart';
import 'package:nightout/group/userGroups/details/widget.dart';
import 'package:nightout/group/userGroups/widget.dart';
import 'package:nightout/group/route.dart';
import 'package:nightout/party/nearBy/near_by.dart';
import 'package:nightout/place/details/widget.dart';
import 'package:nightout/place/route.dart';
import 'package:nightout/sign_in/sign_in.dart';
import 'package:nightout/theme.dart';
import 'package:nightout/utils/fake/main.dart';

void main() async {
  createFakeGroups();
  runApp(const ProviderScope(child: App()));
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: (routeSettings) {
        final routeName = routeSettings.name;
        if (routeName != null) {
          if (routeName.startsWith("/groups/")) {
            final groupRouteArguments =
                routeSettings.arguments as GroupRouteArguments;
            return MaterialPageRoute(
              builder: (context) => UserGroupDetails(groupRouteArguments.group.id),
            );
          }

          if (routeName.startsWith("/place/")) {
            final placeRouteArguments =
                routeSettings.arguments as PlaceRouteArguments;
            return MaterialPageRoute(
              builder: (context) => PlaceDetails(placeRouteArguments.place),
            );
          }
        }

        return null;
      },
      routes: {
        "/signIn": (context) => const SignIn(),
        "/parties/nearBy/map": (context) => const NearByParties(),
        "/user/groups": (context) => const UserGroups(),
      },
      initialRoute: "/signIn",
      themeMode: ThemeMode.dark,
      title: 'NightOut',
      theme: nightoutTheme(context),
    );
  }
}
