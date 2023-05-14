import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:collection/collection.dart';
import 'package:gibsonify/analysis/analysis.dart';
import 'package:gibsonify/collection/collection.dart';
import 'package:gibsonify/fct/fct.dart';
import 'package:gibsonify/household/household.dart';
import 'package:gibsonify/surveys/surveys.dart';
import 'package:gibsonify_repository/gibsonify_repository.dart';
import 'package:intl/intl.dart';

class AnalysisScreen extends StatelessWidget {
  const AnalysisScreen({Key? key, required this.surveyId}) : super(key: key);

  final String surveyId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Analysis: $surveyId'),
      ),
      body: BlocProvider(
        create: (context) => AnalysisBloc(
            gibsonifyRepository: context.read<GibsonifyRepository>(),
            hiveRepository: context.read<HiveRepository>(),
            fctRepository: context.read<FCTRepository>(),
            surveyId: surveyId)
          ..add(const AnalysisStarted()),
        child: BlocBuilder<AnalysisBloc, AnalysisState>(
          builder: (context, state) {
            if (state.survey == null) {
              return const Center(child: CircularProgressIndicator());
            }

            return GridView.count(
              primary: false,
              padding: const EdgeInsets.all(8),
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              crossAxisCount: 3,
              children: const <Widget>[
                SurveyInfoCard(),
                CollectionListCard(),
                RecipeListCard(),
                StatisticsCard(),
                NutritionRDACard(),
                NutritionDietaryDiversityCard()
              ],
            );
          },
        ),
      ),
    );
  }
}

class SurveyInfoCard extends StatelessWidget {
  const SurveyInfoCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AnalysisBloc, AnalysisState>(
      builder: (context, state) {
        final survey = state.survey!;
        return Card(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('Survey Info & Parameters'),
              subtitle: Text('${survey.surveyId}: ${survey.name}'),
            ),
            Expanded(
              child: ListView(children: [
                if (survey.description != null)
                  Card(
                      child: ListTile(
                    title: Text(survey.description!),
                    subtitle: const Text('Description'),
                  )),
                if (survey.comments != null)
                  Card(
                      child: ListTile(
                    title: Text(survey.comments!),
                    subtitle: const Text('Comments'),
                  )),
                Card(
                    child: ListTile(
                  title: Text(survey.fctId),
                  subtitle: const Text('Food Composition Table ID'),
                  trailing: Tooltip(
                    message: 'Browse food composition table',
                    child: IconButton(
                        icon: const Icon(Icons.open_in_new),
                        onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    SelectItemScreen(fctId: survey.fctId)))),
                  ),
                )),
                Card(
                    child: ListTile(
                  title: Text(survey.requiredSex == null
                      ? 'Any'
                      : '${toBeginningOfSentenceCase(survey.requiredSex!.name.toString())} only'),
                  subtitle: const Text('Respondent Sex'),
                )),
                Card(
                    child: ListTile(
                  title: Text('${survey.minAge} - ${survey.maxAge}'),
                  subtitle: const Text('Respondent Age Range'),
                )),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: ElevatedButton(
                      child: const Text('View geographical area'),
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ViewAreaScreen(geoArea: survey.geoArea!)))),
                )
              ]),
            ),
          ]),
        ));
      },
    );
  }
}

class CollectionListCard extends StatelessWidget {
  const CollectionListCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AnalysisBloc, AnalysisState>(
      builder: (context, state) {
        final collections = state.collections!;
        return Card(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            ListTile(
              leading: const Icon(Icons.dining),
              title: const Text('Collections'),
              subtitle:
                  const Text('All collections performed within this survey'),
              trailing: Tooltip(
                  message: 'Export as CSV',
                  child: IconButton(
                      icon: const Icon(Icons.download), onPressed: () {})),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: collections.length,
                  itemBuilder: (context, index) {
                    final collection = collections[index];
                    return Card(
                      child: ListTile(
                        title: Text(
                            '${collection.householdId}: ${collection.respondentName}: ${collection.collection.interviewDate ?? 'No date'}'),
                        subtitle: Row(
                          children: [
                            Text(
                                'Outcome: ${collection.collection.interviewOutcome ?? 'Unspecified'}')
                          ],
                        ),
                        trailing: Column(
                          children: [
                            collection.collection.finished
                                ? const Icon(Icons.done)
                                : const Icon(Icons.pause),
                            collection.collection.finished
                                ? const Text('Finished')
                                : const Text('Paused'),
                          ],
                        ),
                        onTap: () => {
                          Navigator.push(
                              context, collectionPageLoader(collection))
                        },
                      ),
                    );
                  }),
            ),
          ]),
        ));
      },
    );
  }
}

