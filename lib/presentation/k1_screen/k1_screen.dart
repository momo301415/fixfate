import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import 'controller/k1_controller.dart'; // ignore_for_file: must_be_immutable

class K1Screen extends GetWidget<K1Controller> {
  const K1Screen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: Container(
        width: double.maxFinite,
        height: SizeUtils.height,
        decoration: AppDecoration.gradientCyanToOnErrorContainer,
        child: SafeArea(
          child: SizedBox(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomImageView(
                  imagePath: ImageConstant.imgFrame86565,
                  height: 154.h,
                  width: 214.h,
                ),
                SizedBox(height: 58.h)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
