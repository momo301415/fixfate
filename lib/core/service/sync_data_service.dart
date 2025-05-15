import 'package:pulsedevice/core/global_controller.dart';
import 'package:pulsedevice/core/network/api_service.dart';
import 'package:pulsedevice/core/sqliteDb/app_database.dart';

class SyncDataService {
  final AppDatabase db;
  final GlobalController gc;
  final ApiService? aip;
  SyncDataService({required this.db, required this.gc, this.aip});

  Future<void> runBackgroundSync() async {
    await gc.healthDataSyncService.fetchAndStoreData();
    await gc.healthDataSyncService.syncHealthData();
  }
}
