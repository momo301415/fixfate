import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../controller/k62_controller.dart';
import '../models/list_item_model.dart';

// ignore_for_file: must_be_immutable
class ListItemWidget extends StatelessWidget {
  ListItemWidget(this.listItemModelObj, {Key? key})
      : super(
          key: key,
        );

  ListItemModel listItemModelObj;

  var controller = Get.find<K62Controller>();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(
        horizontal: 24.h,
        vertical: 20.h,
      ),
      decoration: AppDecoration.fillWhiteA.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder24,
      ),
      child: Column(
        spacing: 16,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: double.maxFinite,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Obx(
                  () => Text(
                    listItemModelObj.tf!.value,
                    style: CustomTextStyles.bodyMediumPrimaryContainer,
                  ),
                ),
                Spacer(),
                Obx(
                  () => Text(
                    listItemModelObj.tenThousand!.value,
                    style: CustomTextStyles.bodyMediumPrimaryContainer,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8.h),
                  child: Obx(
                    () => Text(
                      listItemModelObj.tf1!.value,
                      style: CustomTextStyles.bodyMediumPrimaryContainer,
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            width: double.maxFinite,
            child: SliderTheme(
              data: SliderThemeData(
                trackShape: RoundedRectSliderTrackShape(),
                activeTrackColor: theme.colorScheme.primary,
                inactiveTrackColor: appTheme.gray300,
                thumbColor: appTheme.whiteA700,
                thumbShape: RoundSliderThumbShape(),
              ),
              child: Slider(
                value: 35.65,
                min: 0.0,
                max: 100.0,
                onChanged: (value) {},
              ),
            ),
          )
        ],
      ),
    );
  }
}
