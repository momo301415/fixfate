import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../controller/k6_controller.dart';
import '../models/list_one1_item_model.dart';

// ignore_for_file: must_be_immutable
class ListOne1ItemWidget extends StatelessWidget {
  ListOne1ItemWidget(this.listOne1ItemModelObj, {Key? key}) : super(key: key);

  ListOne1ItemModel listOne1ItemModelObj;

  var controller = Get.find<K6Controller>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 4.h, bottom: 2.h),
      decoration: AppDecoration.outlineGray,
      child: Row(
        children: [
          Obx(
            () => CustomImageView(
              imagePath: listOne1ItemModelObj.one!.value,
              height: 48.h,
              width: 48.h,
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(top: 4.h),
                child: Column(
                  spacing: 2,
                  children: [
                    SizedBox(
                      width: double.maxFinite,
                      child: Row(
                        children: [
                          Obx(
                            () => Text(
                              listOne1ItemModelObj.two!.value,
                              style: CustomTextStyles.titleSmallErrorContainer,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 16.h),
                            child: Obx(
                              () => Text(
                                listOne1ItemModelObj.time!.value,
                                style: theme.textTheme.bodyMedium,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Obx(
                          () => Text(
                            listOne1ItemModelObj.m130kcaltwo!.value,
                            style: CustomTextStyles.titleMediumPrimary_1,
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 6.h),
                            child: Obx(
                              () => Text(
                                listOne1ItemModelObj.m130kcaltwo1!.value,
                                style: CustomTextStyles
                                    .bodySmallPrimaryContainer_4,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 16.h),
                          child: Obx(
                            () => Text(
                              listOne1ItemModelObj.m30kcaltwo2!.value,
                              style: CustomTextStyles.titleMediumPrimary_1,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 6.h),
                            child: Obx(
                              () => Text(
                                listOne1ItemModelObj.m30kcaltwo3!.value,
                                style: CustomTextStyles
                                    .bodySmallPrimaryContainer_4,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 24.h),
                          child: Obx(
                            () => Text(
                              listOne1ItemModelObj.m0kcaltwo4!.value,
                              style: CustomTextStyles.titleMediumPrimary_1,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 6.h),
                            child: Obx(
                              () => Text(
                                listOne1ItemModelObj.m0kcaltwo5!.value,
                                style: CustomTextStyles
                                    .bodySmallPrimaryContainer_4,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
