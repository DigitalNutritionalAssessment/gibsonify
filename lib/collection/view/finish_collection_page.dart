import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:intl/intl.dart';

import 'package:gibsonify/collection/collection.dart';
import 'package:gibsonify_api/gibsonify_api.dart';

class FinishCollectionPage extends StatelessWidget {
  const FinishCollectionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CollectionBloc, CollectionState>(
      builder: (context, state) {
        final bloc = context.read<CollectionBloc>();
        return Column(
          children: [
            const CollectionFinishedTile(),
            const Expanded(
                child: SingleChildScrollView(child: FinishCollectionForm())),
            Visibility(
              visible: !state.gibsonsForm.finished,
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                        icon: const Icon(Icons.check),
                        label: const Text("Finish Collection"),
                        onPressed: state.gibsonsForm.isFinishCollectionValid()
                            ? () {
                                showDialog<String>(
                                    context: context,
                                    useRootNavigator: false,
                                    builder: (BuildContext context) =>
                                        FinishCollectionDialog(bloc: bloc));
                              }
                            : null),
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }
}

class FinishCollectionForm extends StatelessWidget {
  const FinishCollectionForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<CollectionBloc, CollectionState>(
        builder: (context, state) {
          return AbsorbPointer(
            absorbing: state.gibsonsForm.finished,
            child: Column(
              children: const <Widget>[
                PictureChartCollectedInput(),
                PictureChartNotCollectedReason(),
                InterviewEndTimeInput(),
                InterviewFinishedInOneVisitInput(),
                SecondInterviewVisitDateInput(),
                SecondVisitReasonInput(),
                InterviewOutcomeInput(),
                InterviewOutcomeNotCompletedReason(),
                CommentsInput()
              ],
            ),
          );
        },
      ),
    );
  }
}

class PictureChartCollectedInput extends StatelessWidget {
  const PictureChartCollectedInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CollectionBloc, CollectionState>(
      builder: (context, state) {
        return DropdownSearch<String>(
            popupProps: const PopupProps.menu(
              showSelectedItems: true,
              fit: FlexFit.loose,
              constraints: BoxConstraints.tightFor(),
            ),
            dropdownDecoratorProps: DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(
                  icon: const Icon(Icons.photo_size_select_actual_rounded),
                  labelText: 'Is picture chart collected',
                  helperText: 'Have you collected the picture chart?',
                  // TODO: the errorText should be displayed if nothing is chosen
                  // so investigate how this can be achieved with focusnodes or
                  // maybe send an empty string (although that would not work all
                  // the time), currently no errorText is shown
                  errorText: isFieldModifiedAndInvalid(
                          state.gibsonsForm.pictureChartCollected,
                          state.gibsonsForm.isPictureChartCollectedValid)
                      ? 'Select if you collected the picture chart'
                      : null),
            ),
            items: const ['Yes', 'No'],
            onChanged: (String? pictureChartCollected) => context
                .read<CollectionBloc>()
                .add(PictureChartCollectedChanged(
                    pictureChartCollected: pictureChartCollected ?? '')),
            selectedItem: state.gibsonsForm.pictureChartCollected);
      },
    );
  }
}

class PictureChartNotCollectedReason extends StatelessWidget {
  const PictureChartNotCollectedReason({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CollectionBloc, CollectionState>(
      builder: (context, state) {
        return Visibility(
            visible: isFieldNotNullAndNotEmpty(
                    state.gibsonsForm.pictureChartCollected) &&
                !state.gibsonsForm.isPictureChartCollected(),
            child: TextFormField(
              initialValue: state.gibsonsForm.pictureChartNotCollectedReason,
              decoration: InputDecoration(
                icon: const Icon(Icons.device_unknown_outlined),
                labelText: 'Reason for not collecting the picture chart',
                helperText: 'Why did you not collect the picture chart',
                errorText: isFieldModifiedAndInvalid(
                        state.gibsonsForm.pictureChartNotCollectedReason,
                        state.gibsonsForm.isPictureChartNotCollectedReasonValid)
                    ? 'Please state the reason'
                    : null,
              ),
              onChanged: (value) {
                context.read<CollectionBloc>().add(
                    PictureChartNotCollectedReasonChanged(
                        pictureChartNotCollectedReason: value));
              },
            ));
      },
    );
  }
}

class InterviewEndTimeInput extends StatefulWidget {
  const InterviewEndTimeInput({Key? key}) : super(key: key);

