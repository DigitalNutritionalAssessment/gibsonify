import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsHelpPage extends StatefulWidget {
  // TODO: Once there is more functionality in settings, move the logic
  // to SettingsBloc and change this to a StatelessWidget
  const SettingsHelpPage({Key? key}) : super(key: key);

  @override
  State<SettingsHelpPage> createState() => _SettingsHelpPageState();
}

class _SettingsHelpPageState extends State<SettingsHelpPage> {
  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
    buildSignature: 'Unknown',
  );

  final Uri _gibsonifyRepositoryUrl =
      Uri.https('github.com', '/DigitalNutritionalAssessment/gibsonify');

  @override
  void initState() {
    super.initState();
    _initPackageInfo();
  }

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

  void _launchUrl() async {
    try {
      await launchUrl(_gibsonifyRepositoryUrl);
    } catch (e) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(content: Text('Could not launch $_gibsonifyRepositoryUrl')),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Settings Help')),
        body: Column(children: [
          ListTile(
            title: const Text('App version'),
            subtitle: Text(_packageInfo.version),
          ),
          ListTile(
            title: const Text('Source code'),
            subtitle:
                const Text('github.com/DigitalNutritionalAssessment/gibsonify'),
            onTap: _launchUrl,
            trailing: const Icon(Icons.open_in_new),
          ),
          const ListTile(
            title: Text('© DigitalNutritionalAssessment'),
            subtitle: Text('Licensed under the Apache 2.0 license'),
          )
        ]));
  }
}
