import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:dropdown_search/dropdown_search.dart';

import 'package:gibsonify/collection/collection.dart';
import 'package:gibsonify/navigation/navigation.dart';

class SensitizationScreen extends StatelessWidget {
  const SensitizationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Sensitization'),
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
          initialValue: state.gibsonsForm.householdId,
          decoration: InputDecoration(
            icon: const Icon(Icons.house),
            labelText: 'Household ID',
            helperText: 'A valid Household ID e.g. IMH13D0303',
            // Only show errorText if modified, i.e. if not null, and invalid
            errorText: state.gibsonsForm.householdId != null &&
                    !state.gibsonsForm.isHouseholdIdValid()
                ? 'Enter a valid Household ID with 10 to 15 digits'
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
          initialValue: state.gibsonsForm.respondentName,
          decoration: InputDecoration(
            icon: const Icon(Icons.person),
            labelText: 'Respondent Name',
            helperText: 'Full name of respondent e.g. Keira Brown',
            errorText: state.gibsonsForm.respondentName != null &&
                    !state.gibsonsForm.isRespondentNameValid()
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
          decoration: const InputDecoration(
            labelText: 'Respondent Tel. Number',
            icon: Icon(Icons.phone),
            helperText: 'Full tel. number of respondent e.g. +447448238123',
          ),
          initialValue: state.gibsonsForm.respondentTelNumber,
          initialCountryCode: state.gibsonsForm.respondentCountryCode ?? 'IN',
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
          initialValue: state.gibsonsForm.sensitizationDate,
          decoration: InputDecoration(
            icon: const Icon(Icons.calendar_today),
            labelText: 'Sensitization Date',
            helperText: 'Date of sensitization visit',
            errorText: state.gibsonsForm.sensitizationDate != null &&
                    !state.gibsonsForm.isSensitizationDateValid()
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
            maxHeight: 395.0,
            dropdownSearchDecoration: InputDecoration(
                icon: const Icon(Icons.food_bank_outlined),
                labelText: "Recall Day",
                helperText: 'Type of the recall day',
                // TODO: the errorText should be displayed if nothing is chosen
                // so investigate how this can be achieved with focusnodes or
                // maybe send an empty string (although that would not work all
                // the time), currently the errorText is never shown
                errorText: state.gibsonsForm.recallDay != null &&
                        !state.gibsonsForm.isRecallDayValid()
                    ? 'Select recall day type'
                    : null),
            mode: Mode.MENU,
            showSelectedItems: true,
            showSearchBox: false,
            items: recallDayTypes,
            onChanged: (String? recallDayType) => context
                .read<CollectionBloc>()
                .add(RecallDayChanged(recallDay: recallDayType ?? '')),
            selectedItem: state.gibsonsForm.recallDay);
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
          initialValue: state.gibsonsForm.interviewDate,
          decoration: InputDecoration(
            icon: const Icon(Icons.calendar_today),
            labelText: 'Interview Date',
            helperText: 'Date of interview start',
            errorText: state.gibsonsForm.interviewDate != null &&
                    !state.gibsonsForm.isInterviewDateValid()
                ? 'Interview date needs to be at '
                    'least two days after sensitization date'
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
          initialValue: state.gibsonsForm.interviewStartTime,
          decoration: InputDecoration(
            icon: const Icon(Icons.access_time),
            labelText: 'Interview Start Time',
            helperText: 'Time at the start of the interview',
            errorText: state.gibsonsForm.interviewStartTime != null &&
                    !state.gibsonsForm.isInterviewStartTimeValid()
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
    return BlocListener<CollectionBloc, CollectionState>(
      listenWhen: (previous, current) =>
          previous.geoLocationStatus != current.geoLocationStatus,
      listener: (context, state) {
        if (state.geoLocationStatus == GeoLocationStatus.locationRequested) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(
                  content: Text('Requested device location, please wait.')),
            );
        }
        if (state.geoLocationStatus == GeoLocationStatus.locationDetermined) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(
                  content: Text('Location successfully determined!')),
            );
        }
        if (state.geoLocationStatus == GeoLocationStatus.locationDisabled) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(
                  content: Text('Location services are disabled. '
                      'Please enable location services first and restart '
                      'the app.')),
            );
        }
        if (state.geoLocationStatus == GeoLocationStatus.locationDenied) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(
                  content: Text('Location services are denied. '
                      'Please allow location access for Gibsonify.')),
            );
        }
        if (state.geoLocationStatus ==
            GeoLocationStatus.locationPermanentlyDenied) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(
                  content: Text('Location services are permanently denied. '
                      'Please allow location access for Gibsonify in device '
                      'settings.')),
            );
        }
        if (state.geoLocationStatus == GeoLocationStatus.locationTimedOut) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(
                  content: Text(
                      'Location could not be determined in a reasonable time. '
                      'Please ensure you have proper GPS signal reception.')),
            );
        }
      },
      child: BlocBuilder<CollectionBloc, CollectionState>(
        builder: (context, state) {
          return TextFormField(
            readOnly: true,
            key: UniqueKey(),
            initialValue: state.gibsonsForm.geoLocation.value,
            onTap: () => context
                .read<CollectionBloc>()
                .add(const GeoLocationRequested()),
            decoration: InputDecoration(
              suffixIcon:
                  state.geoLocationStatus == GeoLocationStatus.locationRequested
                      ? const CircularProgressIndicator()
                      : null,
              icon: const Icon(Icons.location_on_outlined),
              labelText: 'GPS Location',
              helperText: 'GPS Coordinates',
              errorText: state.gibsonsForm.geoLocation.invalid
                  ? 'Request the GPS location'
                  : null,
            ),
          );
        },
      ),
    );
  }
}

// TODO: Only allow to move to first pass if all sensitization fields are valid,
// e.g. perhaps make a isSensitizationValid() method in GibsonsForm
