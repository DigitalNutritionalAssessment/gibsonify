import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import 'package:gibsonify/home/home.dart';
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
              context.read<CollectionBloc>().add(const GibsonsFormSaved());
              context.read<HomeBloc>().add(const GibsonsFormsLoaded());
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
        resizeToAvoidBottomInset: false,
        body: const SingleChildScrollView(child: SensitizationForm()));
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
          RespondentTelInfoInput(),
          SensitizationDateInput(),
          RecallDayInput(),
          InterviewDateInput(),
          InterviewStartTimeInput(),
          GeoLocationInput()
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

class RespondentTelInfoInput extends StatelessWidget {
  const RespondentTelInfoInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CollectionBloc, CollectionState>(
      builder: (context, state) {
        return IntlPhoneField(
          invalidNumberMessage: 'Enter a valid tel. number',
          decoration: InputDecoration(
            labelText: 'Respondent Tel. Number',
            icon: const Icon(Icons.phone),
            helperText: 'Full tel. number of respondent e.g. +447448238123',
          ),
          initialValue: state.gibsonsForm.respondentTelNumber.value,
          initialCountryCode:
              state.gibsonsForm.respondentTelNumber.value.isEmpty
                  ? 'IN'
                  : state.gibsonsForm.respondentCountryCode,
          onChanged: (phoneNumber) {
            context.read<CollectionBloc>().add(RespondentTelInfoChanged(
                respondentCountryCode: phoneNumber.countryISOCode,
                respondentTelNumberPrefix: phoneNumber.countryCode,
                respondentTelNumber: phoneNumber.number));
          },
        );
      },
    );
  }
}

class SensitizationDateInput extends StatelessWidget {
  const SensitizationDateInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CollectionBloc, CollectionState>(
      builder: (context, state) {
        return TextFormField(
          readOnly: true,
          key: UniqueKey(),
          initialValue: state.gibsonsForm.sensitizationDate.value,
          decoration: InputDecoration(
            icon: const Icon(Icons.calendar_today),
            labelText: 'Sensitization Date',
            helperText: 'Date of sensitization visit',
            errorText: state.gibsonsForm.sensitizationDate.invalid
                ? 'Choose the sensitization date'
                : null,
          ),
          onTap: () async {
            var date = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1900),
                lastDate: DateTime.now());
            var formattedDate =
                date == null ? '' : DateFormat('yyyy-MM-dd').format(date);
            context.read<CollectionBloc>().add(
                SensitizationDateChanged(sensitizationDate: formattedDate));
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
    const List<DropdownMenuItem<String>> dropdownMenuItems = [
      DropdownMenuItem(child: Text(''), value: ''),
      DropdownMenuItem(child: Text('Normal day'), value: 'Normal day'),
      DropdownMenuItem(child: Text('Sick day'), value: 'Sick day'),
      DropdownMenuItem(child: Text('Fasting day'), value: 'Fasting day'),
      DropdownMenuItem(
          child: Text('Festival/religious day'),
          value: 'Festival/religious day'),
      DropdownMenuItem(
          child: Text('Parties/functions day'), value: 'Parties/functions day'),
      DropdownMenuItem(
          child: Text('Visitors/relatives'), value: 'Visitors/relatives'),
      DropdownMenuItem(child: Text('Other'), value: 'Other'),
    ];
    return BlocBuilder<CollectionBloc, CollectionState>(
      builder: (context, state) {
        return DropdownButtonFormField(
            value: state.gibsonsForm.recallDay.value,
            decoration: InputDecoration(
                icon: const Icon(Icons.food_bank_outlined),
                labelText: 'Recall Day',
                helperText: 'Type of the recall day',
                errorText: state.gibsonsForm.recallDay.invalid
                    ? 'Select recall day type'
                    : null),
            items: dropdownMenuItems,
            onChanged: (String? value) {
              context
                  .read<CollectionBloc>()
                  .add(RecallDayChanged(recallDay: value ?? ''));
            });
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
          key: UniqueKey(),
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
                lastDate: DateTime.now());
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
          key: UniqueKey(),
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

class GeoLocationInput extends StatelessWidget {
  const GeoLocationInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CollectionBloc, CollectionState>(
      builder: (context, state) {
        return TextFormField(
          readOnly: true,
          key: UniqueKey(),
          initialValue: state.gibsonsForm.geoLocation.value,
          onTap: () =>
              context.read<CollectionBloc>().add(const GeoLocationRequested()),
          decoration: InputDecoration(
            icon: const Icon(Icons.location_on_outlined),
            labelText: 'GPS Location',
            helperText: 'GPS Coordinates',
            errorText: state.gibsonsForm.geoLocation.invalid
                ? 'Request the GPS location'
                : null,
          ),
        );
      },
    );
  }
}

// Or perhaps make the bottom navigation bar be a part of the state and only 
// allow to pass to next one if previous one is complete
