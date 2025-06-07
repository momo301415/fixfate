import 'package:flutter/material.dart';
import 'package:pulsedevice/core/global_controller.dart';
import 'package:pulsedevice/core/sqliteDb/app_database.dart';
import 'package:pulsedevice/core/sqliteDb/health_data_sync_service.dart';
import '../../../core/app_export.dart';
import '../models/k73_model.dart';

/// A controller class for the K73Screen.
///
/// This class manages the state of the K73Screen, including the
/// current k73ModelObj
class K73Controller extends GetxController {
  TextEditingController searchController = TextEditingController();
  final gc = Get.find<GlobalController>();

  Rx<K73Model> k73ModelObj = K73Model().obs;

  final loadDataTime = "".obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    print("k73 controller onInit");
    getData();
  }

  @override
  void onClose() {
    super.onClose();
    searchController.dispose();
  }

  /// 路由到個人頁面
  void goK29Screen() {
    Get.toNamed(AppRoutes.k29Page);
  }

  /// 路由到健康-心率頁面
  void gok77Screen() {
    Get.toNamed(AppRoutes.k77Page);
  }

  /// 路由到健康-控制主頁面
  void gok76Screen(int index) {
    Get.toNamed(AppRoutes.k76Screen, arguments: index);
  }

  void gok5Screen() {
    Get.toNamed(AppRoutes.k5Screen);
  }

  Future<void> getData() async {
    print("k73 controller getData");
    var res = await gc.healthDataSyncService.getAnalysisHealthData();
    if (res.isEmpty) return;
    k73ModelObj.value.listviewItemList.value[0].loadTime?.value =
        res["heartDuration"].toString();
    k73ModelObj.value.listviewItemList.value[0].value?.value =
        res["heartRate"].toString();
    k73ModelObj.value.listviewItemList.value[1].loadTime?.value =
        res["combinedDuration"].toString();
    k73ModelObj.value.listviewItemList.value[1].value?.value =
        res["bloodOxygen"].toString();
    k73ModelObj.value.listviewItemList.value[2].loadTime?.value =
        res["combinedDuration"].toString();
    k73ModelObj.value.listviewItemList.value[2].value?.value =
        res["temperature"].toString();
    k73ModelObj.value.listviewItemList.value[3].loadTime?.value =
        res["combinedDuration"].toString();
    k73ModelObj.value.listviewItemList.value[3].value?.value = "0";
    k73ModelObj.value.listviewItemList.value[4].loadTime?.value =
        res["stepDuration"].toString();
    k73ModelObj.value.listviewItemList.value[4].value?.value =
        res["stepCount"].toString();
    k73ModelObj.value.listviewItemList.value[5].loadTime?.value =
        res["sleepDuration"].toString();
    k73ModelObj.value.listviewItemList.value[5].value?.value =
        res["sleepTime"].toString();
    k73ModelObj.value.listviewItemList.value[6].loadTime?.value =
        res["stepDuration"].toString();
    k73ModelObj.value.listviewItemList.value[6].value?.value =
        res["calories"].toString();
    k73ModelObj.value.listviewItemList.value[7].loadTime?.value =
        res["stepDuration"].toString();
    k73ModelObj.value.listviewItemList.value[7].value?.value =
        res["stepDistance"].toString();
    k73ModelObj.value.listviewItemList.refresh();
    loadDataTime.value = res["loadDataTime"].toString();
  }
}
