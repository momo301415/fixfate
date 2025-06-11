import 'package:flutter/material.dart';
import 'package:pulsedevice/widgets/custom_scaffold.dart';
import '../../core/app_export.dart';
import '../../widgets/custom_bottom_bar.dart';
import 'controller/k73_controller.dart';
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
            bottom: 20.h,
          ),
          child: Column(
            // spacing: 12,
            mainAxisSize: MainAxisSize.min,
            children: [
              Obx(() => Text(
                    "msg_update_time".tr +
                        " : " +
                        controller.loadDataTime.value,
                    style: CustomTextStyles.bodySmall10,
                  )),
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
      child: RefreshIndicator(
          onRefresh: () async {
            await controller.getData();
          },
          child: Obx(
            () => GridView.builder(
              itemCount:
                  controller.k73ModelObj.value.listviewItemList.value.length,
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 3.h,
                mainAxisSpacing: 6.h,
                childAspectRatio: 1.6,
              ),
              itemBuilder: (context, index) {
                final item =
                    controller.k73ModelObj.value.listviewItemList.value[index];
                return GestureDetector(
                    onTap: () {
                      controller.gok76Screen(index);
                      print("點擊了${item.label}");
                    },
                    child: ListviewItemWidget(model: item));
              },
            ),
          )),
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
            child: GestureDetector(
                onTap: () {},
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
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 8.h),
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
                )),
          ),
          Expanded(
            child: GestureDetector(
                onTap: () {
                  controller.gok5Screen();
                },
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
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 8.h),
                                    child: _buildRowiconsportrun(
                                      iconsportrun:
                                          ImageConstant.imgIconSportRun,
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
                )),
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
            padding: EdgeInsets.only(right: 20.h, top: 15.v),
            child: Center(
                child: Text(
              one,
              style: CustomTextStyles.bodyMediumPrimaryContainer_2.copyWith(
                color: theme.colorScheme.primaryContainer.withValues(
                  alpha: 0.8,
                ),
              ),
            )),
          ),
        )
      ],
    );
  }
}