  @override
  State<InterviewEndTimeInput> createState() => _InterviewEndTimeInputState();
}

class _InterviewEndTimeInputState extends State<InterviewEndTimeInput> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CollectionBloc, CollectionState>(
      builder: (context, state) {
        return TextFormField(
          readOnly: true,
          key: UniqueKey(),
          initialValue: state.gibsonsForm.interviewEndTime,
          decoration: InputDecoration(
            icon: const Icon(Icons.access_time),
            labelText: 'Interview end time',
            helperText: 'Time at the end of the interview',
            errorText: isFieldModifiedAndInvalid(
                    state.gibsonsForm.interviewEndTime,
                    state.gibsonsForm.isInterviewEndTimeValid)
                ? 'Choose the end time of the interview'
                : null,
          ),
          onTap: () async {
            var time = await showTimePicker(
                context: context, initialTime: TimeOfDay.now());
            if (!mounted) return;
            var formattedTime = time?.format(context);
            context.read<CollectionBloc>().add(
                InterviewEndTimeChanged(interviewEndTime: formattedTime ?? ''));
          },
        );
      },
    );
  }
}

class InterviewFinishedInOneVisitInput extends StatelessWidget {
  const InterviewFinishedInOneVisitInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CollectionBloc, CollectionState>(
      builder: (context, state) {
        return DropdownSearch<String>(
            popupProps: const PopupProps.menu(
                showSelectedItems: true,
                constraints: BoxConstraints(maxHeight: 112.0)),
            dropdownDecoratorProps: DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(
                  icon: const Icon(Icons.calendar_today),
                  labelText: 'Was the interview finished in one visit',
                  helperText:
                      'Have you finished the interview in a single visit',
                  // TODO: the errorText should be displayed if nothing is chosen
                  // so investigate how this can be achieved with focusnodes or
                  // maybe send an empty string (although that would not work all
                  // the time), currently no errorText is shown
                  errorText: isFieldModifiedAndInvalid(
                          state.gibsonsForm.interviewFinishedInOneVisit,
                          state.gibsonsForm.isInterviewFinishedInOneVisitValid)
                      ? 'Select if you finished the interview in one visit'
                      : null),
            ),
            items: const ['Yes', 'No'],
            onChanged: (String? interviewFinishedInOneVisit) => context
                .read<CollectionBloc>()
                .add(InterviewFinishedInOneVisitChanged(
                    interviewFinishedInOneVisit:
                        interviewFinishedInOneVisit ?? '')),
            selectedItem: state.gibsonsForm.interviewFinishedInOneVisit);
      },
    );
  }
}

class SecondInterviewVisitDateInput extends StatefulWidget {
  const SecondInterviewVisitDateInput({Key? key}) : super(key: key);

  @override
  State<SecondInterviewVisitDateInput> createState() =>
      _SecondInterviewVisitDateInputState();
}

class _SecondInterviewVisitDateInputState
    extends State<SecondInterviewVisitDateInput> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CollectionBloc, CollectionState>(
      builder: (context, state) {
        return Visibility(
          visible: isFieldNotNullAndNotEmpty(
                  state.gibsonsForm.interviewFinishedInOneVisit) &&
              !state.gibsonsForm.isInterviewFinishedInOneVisit(),
          child: TextFormField(
            readOnly: true,
            key: UniqueKey(),
            initialValue: state.gibsonsForm.secondInterviewVisitDate,
            decoration: InputDecoration(
              icon: const Icon(Icons.calendar_month),
              labelText: 'Second interview visit date',
              helperText: 'Date of the second interview visit',
              errorText: isFieldModifiedAndInvalid(
                      state.gibsonsForm.secondInterviewVisitDate,
                      state.gibsonsForm.isSecondInterviewVisitDateValid)
                  ? 'Second interview date needs to be after '
                      'the first interview date'
                  : null,
            ),
            onTap: () async {
              var date = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.parse(state.gibsonsForm.interviewDate!),
                  lastDate: DateTime.now());
              if (!mounted) return;
              var formattedDate =
                  date == null ? '' : DateFormat('yyyy-MM-dd').format(date);
              context.read<CollectionBloc>().add(
                  SecondInterviewVisitDateChanged(
                      secondInterviewVisitDate: formattedDate));
            },
          ),
        );
      },
    );
  }
}

