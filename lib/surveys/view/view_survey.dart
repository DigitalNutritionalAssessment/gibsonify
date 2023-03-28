import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:gibsonify/surveys/surveys.dart';
import 'package:gibsonify_api/gibsonify_api.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ViewSurveyScreen extends StatelessWidget {
  final int index;

  const ViewSurveyScreen({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SurveysBloc, SurveysState>(
      builder: (context, state) {
        final survey = state.surveys[index];

        return Scaffold(
            appBar: AppBar(
              title: Text(survey.surveyId),
              actions: [
                IconButton(
                    onPressed: () => {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) =>
                                  ShareSurvey(survey: survey))
                        },
                    icon: const Icon(Icons.share))
              ],
            ),
            body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: FormBuilder(
                  child: Column(
                    children: [
                      FormBuilderTextField(
                        name: 'surveyId',
                        decoration: const InputDecoration(
                            label: Text('Survey ID'), icon: Icon(Icons.list)),
                        initialValue: survey.surveyId,
                        enabled: false,
                      ),
                      FormBuilderTextField(
                        name: 'name',
                        decoration: const InputDecoration(
                            label: Text('Name'), icon: Icon(Icons.label)),
                        initialValue: survey.name,
                        enabled: false,
                      ),
                      FormBuilderTextField(
                        name: 'country',
                        decoration: const InputDecoration(
                            label: Text('Country'), icon: Icon(Icons.flag)),
                        initialValue: survey.country,
                        enabled: false,
                      ),
                      FormBuilderTextField(
                        name: 'description',
                        decoration: const InputDecoration(
                            label: Text('Description'), icon: Icon(Icons.info)),
                        initialValue: survey.description,
                        enabled: false,
                      ),
                      FormBuilderTextField(
                        name: 'comments',
                        minLines: 1,
                        maxLines: null,
                        decoration: const InputDecoration(
                            label: Text('Comments'), icon: Icon(Icons.message)),
                        initialValue: survey.comments,
                        enabled: false,
                      ),
                      const Divider(),
                      FormBuilderTextField(
                        name: 'geoArea',
                        decoration: InputDecoration(
                          label: const Text('Geographical Area'),
                          icon: const Icon(Icons.place),
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.map),
                            onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ViewAreaScreen(
                                        geoArea: survey.geoArea!))),
                          ),
                        ),
                        initialValue: survey.geoArea!,
                        readOnly: true,
                      ),
                      FormBuilderTextField(
                        name: 'requiredSex',
                        decoration: const InputDecoration(
                            label: Text('Respondent Sex'),
                            icon: Icon(Icons.message)),
                        initialValue: toBeginningOfSentenceCase(
                                survey.requiredSex?.name) ??
                            'Any',
                        enabled: false,
                      ),
                      FormBuilderTextField(
                        name: 'minAge',
                        decoration: const InputDecoration(
                            label: Text('Respondent Minimum Age'),
                            icon: Icon(Icons.vertical_align_bottom)),
                        initialValue: survey.minAge.toString(),
                        enabled: false,
                      ),
                      FormBuilderTextField(
                        name: 'maxAge',
                        decoration: const InputDecoration(
                            label: Text('Respondent Maximum Age'),
                            icon: Icon(Icons.vertical_align_top)),
                        initialValue: survey.maxAge.toString(),
                        enabled: false,
                      ),
                    ],
                  ),
                )));
      },
    );
  }
}

class ShareSurvey extends StatelessWidget {
  final Survey survey;

  const ShareSurvey({Key? key, required this.survey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Share survey'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
              'Import this survey on another device by scanning the QR code below from the Gibsonify app.'),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: SizedBox(
                width: 200,
                height: 200,
                child: QrImage(
                  data: jsonEncode(survey),
                  version: QrVersions.auto,
                  backgroundColor: Colors.white,
                )),
          )
        ],
      ),
      actions: [
        TextButton(
            onPressed: () => {Navigator.pop(context)},
            child: const Text('Close'))
      ],
    );
  }
}
