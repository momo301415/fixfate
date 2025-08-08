import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pulsedevice/core/app_export.dart';
import 'package:pulsedevice/core/utils/date_time_utils.dart';
import 'package:pulsedevice/core/utils/image_constant.dart';

import 'package:pulsedevice/presentation/k6_screen/controller/k6_controller.dart';
import 'package:pulsedevice/presentation/k6_screen/models/list_one_item_model.dart';
import 'package:pulsedevice/presentation/k6_screen/widgets/list_one_item_widget.dart';
import 'package:pulsedevice/theme/app_decoration.dart';

class K6Page extends StatefulWidget {
  final int tabIndex;
  const K6Page({super.key, required this.tabIndex});

  @override
  State<K6Page> createState() => _K6PageState();
}

class _K6PageState extends State<K6Page> with AutomaticKeepAliveClientMixin {
  final controller = Get.find<K6Controller>();
  late final RxList<SportRecordGroup> groups;
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    groups = controller.tabIndex.value == 0
        ? controller.groupedAerobic
        : controller.groupedWeightTraining;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 18.h),
      child: Column(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(8.h),
              decoration: AppDecoration.fillWhiteA.copyWith(
                borderRadius: BorderRadiusStyle.roundedBorder24,
              ),
              child: Column(
                children: [
                  _buildDateSelector(),
                  SizedBox(height: 8.v),
                  _buildListByTab(),
                  SizedBox(height: 16.v),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildDateSelector() {
    return GestureDetector(
      onTap: () => controller.selectHistoryDate(),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.h, vertical: 12.h),
        decoration: AppDecoration.fillGray30066.copyWith(
          borderRadius: BorderRadiusStyle.roundedBorder24,
        ),
        width: double.maxFinite,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
                padding: EdgeInsets.only(left: 4.h),
                child: Obx(() {
                  return Text(
                    controller.formattedPickDate,
                    style: CustomTextStyles.bodyMediumPrimaryContainer_1,
                  );
                })),
            CustomImageView(
              imagePath: ImageConstant.imgArrowDownPrimarycontainer16x16,
              height: 16.h,
              width: 18.h,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildListByTab() {
    return Expanded(
      child: Obx(() {
        // final groups = controller.currentGroupedRecords;

        return ListView.builder(
          itemCount: groups.length,
          itemBuilder: (context, index) {
            final group = groups[index];

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 12.v, horizontal: 8.h),
                  child: Text(
                    group.date,
                    style: TextStyle(
                      fontSize: 16.fSize,
                      fontWeight: FontWeight.w600,
                      color: appTheme.gray600,
                    ),
                  ),
                ),
                ...group.records.map((record) {
                  final totalSec = controller.convertToTotalSeconds(
                    hours: record.hours ?? 0,
                    minutes: record.minutes ?? 0,
                    seconds: record.seconds ?? 0,
                  );
                  final unitLabel = controller.getTimeUnitLabel(totalSec);

                  // 根據 tabIndex 決定不同 icon
                  final imagePath = controller.tabIndex == 0
                      ? ImageConstant.imgFrame86912
                      : ImageConstant.imgFrame86911;

                  final listItemModel = ListOneItemModel(
                    one: imagePath, // 圖片使用 icon map
                    two: controller.tabIndex == 0 ? 'lbl253'.tr : 'lbl255'.tr,
                    time: record.time.format(pattern: 'HH:mm'),
                    m130kcaltwo: record.distance.toString(),
                    m130kcaltwo1: 'lbl193'.tr,
                    m30kcaltwo2: record.calories.toString(),
                    m30kcaltwo3: 'lbl191'.tr,
                    m0kcaltwo4: totalSec.toString(),
                    m0kcaltwo5: unitLabel,
                  );

                  return Padding(
                      padding: EdgeInsets.only(bottom: 8.v),
                      child: GestureDetector(
                        onTap: () {
                          print("點擊項目:${record.time}");
                          controller.go7Screen(record);
                        },
                        child: ListOneItemWidget(listItemModel),
                      ));
                }).toList(),
              ],
            );
          },
        );
      }),
    );
  }
}
