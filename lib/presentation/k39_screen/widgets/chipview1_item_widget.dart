import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../models/chipview1_item_model.dart';

// ignore_for_file: must_be_immutable
class Chipview1ItemWidget extends StatelessWidget {
  Chipview1ItemWidget(this.chipview1ItemModelObj, {Key? key})
      : super(
          key: key,
        );

  Chipview1ItemModel chipview1ItemModelObj;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => RawChip(
        padding: EdgeInsets.symmetric(
          horizontal: 12.h,
          vertical: 2.h,
        ),
        showCheckmark: false,
        labelPadding: EdgeInsets.zero,
        label: Text(
          chipview1ItemModelObj.one!.value,
          style: TextStyle(
            color: (chipview1ItemModelObj.isSelected?.value ?? false)
                ? theme.colorScheme.errorContainer
                : appTheme.gray200,
            fontSize: 17.fSize,
            fontFamily: 'PingFang TC',
            fontWeight: FontWeight.w400,
          ),
        ),
        selected: (chipview1ItemModelObj.isSelected?.value ?? false),
        backgroundColor: theme.colorScheme.primary,
        selectedColor: Colors.transparent,
        shape: (chipview1ItemModelObj.isSelected?.value ?? false)
            ? RoundedRectangleBorder(
                side: BorderSide(
                  color: appTheme.blueGray100,
                  width: 1.h,
                ),
                borderRadius: BorderRadius.circular(
                  14.h,
                ))
            : RoundedRectangleBorder(
                side: BorderSide.none,
                borderRadius: BorderRadius.circular(
                  14.h,
                ),
              ),
        onSelected: (value) {
          chipview1ItemModelObj.isSelected!.value = value;
        },
      ),
    );
  }
}
