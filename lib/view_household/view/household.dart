import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gibsonify/view_household/bloc/household_bloc.dart';
import 'package:gibsonify_repository/gibsonify_repository.dart';
import 'package:intl/intl.dart';

import '../../navigation/models/page_router.dart';

class ViewHouseholdPage extends StatelessWidget {
  final int id;

  const ViewHouseholdPage(this.id, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          HouseholdBloc(isarRepository: context.read<IsarRepository>())
            ..add(HouseholdOpened(id: id)),
      child: BlocBuilder<HouseholdBloc, HouseholdState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: state is HouseholdLoaded
                  ? Text(state.household.householdId)
                  : const Text('Household'),
              actions: state is HouseholdLoaded
                  ? [
                      IconButton(
                          onPressed: () => {
                                Navigator.pushNamed(
                                    context, PageRouter.editHousehold,
                                    arguments: {'id': state.household.id})
                              },
                          icon: const Icon(Icons.edit))
                    ]
                  : [],
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: householdView(context, state),
            ),
          );
        },
      ),
    );
  }
}

Widget householdView(context, state) {
  if (state is HouseholdInitial) {
    return const Center(child: CircularProgressIndicator());
  } else if (state is HouseholdLoaded) {
    DateFormat formatter = DateFormat('yyyy-MM-dd');

    return Column(
      children: [
        TextFormField(
          readOnly: true,
          decoration: const InputDecoration(
              labelText: 'Location', icon: Icon(Icons.location_on_outlined)),
          initialValue: state.household.geoLocation,
        ),
        TextFormField(
          readOnly: true,
          decoration: const InputDecoration(
              labelText: 'Sensitization Date',
              icon: Icon(Icons.calendar_today)),
          initialValue: formatter.format(state.household.sensitizationDate),
        ),
        TextFormField(
          readOnly: true,
          decoration: const InputDecoration(
              labelText: 'Comments', icon: Icon(Icons.comment)),
          initialValue: state.household.comments,
          minLines: 1,
          maxLines: null,
        ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Divider(),
        ),
        Row(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.people),
            ),
            Text('Respondents', style: Theme.of(context).textTheme.headline6),
            const Spacer(),
            IconButton(
                onPressed: () => Navigator.pushNamed(
                    context, PageRouter.createRespondent,
                    arguments: {'id': state.household.id}),
                icon: const Icon(Icons.add))
          ],
        ),
      ],
    );
  } else {
    return const Center(child: Text('Error'));
  }
}