import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:pulsedevice/core/global_controller.dart';
import 'package:pulsedevice/core/network/api.dart';
import 'package:pulsedevice/core/network/api_service.dart';
import 'package:pulsedevice/core/utils/dialog_utils.dart';
import 'package:pulsedevice/core/utils/loading_helper.dart';
import 'package:pulsedevice/presentation/log_screen/model/log_item.dart';

class LogController extends GetxController {
  ApiService service = ApiService();
  final gc = Get.find<GlobalController>();
  RxList<LogItem> logs = <LogItem>[].obs;

  @override
  void onInit() {
    super.onInit();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      getLog();
    });
  }

  Future<void> getLog() async {
    LoadingHelper.show();
    try {
      var resData = await service.postJson(
        Api.logget,
        {"userId": gc.apiId.value, "logType": "INFO"},
      );
      LoadingHelper.hide();
      if (resData.isNotEmpty) {
        final resMsg = resData["message"];
        if (resMsg.contains("成功")) {
          logs.value =
              resData["data"].map<LogItem>((j) => LogItem.fromJson(j)).toList();
        }
      }
    } catch (e) {
      LoadingHelper.hide();
      DialogHelper.showError("服務錯誤，請稍後再試");
    }
  }
}
