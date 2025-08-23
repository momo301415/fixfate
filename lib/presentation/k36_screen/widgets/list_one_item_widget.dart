import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../controller/k36_controller.dart';
import '../models/list_one_item_model.dart';

// ignore_for_file: must_be_immutable
class ListOneItemWidget extends StatelessWidget {
  ListOneItemWidget(this.listOneItemModelObj, {Key? key}) : super(key: key);

  ListOneItemModel listOneItemModelObj;

  var controller = Get.find<K36Controller>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(16.h, 16.h, 16.h, 14.h),
      decoration: AppDecoration.outlineGray200,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgIconPrimary,
            height: 20.h,
            width: 20.h,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(
                  () => Text(
                    listOneItemModelObj.eleven!.value,
                    style: theme.textTheme.bodySmall,
                  ),
                ),
                SizedBox(
                  width: double.maxFinite,
                  child: Row(
                    children: [
                      Obx(
                        () => Text(
                          listOneItemModelObj.tf!.value,
                          style: CustomTextStyles.labelLargeSemiBold,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 4.h),
                        child: Obx(
                          () => Text(
                            listOneItemModelObj.two!.value,
                            style:
                                CustomTextStyles
                                    .titleSmallErrorContainerSemiBold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 4.h),
                        child: Obx(
                          () => Text(
                            listOneItemModelObj.kg!.value,
                            style:
                                CustomTextStyles
                                    .titleSmallErrorContainerSemiBold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Obx(
            () => Text(
              listOneItemModelObj.two1!.value,
              style: CustomTextStyles.titleSmallPrimarySemiBold,
            ),
          ),
        ],
      ),
    );
  }
}
