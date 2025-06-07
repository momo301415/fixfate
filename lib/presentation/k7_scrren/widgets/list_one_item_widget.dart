import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../controller/k7_controller.dart';
import '../models/list_one_item_model.dart';

// ignore_for_file: must_be_immutable
class ListOneItemWidget extends StatelessWidget {
  ListOneItemWidget(this.listOneItemModelObj, {Key? key}) : super(key: key);

  ListOneItemModel listOneItemModelObj;

  var controller = Get.find<K7Controller>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(16.h, 14.h, 16.h, 12.h),
      decoration: AppDecoration.outlineGray,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgUCalender,
            height: 20.h,
            width: 22.h,
          ),
          Padding(
            padding: EdgeInsets.only(left: 10.h),
            child: Obx(
              () => Text(
                listOneItemModelObj.two!.value,
                style: CustomTextStyles.bodyMedium15,
              ),
            ),
          ),
          Spacer(),
          Obx(
            () => Text(
              listOneItemModelObj.bpm!.value,
              style: CustomTextStyles.bodyLargePrimaryContainer16_1,
            ),
          ),
        ],
      ),
    );
  }
}
