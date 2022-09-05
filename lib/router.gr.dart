// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:appwrite/models.dart' as _i10;
import 'package:auto_route/auto_route.dart' as _i8;
import 'package:flutter/material.dart' as _i9;

import 'group/join/widget.dart' as _i5;
import 'group/userGroups/details/widget.dart' as _i4;
import 'group/userGroups/user_groups.dart' as _i3;
import 'party/details/party_details.dart' as _i7;
import 'party/near_by/near_by.dart' as _i2;
import 'place/details/widget.dart' as _i6;
import 'sign_in/sign_in.dart' as _i1;

class AppRouter extends _i8.RootStackRouter {
  AppRouter([_i9.GlobalKey<_i9.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i8.PageFactory> pagesMap = {
    SignIn.name: (routeData) {
      final args =
          routeData.argsAs<SignInArgs>(orElse: () => const SignInArgs());
      return _i8.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i1.SignIn(key: args.key, onSignedIn: args.onSignedIn));
    },
    NearByParties.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i2.NearByParties());
    },
    UserGroups.name: (routeData) {
      final args = routeData.argsAs<UserGroupsArgs>();
      return _i8.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i3.UserGroups(key: args.key, userId: args.userId));
    },
    GroupDetails.name: (routeData) {
      final args = routeData.argsAs<GroupDetailsArgs>();
      return _i8.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i4.GroupDetails(key: args.key, groupId: args.groupId));
    },
    JoinGroup.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<JoinGroupArgs>(
          orElse: () => JoinGroupArgs(
                invitationId: pathParams.getString('invitationId'),
              ));
      return _i8.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i5.JoinGroup(
            key: args.key,
            invitationId: args.invitationId,
          ));
    },
    PlaceDetails.name: (routeData) {
      final args = routeData.argsAs<PlaceDetailsArgs>();
      return _i8.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i6.PlaceDetails(key: args.key, placeId: args.placeId));
    },
    PartyDetails.name: (routeData) {
      final args = routeData.argsAs<PartyDetailsArgs>();
      return _i8.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i7.PartyDetails(key: args.key, partyId: args.partyId));
    }
  };

  @override
  List<_i8.RouteConfig> get routes => [
        _i8.RouteConfig('/#redirect',
            path: '/', redirectTo: '/sign-in', fullMatch: true),
        _i8.RouteConfig(SignIn.name, path: '/sign-in'),
        _i8.RouteConfig(NearByParties.name, path: '/parties/near-by'),
        _i8.RouteConfig(UserGroups.name, path: '/groups?members-any=:userId'),
        _i8.RouteConfig(GroupDetails.name, path: '/groups/:groupId'),
        _i8.RouteConfig(JoinGroup.name,
            path: '/groups/:groupId/join/:phoneNumber'),
        _i8.RouteConfig(PlaceDetails.name, path: '/places/:placeId'),
        _i8.RouteConfig(PartyDetails.name, path: '/parties/:partyId')
      ];
}

/// generated route for
/// [_i1.SignIn]
class SignIn extends _i8.PageRouteInfo<SignInArgs> {
  SignIn(
      {_i9.Key? key,
      void Function(_i9.BuildContext, {_i10.Session session})? onSignedIn})
      : super(SignIn.name,
            path: '/sign-in',
            args: SignInArgs(key: key, onSignedIn: onSignedIn));

  static const String name = 'SignIn';
}

class SignInArgs {
  const SignInArgs({this.key, this.onSignedIn});

  final _i9.Key? key;

  final void Function(_i9.BuildContext, {_i10.Session session})? onSignedIn;

  @override
  String toString() {
    return 'SignInArgs{key: $key, onSignedIn: $onSignedIn}';
  }
}

/// generated route for
/// [_i2.NearByParties]
class NearByParties extends _i8.PageRouteInfo<void> {
  const NearByParties() : super(NearByParties.name, path: '/parties/near-by');

  static const String name = 'NearByParties';
}

/// generated route for
/// [_i3.UserGroups]
class UserGroups extends _i8.PageRouteInfo<UserGroupsArgs> {
  UserGroups({_i9.Key? key, required String userId})
      : super(UserGroups.name,
            path: '/groups?members-any=:userId',
            args: UserGroupsArgs(key: key, userId: userId));

  static const String name = 'UserGroups';
}

class UserGroupsArgs {
  const UserGroupsArgs({this.key, required this.userId});

  final _i9.Key? key;

  final String userId;

  @override
  String toString() {
    return 'UserGroupsArgs{key: $key, userId: $userId}';
  }
}

/// generated route for
/// [_i4.GroupDetails]
class GroupDetails extends _i8.PageRouteInfo<GroupDetailsArgs> {
  GroupDetails({_i9.Key? key, required String groupId})
      : super(GroupDetails.name,
            path: '/groups/:groupId',
            args: GroupDetailsArgs(key: key, groupId: groupId));

  static const String name = 'GroupDetails';
}

class GroupDetailsArgs {
  const GroupDetailsArgs({this.key, required this.groupId});

  final _i9.Key? key;

  final String groupId;

  @override
  String toString() {
    return 'GroupDetailsArgs{key: $key, groupId: $groupId}';
  }
}

/// generated route for
/// [_i5.JoinGroup]
class JoinGroup extends _i8.PageRouteInfo<JoinGroupArgs> {
  JoinGroup({
    _i9.Key? key,
    required String invitationId,
  }) : super(JoinGroup.name,
            path: '/group_invitations/:invitationId',
            args: JoinGroupArgs(key: key, invitationId: invitationId),
            rawPathParams: {
              'invitationId': invitationId,
            });

  static const String name = 'JoinGroup';
}

class JoinGroupArgs {
  const JoinGroupArgs({
    this.key,
    required this.invitationId,
  });

  final _i9.Key? key;

  final String invitationId;

  @override
  String toString() {
    return 'JoinGroupArgs{key: $key, invitationId: $invitationId}';
  }
}

/// generated route for
/// [_i6.PlaceDetails]
class PlaceDetails extends _i8.PageRouteInfo<PlaceDetailsArgs> {
  PlaceDetails({_i9.Key? key, required String placeId})
      : super(PlaceDetails.name,
            path: '/places/:placeId',
            args: PlaceDetailsArgs(key: key, placeId: placeId));

  static const String name = 'PlaceDetails';
}

class PlaceDetailsArgs {
  const PlaceDetailsArgs({this.key, required this.placeId});

  final _i9.Key? key;

  final String placeId;

  @override
  String toString() {
    return 'PlaceDetailsArgs{key: $key, placeId: $placeId}';
  }
}

/// generated route for
/// [_i7.PartyDetails]
class PartyDetails extends _i8.PageRouteInfo<PartyDetailsArgs> {
  PartyDetails({_i9.Key? key, required String partyId})
      : super(PartyDetails.name,
            path: '/parties/:partyId',
            args: PartyDetailsArgs(key: key, partyId: partyId));

  static const String name = 'PartyDetails';
}

class PartyDetailsArgs {
  const PartyDetailsArgs({this.key, required this.partyId});

  final _i9.Key? key;

  final String partyId;

  @override
  String toString() {
    return 'PartyDetailsArgs{key: $key, partyId: $partyId}';
  }
}
