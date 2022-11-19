import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gibsonify/household/bloc/household_bloc.dart';
import 'package:gibsonify_api/gibsonify_api.dart';
import 'package:intl/intl.dart';

class ViewRespondentPage extends StatelessWidget {
  final int index;

  const ViewRespondentPage({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HouseholdBloc, HouseholdState>(
      builder: (context, state) {
        final respondent = state.household!.respondents[index];

        return Scaffold(
          appBar: AppBar(
            title: Text(respondent.name),
            actions: [
              IconButton(onPressed: () => {}, icon: const Icon(Icons.edit))
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: respondentView(context, respondent),
          ),
        );
      },
    );
  }
}

Widget respondentView(BuildContext context, Respondent respondent) {
  DateFormat formatter = DateFormat('yyyy-MM-dd');

  return Column(
    children: [
      TextFormField(
        readOnly: true,
        decoration: const InputDecoration(
            labelText: 'Phone Number', icon: Icon(Icons.phone)),
        initialValue: respondent.phoneNumber,
      ),
      TextFormField(
        readOnly: true,
        decoration: const InputDecoration(
            labelText: 'Comments', icon: Icon(Icons.comment)),
        initialValue: respondent.comments,
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
            child: Icon(Icons.info),
          ),
          Text('Collections', style: Theme.of(context).textTheme.headline6),
          const Spacer(),
          IconButton(onPressed: () => {}, icon: const Icon(Icons.add))
        ],
      ),
      const Padding(
        padding: EdgeInsets.all(8.0),
        child: Divider(),
      ),
      Row(
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.straighten),
          ),
          Text('Anthropometrics', style: Theme.of(context).textTheme.headline6),
          const Spacer(),
          IconButton(onPressed: () => {}, icon: const Icon(Icons.add))
        ],
      ),
    ],
  );
}
