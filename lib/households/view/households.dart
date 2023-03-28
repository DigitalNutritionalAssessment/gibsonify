import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gibsonify/households/households.dart';

import 'package:gibsonify/navigation/navigation.dart';
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
            HouseholdsBloc(isarRepository: context.read<IsarRepository>())
              ..add(const HouseholdsPageOpened()),
        child: BlocBuilder<HouseholdsBloc, HouseholdsState>(
          builder: (context, state) {
            return Scaffold(
                appBar: AppBar(
                  title: const Text('Households'),
                  actions: [
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

                          if (state.distances.isNotEmpty) {
                            subtitle += "\n${state.distances[index]}m away";
                          }

                          return Card(
                              child: ListTile(
                            isThreeLine: true,
                            title: Text(household.householdId),
                            subtitle: Text(subtitle),
                            onTap: () => Navigator.pushNamed(
                                context,
                                PageRouter.householdPrefix +
                                    PageRouter.viewHousehold,
                                arguments: {'id': household.id}),
                            onLongPress: () => showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return HouseholdOptions(
                                      id: household.id,
                                      householdId: household.householdId);
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
      {Key? key, required this.id, required this.householdId})
      : super(key: key);

  final int id;
  final String householdId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          HouseholdsBloc(isarRepository: context.read<IsarRepository>()),
      child: BlocBuilder<HouseholdsBloc, HouseholdsState>(
        builder: (context, state) {
          final List<Widget> options = [
            ListTile(title: Text(householdId)),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.delete),
              title: const Text('Delete'),
              onTap: () {
                context
                    .read<HouseholdsBloc>()
                    .add(HouseholdDeleteRequested(id: id));
                Navigator.pop(context);
              },
            )
          ];
          return Wrap(children: options);
        },
      ),
    );
  }
}
