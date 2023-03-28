import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:gibsonify/household/household.dart';
import 'package:gibsonify/surveys/surveys.dart';
import 'package:intl/intl.dart';
import 'package:dropdown_search/dropdown_search.dart';

import 'package:gibsonify/collection/collection.dart';
import 'package:gibsonify/navigation/navigation.dart';
import 'package:gibsonify_api/gibsonify_api.dart';

class SensitizationScreen extends StatelessWidget {
  const SensitizationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Information'),
          actions: [
            IconButton(
                onPressed: () =>
                    Navigator.pushNamed(context, PageRouter.sensitizationHelp),
                icon: const Icon(Icons.help))
          ],
        ),
        body: Column(
          children: const [
            CollectionFinishedTile(),
            Expanded(child: SingleChildScrollView(child: SensitizationForm())),
          ],
        ));
  }
}

class SensitizationForm extends StatelessWidget {
  const SensitizationForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      // TODO: investigate BlocBuilder nesting, probably not best practice, so
      // maybe rewrite children widgets without BlocBuilders
      child: BlocBuilder<CollectionBloc, CollectionState>(
        builder: (context, state) {
          return AbsorbPointer(
            absorbing: state.gibsonsForm.finished,
            child: Column(
              children: const <Widget>[
                SurveyInput(),
                RecallDayInput(),
                InterviewDateInput(),
                InterviewStartTimeInput(),
                PhysioStatusInput()
              ],
            ),
          );
        },
      ),
    );
  }
}

// TODO: refactor input forms into one reusable widget, and/or move to separate
// files

class SurveyInput extends StatelessWidget {
  const SurveyInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SurveysBloc, SurveysState>(
      builder: (context, surveysState) {
        return BlocBuilder<CollectionBloc, CollectionState>(
          builder: (context, collectionState) {
            return DropdownSearch<String>(
              popupProps: const PopupProps.menu(
                  showSelectedItems: true,
                  fit: FlexFit.loose,
                  constraints: BoxConstraints.tightFor()),
              dropdownDecoratorProps: DropDownDecoratorProps(
                dropdownSearchDecoration: InputDecoration(
                    icon: const Icon(Icons.assignment),
                    labelText: "Survey ID",
                    helperText:
                        'The survey under which this interview is being performed',
                    // TODO: the errorText should be displayed if nothing is chosen
                    // so investigate how this can be achieved with focusnodes or
                    // maybe send an empty string (although that would not work all
                    // the time), currently the errorText is never shown
                    errorText: isFieldModifiedAndEmpty(
                            collectionState.gibsonsForm.surveyId)
                        ? 'Select survey'
                        : null),
              ),
              items: surveysState.surveys
                  .map((survey) => survey.surveyId)
                  .toList(),
              onChanged: (surveyId) {
                if (surveyId != null) {
                  context
                      .read<CollectionBloc>()
                      .add(SurveyChanged(surveyId: surveyId));
                }
              },
              selectedItem: collectionState.gibsonsForm.surveyId,
            );
          },
        );
      },
    );
  }
}

class RecallDayInput extends StatelessWidget {
  const RecallDayInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const List<String> recallDayTypes = [
      'Normal day',
      'Sick day',
      'Fasting day',
      'Festival/religious day',
      'Parties/functions day',
      'Visitors/relatives',
      'Other'
    ];

    return BlocBuilder<CollectionBloc, CollectionState>(
      builder: (context, state) {
        return DropdownSearch<String>(
            popupProps: const PopupProps.menu(
                showSelectedItems: true,
                // FlexFit.loose and BoxConstraints.tightFor() give dynamic size
                fit: FlexFit.loose,
                constraints: BoxConstraints.tightFor()),
            dropdownDecoratorProps: DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(
                  icon: const Icon(Icons.food_bank_outlined),
                  labelText: "Recall Day",
                  helperText: 'Type of the recall day',
                  // TODO: the errorText should be displayed if nothing is chosen
                  // so investigate how this can be achieved with focusnodes or
                  // maybe send an empty string (although that would not work all
                  // the time), currently the errorText is never shown
                  errorText: isFieldModifiedAndInvalid(
                          state.gibsonsForm.recallDay,
                          state.gibsonsForm.isRecallDayValid)
                      ? 'Select recall day type'
                      : null),
            ),
            items: recallDayTypes,
            onChanged: (String? recallDayType) => context
                .read<CollectionBloc>()
                .add(RecallDayChanged(recallDay: recallDayType ?? '')),
            selectedItem: state.gibsonsForm.recallDay);
      },
    );
  }
}

