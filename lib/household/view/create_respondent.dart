import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_phone_field/form_builder_phone_field.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gibsonify/household/household.dart';
import 'package:gibsonify_api/gibsonify_api.dart';

class CreateRespondentPage extends StatelessWidget {
  const CreateRespondentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                useRootNavigator: false,
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
              title: const Text('Create new respondent'),
              actions: [
                IconButton(
                    onPressed: () => {
                          if (formKey.currentState!.saveAndValidate())
                            {
                              context.read<HouseholdBloc>().add(
                                  NewRespondentSaveRequested(
                                      respondent: Respondent(
                                          name: formKey
                                              .currentState!.value['name'],
                                          phoneNumber: formKey.currentState!
                                              .value['phoneNumber'],
                                          comments: formKey.currentState!
                                                  .value['comments'] ??
                                              ""))),
                              Navigator.pop(context),
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
                  FormBuilderTextField(
                    name: 'name',
                    decoration: const InputDecoration(
                      label: Text('Respondent Name'),
                      icon: Icon(Icons.person),
                    ),
                    onChanged: (value) => changed = true,
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                      FormBuilderValidators.minLength(4,
                          errorText: 'Must be at least 4 characters'),
                    ]),
                  ),
                  FormBuilderPhoneField(
                    name: 'phoneNumber',
                    decoration: const InputDecoration(
                      label: Text('Phone Number'),
                      icon: Icon(Icons.phone),
                    ),
                    priorityListByIsoCode: const ['GB', 'IN'],
                    defaultSelectedCountryIsoCode: 'IN',
                    onChanged: (value) => changed = true,
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                    ]),
                  ),
                  FormBuilderTextField(
                    name: 'comments',
                    decoration: const InputDecoration(
                        label: Text('Comments'), icon: Icon(Icons.message)),
                    onChanged: (value) => changed = true,
                    minLines: 1,
                    maxLines: null,
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
