import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gibsonify/home/home.dart';
import 'package:gibsonify/login/login.dart';
import 'package:gibsonify/navigation/navigation.dart';
import 'package:intl/intl.dart';

class HouseholdsScreen extends StatelessWidget {
  const HouseholdsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateFormat formatter = DateFormat('yyyy-MM-dd');

    return BlocBuilder<LoginBloc, LoginState>(builder: (context, loginState) {
      return BlocBuilder<HomeBloc, HomeState>(
        builder: (context, homeState) {
          return Scaffold(
              appBar: AppBar(
                title: const Text('Households'),
                actions: [
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
                      itemCount: homeState.households.length,
                      itemBuilder: (context, index) {
                        return Card(
                            child: ListTile(
                          title: Text(homeState.households[index].householdId),
                          subtitle: Text(formatter.format(
                              homeState.households[index].sensitizationDate)),
                          onTap: () => Navigator.pushNamed(
                              context, PageRouter.viewHousehold, arguments: {
                            'id': homeState.households[index].id
                          }),
                          onLongPress: () => showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return HouseholdOptions(
                                    id: homeState.households[index].id,
                                    householdId: homeState
                                        .households[index].householdId);
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
                        onPressed: () {
                          Navigator.pushNamed(
                              context, PageRouter.createHousehold);
                        }),
                  ]));
        },
      );
    });
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
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        final List<Widget> options = [
          ListTile(title: Text(householdId)),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.delete),
            title: const Text('Delete'),
            onTap: () {
              context.read<HomeBloc>().add(DeleteHousehold(id: id));
              Navigator.pop(context);
            },
          )
        ];
        return Wrap(children: options);
      },
    );
  }
}
