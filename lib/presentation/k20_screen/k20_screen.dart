import 'package:flutter/material.dart';
import 'package:pulsedevice/presentation/k20_screen/widgets/chat_record_item_widget.dart';
import 'package:pulsedevice/widgets/custom_fab_location.dart';
import 'package:pulsedevice/widgets/custom_scaffold.dart';
import '../../core/app_export.dart';

import 'controller/k20_controller.dart';

// ignore_for_file: must_be_immutable

class K20Screen extends GetWidget<K20Controller> {
  const K20Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseScaffoldImageHeader(
      enableScroll: false,
      title: "lbl331".tr,
      child: SafeArea(
        top: false,
        child: Container(
          child: buildGroupedChatView(controller),
        ),
      ),
      floatingActionButton: _floatingActionButton(),
      floatingActionButtonLocation:
          CustomFABLocation(bottom: 138.h, right: 16.h),
    );
  }

  Widget _floatingActionButton() {
    return InkWell(
      onTap: () {
        Get.back();
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 12.h),
        decoration: BoxDecoration(
          color: appTheme.teal900,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 2),
            )
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomImageView(
              imagePath: ImageConstant.imgUPlusWhiteA700,
              height: 24.h,
              width: 24.h,
            ),
            SizedBox(height: 4.h),
            Text(
              "lbl332".tr,
              style: CustomTextStyles.bodySmallWhiteA700_1,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildGroupedChatView(K20Controller controller) {
    return Obx(() {
      final grouped = controller.groupedSections;

      return ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 16.h),
        physics: BouncingScrollPhysics(),
        itemCount: grouped.length,
        separatorBuilder: (_, __) => SizedBox(height: 24.h),
        itemBuilder: (context, groupIndex) {
          final section = grouped[groupIndex];

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 4.h, bottom: 8.h),
                child: Text(
                  dayLabel(section.dayOffset),
                  style: theme.textTheme.bodySmall,
                ),
              ),
              ...section.messages.map(
                (msg) => Padding(
                  padding: EdgeInsets.only(bottom: 8.h),
                  child: ChatRecordItemWidget(msg.message?.value ?? ''),
                ),
              ),
            ],
          );
        },
      );
    });
  }
}
