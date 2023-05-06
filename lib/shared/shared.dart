import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:gibsonify_api/gibsonify_api.dart';
import 'package:intl/intl.dart';

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

List<Widget> viewMetadataFields({required Metadata metadata}) {
  DateFormat formatter = DateFormat.yMd().add_Hms();
  return [
    TextFormField(
      readOnly: true,
      decoration: const InputDecoration(
          labelText: 'Created at', icon: Icon(Icons.more_time)),
      initialValue: formatter.format(metadata.createdAt),
    ),
    TextFormField(
      readOnly: true,
      decoration: const InputDecoration(
          labelText: 'Created by (ID)', icon: Icon(Icons.person)),
      initialValue: metadata.createdBy,
    ),
    TextFormField(
      readOnly: true,
      decoration: const InputDecoration(
          labelText: 'Last modified at', icon: Icon(Icons.update)),
      initialValue: formatter.format(metadata.lastModifiedAt),
    ),
    TextFormField(
      readOnly: true,
      decoration: const InputDecoration(
          labelText: 'Last modified by (ID)', icon: Icon(Icons.person)),
      initialValue: metadata.lastModifiedBy,
    ),
  ];
}
