import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gibsonify/fct/fct.dart';
import 'package:gibsonify/fct/widgets/widgets.dart';
import 'package:gibsonify_repository/gibsonify_repository.dart';

class SelectItemScreen extends StatelessWidget {
  const SelectItemScreen({Key? key, required this.fctId}) : super(key: key);

  final String fctId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Select FCT food item'),
        ),
        body: BlocProvider(
          create: (context) => FCTBloc(
              fctRepository: context.read<FCTRepository>(), fctId: fctId)
            ..add(const FCTOpened()),
          child: BlocBuilder<FCTBloc, FCTState>(
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    TextFormField(
                      onChanged: (value) => context
                          .read<FCTBloc>()
                          .add(SearchQueryChanged(value)),
                      decoration: const InputDecoration(
                        icon: Icon(Icons.search),
                        hintText: 'Search...',
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text('Results from FCT ${state.fctId}'),
                    const SizedBox(height: 16),
                    FCTItemList(
                        fctItems: state.fctItems,
                        onTap: (item) {
                          Navigator.of(context).pop(item);
                        }),
                  ],
                ),
              );
            },
          ),
        ));
  }
}
