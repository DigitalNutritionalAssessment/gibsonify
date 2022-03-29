import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dropdown_search/dropdown_search.dart';

import 'package:gibsonify/collection/collection.dart';
import 'package:gibsonify/home/home.dart';
import 'package:gibsonify_api/gibsonify_api.dart';

class FinishCollectionPage extends StatelessWidget {
  const FinishCollectionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CollectionBloc, CollectionState>(
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
              title: const Text('Finish Collection'),
            ),
            resizeToAvoidBottomInset: false,
            body: const SingleChildScrollView(child: FinishCollectionForm()),
            floatingActionButton: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  FloatingActionButton.extended(
                      heroTag: null,
                      label: const Text("Finish Collection"),
                      icon: const Icon(Icons.check),
                      onPressed: () => showDialog<String>(
                          context: context,
                          builder: (BuildContext context) =>
                              FinishCollectionDialog(
                                  gibsonsForm: state.gibsonsForm))
                      // TODO: only allow to finish if all required fields are filled

                      )
                ]));
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
      child: Column(
        children: const <Widget>[
          PictureChartCollectedInput(),
          PictureChartNotCollectedReason(),
          InterviewEndTimeInput(),
          InterviewOutcomeInput(),
          InterviewOutcomeNotCompletedReason(),
          CommentsInput()
        ],
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
            maxHeight: 112.0,
            dropdownSearchDecoration: InputDecoration(
                icon: const Icon(Icons.photo_size_select_actual_rounded),
                labelText: 'Is picture chart collected',
                helperText: 'Have you collected the picture chart?',
                // TODO: the errorText should be displayed if nothing is chosen
                // so investigate how this can be achieved with focusnodes or
                // maybe send an empty string (although that would not work all
                // the time)
                errorText: isFieldModifiedAndInvalid(
                        state.gibsonsForm.pictureChartCollected,
                        state.gibsonsForm.isPictureChartCollectedValid)
                    ? 'Select if you collected the picture chart'
                    : null),
            mode: Mode.MENU,
            showSelectedItems: true,
            showSearchBox: false,
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

class InterviewEndTimeInput extends StatelessWidget {
  const InterviewEndTimeInput({Key? key}) : super(key: key);

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
            labelText: 'Interview End Time',
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
            var formattedTime = time?.format(context);
            context.read<CollectionBloc>().add(
                InterviewEndTimeChanged(interviewEndTime: formattedTime ?? ''));
          },
        );
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
            maxHeight: 280.0,
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
                    : null),
            mode: Mode.MENU,
            showSelectedItems: true,
            showSearchBox: false,
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
  final GibsonsForm gibsonsForm;
  const FinishCollectionDialog({Key? key, required this.gibsonsForm})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String displayRespondentName =
        isFieldUnmodifiedOrEmpty(gibsonsForm.respondentName)
            ? 'unnamed respondent'
            : gibsonsForm.respondentName!;
    return BlocBuilder<CollectionBloc, CollectionState>(
      builder: (context, state) {
        return AlertDialog(
          title: const Text('Finish collection'),
          content: Text(
              'Would you like to finish the collection of $displayRespondentName?\n\n'
              'Once finished, the collection will no longer be editable, even if '
              'it is incomplete. As an alternative, you can pause the collection.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                context.read<CollectionBloc>().add(const GibsonsFormSaved());
                context.read<HomeBloc>().add(const GibsonsFormsLoaded());
                Navigator.pop(context);
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: const Text('Pause'),
            ),
            TextButton(
              onPressed: () async {
                // TODO: investigate concurrency bug when saving from
                // one bloc and loading from another - if the
                // CollectionCompleted event did not save, but the
                // GibsonsFormSaved event was added after it, a bug will
                // occur, hence, saving should be moved to HomeBloc
                context.read<CollectionBloc>().add(const CollectionFinished());
                context.read<HomeBloc>().add(const GibsonsFormsLoaded());
                Navigator.pop(context);
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: const Text('Finish'),
            ),
          ],
        );
      },
    );
  }
}
