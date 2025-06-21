import 'package:flutter/material.dart';
import 'package:pulsedevice/core/global_controller.dart';
import 'package:pulsedevice/core/network/api.dart';
import 'package:pulsedevice/core/network/api_service.dart';
import 'package:pulsedevice/core/utils/loading_helper.dart';
import '../../../core/app_export.dart';
import '../models/k67_model.dart';

/// A controller class for the K67Screen.
///
/// This class manages the state of the K67Screen, including the
/// current k67ModelObj
class K67Controller extends GetxController {
  Rx<K67Model> k67ModelObj = K67Model().obs;
  final gc = Get.find<GlobalController>();
  ApiService apiService = ApiService();
  var selectFamily = <ItemModel>[].obs;
  @override
  void onInit() {
    super.onInit();
    initData();
  }

  void initData() async {
    Future.delayed(Duration.zero, () {
      getFamilyData();
    });
  }

  /// 路由到分享健康數據頁面
  void gok71Screen() {
    Get.toNamed(AppRoutes.k71Screen);
  }

  /// 路由到掃描qr code
  void go72Screen() async {
    final resul = await Get.toNamed(AppRoutes.k72Screen);
    if (resul == true) {
      await getFamilyData();
    }
  }

  /// 家人設定頁面
  void goTow7Screen(dynamic selectedObject) async {
    final result =
        await Get.toNamed(AppRoutes.two7Screen, arguments: selectedObject);
    if (result == true) {
      await getFamilyData();
    }
  }

  Future<void> getFamilyData() async {
    try {
      // LoadingHelper.show();
      final payload = {"userID": gc.apiId.value};
      final res = await apiService.postJson(Api.familyList, payload);
      // LoadingHelper.hide();
      if (res.isNotEmpty && res["message"] == "SUCCESS") {
        final data = res["data"];
        if (data == null) return;
        if (data is List) {
          final modelList = data.map<ItemModel>((e) {
            final map = e as Map<String, dynamic>; // 安全轉型
            return ItemModel(
              two: RxString(map["abbreviation"] ?? ''),
              tf: RxString("更新時間：${map["create_at"] ?? ''}"),
              path: RxString(map["family_avatar_url"] ?? ''),
              isAlert: RxBool(map["notify"]),
              familyId: RxString(map["family_id"] ?? ''),
            );
          }).toList(); // <- 轉成 List<ItemModel>

          k67ModelObj.value.itemList.value = modelList;
          selectFamily.assignAll(modelList); // 若要複製
        }
      }
    } catch (e) {
      print("getFamilyData Error: $e");
    }
  }
}
