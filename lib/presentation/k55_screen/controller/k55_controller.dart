import 'package:pulsedevice/core/global_controller.dart';
import 'package:pulsedevice/core/network/api.dart';
import 'package:pulsedevice/core/network/api_service.dart';
import 'package:pulsedevice/core/utils/date_time_utils.dart';
import 'package:pulsedevice/core/utils/loading_helper.dart';
import 'package:pulsedevice/presentation/k55_screen/models/list6_25_16fort_item_model.dart';
import '../../../core/app_export.dart';
import '../models/k55_model.dart';

/// A controller class for the K55Screen.
///
/// This class manages the state of the K55Screen, including the
/// current k55ModelObj
class K55Controller extends GetxController {
  Rx<K55Model> k55ModelObj = K55Model().obs;
  final gc = Get.find<GlobalController>();
  ApiService apiService = ApiService();

  @override
  void onInit() {
    super.onInit();
    initData();
  }

  void initData() async {
    Future.delayed(Duration.zero, () {
      getNotifyList();
    });
  }

  //INFO:通知消息, WARN 警報紀錄
  Future<void> getNotifyList() async {
    LoadingHelper.show();
    final mm = DateTime.now().month;
    final yy = DateTime.now().year;
    var month = mm.toString().padLeft(2, '0');
    try {
      final payload = {
        "type": "INFO", //INFO:通知消息, WARN 警報紀錄
        "date": "${yy}-${month}",
        "userID": gc.apiId.value
      };
      var res = await apiService.postJson(
        Api.notifyList,
        payload,
      );
      LoadingHelper.hide();
      if (res.isNotEmpty) {
        if (res["message"] == "SUCCESS") {
          final data = res["data"];
          if (data == null) return;
          if (data is List) {
            final list = data.map<List62516fortItemModel>((e) {
              final map = e as Map<String, dynamic>;
              return List62516fortItemModel(
                appVar: RxString(map["title"]),
                tf: RxString(map["content"]),
                forty: RxString(
                    DateTimeUtils.formatToChineseDate(map["createdAt"])),
              );
            }).toList(); // <- 轉成 List<List62516fortItemModel>
            k55ModelObj.value.list62516fortItemList.value = list;
          }
        }
      }
    } catch (e) {
      print("Notify API Error: $e");
    }
  }
}
