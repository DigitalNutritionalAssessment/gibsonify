import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gibsonify_api/gibsonify_api.dart';

import '../bloc/household_bloc.dart';

class CreateAnthropometricsPage extends StatelessWidget {
  const CreateAnthropometricsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, [bool mounted = true]) {
    final formKey = GlobalKey<FormBuilderState>();
    bool changed = false;

    return BlocBuilder<HouseholdBloc, HouseholdState>(
      builder: (context, state) {
        return WillPopScope(
          onWillPop: () async {
            if (!changed) {
              return true;
            }
            bool willLeave = false;
            await showDialog(
                context: context,
                barrierDismissible: false,
                builder: (_) => AlertDialog(
                      title: const Text('Are you sure?'),
                      content: const Text('Any unsaved changes will be lost.'),
                      actions: [
                        ElevatedButton(
                            onPressed: () {
                              willLeave = true;
                              Navigator.of(context).pop();
                            },
                            child: const Text('Yes')),
                        TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: const Text('No'))
                      ],
                    ));
            return willLeave;
          },
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Add anthropometric record'),
              actions: [
                IconButton(
                    onPressed: () {
                      if (formKey.currentState!.saveAndValidate()) {
                        final date = formKey.currentState!.value['date'];
                        final weight = double.tryParse(
                            formKey.currentState!.value['weight'].toString());
                        final height = double.tryParse(
                            formKey.currentState!.value['height'].toString());
                        final waist = double.tryParse(
                            formKey.currentState!.value['waist'].toString());
                        final armLength = double.tryParse(formKey
                            .currentState!.value['armLength']
                            .toString());
                        final handSpan = double.tryParse(
                            formKey.currentState!.value['handSpan'].toString());

                        context.read<HouseholdBloc>().add(
                            NewAnthropometricsSaveRequested(
                                anthropometrics: Anthropometrics(
                                    date: date,
                                    weight: weight,
                                    height: height,
                                    waist: waist,
                                    armLength: armLength,
                                    handSpan: handSpan)));
                        Navigator.pop(context);
                      }
                    },
                    icon: const Icon(Icons.save))
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FormBuilder(
                key: formKey,
                child: Column(children: [
                  FormBuilderDateTimePicker(
                    name: 'date',
                    decoration: const InputDecoration(
                      label: Text('Date'),
                      icon: Icon(Icons.calendar_today),
                    ),
                    onChanged: (value) => changed = true,
                    inputType: InputType.date,
                    lastDate: DateTime.now(),
                    initialValue: DateTime.now(),
                    validator: FormBuilderValidators.required(),
                  ),
                  FormBuilderTextField(
                    name: 'weight',
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    decoration: const InputDecoration(
                      label: Text('Weight (kg)'),
                      icon: Icon(Icons.scale),
                    ),
                    onChanged: (value) => changed = true,
                    validator: FormBuilderValidators.numeric(),
                  ),
                  FormBuilderTextField(
                    name: 'height',
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    decoration: const InputDecoration(
                      label: Text('Height (cm)'),
                      icon: Icon(Icons.height),
                    ),
                    onChanged: (value) => changed = true,
                    validator: FormBuilderValidators.numeric(),
                  ),
                  FormBuilderTextField(
                    name: 'waist',
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    decoration: const InputDecoration(
                      label: Text('Waist (cm)'),
                      icon: Icon(Icons.storm),
                    ),
                    onChanged: (value) => changed = true,
                    validator: FormBuilderValidators.numeric(),
                  ),
                  FormBuilderTextField(
                    name: 'armLength',
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    decoration: const InputDecoration(
                      label: Text('Arm Length (cm)'),
                      icon: Icon(Icons.emoji_people),
                    ),
                    onChanged: (value) => changed = true,
                    validator: FormBuilderValidators.numeric(),
                  ),
                  FormBuilderTextField(
                    name: 'handSpan',
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    decoration: const InputDecoration(
                      label: Text('Hand Span (cm)'),
                      icon: Icon(Icons.front_hand),
                    ),
                    onChanged: (value) => changed = true,
                    validator: FormBuilderValidators.numeric(),
                  ),
                ]),
              ),
            ),
          ),
        );
      },
    );
  }
}
