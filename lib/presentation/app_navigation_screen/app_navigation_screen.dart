import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../five_dialog/controller/five_controller.dart';
import '../five_dialog/five_dialog.dart';

import '../ios_dialog/controller/ios_controller.dart';
import '../ios_dialog/ios_dialog.dart';

import '../k22_bottomsheet/controller/k22_controller.dart';
import '../k22_bottomsheet/k22_bottomsheet.dart';
import '../k23_dialog/controller/k23_controller.dart';
import '../k23_dialog/k23_dialog.dart';

import '../k25_dialog/controller/k25_controller.dart';
import '../k25_dialog/k25_dialog.dart';

import '../k28_dialog/controller/k28_controller.dart';
import '../k28_dialog/k28_dialog.dart';
import '../k31_bottomsheet/controller/k31_controller.dart';
import '../k31_bottomsheet/k31_bottomsheet.dart';
import '../k32_dialog/controller/k32_controller.dart';
import '../k32_dialog/k32_dialog.dart';

import '../k34_dialog/controller/k34_controller.dart';
import '../k34_dialog/k34_dialog.dart';
import '../k35_bottomsheet/controller/k35_controller.dart';
import '../k35_bottomsheet/k35_bottomsheet.dart';
import '../k36_dialog/controller/k36_controller.dart';
import '../k36_dialog/k36_dialog.dart';

import '../k50_bottomsheet/controller/k50_controller.dart';
import '../k50_bottomsheet/k50_bottomsheet.dart';
import '../k51_bottomsheet/controller/k51_controller.dart';
import '../k51_bottomsheet/k51_bottomsheet.dart';

import 'controller/app_navigation_controller.dart'; // ignore_for_file: must_be_immutable

