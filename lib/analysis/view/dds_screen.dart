import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gibsonify/analysis/analysis.dart';
import 'package:gibsonify_api/gibsonify_api.dart';
import 'package:collection/collection.dart';
import 'package:gibsonify_repository/gibsonify_repository.dart';
import 'package:graphic/graphic.dart';

String mean(List<int> vals) {
  return (vals.sum / vals.length).toStringAsFixed(2);
}

double median(List<int> vals) {
  final sorted = vals.sorted((a, b) => a.compareTo(b));
  final mid = sorted.length ~/ 2;
  if (sorted.length.isOdd) {
    return sorted[mid].toDouble();
  } else {
    return (sorted[mid] + sorted[mid - 1]) / 2;
  }
}

double mode(List<int> vals) {
  final counts = <int, int>{};
  for (final val in vals) {
    counts[val] = (counts[val] ?? 0) + 1;
  }
  final maxCount = counts.values.max;
  return counts.entries
      .firstWhere((entry) => entry.value == maxCount)
      .key
      .toDouble();
}

List<DiversityScoredHousehold> generateSampleScoredHouseholds() {
  final random = Random();
  return List.generate(24, (index) {
    final ddsGroups = {
      for (final group in HDDSGroup.values) group: random.nextInt(2)
    };
    final hdds = ddsGroups.values.sum;
    final householdId =
        'GB${10 + random.nextInt(90)}${String.fromCharCode(65 + random.nextInt(26))}${1000 + random.nextInt(9000)}${String.fromCharCode(65 + random.nextInt(26))}';

    return DiversityScoredHousehold(
      householdId: householdId,
      ddsGroups: ddsGroups,
      hdds: hdds,
      collections: [
        FlatCollection(
            householdId: householdId,
            respondentId: 'A',
            respondentName: 'Faizaan Pervaiz',
            collection: GibsonsForm(
                finished: true,
                interviewDate: '2023-05-01',
                interviewOutcome: 'completed',
                id: 'd',
                physioStatus: PhysioStatus.notApplicable,
                foodItems: const [],
                metadata: Metadata.create(createdBy: 'FP361')))
      ],
    );
  }).sortedBy((household) => household.householdId);
}

class HDDSScreen extends StatefulWidget {
  const HDDSScreen({
    Key? key,
    required this.survey,
    required this.collections,
  }) : super(key: key);

  final Survey survey;
  final List<FlatCollection> collections;

  @override
  State<HDDSScreen> createState() => _HDDSScreenState();
}

class _HDDSScreenState extends State<HDDSScreen> {
  Map<String, DiversityScoredHousehold>? scoredHouseholds;

  @override
  void initState() {
    _initState();
    super.initState();
  }

  void _initState() async {
    final scoredHouseholds = await groupAndScore(
        fctRepository: context.read<FCTRepository>(),
        fctId: widget.survey.fctId,
        collections: widget.collections);
    setState(() {
      //this.scoredHouseholds = scoredHouseholds;
      this.scoredHouseholds = {
        for (final household in generateSampleScoredHouseholds())
          household.householdId: household
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget ddsScreen() {
      if (scoredHouseholds == null) {
        return const Center(child: CircularProgressIndicator());
      } else {
        return Row(
          children: [
            Expanded(
                flex: 3,
                child:
                    SpecificCollections(scoredHouseholds: scoredHouseholds!)),
            Expanded(
                flex: 9,
                child: ChartView(
                  scoredHouseholds: scoredHouseholds!,
                )),
          ],
        );
      }
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(
              'Analysis: ${widget.survey.surveyId}: Household Dietary Diversity Scoring'),
        ),
        body: ddsScreen());
  }
}

class SpecificCollections extends StatelessWidget {
  const SpecificCollections({Key? key, required this.scoredHouseholds})
      : super(key: key);

  final Map<String, DiversityScoredHousehold> scoredHouseholds;

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(children: [
        const ListTile(
          leading: Icon(Icons.dining),
          title: Text('Specific Collections'),
          subtitle: Text(
              'Collections used for this analysis (completed and finished only)'),
        ),
        const SizedBox(height: 32),
        Expanded(
          child: ListView.builder(
              itemCount: scoredHouseholds.length,
              itemBuilder: (context, index) {
                final householdId = scoredHouseholds.keys.elementAt(index);
                final collections = scoredHouseholds[householdId]!.collections;
                return ExpansionTile(
                  title: Text(householdId),
                  children: collections
                      .map((collection) => Card(
                            child: ListTile(
                              title: Text(
                                  '${collection.respondentName}: ${collection.collection.interviewDate ?? 'No date'}'),
                              subtitle: Row(
                                children: [
                                  Text(
                                      'Outcome: ${collection.collection.interviewOutcome ?? 'Unspecified'}')
                                ],
                              ),
                              trailing: Column(
                                children: [
                                  collection.collection.finished
                                      ? const Icon(Icons.done)
                                      : const Icon(Icons.pause),
                                  collection.collection.finished
                                      ? const Text('Finished')
                                      : const Text('Paused'),
                                ],
                              ),
                              onTap: () => {
                                Navigator.push(
                                    context, collectionPageLoader(collection))
                              },
                            ),
                          ))
                      .toList(),
                );
              }),
        ),
      ]),
    ));
  }
}

