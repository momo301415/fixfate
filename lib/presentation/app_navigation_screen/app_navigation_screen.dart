import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../five_dialog/controller/five_controller.dart';
import '../five_dialog/five_dialog.dart';
import '../four1_dialog/controller/four1_controller.dart';
import '../four1_dialog/four1_dialog.dart';
import '../ios_dialog/controller/ios_controller.dart';
import '../ios_dialog/ios_dialog.dart';
import '../k20_dialog/controller/k20_controller.dart';
import '../k20_dialog/k20_dialog.dart';
import '../k21_dialog/controller/k21_controller.dart';
import '../k21_dialog/k21_dialog.dart';
import '../k22_bottomsheet/controller/k22_controller.dart';
import '../k22_bottomsheet/k22_bottomsheet.dart';
import '../k23_dialog/controller/k23_controller.dart';
import '../k23_dialog/k23_dialog.dart';
import '../k24_dialog/controller/k24_controller.dart';
import '../k24_dialog/k24_dialog.dart';
import '../k25_dialog/controller/k25_controller.dart';
import '../k25_dialog/k25_dialog.dart';
import '../k26_dialog/controller/k26_controller.dart';
import '../k26_dialog/k26_dialog.dart';
import '../k27_dialog/controller/k27_controller.dart';
import '../k27_dialog/k27_dialog.dart';
import '../k28_dialog/controller/k28_controller.dart';
import '../k28_dialog/k28_dialog.dart';
import '../k31_bottomsheet/controller/k31_controller.dart';
import '../k31_bottomsheet/k31_bottomsheet.dart';
import '../k32_dialog/controller/k32_controller.dart';
import '../k32_dialog/k32_dialog.dart';
import '../k33_dialog/controller/k33_controller.dart';
import '../k33_dialog/k33_dialog.dart';
import '../k34_dialog/controller/k34_controller.dart';
import '../k34_dialog/k34_dialog.dart';
import '../k35_bottomsheet/controller/k35_controller.dart';
import '../k35_bottomsheet/k35_bottomsheet.dart';
import '../k36_dialog/controller/k36_controller.dart';
import '../k36_dialog/k36_dialog.dart';
import '../k37_dialog/controller/k37_controller.dart';
import '../k37_dialog/k37_dialog.dart';
import '../k42_dialog/controller/k42_controller.dart';
import '../k42_dialog/k42_dialog.dart';
import '../k50_bottomsheet/controller/k50_controller.dart';
import '../k50_bottomsheet/k50_bottomsheet.dart';
import '../k51_bottomsheet/controller/k51_controller.dart';
import '../k51_bottomsheet/k51_bottomsheet.dart';
import '../k87_bottomsheet/controller/k87_controller.dart';
import '../k87_bottomsheet/k87_bottomsheet.dart';
import '../k88_bottomsheet/controller/k88_controller.dart';
import '../k88_bottomsheet/k88_bottomsheet.dart';
import '../k89_bottomsheet/controller/k89_controller.dart';
import '../k89_bottomsheet/k89_bottomsheet.dart';
import '../one1_dialog/controller/one1_controller.dart';
import '../one1_dialog/one1_dialog.dart';
import '../one7_bottomsheet/controller/one7_controller.dart';
import '../one7_bottomsheet/one7_bottomsheet.dart';
import '../three2_dialog/controller/three2_controller.dart';
import '../three2_dialog/three2_dialog.dart';
import '../three3_dialog/controller/three3_controller.dart';
import '../three3_dialog/three3_dialog.dart';
import '../three_dialog/controller/three_controller.dart';
import '../three_dialog/three_dialog.dart';
import '../two1_dialog/controller/two1_controller.dart';
import '../two1_dialog/two1_dialog.dart';
import '../two4_dialog/controller/two4_controller.dart';
import '../two4_dialog/two4_dialog.dart';
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
                          screenTitle: "0-註冊 Three - Dialog",
                          onTapScreenTitle: () => onTapDialogTitle(
                              context, ThreeDialog(Get.put(ThreeController()))),
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
                          screenTitle: "0-註冊-卷軸樣式",
                          onTapScreenTitle: () =>
                              onTapScreenTitle(AppRoutes.k9Screen),
                        ),
                        _buildScreenTitle(
                          screenTitle: "0-註冊-我的設備",
                          onTapScreenTitle: () =>
                              onTapScreenTitle(AppRoutes.k10Screen),
                        ),
                        _buildScreenTitle(
                          screenTitle: "0-註冊-我的設備 One - Dialog",
                          onTapScreenTitle: () => onTapDialogTitle(
                              context, One1Dialog(Get.put(One1Controller()))),
                        ),
                        _buildScreenTitle(
                          screenTitle: "0-註冊-我的設備 Two - Dialog",
                          onTapScreenTitle: () => onTapDialogTitle(
                              context, Two1Dialog(Get.put(Two1Controller()))),
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
                          screenTitle: "0-登入 Four - Dialog",
                          onTapScreenTitle: () => onTapDialogTitle(
                              context, Four1Dialog(Get.put(Four1Controller()))),
                        ),
                        _buildScreenTitle(
                          screenTitle: "0-個人中心-個人信息-電子信箱(錯誤格式) - Dialog",
                          onTapScreenTitle: () => onTapDialogTitle(
                              context, K20Dialog(Get.put(K20Controller()))),
                        ),
                        _buildScreenTitle(
                          screenTitle: "0-個人中心-個人信息-電子信箱(輸入後) - Dialog",
                          onTapScreenTitle: () => onTapDialogTitle(
                              context, K21Dialog(Get.put(K21Controller()))),
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
                          screenTitle: "0-個人中心-個人信息-身高(已輸入) - Dialog",
                          onTapScreenTitle: () => onTapDialogTitle(
                              context, K24Dialog(Get.put(K24Controller()))),
                        ),
                        _buildScreenTitle(
                          screenTitle: "0-個人中心-個人信息-體重(輸入前) - Dialog",
                          onTapScreenTitle: () => onTapDialogTitle(
                              context, K25Dialog(Get.put(K25Controller()))),
                        ),
                        _buildScreenTitle(
                          screenTitle: "0-個人中心-個人信息-體重(輸入後) - Dialog",
                          onTapScreenTitle: () => onTapDialogTitle(
                              context, K26Dialog(Get.put(K26Controller()))),
                        ),
                        _buildScreenTitle(
                          screenTitle: "0-個人中心-個人信息-腰圍(輸入前) - Dialog",
                          onTapScreenTitle: () => onTapDialogTitle(
                              context, K27Dialog(Get.put(K27Controller()))),
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
                          screenTitle: "0-個人中心-個人信息-暱稱(輸入後) - Dialog",
                          onTapScreenTitle: () => onTapDialogTitle(
                              context, K33Dialog(Get.put(K33Controller()))),
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
                          screenTitle: "0-個人中心-個人信息-自行輸入(已輸入) - Dialog",
                          onTapScreenTitle: () => onTapDialogTitle(
                              context, K37Dialog(Get.put(K37Controller()))),
                        ),
                        _buildScreenTitle(
                          screenTitle: "0-個人中心-個人信息-選項自行輸入",
                          onTapScreenTitle: () =>
                              onTapScreenTitle(AppRoutes.k38Screen),
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
                          screenTitle: "0-個人中心-我的設備-綁定成功",
                          onTapScreenTitle: () =>
                              onTapScreenTitle(AppRoutes.k44Screen),
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
                        _buildScreenTitle(
                          screenTitle: "0-個人中心-我的設備-設備設定 Two - Dialog",
                          onTapScreenTitle: () => onTapDialogTitle(
                              context, Two4Dialog(Get.put(Two4Controller()))),
                        ),
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
                          screenTitle: "0-個人中心-通知消息-點選樣式",
                          onTapScreenTitle: () =>
                              onTapScreenTitle(AppRoutes.k56Screen),
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
                          screenTitle: "0-個人中心-帳號與安全 Three - Dialog",
                          onTapScreenTitle: () => onTapDialogTitle(context,
                              Three2Dialog(Get.put(Three2Controller()))),
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
                          screenTitle: "0-個人中心-家人管理 Three - Dialog",
                          onTapScreenTitle: () => onTapDialogTitle(context,
                              Three3Dialog(Get.put(Three3Controller()))),
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
                              onTapScreenTitle(AppRoutes.k77Screen),
                        ),
                        _buildScreenTitle(
                          screenTitle: "3-健康-血氧(日)",
                          onTapScreenTitle: () =>
                              onTapScreenTitle(AppRoutes.k80Screen),
                        ),
                        _buildScreenTitle(
                          screenTitle: "2-健康-體溫(日)",
                          onTapScreenTitle: () =>
                              onTapScreenTitle(AppRoutes.k81Screen),
                        ),
                        _buildScreenTitle(
                          screenTitle: "2-健康-壓力(日)",
                          onTapScreenTitle: () =>
                              onTapScreenTitle(AppRoutes.k82Screen),
                        ),
                        _buildScreenTitle(
                          screenTitle: "2-健康-步數(日)",
                          onTapScreenTitle: () =>
                              onTapScreenTitle(AppRoutes.k83Screen),
                        ),
                        _buildScreenTitle(
                          screenTitle: "2-健康-睡眠(日)",
                          onTapScreenTitle: () =>
                              onTapScreenTitle(AppRoutes.k84Screen),
                        ),
                        _buildScreenTitle(
                          screenTitle: "2-健康-卡路里(日)",
                          onTapScreenTitle: () =>
                              onTapScreenTitle(AppRoutes.k85Screen),
                        ),
                        _buildScreenTitle(
                          screenTitle: "2-健康-移動距離(日)",
                          onTapScreenTitle: () =>
                              onTapScreenTitle(AppRoutes.k86Screen),
                        ),
                        _buildScreenTitle(
                          screenTitle: "2-健康-日選擇 - BottomSheet",
                          onTapScreenTitle: () => onTapBottomSheetTitle(context,
                              K87Bottomsheet(Get.put(K87Controller()))),
                        ),
                        _buildScreenTitle(
                          screenTitle: "2-健康-週選擇 - BottomSheet",
                          onTapScreenTitle: () => onTapBottomSheetTitle(context,
                              K88Bottomsheet(Get.put(K88Controller()))),
                        ),
                        _buildScreenTitle(
                          screenTitle: "2-健康-月選擇 - BottomSheet",
                          onTapScreenTitle: () => onTapBottomSheetTitle(context,
                              K89Bottomsheet(Get.put(K89Controller()))),
                        )
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
