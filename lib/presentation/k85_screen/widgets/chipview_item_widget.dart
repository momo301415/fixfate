import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../models/chipview_item_model.dart';

// ignore_for_file: must_be_immutable
class ChipviewItemWidget extends StatelessWidget {
  ChipviewItemWidget(this.chipviewItemModelObj, {Key? key})
      : super(
          key: key,
        );

  ChipviewItemModel chipviewItemModelObj;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => RawChip(
        padding: EdgeInsets.symmetric(
          horizontal: 30.h,
          vertical: 4.h,
        ),
        showCheckmark: false,
        labelPadding: EdgeInsets.zero,
        label: Text(
          chipviewItemModelObj.one!.value,
          style: TextStyle(
            color: (chipviewItemModelObj.isSelected?.value ?? false)
                ? appTheme.whiteA700
                : theme.colorScheme.errorContainer.withValues(
                    alpha: 0.85,
                  ),
            fontSize: 12.fSize,
            fontFamily: 'PingFang TC',
            fontWeight: FontWeight.w400,
          ),
        ),
        selected: (chipviewItemModelObj.isSelected?.value ?? false),
        backgroundColor: appTheme.gray200,
        selectedColor: theme.colorScheme.primary,
        side: BorderSide.none,
        shape: (chipviewItemModelObj.isSelected?.value ?? false)
            ? RoundedRectangleBorder(
                side: BorderSide.none,
                borderRadius: BorderRadius.horizontal(
                  left: Radius.circular(4.h),
                ))
            : RoundedRectangleBorder(
                side: BorderSide.none,
              ),
        onSelected: (value) {
          chipviewItemModelObj.isSelected!.value = value;
        },
      ),
    );
  }
}
