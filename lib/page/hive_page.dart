import 'dart:math';

import 'package:dars5/core/hive_helper.dart';
import 'package:dars5/di.dart';
import 'package:flutter/material.dart';

class HivePage extends StatefulWidget {
  const HivePage({Key? key}) : super(key: key);

  @override
  State<HivePage> createState() => _HivePageState();
}

class _HivePageState extends State<HivePage> {
  final hive = di.get<HiveHelper>();
  var text = "text";
  var temp = "fgsdfgd";

  @override
  Widget build(BuildContext context) {
    print("build");
    return Scaffold(
      appBar: AppBar(title: const Text("HivePage")),
      body: Center(
        child: Builder(builder: (context) {
          print("TEXT");
          return Text(
            text,
            style: const TextStyle(fontSize: 32),
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          temp = Random().nextInt(100).toString();
          setState(() {});
          return;

          text = hive.getToken();
          setState(() {});
          await hive.saveToken("tokennew");
          await Future.delayed(const Duration(seconds: 2));
          text = hive.getToken();
          setState(() {});

          // text = "${hive.getUsers()}";
          // setState(() {});
          // await hive.saveUsers(["Azimjon", "Hayrulla", "Jamshid"]);
          // await Future.delayed(const Duration(seconds: 2));
          // text = "${hive.getUsers()}";
          // setState(() {});
        },
      ),
    );
  }
}
