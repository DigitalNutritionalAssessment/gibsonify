import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:gibsonify/surveys/surveys.dart';

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
                IconButton(onPressed: () => {}, icon: const Icon(Icons.share))
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
                    ],
                  ),
                )));
      },
    );
  }
}
