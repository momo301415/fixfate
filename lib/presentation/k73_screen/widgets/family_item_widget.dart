import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pulsedevice/core/app_export.dart';
import 'package:pulsedevice/presentation/k73_screen/controller/k73_controller.dart';
import 'package:pulsedevice/presentation/k73_screen/models/family_item_model.dart';

// ignore_for_file: must_be_immutable
class FamilyItemWidget extends StatelessWidget {
  FamilyItemWidget(this.itemModelObj, {Key? key, this.index})
      : super(
          key: key,
        );

  FamilyItemModel itemModelObj;
  final int? index;

  var controller = Get.find<K73Controller>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isSelected = controller.familySelectedIndex.value == index;

      return GestureDetector(
        onTap: () {
          controller.familySelectedIndex.value = index!;

          controller.getHealthData(
              familyId: itemModelObj.familyId?.value,
              familyName: itemModelObj.two?.value);
        },
        child: SizedBox(
          width: 50.h,
          child: Opacity(
            opacity: isSelected ? 1.0 : 0.5,
            child: Column(
              children: [
                ClipOval(
                    child: CustomImageView(
                  imagePath: itemModelObj.path?.value == ""
                      ? ImageConstant.imgEllipse8236x36
                      : itemModelObj.path?.value,
                  fit: BoxFit.cover,
                  height: 36.h,
                  width: 36.h,
                )),
                SizedBox(height: 4.v),
                Text(
                  itemModelObj.two!.value,
                  textAlign: TextAlign.center,
                  style: isSelected
                      ? CustomTextStyles.bodyMediumWhite
                      : CustomTextStyles.bodyMediumGray50001,
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
