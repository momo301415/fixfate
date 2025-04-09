import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../controller/two8_controller.dart';
import '../models/list_one_item_model.dart';

// ignore_for_file: must_be_immutable
class ListOneItemWidget extends StatelessWidget {
  ListOneItemWidget(this.listOneItemModelObj, {Key? key})
      : super(
          key: key,
        );

  ListOneItemModel listOneItemModelObj;

  var controller = Get.find<Two8Controller>();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 40.h,
      child: Opacity(
        opacity: 0.5,
        child: SizedBox(
          width: 40.h,
          child: Column(
            spacing: 2,
            children: [
              CustomImageView(
                imagePath: ImageConstant.imgEllipse8236x36,
                height: 36.h,
                width: 36.h,
              ),
              Obx(
                () => Text(
                  listOneItemModelObj.two!.value,
                  overflow: TextOverflow.ellipsis,
                  style: CustomTextStyles.bodyMediumWhiteA700,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
