import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_phone_field/form_builder_phone_field.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gibsonify/household/household.dart';
import 'package:gibsonify_api/gibsonify_api.dart';
import 'package:intl/intl.dart';

class EditRespondentPage extends StatelessWidget {
  const EditRespondentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormBuilderState>();
    bool changed = false;

    return BlocBuilder<HouseholdBloc, HouseholdState>(
      builder: (context, state) {
        final respondent =
            state.household!.respondents[state.selectedRespondentId!]!;

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
              title: const Text('Edit respondent'),
              actions: [
                IconButton(
                    onPressed: () => {
                          if (formKey.currentState!.saveAndValidate())
                            {
                              context.read<HouseholdBloc>().add(
                                  EditRespondentSaveRequested(
                                      respondent: respondent.copyWith(
                                          name: formKey
                                              .currentState!.value['name'],
                                          phoneNumber: formKey.currentState!
                                              .value['phoneNumber'],
                                          dateOfBirth: formKey.currentState!
                                              .value['dateOfBirth'],
                                          sex: formKey
                                              .currentState!.value['sex'],
                                          literacyLevel: formKey.currentState!
                                              .value['literacyLevel'],
                                          occupation: formKey.currentState!
                                              .value['occupation'],
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
                    initialValue: respondent.name,
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
                    initialValue: respondent.phoneNumber,
                  ),
                  FormBuilderDateTimePicker(
                    name: 'dateOfBirth',
                    decoration: const InputDecoration(
                      label: Text('Date of Birth'),
                      icon: Icon(Icons.cake),
                    ),
                    format: DateFormat('yyyy-MM-dd'),
                    onChanged: (value) => changed = true,
                    inputType: InputType.date,
                    lastDate: state.household!.sensitizationDate,
                    initialDate: DateTime(2000, 1, 1),
                    validator: FormBuilderValidators.required(),
                    initialValue: respondent.dateOfBirth,
                  ),
                  FormBuilderDropdown(
                    name: 'sex',
                    decoration: const InputDecoration(
                      label: Text('Sex'),
                      icon: Icon(Icons.wc),
                    ),
                    onChanged: (value) => changed = true,
                    items: Sex.values
                        .map((sex) => DropdownMenuItem(
                            value: sex,
                            child: Text(toBeginningOfSentenceCase(sex.name)!)))
                        .toList(),
                    validator: FormBuilderValidators.required(),
                    initialValue: respondent.sex,
                  ),
                  FormBuilderDropdown(
                    name: 'literacyLevel',
                    decoration: const InputDecoration(
                      label: Text('Literacy Level'),
                      icon: Icon(Icons.translate),
                    ),
                    onChanged: (value) => changed = true,
                    items: LiteracyLevel.values
                        .map((literacyLevel) => DropdownMenuItem(
                            value: literacyLevel,
                            child: Text(literacyLevelToString(literacyLevel))))
                        .toList(),
                    validator: FormBuilderValidators.required(),
                    initialValue: respondent.literacyLevel,
                  ),
                  FormBuilderDropdown(
                    name: 'occupation',
                    decoration: const InputDecoration(
                      label: Text('Occupation'),
                      icon: Icon(Icons.work),
                    ),
                    onChanged: (value) => changed = true,
                    items: Occupation.values
                        .map((occupation) => DropdownMenuItem(
                            value: occupation,
                            child: Text(occupationToString(occupation))))
                        .toList(),
                    validator: FormBuilderValidators.required(),
                    initialValue: respondent.occupation,
                  ),
                  FormBuilderTextField(
                    name: 'comments',
                    decoration: const InputDecoration(
                        label: Text('Comments'), icon: Icon(Icons.message)),
                    onChanged: (value) => changed = true,
                    minLines: 1,
                    maxLines: null,
                    initialValue: respondent.comments,
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
