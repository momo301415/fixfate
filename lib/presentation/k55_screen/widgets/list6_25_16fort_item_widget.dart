import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../controller/k55_controller.dart';
import '../models/list6_25_16fort_item_model.dart';

// ignore_for_file: must_be_immutable
class List62516fortItemWidget extends StatelessWidget {
  List62516fortItemWidget(this.list62516fortItemModelObj, {Key? key})
      : super(
          key: key,
        );

  List62516fortItemModel list62516fortItemModelObj;

  var controller = Get.find<K55Controller>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(12.h, 16.h, 12.h, 14.h),
      decoration: AppDecoration.outlineGray,
      child: Row(
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgUser,
            height: 42.h,
            width: 42.h,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(
                  () => Text(
                    list62516fortItemModelObj.appVar!.value,
                    style: theme.textTheme.titleSmall,
                  ),
                ),
                Obx(
                  () => Text(
                    list62516fortItemModelObj.tf!.value,
                    style: theme.textTheme.bodySmall,
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            width: 36.h,
            child: Obx(
              () => Text(
                list62516fortItemModelObj.forty!.value,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: CustomTextStyles.bodySmallErrorContainer,
              ),
            ),
          )
        ],
      ),
    );
  }
}