class AppNavigationScreen extends GetWidget<AppNavigationController> {
  const AppNavigationScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFFFFFFFF),
      body: SafeArea(
        child: SizedBox(
          width: double.maxFinite,
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Color(0XFFFFFFFF),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 10.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.h),
                      child: Text(
                        "App Navigation",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0XFF000000),
                          fontSize: 20.fSize,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Padding(
                      padding: EdgeInsets.only(left: 20.h),
                      child: Text(
                        "Check your app's UI from the below demo screens of your app.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0XFF888888),
                          fontSize: 16.fSize,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    SizedBox(height: 5.h),
                    Divider(
                      height: 1.h,
                      thickness: 1.h,
                      color: Color(0XFF000000),
                    )
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0XFFFFFFFF),
                    ),
                    child: Column(
                      children: [
                        _buildScreenTitle(
                          screenTitle: "0-註冊",
                          onTapScreenTitle: () =>
                              onTapScreenTitle(AppRoutes.k0Screen),
                        ),
                        _buildScreenTitle(
                          screenTitle: "启动页",
                          onTapScreenTitle: () =>
                              onTapScreenTitle(AppRoutes.k1Screen),
                        ),
                        _buildScreenTitle(
                          screenTitle: "0-登入",
                          onTapScreenTitle: () =>
                              onTapScreenTitle(AppRoutes.k2Screen),
                        ),
                        _buildScreenTitle(
                          screenTitle: "0-註冊 One",
                          onTapScreenTitle: () =>
                              onTapScreenTitle(AppRoutes.oneScreen),
                        ),
                        _buildScreenTitle(
                          screenTitle: "0-註冊 Two",
                          onTapScreenTitle: () =>
                              onTapScreenTitle(AppRoutes.twoScreen),
                        ),

                        _buildScreenTitle(
                          screenTitle: "0-註冊 Four",
                          onTapScreenTitle: () =>
                              onTapScreenTitle(AppRoutes.fourScreen),
                        ),
                        _buildScreenTitle(
                          screenTitle: "0-註冊 Five - Dialog",
                          onTapScreenTitle: () => onTapDialogTitle(
                              context,
                              FiveDialog(
                                Get.put(FiveController()),
                                message: '',
                              )),
                        ),
                        _buildScreenTitle(
                          screenTitle: "0-註冊 Six",
                          onTapScreenTitle: () =>
                              onTapScreenTitle(AppRoutes.sixScreen),
                        ),

                        _buildScreenTitle(
                          screenTitle: "0-註冊-我的設備",
                          onTapScreenTitle: () =>
                              onTapScreenTitle(AppRoutes.k10Screen),
                        ),

                        _buildScreenTitle(
                          screenTitle: "0-登入 One",
                          onTapScreenTitle: () =>
                              onTapScreenTitle(AppRoutes.one2Screen),
                        ),
                        _buildScreenTitle(
                          screenTitle: "0-登入-忘記密碼",
                          onTapScreenTitle: () =>
                              onTapScreenTitle(AppRoutes.k14Screen),
                        ),
                        _buildScreenTitle(
                          screenTitle: "0-登入-忘記密碼 One",
                          onTapScreenTitle: () =>
                              onTapScreenTitle(AppRoutes.one3Screen),
                        ),
                        _buildScreenTitle(
                          screenTitle: "0-登入-忘記密碼 Two",
                          onTapScreenTitle: () =>
                              onTapScreenTitle(AppRoutes.two2Screen),
                        ),
                        _buildScreenTitle(
                          screenTitle: "0-登入 Two",
                          onTapScreenTitle: () =>
                              onTapScreenTitle(AppRoutes.two3Screen),
                        ),
                        _buildScreenTitle(
                          screenTitle: "0-登入 Three",
                          onTapScreenTitle: () =>
                              onTapScreenTitle(AppRoutes.three1Screen),
                        ),

                        _buildScreenTitle(
                          screenTitle: "0-個人中心-個人信息-生日 - BottomSheet",
                          onTapScreenTitle: () => onTapBottomSheetTitle(context,
                              K22Bottomsheet(Get.put(K22Controller()))),
                        ),
                        _buildScreenTitle(
                          screenTitle: "0-個人中心-個人信息-身高(輸入前) - Dialog",
                          onTapScreenTitle: () => onTapDialogTitle(
                              context, K23Dialog(Get.put(K23Controller()))),
                        ),

                        _buildScreenTitle(
                          screenTitle: "0-個人中心-個人信息-體重(輸入前) - Dialog",
                          onTapScreenTitle: () => onTapDialogTitle(
                              context, K25Dialog(Get.put(K25Controller()))),
                        ),

                        _buildScreenTitle(
                          screenTitle: "0-個人中心-個人信息-腰圍(輸入後) - Dialog",
                          onTapScreenTitle: () => onTapDialogTitle(
                              context, K28Dialog(Get.put(K28Controller()))),
                        ),
                        _buildScreenTitle(
                          screenTitle: "0-個人中心-個人資料",
                          onTapScreenTitle: () =>
                              onTapScreenTitle(AppRoutes.k30Screen),
                        ),
                        _buildScreenTitle(
                          screenTitle: "0-個人中心-個人信息-頭貼 - BottomSheet",
                          onTapScreenTitle: () => onTapBottomSheetTitle(context,
                              K31Bottomsheet(Get.put(K31Controller()))),
                        ),
                        _buildScreenTitle(
                          screenTitle: "0-個人中心-個人信息-暱稱(未輸入) - Dialog",
                          onTapScreenTitle: () => onTapDialogTitle(
                              context, K32Dialog(Get.put(K32Controller()))),
                        ),

                        _buildScreenTitle(
                          screenTitle: "0-個人中心-個人信息-電子信箱(輸入前) - Dialog",
                          onTapScreenTitle: () => onTapDialogTitle(
                              context, K34Dialog(Get.put(K34Controller()))),
                        ),
                        _buildScreenTitle(
                          screenTitle: "0-個人中心-個人信息-性別 - BottomSheet",
                          onTapScreenTitle: () => onTapBottomSheetTitle(context,
                              K35Bottomsheet(Get.put(K35Controller()))),
                        ),
                        _buildScreenTitle(
                          screenTitle: "0-個人中心-個人信息-自行輸入(未輸入) - Dialog",
                          onTapScreenTitle: () => onTapDialogTitle(
                              context, K36Dialog(Get.put(K36Controller()))),
                        ),

                        _buildScreenTitle(
                          screenTitle: "0-個人中心-個人信息-捲動範圍",
                          onTapScreenTitle: () =>
                              onTapScreenTitle(AppRoutes.k39Screen),
                        ),
                        _buildScreenTitle(
                          screenTitle: "0-個人中心-我的設備",
                          onTapScreenTitle: () =>
                              onTapScreenTitle(AppRoutes.k40Screen),
                        ),
                        _buildScreenTitle(
                          screenTitle: "0-個人中心-我的設備 One",
                          onTapScreenTitle: () =>
                              onTapScreenTitle(AppRoutes.one4Screen),
                        ),
                        // _buildScreenTitle(
                        //   screenTitle: "0-個人中心-我的設備-安卓配對 - Dialog",
                        //   onTapScreenTitle: () => onTapDialogTitle(
                        //       context, K42Dialog(Get.put(K42Controller()), bluetoothDevice: device,)),
                        // ),
                        _buildScreenTitle(
                          screenTitle: "0-個人中心-我的設備-ios配對 - Dialog",
                          onTapScreenTitle: () => onTapDialogTitle(
                              context, IosDialog(Get.put(IosController()))),
                        ),

                        _buildScreenTitle(
                          screenTitle: "0-個人中心-我的設備-設備設定",
                          onTapScreenTitle: () =>
                              onTapScreenTitle(AppRoutes.k45Screen),
                        ),
                        _buildScreenTitle(
                          screenTitle: "0-個人中心-我的設備-設備設定 One",
                          onTapScreenTitle: () =>
                              onTapScreenTitle(AppRoutes.one5Screen),
                        ),
                        // _buildScreenTitle(
                        //   screenTitle: "0-個人中心-我的設備-設備設定 Two - Dialog",
                        //   onTapScreenTitle: () => onTapDialogTitle(
                        //       context, Two4Dialog(Get.put(Two4Controller()))),
                        // ),
                        _buildScreenTitle(
                          screenTitle: "0-個人中心-用藥提醒",
                          onTapScreenTitle: () =>
                              onTapScreenTitle(AppRoutes.k48Screen),
                        ),
                        _buildScreenTitle(
                          screenTitle: "0-個人中心-用藥提醒 One",
                          onTapScreenTitle: () =>
                              onTapScreenTitle(AppRoutes.one6Screen),
                        ),
                        _buildScreenTitle(
                          screenTitle: "0-個人中心-用藥提醒頻率 - BottomSheet",
                          onTapScreenTitle: () => onTapBottomSheetTitle(context,
                              K50Bottomsheet(Get.put(K50Controller()))),
                        ),
                        _buildScreenTitle(
                          screenTitle: "0-個人中心-用藥提醒-時機 - BottomSheet",
                          onTapScreenTitle: () => onTapBottomSheetTitle(context,
                              K51Bottomsheet(Get.put(K51Controller()))),
                        ),
                        _buildScreenTitle(
                          screenTitle: "0-個人中心-警報紀錄-統計",
                          onTapScreenTitle: () =>
                              onTapScreenTitle(AppRoutes.k53Screen),
                        ),
                        // _buildScreenTitle(
                        //   screenTitle: "0-個人中心-警報紀錄-統計 One - BottomSheet",
                        //   onTapScreenTitle: () => onTapBottomSheetTitle(context,
                        //       One7Bottomsheet(Get.put(One7Controller()))),
                        // ),
                        _buildScreenTitle(
                          screenTitle: "0-個人中心-通知消息",
                          onTapScreenTitle: () =>
                              onTapScreenTitle(AppRoutes.k55Screen),
                        ),

                        _buildScreenTitle(
                          screenTitle: "0-個人中心-測量設定",
                          onTapScreenTitle: () =>
                              onTapScreenTitle(AppRoutes.k57Screen),
                        ),
                        _buildScreenTitle(
                          screenTitle: "0-個人中心-心率測量",
                          onTapScreenTitle: () =>
                              onTapScreenTitle(AppRoutes.k58Screen),
                        ),
                        _buildScreenTitle(
                          screenTitle: "0-個人中心-心率測量 One",
                          onTapScreenTitle: () =>
                              onTapScreenTitle(AppRoutes.one8Screen),
                        ),
                        _buildScreenTitle(
                          screenTitle: "0-個人中心-心率測量 Two",
                          onTapScreenTitle: () =>
                              onTapScreenTitle(AppRoutes.two5Screen),
                        ),
                        _buildScreenTitle(
                          screenTitle: "0-個人中心-體溫測量",
                          onTapScreenTitle: () =>
                              onTapScreenTitle(AppRoutes.k61Screen),
                        ),
                        _buildScreenTitle(
                          screenTitle: "0-個人中心-目標設定",
                          onTapScreenTitle: () =>
                              onTapScreenTitle(AppRoutes.k62Screen),
                        ),
                        _buildScreenTitle(
                          screenTitle: "0-個人中心-帳號與安全",
                          onTapScreenTitle: () =>
                              onTapScreenTitle(AppRoutes.k63Screen),
                        ),
                        _buildScreenTitle(
                          screenTitle: "0-個人中心-帳號與安全 One",
                          onTapScreenTitle: () =>
                              onTapScreenTitle(AppRoutes.one9Screen),
                        ),
                        _buildScreenTitle(
                          screenTitle: "0-個人中心-帳號與安全 Two",
                          onTapScreenTitle: () =>
                              onTapScreenTitle(AppRoutes.two6Screen),
                        ),

                        _buildScreenTitle(
                          screenTitle: "0-個人中心-家人管理",
                          onTapScreenTitle: () =>
                              onTapScreenTitle(AppRoutes.k67Screen),
                        ),
                        _buildScreenTitle(
                          screenTitle: "0-個人中心-家人管理 One",
                          onTapScreenTitle: () =>
                              onTapScreenTitle(AppRoutes.one10Screen),
                        ),
                        _buildScreenTitle(
                          screenTitle: "0-個人中心-家人管理 Two",
                          onTapScreenTitle: () =>
                              onTapScreenTitle(AppRoutes.two7Screen),
                        ),

                        _buildScreenTitle(
                          screenTitle: "0-個人中心-家人管理-分享報告",
                          onTapScreenTitle: () =>
                              onTapScreenTitle(AppRoutes.k71Screen),
                        ),
                        _buildScreenTitle(
                          screenTitle: "0-個人中心-家人管理-新增家人",
                          onTapScreenTitle: () =>
                              onTapScreenTitle(AppRoutes.k72Screen),
                        ),
                        _buildScreenTitle(
                          screenTitle: "2-健康",
                          onTapScreenTitle: () =>
                              onTapScreenTitle(AppRoutes.k73Screen),
                        ),
                        _buildScreenTitle(
                          screenTitle: "2-健康 One",
                          onTapScreenTitle: () =>
                              onTapScreenTitle(AppRoutes.one11Screen),
                        ),
                        _buildScreenTitle(
                          screenTitle: "2-健康 Two",
                          onTapScreenTitle: () =>
                              onTapScreenTitle(AppRoutes.two8Screen),
                        ),
                        _buildScreenTitle(
                          screenTitle: "2-健康 Three",
                          onTapScreenTitle: () =>
                              onTapScreenTitle(AppRoutes.three4Screen),
                        ),
                        _buildScreenTitle(
                          screenTitle: "2-健康-心率(日)",
                          onTapScreenTitle: () =>
                              onTapScreenTitle(AppRoutes.k77Page),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  /// Common click event for dialog
  void onTapDialogTitle(
    BuildContext context,
    Widget className,
  ) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: className,
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.zero,
        );
      },
    );
  }

  /// Common click event for bottomsheet
  void onTapBottomSheetTitle(
    BuildContext context,
    Widget className,
  ) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return className;
      },
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  /// Common widget
  Widget _buildScreenTitle({
    required String screenTitle,
    Function? onTapScreenTitle,
  }) {
    return GestureDetector(
      onTap: () {
        onTapScreenTitle?.call();
      },
      child: Container(
        decoration: BoxDecoration(
          color: Color(0XFFFFFFFF),
        ),
        child: Column(
          children: [
            SizedBox(height: 10.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.h),
              child: Text(
                screenTitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0XFF000000),
                  fontSize: 20.fSize,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            SizedBox(height: 10.h),
            SizedBox(height: 5.h),
            Divider(
              height: 1.h,
              thickness: 1.h,
              color: Color(0XFF888888),
            )
          ],
        ),
      ),
    );
  }

  /// Common click event
  void onTapScreenTitle(String routeName) {
    Get.toNamed(routeName);
  }
}
