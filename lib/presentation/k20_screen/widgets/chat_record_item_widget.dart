import 'package:flutter/material.dart';
import 'package:pulsedevice/core/app_export.dart';
import 'package:pulsedevice/core/utils/image_constant.dart';
import 'package:pulsedevice/theme/app_decoration.dart';
import 'package:pulsedevice/widgets/custom_image_view.dart';

class ChatRecordItemWidget extends StatelessWidget {
  final String text;

  const ChatRecordItemWidget(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.h, vertical: 10.h),
      decoration: AppDecoration.fillWhiteA.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder8,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start, // 上對齊比較自然
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgUserPrimary,
            height: 24.h,
            width: 24.h,
          ),
          SizedBox(width: 12.h),
          Expanded(
            child: Text(
              text,
              style: CustomTextStyles.bodyLarge16,
              softWrap: true,
            ),
          ),
        ],
      ),
    );
  }
}
