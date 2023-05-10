import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gibsonify/surveys/surveys.dart';
import 'package:gibsonify_api/gibsonify_api.dart';
import 'package:intl/intl.dart';

class CreateSurveyScreen extends StatelessWidget {
  final List<String> surveyIds;

  const CreateSurveyScreen({Key? key, required this.surveyIds})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormBuilderState>();
    bool changed = false;

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
                        onPressed: () => Navigator.of(context).pop(null),
                        child: const Text('No'))
                  ],
                ));
        return willLeave;
      },
      child: Scaffold(
          appBar: AppBar(
            title: const Text('Create survey'),
            actions: [
              IconButton(
                  onPressed: () => {
                        if (formKey.currentState!.saveAndValidate())
                          {
                            Navigator.pop(
                                context,
                                Survey(
                                  surveyId:
                                      formKey.currentState!.value['surveyId'],
                                  name: formKey.currentState!.value['name'],
                                  country:
                                      formKey.currentState!.value['country'],
                                  description: formKey
                                      .currentState!.value['description'],
                                  comments:
                                      formKey.currentState!.value['comments'],
                                  requiredSex: formKey
                                      .currentState!.value['requiredSex'],
                                  minAge: (formKey.currentState!
                                          .value['minMaxAge'] as RangeValues)
                                      .start
                                      .toInt(),
                                  maxAge: (formKey.currentState!
                                          .value['minMaxAge'] as RangeValues)
                                      .end
                                      .toInt(),
                                  geoArea:
                                      formKey.currentState!.value['geoArea'],
                                ))
                          }
                      },
                  icon: const Icon(Icons.save))
            ],
          ),
          body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FormBuilder(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      FormBuilderTextField(
                          name: 'surveyId',
                          textCapitalization: TextCapitalization.characters,
                          decoration: const InputDecoration(
                              label: Text('Survey ID'), icon: Icon(Icons.list)),
                          onChanged: (value) => changed = true,
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(),
                            FormBuilderValidators.minLength(4,
                                errorText: 'Must be at least 4 characters'),
                            (id) => surveyIds.contains(id)
                                ? 'Survey with this ID already exists'
                                : null
                          ])),
                      FormBuilderTextField(
                          name: 'name',
                          textCapitalization: TextCapitalization.words,
                          decoration: const InputDecoration(
                              label: Text('Name'), icon: Icon(Icons.label)),
                          onChanged: (value) => changed = true,
                          validator: FormBuilderValidators.required()),
                      FormBuilderTextField(
                          name: 'country',
                          readOnly: true,
                          onTap: () => showCountryPicker(
                              context: context,
                              favorite: ['IN', 'GB'],
                              onSelect: (Country country) {
                                formKey.currentState!.fields['country']!
                                    .didChange(country.name);
                              }),
                          textCapitalization: TextCapitalization.sentences,
                          decoration: const InputDecoration(
                              label: Text('Country'), icon: Icon(Icons.flag)),
                          onChanged: (value) => changed = true,
                          validator: FormBuilderValidators.required()),
                      FormBuilderTextField(
                        name: 'description',
                        textCapitalization: TextCapitalization.sentences,
                        decoration: const InputDecoration(
                            label: Text('Description'), icon: Icon(Icons.info)),
                        onChanged: (value) => changed = true,
                      ),
                      FormBuilderTextField(
                        name: 'comments',
                        textCapitalization: TextCapitalization.sentences,
                        minLines: 1,
                        maxLines: null,
                        decoration: const InputDecoration(
                            label: Text('Comments'), icon: Icon(Icons.message)),
                        onChanged: (value) => changed = true,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Divider(
                          height: 20,
                          thickness: 5,
                        ),
                      ),
                      FormBuilderTextField(
                          name: 'geoArea',
                          readOnly: true,
                          onTap: () async {
                            Area? area = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SelectAreaScreen()));

                            if (area != null) {
                              formKey.currentState!.fields['geoArea']!.didChange(
                                  "${area.center.latitude},${area.center.longitude},${area.radius},${area.zoom}");
                            }
                          },
                          decoration: const InputDecoration(
                              label: Text('Geographical Area'),
                              icon: Icon(Icons.place)),
                          onChanged: (value) => changed = true,
                          validator: FormBuilderValidators.required()),
                      FormBuilderDropdown(
                        name: 'requiredSex',
                        decoration: const InputDecoration(
                          label: Text('Respondent Sex'),
                          icon: Icon(Icons.wc),
                        ),
                        onChanged: (value) => changed = true,
                        items: Sex.values
                            .map((sex) => DropdownMenuItem(
                                value: sex,
                                child:
                                    Text(toBeginningOfSentenceCase(sex.name)!)))
                            .toList(),
                      ),
                      FormBuilderRangeSlider(
                        name: 'minMaxAge',
                        min: 0,
                        max: 100,
                        divisions: 100,
                        decoration: const InputDecoration(
                          label: Text('Respondent Age'),
                          icon: Icon(Icons.person),
                        ),
                        initialValue: const RangeValues(0, 100),
                        validator: (value) => value!.start >= value.end
                            ? 'Maximum age must exceed minimum age'
                            : null,
                      )
                    ],
                  ),
                ),
              ))),
    );
  }
}
