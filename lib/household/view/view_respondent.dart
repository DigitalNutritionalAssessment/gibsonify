import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gibsonify/household/household.dart';
import 'package:gibsonify/navigation/models/page_router.dart';
import 'package:gibsonify_api/gibsonify_api.dart';
import 'package:intl/intl.dart';

class ViewRespondentPage extends StatefulWidget {
  final int index;

  const ViewRespondentPage({Key? key, required this.index}) : super(key: key);

  @override
  State<ViewRespondentPage> createState() => _ViewRespondentPageState();
}

class _ViewRespondentPageState extends State<ViewRespondentPage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  int activeIndex = 0;

  final tabs = const [
    Tab(icon: Icon(Icons.info), text: 'Info'),
    Tab(icon: Icon(Icons.dining), text: 'Nutrition'),
    Tab(icon: Icon(Icons.straighten), text: 'Anthropometry'),
  ];

  @override
  void initState() {
    _tabController = TabController(length: tabs.length, vsync: this);
    _tabController.addListener(() {
      setState(() {
        activeIndex = _tabController.index;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final formatter = DateFormat('yyyy-MM-dd');

    return BlocBuilder<HouseholdBloc, HouseholdState>(
      builder: (context, state) {
        final respondent = state.household!.respondents[widget.index];

        Widget respondentInfo() {
          return Column(
            key: UniqueKey(),
            children: [
              TextFormField(
                readOnly: true,
                decoration: const InputDecoration(
                    labelText: 'Phone Number', icon: Icon(Icons.phone)),
                initialValue: respondent.phoneNumber,
              ),
              TextFormField(
                readOnly: true,
                decoration: const InputDecoration(
                    labelText: 'Date of Birth', icon: Icon(Icons.cake)),
                initialValue: formatter.format(respondent.dateOfBirth!),
              ),
              TextFormField(
                readOnly: true,
                decoration: const InputDecoration(
                    labelText: 'Sex', icon: Icon(Icons.wc)),
                initialValue: toBeginningOfSentenceCase(respondent.sex!.name),
              ),
              TextFormField(
                readOnly: true,
                decoration: const InputDecoration(
                    labelText: 'Literacy Level', icon: Icon(Icons.translate)),
                initialValue: literacyLevelToString(respondent.literacyLevel!),
              ),
              TextFormField(
                readOnly: true,
                decoration: const InputDecoration(
                    labelText: 'Occupation', icon: Icon(Icons.work)),
                initialValue: occupationToString(respondent.occupation!),
              ),
              TextFormField(
                readOnly: true,
                decoration: const InputDecoration(
                    labelText: 'Comments', icon: Icon(Icons.comment)),
                initialValue: respondent.comments,
                minLines: 1,
                maxLines: null,
              ),
            ],
          );
        }

        Widget respondentAnthropometrics() {
          if (respondent.anthropometrics.isEmpty) {
            return const Center(
              child: Text('No anthropometric data'),
            );
          }

          return ListView.builder(
              itemCount: respondent.anthropometrics.length,
              itemBuilder: (context, index) {
                final anthropometrics = respondent.anthropometrics[index];
                final date = anthropometrics.date != null
                    ? formatter.format(anthropometrics.date!)
                    : 'No date';

                return Card(
                  child: ListTile(
                    title: Text(date),
                    onTap: () => {
                      Navigator.pushNamed(
                          context, PageRouter.viewAnthropometrics,
                          arguments: {'index': index})
                    },
                    onLongPress: () => showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return AnthropometricsOptions(
                              index: index, date: date);
                        }),
                  ),
                );
              });
        }

        Widget respondentNutrition() {
          if (respondent.collections.isEmpty) {
            return const Center(
              child: Text('No collections'),
            );
          }

          return ListView.builder(
              itemCount: respondent.collections.length,
              itemBuilder: (context, index) {
                final collection = respondent.collections[index];
                return Card(
                  child: ListTile(
                      title: Text(collection.interviewDate ?? 'No date'),
                      subtitle: Row(
                        children: [
                          Text(collection.interviewOutcome ??
                              'Unspecified outcome')
                        ],
                      ),
                      trailing: Column(
                        children: [
                          collection.finished
                              ? const Icon(Icons.done)
                              : const Icon(Icons.pause),
                          collection.finished
                              ? const Text('Finished')
                              : const Text('Paused'),
                        ],
                      ),
                      onTap: () => {
                            context
                                .read<HouseholdBloc>()
                                .add(CollectionOpened(index: index)),
                            Navigator.pushNamed(context, PageRouter.collection)
                          },
                      onLongPress: () => showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return CollectionOptions(
                                index: index,
                                date: collection.interviewDate ?? 'No date');
                          })),
                );
              });
        }

        Widget buildFloatingActionButton() {
          if (activeIndex == 0) {
            return FloatingActionButton(
              onPressed: () =>
                  Navigator.pushNamed(context, PageRouter.editRespondent),
              child: const Icon(Icons.edit),
            );
          } else if (activeIndex == 2) {
            return FloatingActionButton(
              onPressed: () => Navigator.pushNamed(
                  context, PageRouter.createAnthropometrics),
              child: const Icon(Icons.add),
            );
          } else if (activeIndex == 1) {
            return FloatingActionButton(
              onPressed: () =>
                  Navigator.pushNamed(context, PageRouter.collection),
              child: const Icon(Icons.add),
            );
          } else {
            throw Exception('Invalid tab index');
          }
        }

        return Scaffold(
          appBar: AppBar(
            title: Text(respondent.name),
            bottom: TabBar(
              controller: _tabController,
              tabs: tabs,
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TabBarView(controller: _tabController, children: [
              respondentInfo(),
              respondentNutrition(),
              respondentAnthropometrics(),
            ]),
          ),
          floatingActionButton: buildFloatingActionButton(),
        );
      },
    );
  }
}

class AnthropometricsOptions extends StatelessWidget {
  final int index;
  final String date;

  const AnthropometricsOptions(
      {Key? key, required this.index, required this.date})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HouseholdBloc, HouseholdState>(
        builder: (context, state) {
      final List<Widget> options = [
        ListTile(title: Text(date)),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.delete),
          title: const Text('Delete'),
          onTap: () {
            context
                .read<HouseholdBloc>()
                .add(DeleteAnthropometricsRequested(index: index));
            Navigator.pop(context);
          },
        )
      ];
      return Wrap(children: options);
    });
  }
}

class CollectionOptions extends StatelessWidget {
  final int index;
  final String date;

  const CollectionOptions({Key? key, required this.index, required this.date})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HouseholdBloc, HouseholdState>(
        builder: (context, state) {
      final List<Widget> options = [
        ListTile(title: Text(date)),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.delete),
          title: const Text('Delete'),
          onTap: () {
            context
                .read<HouseholdBloc>()
                .add(DeleteCollectionRequested(index: index));
            Navigator.pop(context);
          },
        )
      ];
      return Wrap(children: options);
    });
  }
}
