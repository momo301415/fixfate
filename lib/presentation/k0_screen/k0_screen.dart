import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/app_bar/appbar_leading_image.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_elevated_button.dart';
import 'controller/k0_controller.dart'; // ignore_for_file: must_be_immutable

///使用者條款
class K0Screen extends GetWidget<K0Controller> {
  const K0Screen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTheme.whiteA700,
      appBar: _buildAppbar(),
      body: SafeArea(
        top: false,
        child: SizedBox(
          width: double.maxFinite,
          child: SingleChildScrollView(
            controller: controller.scrollController,
            child: Container(
              width: double.maxFinite,
              padding: EdgeInsets.only(
                left: 18.h,
                top: 12.h,
                right: 18.h,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 標題
                  Center(
                    child: Text(
                      "terms_title".tr,
                      style: CustomTextStyles.titleLargePrimaryContainer22,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 24.h),

                  // 歡迎詞
                  Text(
                    "terms_welcome".tr,
                    style: CustomTextStyles.bodyMediumBluegray400.copyWith(
                      height: 1.70,
                    ),
                  ),
                  SizedBox(height: 12.h),

                  Text(
                    "terms_please_read".tr,
                    style: CustomTextStyles.bodyMediumBluegray400.copyWith(
                      height: 1.70,
                    ),
                  ),
                  SizedBox(height: 22.h),

                  // 一、使用溫馨提醒
                  _buildSection(
                    title: "terms_section_1".tr,
                    content: [
                      "terms_1_1".tr,
                      "terms_1_2".tr,
                    ],
                  ),
                  SizedBox(height: 22.h),

                  // 二、電子文件意思表示
                  _buildSection(
                    title: "terms_section_2".tr,
                    content: [
                      "terms_2_1".tr,
                      "terms_2_2".tr,
                    ],
                  ),
                  SizedBox(height: 22.h),

                  // 三、使用者服務及權利義務
                  _buildSection(
                    title: "terms_section_3".tr,
                    content: [
                      "terms_3_1".tr,
                      "terms_3_2".tr,
                      "terms_3_3".tr,
                      "terms_3_4".tr,
                    ],
                  ),
                  SizedBox(height: 22.h),

                  // 四、保密
                  _buildSection(
                    title: "terms_section_4".tr,
                    content: [
                      "terms_4_1".tr,
                      "terms_4_2".tr,
                      "terms_4_3".tr,
                    ],
                  ),
                  SizedBox(height: 22.h),

                  // 五、隱私權政策及個人資料保護告知事項
                  _buildSection(
                    title: "terms_section_5".tr,
                    content: [
                      "terms_5_content".tr,
                    ],
                  ),
                  SizedBox(height: 22.h),

                  // 六、智慧財產權
                  _buildSection(
                    title: "terms_section_6".tr,
                    content: [
                      "terms_6_content".tr,
                    ],
                  ),
                  SizedBox(height: 22.h),

                  // 七、系統安全及備份
                  _buildSection(
                    title: "terms_section_7".tr,
                    content: [
                      "terms_7_content".tr,
                      "terms_7_1".tr,
                      "terms_7_2".tr,
                      "terms_7_3".tr,
                      "terms_7_4".tr,
                      "terms_7_5".tr,
                    ],
                  ),
                  SizedBox(height: 22.h),

                  // 八、條款效力、解釋及其他
                  _buildSection(
                    title: "terms_section_8".tr,
                    content: [
                      "terms_8_1".tr,
                      "terms_8_2".tr,
                      "terms_8_3".tr,
                      "terms_8_4".tr,
                    ],
                  ),
                  SizedBox(height: 32.h),

                  // 隱私權政策聲明
                  Text(
                    "privacy_title".tr,
                    style: CustomTextStyles.titleMediumPrimaryContainerSemiBold,
                  ),
                  SizedBox(height: 12.h),

                  Text(
                    "privacy_intro".tr,
                    style: CustomTextStyles.bodyMediumBluegray400.copyWith(
                      height: 1.70,
                    ),
                  ),
                  SizedBox(height: 22.h),

                  // 個人資料安全
                  _buildSection(
                    title: "privacy_section_1".tr,
                    content: [
                      "privacy_1_1".tr,
                      "privacy_1_2".tr,
                    ],
                  ),
                  SizedBox(height: 22.h),

                  // 個人資料的蒐集、處理、利用
                  _buildSection(
                    title: "privacy_section_2".tr,
                    content: [
                      "privacy_2_1".tr,
                      "privacy_2_2".tr,
                    ],
                  ),
                  SizedBox(height: 12.h),

                  // 蒐集目的詳細列表
                  _buildSubSection(
                    title: "privacy_collect_purpose".tr,
                    content: [
                      "privacy_collect_detail".tr,
                    ],
                  ),
                  SizedBox(height: 8.h),

                  // 蒐集目的編號列表
                  _buildPurposeList(),
                  SizedBox(height: 12.h),

                  // 個人資料類別
                  _buildSubSection(
                    title: "privacy_data_category".tr,
                    content: [
                      "privacy_data_category_intro".tr,
                    ],
                  ),
                  SizedBox(height: 8.h),

                  // 個人資料類別詳細列表
                  _buildDataCategoryList(),
                  SizedBox(height: 12.h),

                  // 利用期間、地區、對象及方式
                  _buildSubSection(
                    title: "privacy_usage_period".tr,
                    content: [
                      "privacy_usage_a".tr,
                      "privacy_usage_b".tr,
                      "privacy_usage_c".tr,
                    ],
                  ),
                  SizedBox(height: 8.h),

                  // 利用方式詳細說明
                  _buildUsageDetailList(),
                  SizedBox(height: 12.h),

                  // 使用者權利
                  _buildSubSection(
                    title: "privacy_your_rights".tr,
                    content: [
                      "privacy_right_1".tr,
                      "privacy_right_2".tr,
                      "privacy_right_3".tr,
                      "privacy_right_4".tr,
                      "privacy_right_5".tr,
                      "privacy_rights_note".tr,
                    ],
                  ),
                  SizedBox(height: 22.h),

                  // 三、資料安全保護措施
                  _buildSection(
                    title: "privacy_section_3".tr,
                    content: [
                      "privacy_3_content".tr,
                    ],
                  ),
                  SizedBox(height: 22.h),

                  // 四、裝置資料儲存與相關技術
                  _buildSection(
                    title: "privacy_section_4".tr,
                    content: [
                      "privacy_4_intro".tr,
                      "privacy_4_1".tr,
                      "privacy_4_2".tr,
                      "privacy_4_3".tr,
                      "privacy_4_4".tr,
                      "privacy_4_note1".tr,
                      "privacy_4_note2".tr,
                    ],
                  ),
                  SizedBox(height: 22.h),

                  // 五、隱私權政策修訂與聯絡方式
                  _buildSection(
                    title: "privacy_section_5".tr,
                    content: [
                      "privacy_5_content".tr,
                    ],
                  ),
                  SizedBox(height: 22.h),

                  // APP應用程式授權
                  _buildSection(
                    title: "app_auth_title".tr,
                    content: [
                      "app_auth_content".tr,
                      "app_auth_1".tr,
                      "app_auth_2".tr,
                      "app_auth_3".tr,
                      "app_auth_4".tr,
                    ],
                  ),
                  SizedBox(height: 34.h)
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: _buildBottomBar(),
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppbar() {
    return CustomAppBar(
      height: 56.h,
      leadingWidth: 48.h,
      leading: AppbarLeadingImage(
        imagePath: ImageConstant.imgClose,
        margin: EdgeInsets.only(left: 24.h),
        onTap: () {
          onTapCloseone();
        },
      ),
    );
  }

  /// 通用章節構建器
  Widget _buildSection({
    required String title,
    required List<String> content,
  }) {
    return Container(
      width: double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: CustomTextStyles.bodyMediumPrimaryContainer.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 10.h),
          ...content
              .map((text) => Padding(
                    padding: EdgeInsets.only(left: 6.h, bottom: 8.h),
                    child: Text(
                      text,
                      style: CustomTextStyles.bodyMediumBluegray400.copyWith(
                        height: 1.70,
                      ),
                    ),
                  ))
              .toList(),
        ],
      ),
    );
  }

  /// 子章節構建器
  Widget _buildSubSection({
    required String title,
    required List<String> content,
  }) {
    return Container(
      width: double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: CustomTextStyles.bodyMediumPrimaryContainer.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8.h),
          ...content
              .map((text) => Padding(
                    padding: EdgeInsets.only(left: 12.h, bottom: 6.h),
                    child: Text(
                      text,
                      style: CustomTextStyles.bodyMediumBluegray400.copyWith(
                        height: 1.70,
                      ),
                    ),
                  ))
              .toList(),
        ],
      ),
    );
  }