class SecondVisitReasonInput extends StatelessWidget {
  const SecondVisitReasonInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CollectionBloc, CollectionState>(
      builder: (context, state) {
        return Visibility(
            visible: isFieldNotNullAndNotEmpty(
                    state.gibsonsForm.interviewFinishedInOneVisit) &&
                !state.gibsonsForm.isInterviewFinishedInOneVisit(),
            child: TextFormField(
              initialValue: state.gibsonsForm.secondVisitReason,
              decoration: InputDecoration(
                icon: const Icon(Icons.device_unknown_outlined),
                labelText: 'Reason for second visit',
                helperText: 'Why did you need to conduct a second visit',
                errorText: isFieldModifiedAndInvalid(
                        state.gibsonsForm.secondVisitReason,
                        state.gibsonsForm.isSecondVisitReasonValid)
                    ? 'Please state the reason'
                    : null,
              ),
              onChanged: (value) {
                context
                    .read<CollectionBloc>()
                    .add(SecondVisitReasonChanged(secondVisitReason: value));
              },
            ));
      },
    );
  }
}

class InterviewOutcomeInput extends StatelessWidget {
  const InterviewOutcomeInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const List<String> interviewOutcomes = [
      'Completed',
      'Incomplete',
      'Absent',
      'Refused',
      'Could not locate'
    ];
    return BlocBuilder<CollectionBloc, CollectionState>(
      builder: (context, state) {
        return DropdownSearch<String>(
            popupProps: const PopupProps.menu(
                showSelectedItems: true,
                constraints: BoxConstraints(maxHeight: 280.0)),
            dropdownDecoratorProps: DropDownDecoratorProps(
                dropdownSearchDecoration: InputDecoration(
                    icon: const Icon(Icons.format_indent_increase_sharp),
                    labelText: 'Interview outcome',
                    helperText: 'Final result of the interview',
                    // TODO: the errorText should be displayed if nothing is chosen
                    // so investigate how this can be achieved with focusnodes or
                    // maybe send an empty string (although that would not work all
                    // the time), currently errorText is never shown
                    errorText: isFieldModifiedAndInvalid(
                            state.gibsonsForm.interviewOutcome,
                            state.gibsonsForm.isInterviewOutcomeValid)
                        ? 'Select interview outcome'
                        : null)),
            items: interviewOutcomes,
            onChanged: (String? interviewOutcome) => context
                .read<CollectionBloc>()
                .add(InterviewOutcomeChanged(
                    interviewOutcome: interviewOutcome ?? '')),
            selectedItem: state.gibsonsForm.interviewOutcome);
      },
    );
  }
}

class InterviewOutcomeNotCompletedReason extends StatelessWidget {
  const InterviewOutcomeNotCompletedReason({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CollectionBloc, CollectionState>(
      builder: (context, state) {
        return Visibility(
            visible: state.gibsonsForm.isInterviewOutcomeValid() &&
                !state.gibsonsForm.isInterviewOutcomeCompleted(),
            child: TextFormField(
              initialValue:
                  state.gibsonsForm.interviewOutcomeNotCompletedReason,
              decoration: InputDecoration(
                icon: const Icon(Icons.device_unknown_outlined),
                labelText: 'Reason for not completing the interview',
                helperText: 'Why did you not complete the interview',
                errorText: isFieldModifiedAndInvalid(
                        state.gibsonsForm.interviewOutcomeNotCompletedReason,
                        state.gibsonsForm
                            .isInterviewOutcomeNotCompletedReasonValid)
                    ? 'Explain the reason'
                    : null,
              ),
              onChanged: (value) {
                context.read<CollectionBloc>().add(
                    InterviewOutcomeNotCompletedReasonChanged(
                        interviewOutcomeNotCompletedReason: value));
              },
            ));
      },
    );
  }
}

class CommentsInput extends StatelessWidget {
  const CommentsInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CollectionBloc, CollectionState>(
      builder: (context, state) {
        return TextFormField(
          initialValue: state.gibsonsForm.comments,
          decoration: const InputDecoration(
              icon: Icon(Icons.comment),
              labelText: 'Comments',
              helperText: 'Any relevant extra information'),
          onChanged: (value) {
            context
                .read<CollectionBloc>()
                .add(CommentsChanged(comments: value));
          },
          textInputAction: TextInputAction.next,
        );
      },
    );
  }
}

class FinishCollectionDialog extends StatelessWidget {
  final CollectionBloc bloc;
  const FinishCollectionDialog({Key? key, required this.bloc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Finish collection?'),
      content: const Text(
          'Would you like to finish this collection?\n\nOnce finished, the collection will '
          'no longer be editable, even if it is not fully completed.'),
      actions: [
        ElevatedButton(
          onPressed: () async {
            bloc.add(const CollectionFinished());
            Navigator.pop(context);
          },
          child: const Text('Yes'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('No'),
        ),
      ],
    );
  }
}
