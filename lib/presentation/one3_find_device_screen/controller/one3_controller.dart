import 'dart:io';
import 'dart:ui';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pp_bluetooth_kit_flutter/ble/pp_bluetooth_kit_manager.dart';
import 'package:pp_bluetooth_kit_flutter/enums/pp_scale_enums.dart';
import 'package:pp_bluetooth_kit_flutter/model/pp_device_model.dart';
import 'package:pulsedevice/core/global_controller.dart';
import 'package:pulsedevice/core/hiveDb/pp_device_storage.dart';
import 'package:pulsedevice/core/hiveDb/user_profile_storage.dart';
import 'package:pulsedevice/core/network/api.dart';
import 'package:pulsedevice/core/network/api_service.dart';
import 'package:pulsedevice/core/service/firebase_analytics_service.dart';
import 'package:pulsedevice/core/utils/dialog_utils.dart';
import 'package:pulsedevice/core/utils/loading_helper.dart';
import 'package:pulsedevice/core/utils/snackbar_helper.dart';
import 'package:pulsedevice/presentation/ios_dialog/controller/ios_controller.dart';
import 'package:pulsedevice/presentation/ios_dialog/ios_dialog.dart';
import 'package:pulsedevice/presentation/one3_find_device_screen/models/devicelistsection_item_model.dart';
import 'package:pulsedevice/presentation/one3_find_device_screen/models/k24_model.dart';
import 'package:pulsedevice/theme/custom_button_style.dart';
import 'package:pulsedevice/widgets/custom_elevated_button.dart';
import '../../../core/app_export.dart';
import '../models/one3_model.dart';

/// A controller class for the One3Screen.
///
/// This class manages the state of the One3Screen, including the
/// current one3ModelObj
class One3FindDeviceController extends GetxController {
  final gc = Get.find<GlobalController>();
  final apiService = ApiService();
  RxList<PPDeviceModel> devices = <PPDeviceModel>[].obs;
  Rx<PPDeviceModel?> selectedDevice = Rx<PPDeviceModel?>(null);
  Rx<One3FindDeviceModel> one3FindDeviceModelObj = One3FindDeviceModel().obs;
  // Rx<K24Model> k24ModelObj = K24Model().obs;
  RxList<DevicelistsectionItemModel> devicelistsectionItemList =
      <DevicelistsectionItemModel>[].obs;

  bool _hasPermissions = false;

  @override
  void onInit() {
    super.onInit();

    checkBluetoothPermission();
  }

