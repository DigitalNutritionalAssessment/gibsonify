import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gibsonify/home/home.dart';
import 'package:gibsonify/login/login.dart';
import 'package:gibsonify/navigation/navigation.dart';

class HouseholdsScreen extends StatelessWidget {
  const HouseholdsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                          subtitle: Text(
                              homeState.households[index].sensitizationDate),
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
                        onPressed: () {}),
                  ]));
        },
      );
    });
  }
}
