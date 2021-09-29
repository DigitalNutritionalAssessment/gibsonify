import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gibsonify/collection/collection.dart';
import 'package:gibsonify/navigation/navigation.dart';

class SensitizationScreen extends StatelessWidget {
  const SensitizationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: refactor this to a Scrollview or something else
    // such that I don't nest two Scaffolds
    return Scaffold(
        appBar: AppBar(title: const Text('Sensitization')),
        body: const SensitizationForm(),
        floatingActionButton: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              FloatingActionButton(
                  child: const Icon(Icons.help),
                  onPressed: () => Navigator.pushNamed(
                      context, PageRouter.sensitizationHelp))
            ]));
  }
}

class SensitizationForm extends StatefulWidget {
  const SensitizationForm({Key? key}) : super(key: key);

  @override
  State<SensitizationForm> createState() => _SensitizationFormState();
}

// TODO: Fix form input fields showwing errors while typing
class _SensitizationFormState extends State<SensitizationForm> {
  final _householdIdFocusNode = FocusNode();
  final _respondentNameFocusNode = FocusNode();
  final _respondentTelNumberFocusNode = FocusNode();
  final _interviewDateFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _householdIdFocusNode.addListener(() {
      if (!_householdIdFocusNode.hasFocus) {
        context.read<CollectionBloc>().add(HouseholdIdUnfocused());
      }
    });
    _respondentNameFocusNode.addListener(() {
      if (!_respondentNameFocusNode.hasFocus) {
        context.read<CollectionBloc>().add(RespondentNameUnfocused());
      }
    });
    _respondentTelNumberFocusNode.addListener(() {
      if (!_respondentTelNumberFocusNode.hasFocus) {
        context.read<CollectionBloc>().add(RespondentTelNumberUnfocused());
      }
    });
    _interviewDateFocusNode.addListener(() {
      if (!_interviewDateFocusNode.hasFocus) {
        context.read<CollectionBloc>().add(InterviewDateUnfocused());
      }
    });
  }

  @override
  void dispose() {
    _householdIdFocusNode.dispose();
    _respondentNameFocusNode.dispose();
    _respondentTelNumberFocusNode.dispose();
    _interviewDateFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          HouseholdIdInput(focusNode: _householdIdFocusNode),
          RespondentNameInput(focusNode: _respondentNameFocusNode),
          RespondentTelNumberInput(focusNode: _respondentTelNumberFocusNode),
          InterviewDateInput(focusNode: _interviewDateFocusNode)
        ],
      ),
    );
  }
}

// TODO: refactor input forms into one reusable widget, and/or move to separate
// files

class HouseholdIdInput extends StatelessWidget {
  const HouseholdIdInput({Key? key, required this.focusNode}) : super(key: key);

  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CollectionBloc, CollectionState>(
      builder: (context, state) {
        return TextFormField(
          initialValue: state.householdId.value,
          focusNode: focusNode,
          decoration: InputDecoration(
            icon: const Icon(Icons.house),
            labelText: 'Household ID',
            helperText: 'A valid Household ID e.g. IMH13D0303',
            errorText: state.householdId.invalid
                ? 'Enter a valid Household ID e.g. IMH13D0303'
                : null,
          ),
          onChanged: (value) {
            context
                .read<CollectionBloc>()
                .add(HouseholdIdChanged(householdId: value));
          },
          textInputAction: TextInputAction.next,
        );
      },
    );
  }
}

class RespondentNameInput extends StatelessWidget {
  const RespondentNameInput({Key? key, required this.focusNode})
      : super(key: key);

  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CollectionBloc, CollectionState>(
      builder: (context, state) {
        return TextFormField(
          initialValue: state.respondentName.value,
          focusNode: focusNode,
          decoration: InputDecoration(
            icon: const Icon(Icons.person),
            labelText: 'Respondent Name',
            helperText: 'Full name of respondent e.g. Keira Brown',
            errorText:
                state.respondentName.invalid ? 'Enter respondent name' : null,
          ),
          onChanged: (value) {
            context
                .read<CollectionBloc>()
                .add(RespondentNameChanged(respondentName: value));
          },
          textInputAction: TextInputAction.next,
        );
      },
    );
  }
}

class RespondentTelNumberInput extends StatelessWidget {
  const RespondentTelNumberInput({Key? key, required this.focusNode})
      : super(key: key);

  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CollectionBloc, CollectionState>(
      builder: (context, state) {
        return TextFormField(
          initialValue: state.respondentTelNumber.value,
          keyboardType: TextInputType.phone,
          focusNode: focusNode,
          decoration: InputDecoration(
            icon: const Icon(Icons.phone),
            labelText: 'Respondent Tel. Number',
            helperText: 'Full tel. number of respondent e.g. +447448238123',
            errorText: state.respondentTelNumber.invalid
                ? 'Enter valid tel. number'
                : null,
          ),
          onChanged: (value) {
            context
                .read<CollectionBloc>()
                .add(RespondentTelNumberChanged(respondentTelNumber: value));
          },
          textInputAction: TextInputAction.next,
        );
      },
    );
  }
}

class InterviewDateInput extends StatelessWidget {
  const InterviewDateInput({Key? key, required this.focusNode})
      : super(key: key);

  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CollectionBloc, CollectionState>(
      builder: (context, state) {
        return TextFormField(
          initialValue: state.interviewDate.value,
          keyboardType: TextInputType.datetime,
          focusNode: focusNode,
          decoration: InputDecoration(
            icon: const Icon(Icons.calendar_today),
            labelText: 'Interview Date',
            helperText: 'Date at the interview',
            errorText:
                state.interviewDate.invalid ? 'Enter a valid date' : null,
          ),
          onChanged: (value) {
            context
                .read<CollectionBloc>()
                .add(InterviewDateChanged(interviewDate: value));
          },
        );
      },
    );
  }
}
// TODO: Add datepicker

// TODO: Add a "First Pass" Button at the bottom of the form
