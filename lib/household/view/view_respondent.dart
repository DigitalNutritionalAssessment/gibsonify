import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gibsonify/household/household.dart';
import 'package:gibsonify/navigation/models/page_router.dart';

class ViewRespondentPage extends StatelessWidget {
  final int index;

  const ViewRespondentPage({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HouseholdBloc, HouseholdState>(
      builder: (context, state) {
        final respondent = state.household!.respondents[index];

        Widget respondentView() {
          return Column(
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
                    labelText: 'Comments', icon: Icon(Icons.comment)),
                initialValue: respondent.comments,
                minLines: 1,
                maxLines: null,
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Divider(),
              ),
              Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.info),
                  ),
                  Text('Collections',
                      style: Theme.of(context).textTheme.headline6),
                  const Spacer(),
                  IconButton(
                      onPressed: () =>
                          {Navigator.pushNamed(context, PageRouter.collection)},
                      icon: const Icon(Icons.add))
                ],
              ),
              Expanded(
                child: ListView.builder(
                    padding: const EdgeInsets.all(2.0),
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
                                  Navigator.pushNamed(
                                      context, PageRouter.collection)
                                },
                            onLongPress: () => showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return CollectionOptions(
                                      index: index,
                                      date: collection.interviewDate ??
                                          'No date');
                                })),
                      );
                    }),
              ),
            ],
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: Text(respondent.name),
            actions: [
              IconButton(
                  onPressed: () =>
                      {Navigator.pushNamed(context, PageRouter.editRespondent)},
                  icon: const Icon(Icons.edit))
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: respondentView(),
          ),
        );
      },
    );
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
