import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gibsonify/surveys/view/create_survey.dart';
import 'package:gibsonify_api/gibsonify_api.dart';
import 'package:gibsonify_repository/gibsonify_repository.dart';
import 'package:intl/intl.dart';

import '../bloc/surveys_bloc.dart';

class SurveysScreen extends StatelessWidget {
  const SurveysScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SurveysView();
  }
}

class SurveysView extends StatelessWidget {
  const SurveysView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, [bool mounted = false]) {
    return BlocBuilder<SurveysBloc, SurveysState>(
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
              title: const Text('Surveys'),
              actions: [
                IconButton(
                    onPressed: () => {},
                    icon: const Icon(Icons.qr_code_scanner)),
                IconButton(onPressed: () => {}, icon: const Icon(Icons.help))
              ],
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(2.0),
                    itemCount: state.surveys.length,
                    itemBuilder: (context, index) {
                      return Card(
                          child: ListTile(
                        title: Text(state.surveys[index].name),
                        subtitle: Text(state.surveys[index].surveyId),
                        onTap: () => {
                          context
                              .read<SurveysBloc>()
                              .add(SurveyOpened(index: index)),
                          // Navigator.pushNamed(context, PageRouter.viewSurvey)
                        },
                        onLongPress: () => showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return SurveyOptions(
                                  id: state.surveys[index].id,
                                  surveyId: state.surveys[index].surveyId);
                            }),
                      ));
                    },
                  ),
                )
              ],
            ),
            floatingActionButton: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  FloatingActionButton.extended(
                      heroTag: null,
                      label: const Text("New survey"),
                      icon: const Icon(Icons.add),
                      onPressed: () async {
                        final bloc = context.read<SurveysBloc>();
                        Survey? survey = await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const CreateSurveyScreen()));

                        if (survey != null) {
                          bloc.add(SurveySaveRequested(survey: survey));
                        }
                      }),
                ]));
      },
    );
  }
}

class SurveyOptions extends StatelessWidget {
  const SurveyOptions({Key? key, required this.id, required this.surveyId})
      : super(key: key);

  final int id;
  final String surveyId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          SurveysBloc(isarRepository: context.read<IsarRepository>()),
      child: BlocBuilder<SurveysBloc, SurveysState>(
        builder: (context, state) {
          final List<Widget> options = [
            ListTile(title: Text(surveyId)),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.delete),
              title: const Text('Delete'),
              onTap: () {
                context.read<SurveysBloc>().add(SurveyDeleteRequested(id: id));
                Navigator.pop(context);
              },
            )
          ];
          return Wrap(children: options);
        },
      ),
    );
  }
}