  /// 構建蒐集目的編號列表
  Widget _buildPurposeList() {
    final purposeKeys = [
      "privacy_purpose_001",
      "privacy_purpose_031",
      "privacy_purpose_040",
      "privacy_purpose_063",
      "privacy_purpose_064",
      "privacy_purpose_067",
      "privacy_purpose_069",
      "privacy_purpose_080",
      "privacy_purpose_081",
      "privacy_purpose_090",
      "privacy_purpose_091",
      "privacy_purpose_098",
      "privacy_purpose_104",
      "privacy_purpose_107",
      "privacy_purpose_125",
      "privacy_purpose_129",
      "privacy_purpose_132",
      "privacy_purpose_135",
      "privacy_purpose_136",
      "privacy_purpose_148",
      "privacy_purpose_152",
      "privacy_purpose_153",
      "privacy_purpose_157",
      "privacy_purpose_181",
    ];

    return Container(
      width: double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: purposeKeys
            .map((key) => Padding(
                  padding: EdgeInsets.only(left: 18.h, bottom: 4.h),
                  child: Text(
                    key.tr,
                    style: CustomTextStyles.bodyMediumBluegray400.copyWith(
                      height: 1.50,
                    ),
                  ),
                ))
            .toList(),
      ),
    );
  }

  /// 構建個人資料類別詳細列表
  Widget _buildDataCategoryList() {
    final dataKeys = [
      "privacy_data_c001",
      "privacy_data_c002",
      "privacy_data_c003",
      "privacy_data_c011",
      "privacy_data_c012",
      "privacy_data_c013",
      "privacy_data_c014",
      "privacy_data_c021",
      "privacy_data_c035",
      "privacy_data_c036",
      "privacy_data_c040",
      "privacy_data_c066",
      "privacy_data_c088",
      "privacy_data_c093",
      "privacy_data_c102",
      "privacy_data_c111",
      "privacy_data_c112",
      "privacy_data_c113",
      "privacy_data_c132",
    ];

    return Container(
      width: double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: dataKeys
            .map((key) => Padding(
                  padding: EdgeInsets.only(left: 18.h, bottom: 4.h),
                  child: Text(
                    key.tr,
                    style: CustomTextStyles.bodyMediumBluegray400.copyWith(
                      height: 1.50,
                    ),
                  ),
                ))
            .toList(),
      ),
    );
  }

  /// 構建利用方式詳細說明列表
  Widget _buildUsageDetailList() {
    final usageKeys = [
      "privacy_usage_c1",
      "privacy_usage_c2",
      "privacy_usage_c3",
      "privacy_usage_c4",
      "privacy_usage_c5",
      "privacy_usage_c6",
    ];

    return Container(
      width: double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: usageKeys
            .map((key) => Padding(
                  padding: EdgeInsets.only(left: 18.h, bottom: 6.h),
                  child: Text(
                    key.tr,
                    style: CustomTextStyles.bodyMediumBluegray400.copyWith(
                      height: 1.70,
                    ),
                  ),
                ))
            .toList(),
      ),
    );
  }

  /// Section Widget
  Widget _buildBottomBar() {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(horizontal: 24.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Obx(() => CustomElevatedButton(
                text: "lbl26_1".tr,
                margin: EdgeInsets.only(bottom: 12.h),
                buttonStyle: controller.isBottomReached.value
                    ? CustomButtonStyles.none
                    : CustomButtonStyles.fillTeal,
                decoration: controller.isBottomReached.value
                    ? CustomButtonStyles.gradientCyanToPrimaryDecoration
                    : null,
                onPressed: controller.isBottomReached.value
                    ? () => Get.back(result: true)
                    : null,
              ))
        ],
      ),
    );
  }

  /// Navigates to the previous screen.
  onTapCloseone() {
    Get.back();
  }
}
