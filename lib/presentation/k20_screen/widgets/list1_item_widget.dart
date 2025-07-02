import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../controller/k20_controller.dart';
import '../models/list1_item_model.dart';

// ignore_for_file: must_be_immutable
class List1ItemWidget extends StatelessWidget {
  List1ItemWidget(this.list1ItemModelObj, {Key? key}) : super(key: key);

  List1ItemModel list1ItemModelObj;

  var controller = Get.find<K20Controller>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.h, vertical: 10.h),
      decoration: AppDecoration.fillWhiteA.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder8,
      ),
      child: Row(
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgUserPrimary,
            height: 24.h,
            width: 24.h,
          ),
          Padding(
            padding: EdgeInsets.only(left: 12.h),
            child: Obx(
              () => Text(
                list1ItemModelObj.two!.value,
                style: CustomTextStyles.bodyLarge16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
