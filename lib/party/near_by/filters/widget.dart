import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nightout/party/near_by/filters/filters.dart';
import 'package:nightout/party/near_by/provider.dart';
import 'package:nightout/tag/tag.dart';
import 'package:nightout/utils/error.dart';
import 'package:nightout/utils/loading.dart';

class Filters extends ConsumerWidget {
  const Filters({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    radius() => ref.watch(radiusProvider);
    final radiusNotifier = ref.read(radiusProvider.notifier);
    excludedPartyTypes() => ref.watch(excludedPartyTypesProvider);
    final excludedPartyTypesNotifier =
        ref.read(excludedPartyTypesProvider.notifier);
    excludedTags() => ref.watch(excludedTagsProvider);
    final excludedTagsNotifier = ref.read(excludedTagsProvider.notifier);
    nearByParties() => ref.watch(nearByPartiesProvider);

    return ListView(
      children: [
        ListTile(
          leading: Text(
            "Radius",
            style: Theme.of(context).textTheme.labelLarge,
          ),
          trailing: Text(radius() >= 1
              ? "${ref.watch(radiusKmTextDataVariableProvider).toStringAsFixed(1)} km"
              : "${ref.watch(radiusTextDataVariableProvider).toStringAsFixed(1)} m"),
          title: Slider(
            onChanged: (value) {
              ref.read(radiusSliderValueProvider.notifier).state = value;
              ref.read(radiusTextDataVariableProvider.notifier).state =
                  (minRadiusInMeters +
                          ((maxRadiusInMeters - minRadiusInMeters) * value))
                      .toInt();
              ref.read(radiusKmTextDataVariableProvider.notifier).state =
                  (minRadiusInMeters +
                          ((maxRadiusInMeters - minRadiusInMeters) * value)) /
                      1000;
            },
            value: ref.watch(radiusSliderValueProvider),
            onChangeEnd: (value) {
              final radius = minRadiusInMeters +
                  ((maxRadiusInMeters - minRadiusInMeters) * value);
              radiusNotifier.state = radius.toInt();
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FilterChip(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      label: const Text("Places"),
                      selected: !excludedPartyTypes().contains(PartyType.place),
                      onSelected: (selected) => excludedPartyTypesNotifier
                              .state =
                          _excludedPartyTypesAfterSelection(
                              selected, PartyType.place, excludedPartyTypes()),
                      selectedColor: Theme.of(context).primaryColor,
                    ),
                    FilterChip(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      label: const Text("Groups"),
                      selected: !excludedPartyTypes().contains(PartyType.group),
                      onSelected: (selected) => excludedPartyTypesNotifier
                              .state =
                          _excludedPartyTypesAfterSelection(
                              selected, PartyType.group, excludedPartyTypes()),
                      selectedColor: Theme.of(context).primaryColor,
                    ),
                  ],
                ),
              ),
              Wrap(
                alignment: WrapAlignment.spaceBetween,
                spacing: 8,
                children: nearByParties().when(
                  data: (parties) => parties
                      .expand((element) => element.tags)
                      .toSet()
                      .map((tag) => FilterChip(
                            label: Text(tag.name),
                            selected: !excludedTags().contains(tag),
                            onSelected: (selected) =>
                                excludedTagsNotifier.state =
                                    _excludedTagsAfterSelection(
                                        selected, tag, excludedTags()),
                            selectedColor: Theme.of(context).primaryColor,
                          ))
                      .toList(),
                  error: (error, st) => [Error(error, stackTrace: st)],
                  loading: () => [const Loading()],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Set<PartyType> _excludedPartyTypesAfterSelection(
      bool selected, PartyType partyType, Set<PartyType> excludedPartyTypes) {
    return (selected
            ? excludedPartyTypes.difference({partyType})
            : excludedPartyTypes.followedBy({partyType}))
        .toSet();
  }

  Set<Tag> _excludedTagsAfterSelection(
      bool selected, Tag tag, Set<Tag> excludedTags) {
    return (selected
            ? excludedTags.difference({tag})
            : excludedTags.followedBy({tag}))
        .toSet();
  }
}