enum HDDSChart {
  scoresByHousehold('Scores by Household'),
  foodGroupMatrix('Food Group Matrix');

  final String name;
  const HDDSChart(this.name);
}

class ChartView extends StatefulWidget {
  const ChartView({Key? key, required this.scoredHouseholds}) : super(key: key);

  final Map<String, DiversityScoredHousehold> scoredHouseholds;

  @override
  State<ChartView> createState() => _ChartViewState();
}

class _ChartViewState extends State<ChartView> {
  HDDSChart _selectedChart = HDDSChart.scoresByHousehold;

  @override
  Widget build(BuildContext context) {
    Widget chart() {
      switch (_selectedChart) {
        case HDDSChart.scoresByHousehold:
          return Container(
            margin: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 64.0),
            child: Chart(
              // random sample data
              data: widget.scoredHouseholds.values.toList(),
              variables: {
                'Household ID': Variable(
                  accessor: (DiversityScoredHousehold dsh) => dsh.householdId,
                ),
                'HDDS': Variable(
                    accessor: (DiversityScoredHousehold dsh) => dsh.hdds,
                    scale: LinearScale(min: 0, max: 12, tickCount: 13)),
              },
              marks: [IntervalMark()],
              axes: [
                AxisGuide(
                  line: Defaults.strokeStyle,
                  label: LabelStyle(
                      align: Alignment.centerLeft,
                      textStyle: Defaults.textStyle,
                      offset: const Offset(0, 7.5),
                      rotation: -1.57),
                ),
                Defaults.verticalAxis,
              ],
            ),
          );
        case HDDSChart.foodGroupMatrix:
          return Container(
            margin: const EdgeInsets.fromLTRB(64.0, 8.0, 8.0, 64.0),
            child: Chart(
              data: [
                for (final household in widget.scoredHouseholds.values)
                  for (final entry in household.ddsGroups.entries)
                    [
                      '${household.householdId} (${household.hdds})',
                      entry.key.name,
                      entry.value
                    ]
              ],
              variables: {
                'Food Group': Variable(
                  accessor: (List datum) => datum[1] as String,
                ),
                'Household ID': Variable(
                  accessor: (List datum) => datum[0] as String,
                ),
                'Consumed': Variable(
                  accessor: (List datum) => datum[2] as int,
                ),
              },
              marks: [
                PolygonMark(
                  color: ColorEncode(
                    variable: 'Consumed',
                    values: [
                      const Color.fromARGB(255, 255, 160, 160),
                      const Color.fromARGB(255, 160, 255, 160),
                    ],
                  ),
                )
              ],
              axes: [
                AxisGuide(
                  line: Defaults.strokeStyle,
                  label: LabelStyle(
                      maxWidth: 64.0,
                      align: Alignment.centerLeft,
                      textStyle: Defaults.textStyle,
                      offset: const Offset(0, 16.0),
                      rotation: -1.57),
                ),
                Defaults.verticalAxis,
              ],
              selections: {'tap': PointSelection()},
              tooltip: TooltipGuide(),
            ),
          );
      }
    }

    final hddss =
        widget.scoredHouseholds.values.map((dsh) => dsh.hdds).toList();

    return Card(
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                ListTile(
                  isThreeLine: true,
                  leading: const Icon(Icons.analytics),
                  title: const Text('Charts'),
                  subtitle: Text(
                      'Graphical analysis of household dietary diversity scores\nHDDS mean: ${mean(hddss)}, median: ${median(hddss)}, mode: ${mode(hddss)}'),
                  trailing: DropdownButton(
                      value: _selectedChart,
                      onChanged: (HDDSChart? chart) => setState(() {
                            if (chart != null) _selectedChart = chart;
                          }),
                      items: HDDSChart.values
                          .map((hddsChart) => DropdownMenuItem(
                              value: hddsChart, child: Text(hddsChart.name)))
                          .toList()),
                ),
                Expanded(child: chart()),
              ],
            )));
  }
}

