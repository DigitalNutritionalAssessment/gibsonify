import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Settings Help')),
        body: Column(children: [
          ListTile(
            title: const Text('App version'),
            subtitle: Text(_packageInfo.version),
          ),
        ]));
  }
}
