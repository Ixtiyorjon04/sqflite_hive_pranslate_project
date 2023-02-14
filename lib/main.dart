import 'package:dars5/di.dart';
import 'package:dars5/page/hive_page.dart';
import 'package:dars5/page/sqflite_page.dart';
import 'package:flutter/material.dart';

void main() async {
  await setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const SqflitePage(),
    );
  }
}
