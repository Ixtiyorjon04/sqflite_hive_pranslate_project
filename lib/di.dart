import 'package:dars5/core/database_helper.dart';
import 'package:dars5/core/hive_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';

final GetIt di = GetIt.instance;

Future<void> setup() async {
  WidgetsFlutterBinding.ensureInitialized();
  di.registerLazySingleton(() => DatabaseHelper());
  await di.get<DatabaseHelper>().init();
  di.registerLazySingleton(() => HiveHelper());
  await di.get<HiveHelper>().init();
}
