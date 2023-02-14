import 'package:dars5/core/model/word_model.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class HiveHelper {
  late final Box _box;

  Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    Hive.init("${dir.path}gita");
    _box = await Hive.openBox("diyorbek");
  }

  Future<void> saveToken(String token) async {
    await _box.put("token", token);
  }

  String getToken() {
    return _box.get("token", defaultValue: "");
  }

  Future<void> saveUsers(List<String> users) async {
    for (int i = 0; i < users.length; i++) {
      await _box.add(users[i]);
    }
  }

  List<String> getUsers() {
    final list = <String>[];
    for (int i = 0; i < _box.length; i++) {
      list.add(_box.getAt(i));
    }
    return list;
  }
}
