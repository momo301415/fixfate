import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pulsedevice/core/app_export.dart';
import 'package:pulsedevice/presentation/k76_screen/controller/k76_controller.dart';
import 'package:pulsedevice/presentation/k76_screen/model/list_icon_bar_model.dart';

class ListItemWidget extends StatelessWidget {
  final ListIconBarModel listIconBarModel;
  final int index;
  final GlobalKey keyItem;

  ListItemWidget(this.listIconBarModel,
      {Key? key, required this.index, required this.keyItem})
      : super(key: key);

  final controller = Get.find<K76Controller>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        final isSelected = controller.selectedIndex.value == index;

        return GestureDetector(
          onTap: () => controller.onIconTap(index),
          child: Container(
            key: keyItem,
            margin: EdgeInsets.symmetric(horizontal: 8.h),
            padding: EdgeInsets.symmetric(vertical: 2.v, horizontal: 12.h),
            decoration: BoxDecoration(
              color: isSelected ? appTheme.blueGray90001 : appTheme.teal2007f01,
              borderRadius: BorderRadius.circular(12.h),
              boxShadow: [
                if (isSelected)
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6,
                    offset: Offset(0, 2),
                  ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 33.h,
                  height: 33.h,
                  padding: EdgeInsets.all(6.h),
                  child: CustomImageView(
                    imagePath: listIconBarModel.icon?.value ?? '',
                    color: Colors.white,
                    fit: BoxFit.fill,
                  ),
                ),
                Text(
                  listIconBarModel.label?.value ?? '',
                  style: TextStyle(
                    fontSize: 14.fSize,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
