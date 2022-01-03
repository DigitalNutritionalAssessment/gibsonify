import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:gibsonify/collection/collection.dart';
import 'package:gibsonify/navigation/navigation.dart';

class SensitizationScreen extends StatelessWidget {
  const SensitizationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Sensitization'),
          // TODO: Refactor this BackButton as a reusable widget across passes
          leading: BackButton(
            onPressed: () {
              context.read<CollectionBloc>().add(GibsonsFormSaved());
              Navigator.maybePop(context);
            },
          ),
          actions: [
            IconButton(
                onPressed: () =>
                    Navigator.pushNamed(context, PageRouter.sensitizationHelp),
                icon: const Icon(Icons.help))
          ],
        ),
        body: const SensitizationForm());
  }
}

class SensitizationForm extends StatelessWidget {
  const SensitizationForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: const <Widget>[
          HouseholdIdInput(),
          RespondentNameInput(),
          RespondentTelNumberInput(),
          InterviewDateInput(),
          InterviewStartTimeInput()
        ],
      ),
    );
  }
}

// TODO: refactor input forms into one reusable widget, and/or move to separate
// files

class HouseholdIdInput extends StatelessWidget {
  const HouseholdIdInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CollectionBloc, CollectionState>(
      builder: (context, state) {
        return TextFormField(
          initialValue: state.gibsonsForm.householdId.value,
          decoration: InputDecoration(
            icon: const Icon(Icons.house),
            labelText: 'Household ID',
            helperText: 'A valid Household ID e.g. IMH13D0303',
            errorText: state.gibsonsForm.householdId.invalid
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
  const RespondentNameInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CollectionBloc, CollectionState>(
      builder: (context, state) {
        return TextFormField(
          initialValue: state.gibsonsForm.respondentName.value,
          decoration: InputDecoration(
            icon: const Icon(Icons.person),
            labelText: 'Respondent Name',
            helperText: 'Full name of respondent e.g. Keira Brown',
            errorText: state.gibsonsForm.respondentName.invalid
                ? 'Enter respondent name'
                : null,
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
  const RespondentTelNumberInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CollectionBloc, CollectionState>(
      builder: (context, state) {
        return TextFormField(
          initialValue: state.gibsonsForm.respondentTelNumber.value,
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
            icon: const Icon(Icons.phone),
            labelText: 'Respondent Tel. Number',
            helperText: 'Full tel. number of respondent e.g. +447448238123',
            errorText: state.gibsonsForm.respondentTelNumber.invalid
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
  const InterviewDateInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CollectionBloc, CollectionState>(
      builder: (context, state) {
        return TextFormField(
          readOnly: true,
          key: Key(state.gibsonsForm.interviewDate.value),
          initialValue: state.gibsonsForm.interviewDate.value,
          decoration: InputDecoration(
            icon: const Icon(Icons.calendar_today),
            labelText: 'Interview Date',
            helperText: 'Date of interview start',
            errorText: state.gibsonsForm.interviewDate.invalid
                ? 'Choose the date of interview start'
                : null,
          ),
          onTap: () async {
            var date = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1900),
                lastDate: DateTime(2100));
            var formattedDate =
                date == null ? '' : DateFormat('yyyy-MM-dd').format(date);
            context
                .read<CollectionBloc>()
                .add(InterviewDateChanged(interviewDate: formattedDate));
          },
        );
      },
    );
  }
}

class InterviewStartTimeInput extends StatelessWidget {
  const InterviewStartTimeInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CollectionBloc, CollectionState>(
      builder: (context, state) {
        return TextFormField(
          readOnly: true,
          key: Key(state.gibsonsForm.interviewStartTime.value),
          initialValue: state.gibsonsForm.interviewStartTime.value,
          decoration: InputDecoration(
            icon: const Icon(Icons.access_time),
            labelText: 'Interview Start Time',
            helperText: 'Time at the start of the interview',
            errorText: state.gibsonsForm.interviewStartTime.invalid
                ? 'Choose the start time of the interview'
                : null,
          ),
          onTap: () async {
            var time = await showTimePicker(
                context: context, initialTime: TimeOfDay.now());
            var formattedTime = time?.format(context);
            context.read<CollectionBloc>().add(InterviewStartTimeChanged(
                interviewStartTime: formattedTime ?? ''));
          },
        );
      },
    );
  }
}


// TODO: Add a "Tick mark" FloatingActionButton to the bottom right of Scaffold
// that checks if the all the fields are completed
// (i.e. checks state.sensitizationStatus.isValid) and allows to go to first
// pass if true

// Or perhaps make the bottom navigation bar be a part of the state and only 
// allow to pass to next one if previous one is complete
