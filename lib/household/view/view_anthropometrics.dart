import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../bloc/household_bloc.dart';

class ViewAnthropometricsPage extends StatelessWidget {
  final int index;

  const ViewAnthropometricsPage({Key? key, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context, [bool mounted = true]) {
    return BlocBuilder<HouseholdBloc, HouseholdState>(
      builder: (context, state) {
        final record = state.household!
            .respondents[state.selectedRespondentIndex!].anthropometrics[index];

        return Scaffold(
          appBar: AppBar(
            title: Text(record.date.toString()),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FormBuilder(
              child: Column(children: [
                FormBuilderDateTimePicker(
                  name: 'date',
                  enabled: false,
                  decoration: const InputDecoration(
                    label: Text('Date'),
                    icon: Icon(Icons.calendar_today),
                  ),
                  inputType: InputType.date,
                  initialValue: record.date,
                ),
                FormBuilderTextField(
                  name: 'weight',
                  enabled: false,
                  decoration: const InputDecoration(
                    label: Text('Weight (kg)'),
                    icon: Icon(Icons.scale),
                  ),
                  initialValue: record.weight?.toString() ?? '',
                ),
                FormBuilderTextField(
                  name: 'height',
                  enabled: false,
                  decoration: const InputDecoration(
                    label: Text('Height (cm)'),
                    icon: Icon(Icons.height),
                  ),
                  initialValue: record.height?.toString() ?? '',
                ),
                FormBuilderTextField(
                  name: 'waist',
                  enabled: false,
                  decoration: const InputDecoration(
                    label: Text('Waist (cm)'),
                    icon: Icon(Icons.storm),
                  ),
                  initialValue: record.waist?.toString() ?? '',
                ),
                FormBuilderTextField(
                  name: 'armLength',
                  enabled: false,
                  decoration: const InputDecoration(
                    label: Text('Arm Length (cm)'),
                    icon: Icon(Icons.emoji_people),
                  ),
                  initialValue: record.armLength?.toString() ?? '',
                ),
                FormBuilderTextField(
                  name: 'handSpan',
                  enabled: false,
                  decoration: const InputDecoration(
                    label: Text('Hand Span (cm)'),
                    icon: Icon(Icons.front_hand),
                  ),
                  initialValue: record.handSpan?.toString() ?? '',
                ),
              ]),
            ),
          ),
        );
      },
    );
  }
}
