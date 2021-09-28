import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gibsonify/collection/collection.dart';

class SensitizationScreen extends StatelessWidget {
  const SensitizationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: move BlocBuilder to standalone widgets
    // such that only those get rebuilt
    return BlocBuilder<CollectionBloc, CollectionState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: const Text('Sensitization')),
          // TODO: refactor into standalone widgets
          body: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(child: Text('Household ID')),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                    onChanged: (householdId) => context
                        .read<CollectionBloc>()
                        .add(CollectionUpdated(state.collection
                            .copyWith(householdId: householdId))),
                    decoration: InputDecoration(
                        hintText: state.collection.householdId ??
                            'Enter Household ID',
                        border: const OutlineInputBorder())),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(child: Text('Respondent Name')),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                    onChanged: (respondentName) => context
                        .read<CollectionBloc>()
                        .add(CollectionUpdated(state.collection
                            .copyWith(respondentName: respondentName))),
                    decoration: InputDecoration(
                        hintText: state.collection.respondentName ??
                            'Enter Respondent Name',
                        border: const OutlineInputBorder())),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(child: Text('Respondent Tel. Number')),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                    keyboardType: TextInputType.number,
                    onChanged: (respondentTelephoneNumber) => context
                        .read<CollectionBloc>()
                        .add(CollectionUpdated(state.collection.copyWith(
                            respondentTelephoneNumber:
                                respondentTelephoneNumber))),
                    decoration: InputDecoration(
                        hintText: state.collection.respondentTelephoneNumber ??
                            'Enter Respondent Tel. Number',
                        border: const OutlineInputBorder())),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(child: Text('Interview Date')),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                    onChanged: (interviewDate) => context
                        .read<CollectionBloc>()
                        .add(CollectionUpdated(state.collection
                            .copyWith(interviewDate: interviewDate))),
                    decoration: InputDecoration(
                        hintText: state.collection.interviewDate ??
                            'Enter Interview Date',
                        border: const OutlineInputBorder())),
                // TODO: fix bug with only date being one
              ),
            ],
          ),
          // TODO: Add floating action button for help prompt (with an '?' Icon)
        );
      },
    );
  }
}

// TODO: Implement a block observer

// // TODO: move to widgets
// class DatePicker extends StatefulWidget {
//   const DatePicker({Key? key}) : super(key: key);

//   @override
//   _DatePickerState createState() => _DatePickerState();
// }

// class _DatePickerState extends State<DatePicker> {
//   final _dateController = TextEditingController();

//   @override
//   void dispose() {
//     _dateController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<CollectionBloc, CollectionState>(
//       builder: (context, state) {
//         return TextField(
//             onSubmitted: (interviewDate) => context.read<CollectionBloc>().add(
//                 CollectionUpdated(
//                     state.collection.copyWith(interviewDate: interviewDate))),
//             controller: _dateController,
//             decoration: InputDecoration(
//                 hintText: state.collection.interviewDate ??
//                     'Choose Interview Start Date',
//                 border: const OutlineInputBorder()),
//             onTap: () async {
//               var date = await showDatePicker(
//                   context: context,
//                   initialDate: DateTime.now(),
//                   firstDate: DateTime(1900),
//                   lastDate: DateTime(2100));
//               _dateController.text = date
//                   .toString()
//                   .substring(0, 10); // TODO fix exception when cancelling
//             });
//       },
//     );
//   }
// }

// TODO: rewrite like this
// class _HouseholdIdInput extends StatelessWidget {
//   const _HouseholdIdInput({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<SubjectBloc, SubjectState>(
//       builder: (context, state) {
//         return TextField(
//           onChanged: (hoseholdId) =>
//               context.read<CollectionBloc>().add(CollectionUpdated(state)),
//         );
//       },
//     );
//   }
// }