class DiversityScoredHousehold {
  final String householdId;
  final Map<HDDSGroup, int> ddsGroups;
  final int hdds;
  final List<FlatCollection> collections;

  const DiversityScoredHousehold(
      {required this.householdId,
      required this.ddsGroups,
      required this.hdds,
      required this.collections});
}

Future<Map<String, DiversityScoredHousehold>> groupAndScore(
    {required FCTRepository fctRepository,
    required String fctId,
    required List<FlatCollection> collections}) async {
  final Map<String, List<FlatCollection>> grouped =
      groupBy(collections, (collection) => collection.householdId);
  final Map<String, DiversityScoredHousehold> scored = {};
  grouped.forEach((householdId, collections) async {
    final ddsGroups =
        await calculateDiversityScore(fctRepository, fctId, collections);
    scored[householdId] = DiversityScoredHousehold(
        householdId: householdId,
        ddsGroups: ddsGroups,
        hdds: ddsGroups.values.sum,
        collections: collections);
  });
  return scored;
}

enum HDDSGroup {
  cereals('Cereals'),
  whiteRootsAndTubers('White Roots and Tubers'),
  vegetables('Vegetables'),
  fruits('Fruits'),
  meat('Meat'),
  eggs('Eggs'),
  fishAndOtherSeafood('Fish and Other Seafood'),
  legumesNutsSeeds('Legumes, Nuts and Seeds'),
  milkAndMilkProducts('Milk and Milk Products'),
  oilsAndFats('Oils and Fats'),
  sweets('Sweets'),
  spicesCondimentsBeverages('Spices, Condiments and Beverages');

  final String name;
  const HDDSGroup(this.name);

  static HDDSGroup fromDDSFoodGroup(DDSFoodGroup ddsFoodGroup) {
    switch (ddsFoodGroup) {
      case DDSFoodGroup.cereals:
        return HDDSGroup.cereals;
      case DDSFoodGroup.whiteRootsAndTubers:
        return HDDSGroup.whiteRootsAndTubers;
      case DDSFoodGroup.vitARichVegetablesAndTubers:
        return HDDSGroup.vegetables;
      case DDSFoodGroup.darkGreenLeafyVegetables:
        return HDDSGroup.vegetables;
      case DDSFoodGroup.otherVegetables:
        return HDDSGroup.vegetables;
      case DDSFoodGroup.vitARichFruits:
        return HDDSGroup.fruits;
      case DDSFoodGroup.otherFruits:
        return HDDSGroup.fruits;
      case DDSFoodGroup.organMeats:
        return HDDSGroup.meat;
      case DDSFoodGroup.fleshMeats:
        return HDDSGroup.meat;
      case DDSFoodGroup.eggs:
        return HDDSGroup.eggs;
      case DDSFoodGroup.fishAndSeafood:
        return HDDSGroup.fishAndOtherSeafood;
      case DDSFoodGroup.legumesNutsSeeds:
        return HDDSGroup.legumesNutsSeeds;
      case DDSFoodGroup.milkAndMilkProducts:
        return HDDSGroup.milkAndMilkProducts;
      case DDSFoodGroup.oilsAndFats:
        return HDDSGroup.oilsAndFats;
      case DDSFoodGroup.sweets:
        return HDDSGroup.sweets;
      case DDSFoodGroup.spicesCondimentsBeverages:
        return HDDSGroup.spicesCondimentsBeverages;
    }
  }
}

Future<Map<HDDSGroup, int>> calculateDiversityScore(FCTRepository fctRepository,
    String fctId, List<FlatCollection> collections) async {
  var ddsGroups = {for (final hddsGroup in HDDSGroup.values) hddsGroup: 0};

  for (final collection in collections) {
    for (final fctFoodItemId in collection.collection.foodItems
        .expand((foodItem) => foodItem.recipe!.ingredients)
        .map((ingredient) => ingredient.fctFoodItemId)) {
      final fctFoodItem =
          await fctRepository.getFoodItemById(fctId: fctId, id: fctFoodItemId!);
      if (fctFoodItem == null) continue;
      final hddsGroup = HDDSGroup.fromDDSFoodGroup(fctFoodItem.ddsGroupId);
      ddsGroups[hddsGroup] = 1;
    }
  }

  return ddsGroups;
}
