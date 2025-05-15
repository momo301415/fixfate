import 'package:flutter/material.dart';
import 'package:pulsedevice/presentation/k52_page2/controller/k52_controller2.dart';
import 'package:pulsedevice/presentation/k52_page2/models/list_item_model2.dart';
import '../../../core/app_export.dart';

// ignore_for_file: must_be_immutable
class ListItemWidget2 extends StatelessWidget {
  ListItemWidget2(this.listItemModelObj, {Key? key})
      : super(
          key: key,
        );

  ListItemModel2 listItemModelObj;

  var controller = Get.find<K52Controller2>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 4.h),
      child: Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: SizedBox(
            width: double.maxFinite,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(18.h, 6.h, 18.h, 4.h),
                  decoration: AppDecoration.outlineGray,
                  width: double.maxFinite,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: EdgeInsets.only(top: 10.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  listItemModelObj.tf!.value,
                                  style: CustomTextStyles
                                      .titleMediumPrimaryContainer16,
                                ),
                                Container(
                                  width: double.maxFinite,
                                  margin: EdgeInsets.only(right: 14.h),
                                  child: Container(
                                    height: 4.h,
                                    width: 218.h,
                                    decoration: BoxDecoration(
                                      color: appTheme.gray200,
                                      borderRadius: BorderRadius.circular(
                                        2.h,
                                      ),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                        2.h,
                                      ),
                                      child: LinearProgressIndicator(
                                        value: listItemModelObj.tf2!.value,
                                        backgroundColor: appTheme.gray200,
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                          theme.colorScheme.primary,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 4.h),
                        child: Text(
                          "${listItemModelObj.tf1!.value}",
                          style: CustomTextStyles.headlineLargePrimaryContainer,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 8.h),
                        child: Text(
                          "lbl161".tr,
                          style: CustomTextStyles.bodySmallPrimaryContainer_2,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
