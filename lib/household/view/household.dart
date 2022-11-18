import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gibsonify/household/bloc/household_bloc.dart';
import 'package:intl/intl.dart';

class ViewHouseholdPage extends StatelessWidget {
  final int id;

  const ViewHouseholdPage(this.id, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HouseholdBloc, HouseholdState>(
      builder: (context, state) {
        if (state is HouseholdInitial) {
          context.read<HouseholdBloc>().add(HouseholdOpened(id: id));
        }

        return Scaffold(
          appBar: AppBar(
            title: state is HouseholdLoaded
                ? Text(state.household.householdId)
                : const Text('Household'),
            actions: [
              IconButton(onPressed: () => {}, icon: const Icon(Icons.edit))
            ],
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
          initialValue: state.household.geoLocation,
        ),
        TextFormField(
          readOnly: true,
          decoration: const InputDecoration(
              labelText: 'Sensitization Date', icon: Icon(Icons.date_range)),
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
      ],
    );
  } else {
    return const Center(child: Text('Error'));
  }
}
