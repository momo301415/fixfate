import 'package:flutter/material.dart';
import 'package:pulsedevice/core/global_controller.dart';
import 'package:pulsedevice/core/network/api.dart';
import 'package:pulsedevice/core/network/api_service.dart';
import 'package:pulsedevice/core/utils/dialog_utils.dart';
import 'package:pulsedevice/core/utils/loading_helper.dart';
import 'package:pulsedevice/presentation/k67_screen/models/k67_model.dart';
import '../../../core/app_export.dart';
import '../models/two7_model.dart';

/// A controller class for the Two7Screen.
///
/// This class manages the state of the Two7Screen, including the
/// current two7ModelObj
class Two7Controller extends GetxController {
  Rx<Two7Model> two7ModelObj = Two7Model().obs;
  final gc = Get.find<GlobalController>();
  ApiService apiService = ApiService();
  Rx<bool> isSelectedSwitch = true.obs;
  final model = Get.arguments as ItemModel;

  @override
  void onInit() {
    super.onInit();
    isSelectedSwitch.value = model.isAlert!.value;
  }

  void showDelete() async {
    final dialog = await DialogHelper.showFamilyDeleteDialog();
    if (dialog == true) {
      await deleteFamily();
    }
  }

  void switchChange(bool value) {
    isSelectedSwitch.value = value;
    postApi(gc.apiId.value, model.familyId!.value, model.two!.value);
  }

  Future<void> deleteFamily() async {
    try {
      LoadingHelper.show();
      final payload = {
        "id": {"userId": gc.apiId.value, "familyId": model.familyId!.value}
      };
      final res = await apiService.postJson(Api.familyDelete, payload);
      LoadingHelper.hide();
      if (res.isNotEmpty && res["message"] == "SUCCESS") {
        Get.back(result: true);
      }
    } catch (e) {
      print("deleteFamily Error: $e");
    }
  }

  Future<void> postApi(String main, String sub, String nickName) async {
    try {
      final payload = {
        "id": {
          "userId": main,
          "familyId": sub,
        },
        "notify": isSelectedSwitch.value, //緊報通知
        "abbreviation": nickName
      };
      var res = await ApiService().postJson(
        Api.familyBiding,
        payload,
      );

      if (res.isNotEmpty) {}
    } catch (e) {
      print("Notify API Error: $e");
    }
  }
}
