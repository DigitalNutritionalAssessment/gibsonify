import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gibsonify_api/gibsonify_api.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ImportSurveyScreen extends StatelessWidget {
  const ImportSurveyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Import survey'),
      ),
      body: MobileScanner(
          allowDuplicates: false,
          onDetect: (barcode, args) {
            if (barcode.rawValue == null) {
              Navigator.pop(context, 'ERROR');
            } else {
              final String code = barcode.rawValue!;
              try {
                final Survey survey = Survey.fromJson(jsonDecode(code));
                Navigator.pop(context, survey);
              } catch (e) {
                Navigator.pop(context, 'ERROR');
              }
            }
          }),
    );
  }
}
