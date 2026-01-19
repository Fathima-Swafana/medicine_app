import 'package:hive_flutter/hive_flutter.dart';
import '../models/medicine.dart';

class HiveService {
  static const String boxName = 'medicines';

  static Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(MedicineAdapter());
    await Hive.openBox<Medicine>(boxName);
  }

  static Box<Medicine> get box => Hive.box<Medicine>(boxName);
}
