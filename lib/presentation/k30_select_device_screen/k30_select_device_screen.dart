import 'package:flutter/material.dart';
import 'package:pulsedevice/presentation/k30_select_device_screen/controller/k30_select_device_controller.dart';
import 'package:pulsedevice/widgets/custom_scaffold.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';
import '../../core/app_export.dart';

import 'models/deviceselectiongrid_item_model.dart';
import 'widgets/deviceselectiongrid_item_widget.dart'; // ignore_for_file: must_be_immutable

/**
 * 選擇設備
 */
class K30SelectDeviceScreen extends GetWidget<K30SelectDeviceController> {
  const K30SelectDeviceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseScaffoldImageHeader(
      title: "lbl428".tr,
      isShowBackButton: true,
      child: Column(
        children: [
          Text(
            "lbl429".tr,
            style: CustomTextStyles.bodySmallPrimaryContainer_1,
          ),
          SizedBox(height: 16.h),
          _buildDeviceSelectionGrid(),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildDeviceSelectionGrid() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 14.h),
      child: Obx(
        () => ResponsiveGridListBuilder(
          minItemWidth: 1,
          minItemsPerRow: 2,
          maxItemsPerRow: 2,
          horizontalGridSpacing: 16.h,
          verticalGridSpacing: 16.h,
          builder: (context, items) => ListView(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: BouncingScrollPhysics(),
            children: items,
          ),
          gridItems: List.generate(
            controller
                .k30ModelObj.value.deviceselectiongridItemList.value.length,
            (index) {
              DeviceselectiongridItemModel model = controller
                  .k30ModelObj.value.deviceselectiongridItemList.value[index];
              return GestureDetector(
                onTap: () {
                  controller.goOne3FindDeviceScreen();
                },
                child: DeviceselectiongridItemWidget(model),
              );
            },
          ),
        ),
      ),
    );
  }
}
