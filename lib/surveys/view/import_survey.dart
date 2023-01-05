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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            children: [
              const Text(
                'Import a survey by scanning a Gibsonify-generated QR code.',
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 24.0),
                child: SizedBox(
                  height: 400,
                  child: MobileScanner(
                      allowDuplicates: false,
                      onDetect: (barcode, args) {
                        if (barcode.rawValue == null) {
                          Navigator.pop(context, 'ERROR');
                        } else {
                          final String code = barcode.rawValue!;
                          try {
                            final Survey survey =
                                Survey.fromJson(jsonDecode(code));
                            Navigator.pop(context, survey);
                          } catch (e) {
                            Navigator.pop(context, 'ERROR');
                          }
                        }
                      }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
