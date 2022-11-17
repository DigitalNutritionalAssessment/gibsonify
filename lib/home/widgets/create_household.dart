import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:geolocator/geolocator.dart';

import '../bloc/home_bloc.dart';

class CreateHouseholdScreen extends StatelessWidget {
  const CreateHouseholdScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, [bool mounted = true]) {
    final formKey = GlobalKey<FormBuilderState>();
    final existingHouseholdIds = context
        .select((HomeBloc bloc) => bloc.state.households)
        .map((household) => household.householdId)
        .toSet();
    bool changed = false;

    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, homeState) {
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
              title: const Text('Create new household'),
              actions: [
                IconButton(
                    onPressed: () => {
                          if (formKey.currentState!.saveAndValidate())
                            {
                              context.read<HomeBloc>().add(SaveNewHousehold(
                                  householdId: formKey
                                      .currentState!.value['householdId'],
                                  sensitizationDate: formKey
                                      .currentState!.value['sensitizationDate'],
                                  geoLocation: formKey
                                      .currentState!.value['geoLocation'],
                                  comments:
                                      formKey.currentState!.value['comments'])),
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
                    name: 'householdId',
                    decoration: const InputDecoration(
                      label: Text('Household ID'),
                      icon: Icon(Icons.house),
                    ),
                    onChanged: (value) => changed = true,
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                      FormBuilderValidators.minLength(10,
                          errorText: 'Must be at least 10 characters'),
                      (value) => existingHouseholdIds.contains(value)
                          ? 'Household ID already exists'
                          : null,
                    ]),
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
                  ),
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
                                    content: Text('Getting location...'),
                                  ));
                                final position =
                                    await Geolocator.getCurrentPosition();
                                if (!mounted) {
                                  return;
                                }
                                ScaffoldMessenger.of(context)
                                    .hideCurrentSnackBar();
                                formKey.currentState!.fields['geoLocation']!
                                    .didChange(
                                        '${position.latitude}, ${position.longitude}');
                              } catch (e) {
                                ScaffoldMessenger.of(context)
                                  ..hideCurrentSnackBar()
                                  ..showSnackBar(SnackBar(
                                    content: Text('Could not get location: $e'),
                                  ));
                              }
                            },
                            icon: const Icon(Icons.refresh))),
                    onChanged: (value) => changed = true,
                    readOnly: true,
                    validator: FormBuilderValidators.required(),
                  ),
                  FormBuilderTextField(
                    name: 'comments',
                    decoration: const InputDecoration(
                        label: Text('Comments'), icon: Icon(Icons.message)),
                    onChanged: (value) => changed = true,
                    validator: FormBuilderValidators.required(),
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

Future<Position> getPosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the
    // App to enable the location services.
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately.
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  return await Geolocator.getCurrentPosition();
}