class InterviewDateInput extends StatefulWidget {
  const InterviewDateInput({Key? key}) : super(key: key);

  @override
  State<InterviewDateInput> createState() => _InterviewDateInputState();
}

class _InterviewDateInputState extends State<InterviewDateInput> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HouseholdBloc, HouseholdState>(
      builder: (context, householdState) {
        return BlocBuilder<CollectionBloc, CollectionState>(
          builder: (context, state) {
            return TextFormField(
              readOnly: true,
              key: UniqueKey(),
              initialValue: state.gibsonsForm.interviewDate,
              decoration: InputDecoration(
                icon: const Icon(Icons.calendar_today),
                labelText: 'Interview Date',
                helperText: 'Date of interview start',
                errorText: isFieldModifiedAndInvalid(
                        state.gibsonsForm.interviewDate, () => true)
                    ? 'Interview date needs to be at '
                        'least two days after sensitization date'
                    : null,
              ),
              onTap: () async {
                var date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: householdState.household!.sensitizationDate
                        .add(const Duration(days: 1)),
                    lastDate: DateTime.now());
                if (!mounted) return;
                var formattedDate =
                    date == null ? '' : DateFormat('yyyy-MM-dd').format(date);
                context
                    .read<CollectionBloc>()
                    .add(InterviewDateChanged(interviewDate: formattedDate));
              },
            );
          },
        );
      },
    );
  }
}

class InterviewStartTimeInput extends StatefulWidget {
  const InterviewStartTimeInput({Key? key}) : super(key: key);

  @override
  State<InterviewStartTimeInput> createState() =>
      _InterviewStartTimeInputState();
}

class _InterviewStartTimeInputState extends State<InterviewStartTimeInput> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CollectionBloc, CollectionState>(
      builder: (context, state) {
        return TextFormField(
          readOnly: true,
          key: UniqueKey(),
          initialValue: state.gibsonsForm.interviewStartTime,
          decoration: InputDecoration(
            icon: const Icon(Icons.access_time),
            labelText: 'Interview Start Time',
            helperText: 'Time at the start of the interview',
            errorText: isFieldModifiedAndInvalid(
                    state.gibsonsForm.interviewStartTime,
                    state.gibsonsForm.isInterviewStartTimeValid)
                ? 'Choose the start time of the interview'
                : null,
          ),
          onTap: () async {
            var time = await showTimePicker(
                context: context, initialTime: TimeOfDay.now());
            if (!mounted) return;
            var formattedTime = time?.format(context);
            context.read<CollectionBloc>().add(InterviewStartTimeChanged(
                interviewStartTime: formattedTime ?? ''));
          },
        );
      },
    );
  }
}

class PhysioStatusInput extends StatelessWidget {
  const PhysioStatusInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HouseholdBloc, HouseholdState>(
      builder: (context, householdState) {
        return BlocBuilder<CollectionBloc, CollectionState>(
            builder: (context, collectionState) {
          return FormBuilderDropdown(
              name: 'physioStatus',
              key: UniqueKey(),
              decoration: const InputDecoration(
                label: Text('Physiological Status'),
                icon: Icon(Icons.health_and_safety),
                helperText: 'Whether the respondent is pregnant or lactating',
              ),
              enabled: householdState
                      .household!
                      .respondents[householdState.selectedRespondentIndex!]
                      .sex ==
                  Sex.female,
              initialValue: collectionState.gibsonsForm.physioStatus,
              onChanged: (PhysioStatus? physioStatus) {
                if (physioStatus != null) {
                  context
                      .read<CollectionBloc>()
                      .add(PhysioStatusChanged(physioStatus: physioStatus));
                }
              },
              items: PhysioStatus.values
                  .map((physioStatus) => DropdownMenuItem(
                      value: physioStatus,
                      child: Text(physioStatusToString(physioStatus))))
                  .toList());
        });
      },
    );
  }
}
