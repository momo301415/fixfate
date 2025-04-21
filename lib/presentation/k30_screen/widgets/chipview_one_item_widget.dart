import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../models/chipview_one_item_model.dart';

// ignore_for_file: must_be_immutable
class ChipviewOneItemWidget extends StatelessWidget {
  ChipviewOneItemWidget(this.chipviewOneItemModelObj, {Key? key, this.onTap})
      : super(
          key: key,
        );

  ChipviewOneItemModel chipviewOneItemModelObj;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        canvasColor: Colors.transparent,
      ),
      child: Obx(
        () => RawChip(
          padding: EdgeInsets.symmetric(
            horizontal: 12.h,
            vertical: 2.h,
          ),
          showCheckmark: false,
          labelPadding: EdgeInsets.zero,
          label: Text(
            chipviewOneItemModelObj.one!.value,
            style: TextStyle(
              color: (chipviewOneItemModelObj.isSelected?.value ?? false)
                  ? appTheme.gray200
                  : appTheme.gray50001,
              fontSize: 17.fSize,
              fontFamily: 'PingFang TC',
              fontWeight: FontWeight.w400,
            ),
          ),
          selected: (chipviewOneItemModelObj.isSelected?.value ?? false),
          backgroundColor: Colors.transparent,
          selectedColor: theme.colorScheme.primary,
          shape: (chipviewOneItemModelObj.isSelected?.value ?? false)
              ? RoundedRectangleBorder(
                  side: BorderSide.none,
                  borderRadius: BorderRadius.circular(
                    14.h,
                  ))
              : RoundedRectangleBorder(
                  side: BorderSide(
                    color: appTheme.blueGray100,
                    width: 1.h,
                  ),
                  borderRadius: BorderRadius.circular(
                    14.h,
                  ),
                ),
          onSelected: (value) {
            chipviewOneItemModelObj.isSelected!.value = value;
            if (onTap != null) {
              onTap!();
            }
          },
        ),
      ),
    );
  }
}
