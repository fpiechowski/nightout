import 'package:faker/faker.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nightout/party/party.dart';
import 'package:nightout/party/routing.dart';
import 'package:nightout/utils/gradient_card.dart';

class PartyCard extends ConsumerStatefulWidget {
  const PartyCard({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PartyCardState();
}

class _PartyCardState extends ConsumerState<PartyCard>
    with TickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    animation = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(animationController);
  }

  @override
  Widget build(BuildContext context) {
    final party = ref.watch(selectedPartyProvider);

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 400),
      child: party != null
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: Colors.transparent,
                ),
                clipBehavior: Clip.antiAlias,
                onPressed: () => Navigator.pushNamed(context,
                    "/party/${party.id}",
                    arguments: PartyDetailsArguments(party)),
                child: GradientCard(
                  elevation: 0,
                  child: Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                              "https://picsum.photos/seed/${faker.lorem.word()}/100/100/"),
                        ),
                        title: Text(
                          party.name,
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                        trailing: Container(
                          padding: const EdgeInsets.only(top: 8),
                          height: 100,
                          width: 100,
                          child: Stack(
                            children: [
                              Opacity(
                                opacity: 0.8,
                                child: SizedBox(
                                  child: PieChart(
                                    PieChartData(
                                        startDegreeOffset: -90,
                                        centerSpaceRadius: 10,
                                        sectionsSpace: 1,
                                        sections: [
                                          PieChartSectionData(
                                            badgeWidget: Icon(
                                              Icons.male,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary,
                                            ),
                                            badgePositionPercentageOffset: 1.8,
                                            title: "men",
                                            showTitle: false,
                                            value: 0.4,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                            radius: 15,
                                          ),
                                          PieChartSectionData(
                                            showTitle: false,
                                            value: 0.1,
                                            radius: 13,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .surface,
                                          ),
                                          PieChartSectionData(
                                            badgeWidget: Icon(
                                              Icons.female,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .secondary,
                                            ),
                                            badgePositionPercentageOffset: 1.8,
                                            title: "women",
                                            showTitle: false,
                                            value: 0.5,
                                            radius: 15,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .secondary,
                                          ),
                                        ]),
                                  ),
                                ),
                              ),
                              Align(
                                child: SizedBox(
                                  height: 100,
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Positioned(
                                        top: 8,
                                        child: Icon(
                                          Icons.local_fire_department,
                                          shadows: [
                                            ...List.generate(
                                              5,
                                              (index) => const Shadow(
                                                  color: Colors.black,
                                                  blurRadius: 5),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 6,
                                        child: Text(
                                          "87%",
                                          style: Theme.of(context)
                                              .textTheme
                                              .overline
                                              ?.copyWith(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  shadows: [
                                                ...List.generate(
                                                  5,
                                                  (index) => const Shadow(
                                                      color: Colors.black,
                                                      blurRadius: 5),
                                                ),
                                              ]),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Wrap(
                          alignment: WrapAlignment.center,
                          spacing: 5,
                          children: party.tags
                              .map((tag) => Chip(label: Text(tag.name)))
                              .toList(),
                        ),
                      ),
                      ButtonBar(
                        alignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              // Perform some action
                            },
                            child: const Text('Invite Group'),
                          ),
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.thumb_up_outlined,
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )
          : Container(),
    );
  }
}
