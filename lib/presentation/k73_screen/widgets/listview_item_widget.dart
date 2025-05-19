import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pulsedevice/presentation/k73_screen/controller/k73_controller.dart';
import 'package:pulsedevice/presentation/k73_screen/models/listview_item_model.dart';
import 'package:pulsedevice/widgets/custom_image_view.dart';
import 'package:pulsedevice/core/utils/image_constant.dart';
import 'package:pulsedevice/core/utils/size_utils.dart';

class ListviewItemWidget extends StatelessWidget {
  final ListViewItemModel model;

  const ListviewItemWidget({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isAlert = model.isAlert?.value ?? false;

    return Container(
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
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomImageView(
                imagePath: model.icon!.value,
                height: 24.h,
                width: 24.h,
              ),
              Spacer(),
              if (isAlert)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 6.h, vertical: 2.v),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(8.h),
                  ),
                  child: Text(
                    "異常",
                    style: TextStyle(color: Colors.white, fontSize: 12.fSize),
                  ),
                ),
              SizedBox(width: 4.h),
              Text(
                model.loadTime!.value,
                style: TextStyle(fontSize: 12.fSize, color: Colors.grey),
              ),
            ],
          ),
          SizedBox(height: 8.v),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Text(
                  model.label!.value,
                  style: TextStyle(fontSize: 14.fSize, color: Colors.black87),
                ),
              ),
              Text(
                model.value!.value,
                style:
                    TextStyle(fontSize: 22.fSize, fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 4.h),
              Text(
                model.unit!.value,
                style: TextStyle(fontSize: 14.fSize),
              ),
            ],
          )
        ],
      ),
    );
  }
}
