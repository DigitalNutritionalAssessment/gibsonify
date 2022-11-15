import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class CreateHouseholdScreen extends StatelessWidget {
  const CreateHouseholdScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormBuilderState>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create new household'),
        actions: [
          IconButton(
              onPressed: () => {
                    if (formKey.currentState!.saveAndValidate())
                      {print(formKey.currentState!.value)}
                  },
              icon: const Icon(Icons.save))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FormBuilder(
          key: formKey,
          child: Column(children: [
            FormBuilderTextField(
              name: 'householdId',
              decoration: const InputDecoration(
                label: Text('Household ID'),
                icon: Icon(Icons.house),
              ),
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(),
                FormBuilderValidators.minLength(10,
                    errorText: 'Must be at least 10 characters'),
              ]),
            ),
            FormBuilderDateTimePicker(
              name: 'sensitizationDate',
              decoration: const InputDecoration(
                label: Text('Sensitization Date'),
                icon: Icon(Icons.calendar_today),
              ),
              inputType: InputType.date,
            ),
            FormBuilderTextField(
              name: 'geoLocation',
              decoration: const InputDecoration(
                label: Text('Location'),
                icon: Icon(Icons.location_on_outlined),
              ),
            ),
            FormBuilderTextField(
              name: 'comments',
              decoration: const InputDecoration(
                  label: Text('Comments'), icon: Icon(Icons.message)),
            ),
          ]),
        ),
      ),
    );
  }
}
