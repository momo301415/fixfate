import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pulsedevice/theme/custom_button_style.dart';
import 'package:pulsedevice/widgets/custom_elevated_button.dart';
import '../../core/app_export.dart';
import 'controller/one7_controller.dart';

///日期選擇器 - 選擇年月
class One7Bottomsheet extends StatelessWidget {
  final void Function(int year, int month) onConfirm;

  One7Bottomsheet({
    Key? key,
    required this.onConfirm,
  }) : super(key: key);

  final One7Controller controller = Get.put(One7Controller());

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.h, vertical: 20.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          /// 年份與切換箭頭
          Obx(() => Row(
                children: [
                  Text(
                    "${controller.year.value}年",
                    style: CustomTextStyles.bodyLarge16,
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.chevron_left),
                    onPressed: controller.decrementYear,
                  ),
                  IconButton(
                    icon: const Icon(Icons.chevron_right),
                    onPressed: controller.incrementYear,
                  ),
                ],
              )),
          SizedBox(height: 12.h),

          /// 月份選擇格子
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 12,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 10.h,
              crossAxisSpacing: 10.h,
              childAspectRatio: 2.1,
            ),
            itemBuilder: (context, index) {
              final m = index + 1;
              return Obx(() {
                final isSelected = controller.month.value == m;
                return GestureDetector(
                  onTap: () => controller.selectMonth(m),
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color:
                          isSelected ? const Color(0xFF5BB5C4) : Colors.white,
                      border: Border.all(
                        color: isSelected
                            ? const Color(0xFF5BB5C4)
                            : appTheme.gray300,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(6.h),
                    ),
                    child: Text(
                      "${m.toString().padLeft(2, '0')}月",
                      style: TextStyle(
                        color: isSelected ? Colors.white : appTheme.gray900,
                        fontSize: 16.fSize,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                );
              });
            },
          ),
          SizedBox(height: 8.h),

          /// 按鈕
          Row(
            children: [
              Expanded(
                child: CustomElevatedButton(
                    onPressed: () => Get.back(),
                    text: "lbl50".tr,
                    margin: EdgeInsets.symmetric(horizontal: 8.h),
                    buttonStyle: CustomButtonStyles.fillGray,
                    buttonTextStyle: CustomTextStyles.bodyLarge16),
              ),
              Expanded(
                child: CustomElevatedButton(
                  onPressed: () {
                    onConfirm(controller.year.value, controller.month.value);
                    Get.back();
                  },
                  text: "lbl51".tr,
                  margin: EdgeInsets.symmetric(horizontal: 8.h),
                  buttonStyle: CustomButtonStyles.fillPrimary,
                ),
              ),
            ],
          ),
          SizedBox(height: 30.h),
        ],
      ),
    );
  }
}
