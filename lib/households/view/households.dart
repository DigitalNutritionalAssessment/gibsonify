import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gibsonify/households/households.dart';

import 'package:gibsonify/navigation/navigation.dart';
import 'package:gibsonify/shared/shared.dart';
import 'package:gibsonify_api/gibsonify_api.dart';
import 'package:gibsonify_repository/gibsonify_repository.dart';
import 'package:intl/intl.dart';

enum HouseholdsSortBy { householdId, sensitizationDate, distance }

class HouseholdsScreen extends StatelessWidget {
  const HouseholdsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, [bool mounted = true]) {
    DateFormat formatter = DateFormat('yyyy-MM-dd');

    return BlocProvider(
        create: (context) =>
            HouseholdsBloc(hiveRepository: context.read<HiveRepository>())
              ..add(const HouseholdsPageOpened()),
        child: BlocBuilder<HouseholdsBloc, HouseholdsState>(
          builder: (context, state) {
            final bloc = context.read<HouseholdsBloc>();
            return Scaffold(
                appBar: AppBar(
                  title: const Text('Households'),
                  actions: [
                    IconButton(
                        onPressed: () => context
                            .read<HouseholdsBloc>()
                            .add(const LocationUpdateRequested()),
                        icon: const Icon(Icons.refresh)),
                    IconButton(
                        onPressed: () async {
                          final sortBy = await showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return SimpleDialog(
                                    title: const Text('Sort by'),
                                    children: [
                                      SimpleDialogOption(
                                          onPressed: () => Navigator.pop(
                                              context,
                                              HouseholdsSortBy.householdId),
                                          child: const Text('Household ID')),
                                      SimpleDialogOption(
                                          onPressed: () => Navigator.pop(
                                              context,
                                              HouseholdsSortBy
                                                  .sensitizationDate),
                                          child:
                                              const Text('Sensitization Date')),
                                      SimpleDialogOption(
                                          onPressed: () => Navigator.pop(
                                              context,
                                              HouseholdsSortBy.distance),
                                          child: const Text('Distance')),
                                    ]);
                              });

                          if (mounted && sortBy != null) {
                            context.read<HouseholdsBloc>().add(
                                HouseholdsSortOrderUpdated(sortBy: sortBy));
                          }
                        },
                        icon: const Icon(Icons.sort)),
                    IconButton(
                        onPressed: () => Navigator.pushNamed(
                            context, PageRouter.collectionsHelp),
                        icon: const Icon(Icons.help))
                  ],
                ),
                body: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.all(2.0),
                        itemCount: state.households.length,
                        itemBuilder: (context, index) {
                          final household = state.households[index];
                          var subtitle =
                              "Sensitization Date: ${formatter.format(household.sensitizationDate)}";
                          subtitle +=
                              "\n${household.respondents.length} respondents";

                          return Card(
                              child: ListTile(
                            isThreeLine: true,
                            title: Text(household.householdId),
                            subtitle: Text(subtitle),
                            trailing: state.distances.isNotEmpty
                                ? Text("${state.distances[index]}m away")
                                : null,
                            onTap: () => Navigator.pushNamed(
                                context,
                                PageRouter.householdPrefix +
                                    PageRouter.viewHousehold,
                                arguments: {'id': household.householdId}),
                            onLongPress: () => showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return HouseholdOptions(
                                      bloc: bloc, household: household);
                                }),
                          ));
                        },
                      ),
                    )
                  ],
                ),
                floatingActionButton: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      FloatingActionButton.extended(
                          heroTag: null,
                          label: const Text("New household"),
                          icon: const Icon(Icons.add),
                          onPressed: () async {
                            final newHousehold = await Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return CreateHouseholdPage(
                                  existingHouseholdIds: state.households
                                      .map((household) => household.householdId)
                                      .toSet());
                            }));

                            if (!mounted) {
                              return;
                            }

                            if (newHousehold != null) {
                              context.read<HouseholdsBloc>().add(
                                  NewHouseholdSaveRequested(
                                      household: newHousehold as Household));
                            }
                          }),
                    ]));
          },
        ));
  }
}

class HouseholdOptions extends StatelessWidget {
  const HouseholdOptions(
      {Key? key, required this.household, required this.bloc})
      : super(key: key);

  final Household household;
  final HouseholdsBloc bloc;

  @override
  Widget build(BuildContext context) {
    final List<Widget> options = [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: ListTile(
          isThreeLine: true,
          title: Text(household.householdId),
          subtitle: MetadataSubtitle(
              id: household.householdId, metadata: household.metadata),
        ),
      ),
      const Divider(),
      ListTile(
        leading: const Icon(Icons.delete),
        title: const Text('Delete'),
        onTap: () {
          bloc.add(HouseholdDeleteRequested(id: household.householdId));
          Navigator.pop(context);
        },
      )
    ];
    return Wrap(children: options);
  }
}
