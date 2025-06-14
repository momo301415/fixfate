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

    return Stack(
      clipBehavior: Clip.none,
      children: [
        // 卡片本體
        Container(
          margin: EdgeInsets.all(8.h),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (isAlert)
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 6.h, vertical: 2.v),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(8.h),
                      ),
                      child: Text(
                        "lbl216".tr,
                        style:
                            TextStyle(color: Colors.white, fontSize: 12.fSize),
                      ),
                    ),
                  SizedBox(width: 4.h),
                  Text(
                    model.loadTime!.value,
                    style:
                        TextStyle(fontSize: 12.fSize, color: appTheme.cyan700),
                  ),
                ],
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

        // 圖示：超出卡片
        Positioned(
          top: -12.v,
          left: 12.h,
          child: CustomImageView(
            imagePath: model.icon!.value,
            height:
                model.icon!.value.contains(ImageConstant.imgIconWhiteA70040x40)
                    ? 55.h
                    : 45.h,
            width:
                model.icon!.value.contains(ImageConstant.imgIconWhiteA70040x40)
                    ? 55.h
                    : 45.h,
            fit: BoxFit.contain,
          ),
        ),
      ],
    );
  }
}