  /// 顯示配對裝置對話框
  void showMatchDeviceDialog(PPDeviceModel device) {
    showModalBottomSheet(
      context: Get.context!,
      backgroundColor: Colors.transparent, // 重要：设置背景透明
      barrierColor: Colors.black.withOpacity(0.5), // 半透明遮罩
      builder: (context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0), // 模糊程度
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.0), // 半透明背景
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: double.maxFinite,
                      padding: EdgeInsets.symmetric(
                          horizontal: 24.h, vertical: 26.h),
                      decoration: AppDecoration.fillWhiteA.copyWith(
                        borderRadius: BorderRadiusStyle.roundedBorder16,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(height: 6.h),
                          CustomImageView(
                            imagePath: ImageConstant.imgClosePrimarycontainer1,
                            height: 10.h,
                            width: 12.h,
                            alignment: Alignment.centerRight,
                            onTap: () {
                              Get.back();
                            },
                          ),
                          SizedBox(height: 4.h),
                          CustomImageView(
                            imagePath: ImageConstant.imgFrame866181,
                            height: 128.h,
                            width: 130.h,
                          ),
                          SizedBox(height: 22.h),
                          SizedBox(
                            width: double.maxFinite,
                            child: Text(
                              "msg_scanfit2".tr,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: CustomTextStyles
                                  .titleMediumManropePrimaryContainerSemiBold,
                            ),
                          ),
                          SizedBox(height: 26.h),
                          CustomElevatedButton(
                            onPressed: () {
                              connectToDevice(device);
                            },
                            height: 56.h,
                            text: "lbl33".tr,
                            buttonStyle: CustomButtonStyles.none,
                            decoration: CustomButtonStyles
                                .gradientCyanToPrimaryTL8Decoration,
                            buttonTextStyle:
                                CustomTextStyles.titleMediumManrope,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  /// 檢查藍牙權限
  Future<void> checkBluetoothPermission() async {
    try {
      if (Platform.isAndroid) {
        final androidInfo = await DeviceInfoPlugin().androidInfo;
        final sdkInt = androidInfo.version.sdkInt;
        bool granted = false;

        if (sdkInt >= 31) {
          final statusScan = await Permission.bluetoothScan.request();
          final statusConnect = await Permission.bluetoothConnect.request();
          granted = statusScan.isGranted && statusConnect.isGranted;
        } else {
          final statusLocation = await Permission.locationWhenInUse.request();
          granted = statusLocation.isGranted;
        }

        if (granted) {
          await _onScanPressed();
        } else {
          Get.snackbar('權限錯誤', '請開啟藍牙相關權限');
        }
      } else {
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          final state = gc.isBleLefuPermission.value;
          if (state != PPBlePermissionState.on) {
            showBlueTooth();
          } else {
            await _onScanPressed();
          }
        });
      }
    } catch (e) {
      rethrow;
    }
  }

  /// 開始掃描藍牙設備
  Future _onScanPressed() async {
    print("開始掃描藍牙設備----");

    PPBluetoothKitManager.startScan((device) {
      print('Scan result:${device.toJson()}');

      final uniqueDevices = <String, PPDeviceModel>{};
      if (device.deviceMac != null && device.deviceMac!.isNotEmpty) {
        uniqueDevices[device.deviceMac!] = device;
      }

      final sortedList = uniqueDevices.values.toList()
        ..sort((a, b) => (b.rssi!.toInt()) - (a.rssi!.toInt()));

      devices.assignAll(sortedList);
    });
  }

  /// 顯示藍牙對話框
  Future<void> showBlueTooth() async {
    final result = await DialogHelper.showCustomDialog(
        Get.context!, IosDialog(Get.put(IosController())));
    if (result != null && result.isNotEmpty) {}
  }

  /// 停止掃描藍牙設備
  Future _onStopPressed() async {
    PPBluetoothKitManager.stopScan();
  }

  /// 返回
  void onBack() {
    _onStopPressed();
    Get.back();
  }

  /// 連接裝置
  Future<void> connectToDevice(PPDeviceModel device) async {
    try {
      // 📊 記錄開始配對按鈕點擊事件
      FirebaseAnalyticsService.instance.logClickStartPairing(
        deviceName: device.deviceName,
      );

      LoadingHelper.show();
      PPBluetoothKitManager.connectDevice(device, callBack: (state) {
        if (state == PPDeviceConnectionState.connected) {
          _onStopPressed();
          SnackbarHelper.showBlueSnackbar(
              title: '連線成功', message: '已連線到 ${device.deviceName}');
          UserProfileStorage.saveFitDeviceForCurrentUser(
              gc.userId.value, device);

          /// 儲存裝置到 Hive
          PPDeviceStorage.savePPDevice(gc.userId.value, device);
          callApiBindDevice(device);
          Future.delayed(const Duration(milliseconds: 500), () {
            goHomePage();
          });
        }
      });
    } catch (e) {
      rethrow;
    } finally {
      LoadingHelper.hide();
    }
  }

  /// 綁定裝置
  Future<bool> callApiBindDevice(PPDeviceModel device) async {
    try {
      LoadingHelper.show();
      var apiId = await PrefUtils().getApiUserId();
      final params = {
        "userId": apiId,
        "deviceType": "fit",
        "deviceCode": device.deviceMac,
        "bluetoothCode": device.deviceName
      };
      var res = await apiService.postJson(Api.bindDevice, params);
      LoadingHelper.hide();
      if (res.isNotEmpty) {
        var resBody = res['data'];
        if (resBody != null) {
          return true;
        } else {
          DialogHelper.showError("${res["message"]}");
        }
      }
    } catch (e) {
      LoadingHelper.hide();
      DialogHelper.showError("服務錯誤，請稍後再試");
    } finally {
      LoadingHelper.hide();
    }
    return false;
  }

  /// 返回首頁
  void goHomePage() {
    // 檢查當前路由
    if (Get.currentRoute == AppRoutes.homePage) {
      print('✅ 已在 HomePage，直接返回');
      Get.back();
      return;
    }

    // 嘗試返回到已有的 HomePage
    try {
      print('🔄 嘗試返回到現有 HomePage');
      Get.until((route) => route.settings.name == AppRoutes.homePage);
      print('✅ 成功返回');
      return;
    } catch (e) {
      print('⚠️ 無法返回，將創建新 HomePage: $e');
    }

    // 首次進入才執行
    print('🆕 創建新 HomePage');
    Get.offNamedUntil(
        AppRoutes.homePage, ModalRoute.withName(AppRoutes.one2Screen));
  }
}
