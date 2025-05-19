import 'package:flutter/material.dart';
import 'package:pulsedevice/widgets/custom_scaffold.dart';
import '../../core/app_export.dart';
import '../../widgets/custom_bottom_bar.dart';
import '../../widgets/custom_search_view.dart';
import 'controller/k73_controller.dart';
import 'models/listview_item_model.dart';
import 'widgets/listview_item_widget.dart'; // ignore_for_file: must_be_immutable

/// 健康資料主頁面
class K73Screen extends GetWidget<K73Controller> {
  const K73Screen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return BaseChatScaffold(
      child: Container(
        child: Container(
          width: double.maxFinite,
          margin: EdgeInsets.only(
            left: 0.h,
            right: 0.h,
            bottom: 80.h,
          ),
          child: Column(
            spacing: 12,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "msg_2025_03_29".tr,
                style: CustomTextStyles.bodySmall10,
              ),
              _buildListview(),
              _buildRowviewtwo()
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomBar(
        onChanged: (value) {
          switch (value) {
            case 0:
              break;
            case 1:
              break;
            case 2:
              controller.goK29Screen();
              break;
          }
        },
      ),
    );
  }

  /// Section Widget
  Widget _buildListview() {
    return Padding(
      padding: EdgeInsets.only(right: 8.h),
      child: Obx(
        () => GridView.builder(
          itemCount: controller.k73ModelObj.value.listviewItemList.value.length,
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12.h,
            mainAxisSpacing: 12.h,
            childAspectRatio: 1.3,
          ),
          itemBuilder: (context, index) {
            final item =
                controller.k73ModelObj.value.listviewItemList.value[index];
            return ListviewItemWidget(model: item);
          },
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildRowviewtwo() {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.only(right: 8.h),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 50.h,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    height: 40.h,
                    width: 162.h,
                    decoration: BoxDecoration(
                      color: appTheme.whiteA700,
                      borderRadius: BorderRadius.circular(
                        8.h,
                      ),
                    ),
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
                                padding: EdgeInsets.symmetric(horizontal: 8.h),
                                child: _buildRowiconsportrun(
                                  iconsportrun: ImageConstant.img2411,
                                  one: "lbl222".tr,
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
          ),
          Expanded(
            child: Container(
              height: 50.h,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    height: 40.h,
                    width: 162.h,
                    decoration: BoxDecoration(
                      color: appTheme.whiteA700,
                      borderRadius: BorderRadius.circular(
                        8.h,
                      ),
                    ),
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
                                padding: EdgeInsets.symmetric(horizontal: 8.h),
                                child: _buildRowiconsportrun(
                                  iconsportrun: ImageConstant.imgIconSportRun,
                                  one: "lbl223".tr,
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
          )
        ],
      ),
    );
  }

  /// Common widget
  Widget _buildRowiconsportrun({
    required String iconsportrun,
    required String one,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomImageView(
          imagePath: iconsportrun,
          height: 40.h,
          width: 42.h,
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: EdgeInsets.only(right: 20.h),
            child: Text(
              one,
              style: CustomTextStyles.bodyMediumPrimaryContainer_2.copyWith(
                color: theme.colorScheme.primaryContainer.withValues(
                  alpha: 0.8,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  ///Handling route based on bottom click actions
  String getCurrentRoute(BottomBarEnum type) {
    switch (type) {
      case BottomBarEnum.tf:
        return AppRoutes.threeInitialPage;
      default:
        return "/";
    }
  }
}
