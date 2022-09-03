import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttercontactpicker/fluttercontactpicker.dart';
import 'package:nightout/group/group.dart';
import 'package:nightout/group/userGroups/details/provider.dart';
import 'package:nightout/group/userGroups/user_groups.dart';
import 'package:nightout/place/place.dart';
import 'package:nightout/profile/provider.dart';
import 'package:nightout/scaffold/details.dart';
import 'package:nightout/tag/tag.dart';
import 'package:nightout/utils/also.dart';
import 'package:nightout/utils/error.dart';
import 'package:nightout/utils/image_labeled_button.dart';
import 'package:nightout/utils/loading.dart';
import 'package:url_launcher/url_launcher.dart';

class UserGroupDetails extends ConsumerWidget {
  final String groupId;

  const UserGroupDetails(
    this.groupId, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final group = ref.watch(userGroupProvider(groupId));

    return group.when(
        data: (data) => Details(
              title: data.name,
              actions: [
                DetailsActionButton(
                    onPressed: () async {
                      await addMember(data, ref).onError(
                        (error, stackTrace) {
                          switch (error.runtimeType) {
                            case ProfileNotFound:
                              showDialog(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  title: const Text("Send SMS?"),
                                  content: const Text(
                                    "Selected contact does not have NightOut app.",
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () => launchUrl(
                                        Uri.parse(
                                            "sms:${(error as ProfileNotFound).phoneNumber}?body=Join%20our%20group%20on%20NightOut!%0Ahttp%3A%2F%2Fweb.nightout.party%2Fgroup%2F$groupId%2Fjoin%3FphoneNumber%3D${error.phoneNumber}"),
                                      ),
                                      child: const Text("SMS"),
                                    )
                                  ],
                                ),
                              );
                              break;
                            default:
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(error.toString()),
                                ),
                              );
                              break;
                          }
                        },
                      );
                    },
                    child: const Icon(Icons.add)),
              ],
              appBarBackground: DetailsPhotosGridBackground(
                crossAxisCount: 3,
                children: [
                  ...List.generate(
                    10,
                    (index) => Image.network(
                      "https://picsum.photos/seed/${faker.lorem.word()}/200",
                    ),
                  )
                ],
              ),
              appBarChild: Wrap(
                spacing: 5,
                children: [
                  ...data.members.map((e) => Chip(
                        label: Text(e.firstName),
                        avatar: CircleAvatar(
                          backgroundImage: NetworkImage(
                              "https://picsum.photos/seed/${random.integer(10)}/30/30"),
                        ),
                      )),
                ],
              ),
              slivers: [
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      FavoriteTags(),
                      /*FavoritePlaces(
                        places: data.favoritePlaces,
                      )*/
                    ],
                  ),
                )
              ],
              floatingActionButton: FloatingActionButton(
                child: const Icon(Icons.whatsapp),
                onPressed: () {},
              ),
            ),
        error: (error, st) => Error(error, stackTrace: st),
        loading: () => const Loading());
  }

  Future<void> addMember(Group group, WidgetRef ref) async {
    final contact = await FlutterContactPicker.pickPhoneContact();

    if (contact.phoneNumber != null) {
      final profile = await ref.read(
          profileByPhoneNumberProvider(contact.phoneNumber!.number!).future);

      if (profile != null) {
        if (!group.members.contains(profile)) {
          group.members.add(profile);
          await GroupRepository.update(group);
          ref.refresh(userGroupProvider(groupId));
        } else {
          throw "contact_already_in_group";
        }
      } else {
        throw ProfileNotFound(contact.phoneNumber?.number);
      }
    } else {
      throw "no_phone_number";
    }
  }
}

class ProfileNotFound {
  final String? phoneNumber;

  ProfileNotFound(this.phoneNumber);
}

class FavoritePlaces extends ConsumerWidget {
  final int wrappedLimit;
  final List<Place> places;

  const FavoritePlaces({
    Key? key,
    this.wrappedLimit = 5,
    required this.places,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ListTile(
              trailing: TextButton(
                onPressed: () {},
                child: const Text("See all"),
              ),
              title: Text(
                "Favorite places",
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: PlaceButton(
                    place: places.first,
                  ),
                ),
                ...List.generate(
                    wrappedLimit - 1 % 2,
                    (index) => Row(
                          children: [
                            Expanded(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: PlaceButton(place: places[index + 1]),
                            )),
                            Expanded(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: PlaceButton(place: places[index + 1]),
                            ))
                          ],
                        ))
              ],
            )
          ],
        ),
      ),
    );
  }
}

class FavoriteTags extends ConsumerWidget {
  final int count;
  final List<Tag> tags;

  FavoriteTags({
    this.count = 10,
    List<Tag>? tags,
    Key? key,
  })  : tags = tags ?? [],
        super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          ListTile(
            trailing: TextButton(
              onPressed: () {},
              child: const Text("See all"),
            ),
            title: Text(
              "Favorite tags",
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: tags.isEmpty
                ? Center(
                    child: Text(
                    "Members have no favorite tags.",
                    style: Theme.of(context).textTheme.subtitle2,
                  ))
                : AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: Wrap(
                      alignment: WrapAlignment.spaceBetween,
                      spacing: 8,
                      children: [
                        ...tags.let((it) {
                          if (ref.watch(favoriteTagsWrappedProvider)) {
                            return it.take(count);
                          } else {
                            return it;
                          }
                        }).map((e) => Chip(
                              label: Text(e.name),
                            )),
                      ],
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

class PlaceButton extends ConsumerWidget {
  final Place place;

  const PlaceButton({
    Key? key,
    required this.place,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ImageLabeledButton(
        label: faker.lorem.sentences(3).join(" "),
        image: NetworkImage(
          'https://picsum.photos/seed/${faker.lorem.word()}/360/360',
        ));
  }
}
