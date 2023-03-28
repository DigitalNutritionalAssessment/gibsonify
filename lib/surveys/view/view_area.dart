import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:gibsonify/surveys/surveys.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

class ViewAreaScreen extends StatelessWidget {
  ViewAreaScreen({Key? key, required this.geoArea}) : super(key: key);
  final String geoArea;
  final MapController _mapController = MapController();

  @override
  Widget build(BuildContext context) {
    final circleDia = MediaQuery.of(context).size.width * 0.8;
    final vals = geoArea.split(',');
    final center = LatLng(double.parse(vals[0]), double.parse(vals[1]));
    final radius = int.parse(vals[2]);
    final zoom = double.parse(vals[3]);
    final area = Area(center, radius, zoom);

    return Scaffold(
      appBar: AppBar(
        title: const Text('View area'),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
                center: area.center,
                zoom: area.zoom,
                interactiveFlags: InteractiveFlag.none),
            nonRotatedChildren: [
              AttributionWidget.defaultWidget(
                source: '© OpenStreetMap',
                onSourceTapped: () =>
                    launchUrl(Uri.parse('https://openstreetmap.org/copyright')),
              ),
            ],
            children: [
              TileLayer(
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
