import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_tile_caching/flutter_map_tile_caching.dart';
import 'package:geolocator/geolocator.dart';
import 'package:gibsonify_api/gibsonify_api.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

class SelectAreaScreen extends StatelessWidget {
  SelectAreaScreen({Key? key}) : super(key: key);

  final MapController _mapController = MapController();

  @override
  Widget build(BuildContext context) {
    final circleDia = MediaQuery.of(context).size.width * 0.8;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Select area'),
        actions: [
          IconButton(
            onPressed: () {
              final center = _mapController.center;
              final centerPoint = _mapController.latLngToScreenPoint(center);
              final zoom = _mapController.zoom;

              final boundary = _mapController.pointToLatLng(
                  CustomPoint(centerPoint!.x, centerPoint.y + circleDia / 2));
              final distance = Geolocator.distanceBetween(center.latitude,
                  center.longitude, boundary!.latitude, boundary.longitude);
              Navigator.pop(context, Area(center, distance.toInt(), zoom));
            },
            icon: const Icon(Icons.check),
          ),
        ],
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
                center: LatLng(20.8, 78.5),
                zoom: 4.6,
                interactiveFlags:
                    InteractiveFlag.all & ~InteractiveFlag.rotate),
            nonRotatedChildren: [
              AttributionWidget.defaultWidget(
                source: '© OpenStreetMap',
                onSourceTapped: () =>
                    launchUrl(Uri.parse('https://openstreetmap.org/copyright')),
              ),
            ],
            children: [
              TileLayer(
                tileProvider: FMTC.instance('default').getTileProvider(),
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'org.gibsonify.gibsonify',
              ),
            ],
          ),
          IgnorePointer(
            child: Container(
              width: circleDia,
              height: circleDia,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.black),
              ),
            ),
          ),
          const IgnorePointer(
            child: Padding(
              padding: EdgeInsets.only(bottom: 12.0),
              child: Icon(Icons.place, color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
