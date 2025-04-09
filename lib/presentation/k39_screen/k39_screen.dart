import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../widgets/app_bar/appbar_subtitle_one.dart';
import '../../widgets/app_bar/appbar_subtitle_two.dart';
import '../../widgets/app_bar/appbar_trailing_image.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../k24_dialog/controller/k24_controller.dart';
import '../k24_dialog/k24_dialog.dart';
import 'controller/k39_controller.dart';
import 'models/chipview1_item_model.dart';
import 'models/chipview_item_model.dart';
import 'models/chipview_one_item_model.dart';
import 'models/list_item_model.dart';
import 'widgets/chipview1_item_widget.dart';
import 'widgets/chipview_item_widget.dart';
import 'widgets/chipview_one_item_widget.dart';
import 'widgets/list_item_widget.dart'; // ignore_for_file: must_be_immutable

class K39Screen extends GetWidget<K39Controller> {
  const K39Screen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTheme.teal50,
      body: SafeArea(
        child: SizedBox(
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: Container(
              height: 832.h,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  _buildStackunionone(),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 8.h),
                          width: double.maxFinite,
                          child: Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(left: 8.h),
                                  child: Column(
                                    spacing: 16,
                                    children: [
                                      Container(
                                        width: double.maxFinite,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 16.h),
                                        decoration:
                                            AppDecoration.fillWhiteA.copyWith(
                                          borderRadius:
                                              BorderRadiusStyle.roundedBorder24,
                                        ),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            SizedBox(
                                              width: double.maxFinite,
                                              child: _buildAppbar(),
                                            ),
                                            _buildList(),
                                            SizedBox(height: 16.h),
                                            Container(
                                              width: double.maxFinite,
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 8.h),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "lbl81".tr,
                                                    style: CustomTextStyles
                                                        .bodyMediumBluegray900,
                                                  ),
                                                  Spacer(),
                                                  Text(
                                                    "lbl_100_cm".tr,
                                                    style: CustomTextStyles
                                                        .bodyMediumBluegray900,
                                                  ),
                                                  CustomImageView(
                                                    imagePath: ImageConstant
                                                        .imgVectorGray50001,
                                                    height: 8.h,
                                                    width: 6.h,
                                                    margin: EdgeInsets.only(
                                                        left: 16.h),
                                                  )
                                                ],
                                              ),
                                            ),
                                            SizedBox(height: 32.h)
                                          ],
                                        ),
                                      ),
                                      _buildColumnone(),
                                      _buildColumnone1()
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                height: 680.h,
                                width: 4.h,
                                margin: EdgeInsets.only(left: 4.h),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: _buildColumnone2(),
    );
  }

  /// Section Widget
  Widget _buildStackunionone() {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        height: 90.h,
        child: Stack(
          alignment: Alignment.center,
          children: [
            CustomImageView(
              imagePath: ImageConstant.imgUnion90x374,
              height: 90.h,
              width: double.maxFinite,
            ),
            Align(
              alignment: Alignment.topCenter,
              child: SizedBox(
                width: double.maxFinite,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: double.maxFinite,
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: 30.h,
                            top: 10.h,
                            right: 30.h,
                          ),
                          child: Row(
                            children: [
                              CustomImageView(
                                imagePath: ImageConstant.imgArrowLeft,
                                height: 24.h,
                                width: 24.h,
                                alignment: Alignment.bottomCenter,
                                onTap: () {
                                  onTapImgArrowleftone();
                                },
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 92.h),
                                child: Text(
                                  "lbl61".tr,
                                  style: theme.textTheme.titleMedium,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppbar() {
    return CustomAppBar(
      height: 40.h,
      title: AppbarSubtitleTwo(
        text: "lbl74".tr,
        margin: EdgeInsets.only(left: 8.h),
      ),
      actions: [
        AppbarSubtitleOne(
          text: "lbl54".tr,
        ),
        AppbarTrailingImage(
          imagePath: ImageConstant.imgVectorGray50001,
          height: 8.h,
          width: 4.h,
          margin: EdgeInsets.only(
            left: 17.h,
            right: 7.h,
          ),
        )
      ],
      styleType: Style.bgOutlineGray200,
    );
  }

  /// Section Widget
  Widget _buildList() {
    return Obx(
      () => ListView.builder(
        padding: EdgeInsets.zero,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: controller.k39ModelObj.value.listItemList.value.length,
        itemBuilder: (context, index) {
          ListItemModel model =
              controller.k39ModelObj.value.listItemList.value[index];
          return ListItemWidget(
            model,
            onTapRow: () {
              onTapRow();
            },
          );
        },
      ),
    );
  }

  /// Section Widget
  Widget _buildColumnone() {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.all(16.h),
      decoration: AppDecoration.fillWhiteA.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "lbl82".tr,
            style: CustomTextStyles.titleMediumErrorContainer,
          ),
          SizedBox(height: 4.h),
          Text(
            "lbl83".tr,
            style: CustomTextStyles.bodySmallGray50001,
          ),
          SizedBox(height: 16.h),
          SizedBox(
            width: double.maxFinite,
            child: Obx(
              () => Wrap(
                runSpacing: 6.h,
                spacing: 6.h,
                children: List<Widget>.generate(
                  controller.k39ModelObj.value.chipviewItemList.value.length,
                  (index) {
                    ChipviewItemModel model = controller
                        .k39ModelObj.value.chipviewItemList.value[index];
                    return ChipviewItemWidget(
                      model,
                    );
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildColumnone1() {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.all(16.h),
      decoration: AppDecoration.fillWhiteA.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "lbl94".tr,
            style: CustomTextStyles.titleMediumErrorContainer,
          ),
          SizedBox(height: 4.h),
          Text(
            "lbl95".tr,
            style: CustomTextStyles.bodySmallGray50001,
          ),
          SizedBox(height: 16.h),
          SizedBox(
            width: double.maxFinite,
            child: Obx(
              () => SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Wrap(
                  direction: Axis.horizontal,
                  runSpacing: 6.h,
                  spacing: 6.h,
                  children: List<Widget>.generate(
                    controller
                        .k39ModelObj.value.chipviewOneItemList.value.length,
                    (index) {
                      ChipviewOneItemModel model = controller
                          .k39ModelObj.value.chipviewOneItemList.value[index];
                      return ChipviewOneItemWidget(
                        model,
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 12.h),
          SizedBox(
            width: double.maxFinite,
            child: Obx(
              () => Wrap(
                runSpacing: 6.h,
                spacing: 6.h,
                children: List<Widget>.generate(
                  controller.k39ModelObj.value.chipview1ItemList.value.length,
                  (index) {
                    Chipview1ItemModel model = controller
                        .k39ModelObj.value.chipview1ItemList.value[index];
                    return Chipview1ItemWidget(
                      model,
                    );
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildColumnone2() {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(horizontal: 16.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: double.maxFinite,
            margin: EdgeInsets.only(bottom: 12.h),
            padding: EdgeInsets.symmetric(vertical: 16.h),
            decoration: AppDecoration.fillWhiteA.copyWith(
              borderRadius: BorderRadiusStyle.roundedBorder24,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "lbl102".tr,
                  style: CustomTextStyles.titleMediumErrorContainer,
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  /// Navigates to the previous screen.
  onTapImgArrowleftone() {
    Get.back();
  }

  /// Displays a dialog with the [K24Dialog] content.
  onTapRow() {
    Get.dialog(AlertDialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.zero,
      content: K24Dialog(
        Get.put(
          K24Controller(),
        ),
      ),
    ));
  }
}
