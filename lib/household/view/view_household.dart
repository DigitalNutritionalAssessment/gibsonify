import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gibsonify/household/household.dart';
import 'package:gibsonify/navigation/navigation.dart';
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
          return Column(key: UniqueKey(), children: [
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
          ]);
        }

        Widget householdRespondents() {
          if (state.household!.respondents.isEmpty) {
            return const Center(child: Text('No respondents'));
          }

          return ListView.builder(
            itemCount: state.household!.respondents.length,
            itemBuilder: (context, index) {
              return Card(
                  child: ListTile(
                title: Text(state.household!.respondents[index].name),
                subtitle: Text("ID: ${index + 1}"),
                onTap: () => {
                  context
                      .read<HouseholdBloc>()
                      .add(RespondentOpened(index: index)),
                  Navigator.pushNamed(context, PageRouter.viewRespondent,
                      arguments: {'index': index})
                },
                onLongPress: () => showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return RespondentOptions(
                          index: index,
                          name: state.household!.respondents[index].name);
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
  final int index;
  final String name;

  const RespondentOptions({Key? key, required this.index, required this.name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HouseholdBloc, HouseholdState>(
        builder: (context, state) {
      final List<Widget> options = [
        ListTile(title: Text(name)),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.delete),
          title: const Text('Delete'),
          onTap: () {
            context
                .read<HouseholdBloc>()
                .add(DeleteRespondentRequested(index: index));
            Navigator.pop(context);
          },
        )
      ];
      return Wrap(children: options);
    });
  }
}