MaterialPageRoute collectionPageLoader(FlatCollection collection) {
  return MaterialPageRoute(
      builder: (context) => BlocProvider(
            create: (context) =>
                HouseholdBloc(hiveRepository: context.read<HiveRepository>())
                  ..add(HouseholdOpened(id: collection.householdId))
                  ..add(RespondentOpened(id: collection.respondentId))
                  ..add(CollectionOpened(id: collection.collection.id)),
            child: BlocBuilder<HouseholdBloc, HouseholdState>(
              builder: (context, state) {
                if (state.household == null) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return CollectionPage(collection: collection.collection);
                }
              },
            ),
          ));
}

class StatisticsCard extends StatelessWidget {
  const StatisticsCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(children: [
        ListTile(
          leading: const Icon(Icons.bar_chart),
          title: const Text('Statistics'),
          subtitle: const Text('Survey statistics'),
        ),
        Expanded(
          child: ListView(
            children: [
              Card(
                  child: ListTile(
                title: const Text('Total households'),
                subtitle: const Text('Total number of households'),
                trailing: const Text('0'),
              )),
              Card(
                  child: ListTile(
                title: const Text('Total respondents'),
                subtitle: const Text('Total number of respondents'),
                trailing: const Text('0'),
              )),
              Card(
                  child: ListTile(
                title: const Text('Total collections'),
                subtitle: const Text('Total number of collections'),
                trailing: const Text('0'),
              )),
              Card(
                  child: ListTile(
                title: const Text('Total food items'),
                subtitle: const Text('Total number of food items'),
                trailing: const Text('0'),
              )),
            ],
          ),
        ),
      ]),
    ));
  }
}

class RecipeListCard extends StatelessWidget {
  const RecipeListCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AnalysisBloc, AnalysisState>(
      builder: (context, state) {
        final recipes = state.collections!
            .expand((collection) => collection.collection.foodItems)
            .map((foodItem) => foodItem.recipe)
            .whereNotNull()
            .toList();
        return Card(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            ListTile(
              leading: const Icon(Icons.food_bank),
              title: const Text('Recipes'),
              subtitle: const Text('All recipes used within this survey'),
              trailing: Tooltip(
                  message: 'Export as CSV',
                  child: IconButton(
                      icon: const Icon(Icons.download), onPressed: () {})),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: recipes.length,
                  itemBuilder: (context, index) {
                    final recipe = recipes[index];
                    return Card(
                        child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 10.0),
                      title: Text(recipe.recipeNameDisplay()),
                      subtitle:
                          Text(recipe.type + recipe.ingredientNamesDisplay()),
                      trailing: recipe.saved
                          ? const Icon(Icons.done)
                          : const Icon(Icons.new_releases),
                      onTap: () {},
                    ));
                  }),
            ),
          ]),
        ));
      },
    );
  }
}

class NutritionRDACard extends StatelessWidget {
  const NutritionRDACard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(children: [
              ListTile(
                leading: const Icon(Icons.food_bank),
                title: const Text('Nutritional Analysis: RDA Deficiencies'),
                subtitle: const Text(
                    'Overall utrient deficiency statistics for this survey'),
                trailing: Tooltip(
                    message: 'Export as CSV',
                    child: IconButton(
                        icon: const Icon(Icons.download), onPressed: () {})),
              ),
              Expanded(
                  child: ListView(children: [
                Card(
                    child: ListTile(
                  title: const Text('Energy'),
                  subtitle: const Text('kcal'),
                  trailing: const Text('0'),
                )),
              ])),
            ])));
  }
}

class NutritionDietaryDiversityCard extends StatelessWidget {
  const NutritionDietaryDiversityCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(children: [
              ListTile(
                leading: const Icon(Icons.food_bank),
                title: const Text('Nutritional Analysis: Dietary Diversity'),
                subtitle: const Text(
                    'Overall dietary diversity statistics for this survey'),
                trailing: Tooltip(
                    message: 'Export as CSV',
                    child: IconButton(
                        icon: const Icon(Icons.download), onPressed: () {})),
              ),
              Expanded(
                  child: ListView(children: [
                Card(
                    child: ListTile(
                  title: const Text('Energy'),
                  subtitle: const Text('kcal'),
                  trailing: const Text('0'),
                )),
              ])),
            ])));
  }
}
