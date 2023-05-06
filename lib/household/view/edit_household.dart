import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gibsonify/household/household.dart';
import 'package:gibsonify/login/login.dart';
import 'package:gibsonify/shared/shared.dart';
import 'package:intl/intl.dart';

class EditHouseholdPage extends StatelessWidget {
  const EditHouseholdPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, [bool mounted = true]) {
    final formKey = GlobalKey<FormBuilderState>();
    bool changed = false;

    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, loginState) {
        return BlocBuilder<HouseholdBloc, HouseholdState>(
          builder: (context, state) {
            return WillPopScope(
              onWillPop: () async {
                if (!changed) {
                  return true;
                }
                bool willLeave = false;
                await showDialog(
                    useRootNavigator: false,
                    context: context,
                    barrierDismissible: false,
                    builder: (_) => AlertDialog(
                          title: const Text('Are you sure?'),
                          content:
                              const Text('Any unsaved changes will be lost.'),
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
                  title: const Text('Edit household'),
                  actions: state is HouseholdLoaded
                      ? [
                          IconButton(
                              onPressed: () => {
                                    if (formKey.currentState!.saveAndValidate())
                                      {
                                        context.read<HouseholdBloc>().add(
                                            EditHouseholdSaveRequested(
                                                employeeId: loginState
                                                    .loginInfo.employeeId!,
                                                sensitizationDate: formKey
                                                    .currentState!
                                                    .value['sensitizationDate'],
                                                geoLocation: formKey
                                                    .currentState!
                                                    .value['geoLocation'],
                                                comments: formKey.currentState!
                                                        .value['comments'] ??
                                                    "")),
                                        Navigator.pop(context),
                                      }
                                  },
                              icon: const Icon(Icons.save))
                        ]
                      : [],
                ),
                body: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: state is HouseholdLoaded
                      ? FormBuilder(
                          key: formKey,
                          child: Column(children: [
                            FormBuilderTextField(
                              name: 'geoLocation',
                              decoration: InputDecoration(
                                  label: const Text('Location'),
                                  icon: const Icon(Icons.location_on_outlined),
                                  suffixIcon: IconButton(
                                      onPressed: () async {
                                        try {
                                          ScaffoldMessenger.of(context)
                                            ..hideCurrentSnackBar()
                                            ..showSnackBar(const SnackBar(
                                              content:
                                                  Text('Getting location...'),
                                            ));
                                          final position = await getPosition();
                                          if (!mounted) {
                                            return;
                                          }
                                          ScaffoldMessenger.of(context)
                                              .hideCurrentSnackBar();
                                          formKey.currentState!
                                              .fields['geoLocation']!
                                              .didChange(
                                                  '${position.latitude}, ${position.longitude}');
                                        } catch (e) {
                                          ScaffoldMessenger.of(context)
                                            ..hideCurrentSnackBar()
                                            ..showSnackBar(SnackBar(
                                              content: Text(
                                                  'Could not get location: $e'),
                                            ));
                                        }
                                      },
                                      icon: const Icon(Icons.refresh))),
                              onChanged: (value) => changed = true,
                              readOnly: true,
                              validator: FormBuilderValidators.required(),
                              initialValue: state.household!.geoLocation,
                            ),
                            FormBuilderDateTimePicker(
                              name: 'sensitizationDate',
                              decoration: const InputDecoration(
                                label: Text('Sensitization Date'),
                                icon: Icon(Icons.calendar_today),
                              ),
                              onChanged: (value) => changed = true,
                              inputType: InputType.date,
                              lastDate: DateTime.now(),
                              validator: FormBuilderValidators.required(),
                              format: DateFormat('yyyy-MM-dd'),
                              initialValue: state.household!.sensitizationDate,
                            ),
                            FormBuilderTextField(
                              name: 'comments',
                              decoration: const InputDecoration(
                                  label: Text('Comments'),
                                  icon: Icon(Icons.comment)),
                              onChanged: (value) => changed = true,
                              minLines: 1,
                              maxLines: null,
                              initialValue: state.household!.comments,
                            ),
                          ]),
                        )
                      : const Center(child: CircularProgressIndicator()),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
