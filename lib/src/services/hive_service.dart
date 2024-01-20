import 'package:hive_flutter/hive_flutter.dart';

import '../models/person_model.dart';

class HiveService {
  static Future<bool> initService() async {
    await Hive.initFlutter();
    Hive.registerAdapter(PersonModelAdapter());
    return true;
  }

  static Future<Box<T>> openBox<T>() async {
    if (Hive.isBoxOpen('$T')) {
      return Hive.box<T>('$T');
    } else {
      return Hive.openBox<T>('$T');
    }
  }

  static Future<int> addToBox<T>(Box<T> box, T data) {
    return box.add(data);
  }

  static Future<void> remove<T>(Box<T> box, int index) {
    return box.deleteAt(index);
  }
}
