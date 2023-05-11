import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gibsonify/household/household.dart';
import 'package:gibsonify/navigation/navigation.dart';
import 'package:gibsonify/shared/shared.dart';
import 'package:gibsonify_api/gibsonify_api.dart';
import 'package:intl/intl.dart';

class ViewHouseholdPage extends StatefulWidget {
  const ViewHouseholdPage({Key? key}) : super(key: key);

  @override
  State<ViewHouseholdPage> createState() => _ViewHouseholdPageState();
}

class _ViewHouseholdPageState extends State<ViewHouseholdPage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  int activeIndex = 0;

  final tabs = const [
    Tab(icon: Icon(Icons.info), text: 'Info'),
    Tab(icon: Icon(Icons.people), text: 'Respondents')
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
    DateFormat formatter = DateFormat('yyyy-MM-dd');

    return BlocBuilder<HouseholdBloc, HouseholdState>(
      builder: (context, state) {
        Widget householdInfo() {
          return SingleChildScrollView(
            child: Column(key: UniqueKey(), children: [
              TextFormField(
                readOnly: true,
                decoration: const InputDecoration(
                    labelText: 'Location',
                    icon: Icon(Icons.location_on_outlined)),
                initialValue: state.household!.geoLocation,
              ),
              TextFormField(
                readOnly: true,
                decoration: const InputDecoration(
                    labelText: 'Sensitization Date',
                    icon: Icon(Icons.calendar_today)),
                initialValue:
                    formatter.format(state.household!.sensitizationDate),
              ),
              TextFormField(
                readOnly: true,
                decoration: const InputDecoration(
                    labelText: 'Comments', icon: Icon(Icons.comment)),
                initialValue: state.household!.comments,
                minLines: 1,
                maxLines: null,
              ),
            ]),
          );
        }

        Widget householdRespondents() {
          if (state.household!.respondents.isEmpty) {
            return const Center(child: Text('No respondents'));
          }

          final respondents = state.household!.respondents.values.toList();

          return ListView.builder(
            itemCount: state.household!.respondents.length,
            itemBuilder: (context, index) {
              final respondent = respondents[index];
              final finishedCollections = respondent.collections.values
                  .where((collection) => collection.finished)
                  .length;
              return Card(
                  child: ListTile(
                title: Text(respondent.name),
                subtitle: Text(
                    'Collections: $finishedCollections finished, ${respondent.collections.length - finishedCollections} unfinished'),
                onTap: () => {
                  context
                      .read<HouseholdBloc>()
                      .add(RespondentOpened(id: respondent.id)),
                  Navigator.pushNamed(context, PageRouter.viewRespondent,
                      arguments: {'id': respondent.id})
                },
                onLongPress: () => showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return RespondentOptions(respondent: respondent);
                    }),
              ));
            },
          );
        }

        if (state is HouseholdInitial) {
          return const Scaffold(
              body: Center(child: CircularProgressIndicator()));
        } else if (state is HouseholdLoaded) {
          return Scaffold(
            appBar: AppBar(
                leading: IconButton(
                    onPressed: () {
                      Navigator.of(context, rootNavigator: true).pop();
                    },
                    icon: const Icon(Icons.arrow_back)),
                title: Text(state.household!.householdId),
                bottom: TabBar(
                  controller: _tabController,
                  tabs: tabs,
                )),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TabBarView(
                controller: _tabController,
                children: [householdInfo(), householdRespondents()],
              ),
            ),
            floatingActionButton: activeIndex == 0
                ? FloatingActionButton(
                    onPressed: () => Navigator.pushNamed(
                      context,
                      PageRouter.editHousehold,
                    ),
                    child: const Icon(Icons.edit),
                  )
                : FloatingActionButton(
                    onPressed: () => Navigator.pushNamed(
                      context,
                      PageRouter.createRespondent,
                    ),
                    child: const Icon(Icons.add),
                  ),
          );
        } else {
          return const Scaffold(body: Text('Error'));
        }
      },
    );
  }
}

class RespondentOptions extends StatelessWidget {
  final Respondent respondent;

  const RespondentOptions({Key? key, required this.respondent})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HouseholdBloc, HouseholdState>(
        builder: (context, state) {
      final List<Widget> options = [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: ListTile(
            isThreeLine: true,
            title: Text(respondent.name),
            subtitle: MetadataSubtitle(
              id: respondent.id,
              metadata: respondent.metadata,
            ),
          ),
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.delete),
          title: const Text('Delete'),
          onTap: () {
            context
                .read<HouseholdBloc>()
                .add(DeleteRespondentRequested(id: respondent.id));
            Navigator.pop(context);
          },
        )
      ];
      return Wrap(children: options);
    });
  }
}
