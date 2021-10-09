import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gibsonify/collection/collection.dart';

class FourthPassScreen extends StatelessWidget {
  const FourthPassScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CollectionBloc, CollectionState>(
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(title: const Text('Fourth Pass')),
            body: Center(
                child: Text('DEMO Interview Date: ' + state.interviewDate.value)));
      },
    );
  }
}
