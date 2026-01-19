import 'package:flutter/material.dart';
import '../models/medicine.dart';
import '../services/hive_service.dart';
import '../services/notification_service.dart';

class MedicineProvider extends ChangeNotifier {
  /// Returns all medicines sorted by time
  List<Medicine> get medicines {
    final list = HiveService.box.values.toList();
    list.sort((a, b) => a.time.compareTo(b.time));
    return list;
  }

  /// Add a new medicine and schedule alarm
  void addMedicine(Medicine medicine) {
    HiveService.box.add(medicine);

    // Schedule notification/alarm
    NotificationService.scheduleAlarm(
      id: medicine.hashCode,
      medicineName: medicine.name,
      dateTime: medicine.time,
    );

    notifyListeners();
  }

  /// Delete a medicine and cancel its alarm
  void deleteMedicine(Medicine medicine) {
    // Cancel scheduled alarm
    NotificationService.cancelNotification(medicine.hashCode);

    // Delete from Hive
    medicine.delete();

    // Notify UI
    notifyListeners();
  }
}
