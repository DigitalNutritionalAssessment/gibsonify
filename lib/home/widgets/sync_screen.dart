import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_mailer/flutter_mailer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gibsonify/recipe/recipe.dart';

class SyncScreen extends StatelessWidget {
  const SyncScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeBloc, RecipeState>(
        builder: (context, recipeState) {
      String recipeJson = recipeState.toJson();
      return Scaffold(
          appBar: AppBar(title: const Text('Export Data via Email')),
          body: Center(
              child: ElevatedButton.icon(
            onPressed: () async {
              final directory = await getApplicationDocumentsDirectory();
              final path = directory.path;
              final _filePath = '$path/data.txt';
              final _file = File(_filePath);
              _file.writeAsString(recipeJson);

              final MailOptions mailOptions = MailOptions(
                body:
                    'Gibsonify collection and recipe data attached as a JSON string. <br> Data can be pasted into https://www.convertcsv.com/json-to-csv.htm to obtain a csv file.',
                subject: 'Gibsonify collection and recipe data',
                recipients: [],
                isHTML: true,
                bccRecipients: [],
                ccRecipients: [],
                attachments: [
                  _filePath,
                ],
              );

              await FlutterMailer.send(mailOptions);
            },
            icon: const Icon(Icons.send, size: 18),
            label: const Text("Export saved data as JSON"),
          )));
    });
  }
}
