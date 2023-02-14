import 'dart:io';

import 'package:dars5/core/model/word_model.dart';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  late final Database _db;

  Future<void> init() async {
    var dirPath = await getDatabasesPath(); //telefondagi cache path
    final dbFile = File('${dirPath}UZENUZ.db');
    if (!await dbFile.exists()) {
      final byteDate = await rootBundle.load("assets/UZENUZ.db");
      await dbFile.writeAsBytes(byteDate.buffer.asUint8List(
        byteDate.offsetInBytes,
        byteDate.lengthInBytes,
      ));
    }
    _db = await openDatabase('${dirPath}UZENUZ.db', version: 1);
  }
  Future<List<WordModel>> findByUz(String value) async {
    // await Future.delayed(const Duration(seconds: 2));
    final list = await _db.rawQuery(
      "SELECT * FROM data_uz WHERE uz LIKE \"$value%\"",
    );
    return list.map((e) => WordModel.fromJson(e)).toList();
    // return await _db
    //     .rawQuery("SELECT * FROM data_uz WHERE uz LIKE \"$value%\" LIMIT 0,30");
  }
  Future<List<WordModel>> findByEn(String value) async {
    final list = await _db.rawQuery(
      "SELECT * FROM data_en WHERE en LIKE \"$value%\"",
    );
    return list.map((e) => WordModel.fromJson(e)).toList();
    // return await _db
    //     .rawQuery("SELECT * FROM data_uz WHERE uz LIKE \"$value%\" LIMIT 0,30");
  }
}
