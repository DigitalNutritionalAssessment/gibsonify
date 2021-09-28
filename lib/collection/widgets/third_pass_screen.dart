import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gibsonify/collection/collection.dart';

class ThirdPassScreen extends StatelessWidget {
  const ThirdPassScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CollectionBloc, CollectionState>(
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(title: const Text('Third Pass')), // TODO: fix!
            body: Center(
                child: Text('Respondent Tel. Number: ' +
                    (state.collection.respondentTelephoneNumber ??
                        'not selected'))));
      },
    );
  }
}
