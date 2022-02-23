import 'dart:io';

import 'package:course/global_vars.dart';
import 'package:course/objectbox.g.dart';
import 'package:course/pages/page_magasin.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory appPath =  await getApplicationDocumentsDirectory();
  GlobalVars.store = await openStore(directory: "${appPath.path}/database/");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: PageMagasin(),
      debugShowCheckedModeBanner: false,
    );
  }
}
