import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pulsedevice/core/app_export.dart';
import 'package:pulsedevice/presentation/k73_screen/models/listview_item_model.dart';
import 'package:pulsedevice/widgets/custom_image_view.dart';
import 'package:pulsedevice/core/utils/size_utils.dart';

class ListviewItemWidget extends StatelessWidget {
  final ListViewItemModel model;

  const ListviewItemWidget({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isAlert = model.isAlert?.value ?? false;
    bool isLastItme = false;
    var iconHeight = 45.h;
    var iconWidth = 45.h;
    var iconLeftPosition = 12.h;
    var iconTopPosition = -12.v;
    if (model.icon!.value.contains(ImageConstant.imgIconWhiteA70040x40)) {
      iconWidth = 55.h;
      iconHeight = 55.h;
    }
    if (model.icon!.value.contains(ImageConstant.iconSleep)) {
      iconWidth = 70.h;
      iconHeight = 70.h;
      iconLeftPosition = 0.h;
      iconTopPosition = -20.v;
    }
    if (model.icon!.value.contains(ImageConstant.imgIcon40x40)) {
      iconWidth = 35.h;
      iconHeight = 35.h;
      iconLeftPosition = 15.h;
      iconTopPosition = -10.v;
      isLastItme = true;
    }

    return Stack(
      clipBehavior: Clip.none,
      children: [
        // 卡片本體
        Container(
          margin: isLastItme
              ? EdgeInsets.symmetric(horizontal: 8.h, vertical: 1.v)
              : EdgeInsets.all(8.h),
          padding: EdgeInsets.symmetric(horizontal: 12.h, vertical: 12.v),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.h),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 4,
                offset: Offset(0, 2),
              )
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 顯示時間與異常
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  model.loadTime!.value,
                  style: TextStyle(fontSize: 12.fSize, color: appTheme.cyan700),
                ),
              ),
              SizedBox(height: 8.v),
              // Label + Value + Unit
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Text(
                      model.label!.value,
                      style:
                          TextStyle(fontSize: 14.fSize, color: Colors.black87),
                    ),
                  ),
                  Text(
                    model.value!.value,
                    style: TextStyle(
                        fontSize: 18.fSize, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 4.h),
                  Text(
                    model.unit!.value,
                    style: TextStyle(fontSize: 14.fSize),
                  ),
                ],
              ),
            ],
          ),
        ),
        // 右上紅色警示 Badge
        if (isAlert)
          Positioned(
            top: 0,
            right: 12.v,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 6.h, vertical: 2.v),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(8.h),
              ),
              child: Text(
                "lbl216".tr,
                style: TextStyle(color: Colors.white, fontSize: 12.fSize),
              ),
            ),
          ),

        // 圖示：超出卡片
        Positioned(
          top: iconTopPosition,
          left: iconLeftPosition,
          child: CustomImageView(
            imagePath: model.icon!.value,
            height: iconHeight,
            width: iconWidth,
            fit: BoxFit.contain,
          ),
        ),
      ],
    );
  }
}
