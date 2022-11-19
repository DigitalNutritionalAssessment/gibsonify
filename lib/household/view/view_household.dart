import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gibsonify/household/bloc/household_bloc.dart';
import 'package:intl/intl.dart';

import '../../navigation/models/page_router.dart';

class ViewHouseholdPage extends StatelessWidget {
  const ViewHouseholdPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HouseholdBloc, HouseholdState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: state is HouseholdLoaded
                ? Text(state.household!.householdId)
                : const Text('Household'),
            actions: state is HouseholdLoaded
                ? [
                    IconButton(
                        onPressed: () => {
                              Navigator.pushNamed(
                                context,
                                PageRouter.editHousehold,
                              )
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
          initialValue: state.household!.geoLocation,
        ),
        TextFormField(
          readOnly: true,
          decoration: const InputDecoration(
              labelText: 'Sensitization Date',
              icon: Icon(Icons.calendar_today)),
          initialValue: formatter.format(state.household!.sensitizationDate),
        ),
        TextFormField(
          readOnly: true,
          decoration: const InputDecoration(
              labelText: 'Comments', icon: Icon(Icons.comment)),
          initialValue: state.household!.comments,
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
                onPressed: () =>
                    Navigator.pushNamed(context, PageRouter.createRespondent),
                icon: const Icon(Icons.add))
          ],
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(2.0),
            itemCount: state.household!.respondents.length,
            itemBuilder: (context, index) {
              return Card(
                  child: ListTile(
                title: Text(state.household!.respondents[index].name),
                subtitle: Text("ID: ${index + 1}"),
                onTap: () => {},
                onLongPress: () => {},
              ));
            },
          ),
        )
      ],
    );
  } else {
    return const Center(child: Text('Error'));
  }
}
