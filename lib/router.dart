import 'package:auto_route/auto_route.dart';
import 'package:nightout/group/join/widget.dart';
import 'package:nightout/group/userGroups/details/widget.dart';
import 'package:nightout/group/userGroups/user_groups.dart';
import 'package:nightout/party/details/party_details.dart';
import 'package:nightout/party/near_by/near_by.dart';
import 'package:nightout/place/details/widget.dart';
import 'package:nightout/sign_in/sign_in.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(page: SignIn, path: "/sign-in", initial: true),
    AutoRoute(page: NearByParties, path: "/parties/near-by"),
    AutoRoute(page: UserGroups, path: "/groups?members-any=:userId"),
    AutoRoute(page: GroupDetails, path: "/groups/:groupId"),
    AutoRoute(page: JoinGroup, path: "/groups/:groupId/join/:phoneNumber"),
    AutoRoute(page: PlaceDetails, path: "/places/:placeId"),
    AutoRoute(page: PartyDetails, path: "/parties/:partyId"),
  ],
)
class $AppRouter {}
