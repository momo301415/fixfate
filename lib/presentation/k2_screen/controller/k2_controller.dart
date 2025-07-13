import 'package:pulsedevice/core/global_controller.dart';
import 'package:pulsedevice/core/network/api.dart';
import 'package:pulsedevice/core/network/api_service.dart';
import 'package:pulsedevice/core/utils/config.dart';
import 'package:pulsedevice/core/utils/dialog_utils.dart';
import 'package:pulsedevice/core/utils/firebase_helper.dart';
import 'package:pulsedevice/core/utils/loading_helper.dart';

import '../../../core/app_export.dart';
import '../models/k2_model.dart';

/// A controller class for the K2Screen.
///
/// This class manages the state of the K2Screen, including the
/// current k2ModelObj
class K2Controller extends GetxController {
  Rx<K2Model> k2ModelObj = K2Model().obs;
  final service = ApiService();
  final gc = Get.find<GlobalController>();

  @override
  void onInit() {
    super.onInit();
    initData();
  }

  void initData() async {
    if (gc.isLogout.value) return;
    autoLogin();
  }

  /// 路由登入頁面
  void goOne2Screen() {
    Get.toNamed(AppRoutes.one2Screen);
  }

  /// 路由註冊頁面
  void goOneScreen() {
    Get.toNamed(AppRoutes.oneScreen);
  }

  Future<bool> pressFetchLogin(String userid, String password) async {
    try {
      LoadingHelper.show();
      final notityToken = await FirebaseHelper.getDeviceToken();
      var resData = await service.postJson(
        Api.login,
        {
          'phone': userid,
          'password': password,
          'notityToken': notityToken,
        },
      );
      LoadingHelper.hide();
      if (resData.isNotEmpty) {
        var resBody = resData['data'];
        if (resBody != null) {
          await PrefUtils().setApiUserId(resBody['id'].toString());
          gc.apiToken.value = resBody['token'].toString();
          gc.apiId.value = resBody['id'].toString();
          gc.userId.value = userid;
          gc.healthDataSyncService.setUserId(userid);
          Config.apiId = resBody['id'].toString();
          Config.userId = userid;
          Config.userName = resBody['name'].toString();
          gc.avatarUrl.value = resBody['avatarUrl'] ?? "";
          gc.userGender.value = resBody['gender'] ?? "";

          final ftoken = await FirebaseHelper.getDeviceToken();
          if (ftoken != null) {
            gc.firebaseToken.value = ftoken;
            Config.notifyToken = ftoken;
          }

          goHomePage();
          return true;
        } else {
          DialogHelper.showError("${resData["message"]}");
        }
      }
    } catch (e) {
      LoadingHelper.show();
      DialogHelper.showError("服務錯誤，請稍後再試");
    }
    return false;
  }

  void autoLogin() async {
    var userid = await PrefUtils().getUserId();
    var password = await PrefUtils().getPassword();
    if (userid.isNotEmpty) {
      await pressFetchLogin(userid, password);
    }
  }

  /// 路由到個人中心
  void goHomePage() {
    Get.toNamed(AppRoutes.homePage);
  }
}
