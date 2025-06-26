import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/app_bar/appbar_leading_image.dart';
import '../../widgets/app_bar/appbar_title_one.dart';
import '../../widgets/app_bar/appbar_trailing_image.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_outlined_button.dart';
import '../../widgets/custom_text_form_field.dart';
import 'controller/k19_controller.dart'; // ignore_for_file: must_be_immutable

/// 諮詢頁面--預設首頁
class K19Screen extends GetWidget<K19Controller> {
  const K19Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTheme.teal50,
      body: SafeArea(
        child: SizedBox(
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: Container(
              height: 720.h,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    height: 502.h,
                    margin: EdgeInsets.only(bottom: 68.h),
                    padding: EdgeInsets.symmetric(horizontal: 16.h),
                    child: Chat(
                      showUserNames: false,
                      disableImageGallery: false,
                      dateHeaderThreshold: 86400000,
                      messages: controller.messageList.value,
                      user: controller.chatUser.value,
                      bubbleBuilder: (
                        child, {
                        required message,
                        required nextMessageInGroup,
                      }) {
                        return message.author.id == controller.chatUser.value.id
                            ? Container(
                                decoration: BoxDecoration(
                                  color: theme.colorScheme.onError,
                                  borderRadius: BorderRadius.circular(9.5.h),
                                ),
                                child: child,
                              )
                            : Container(
                                decoration: BoxDecoration(
                                  color: appTheme.deepOrangeA200,
                                  borderRadius: BorderRadius.circular(9.5.h),
                                ),
                                child: child,
                              );
                      },
                      textMessageBuilder: (
                        textMessage, {
                        required messageWidth,
                        required showName,
                      }) {
                        return textMessage.author.id ==
                                controller.chatUser.value.id
                            ? Container(
                                width: double.maxFinite,
                                padding: EdgeInsets.only(right: 10.h),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      textMessage.text.toString(),
                                      style: CustomTextStyles
                                          .labelMediumWhiteA700
                                          .copyWith(color: appTheme.whiteA700),
                                    ),
                                  ],
                                ),
                              )
                            : Container(
                                padding: EdgeInsets.symmetric(horizontal: 10.h),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      textMessage.text.toString(),
                                      style: CustomTextStyles
                                          .labelMediumWhiteA700
                                          .copyWith(color: appTheme.whiteA700),
                                    ),
                                  ],
                                ),
                              );
                      },
                      onSendPressed: (types.PartialText text) {},
                      customBottomWidget: Container(
                        width: double.maxFinite,
                        padding: EdgeInsets.symmetric(horizontal: 54.h),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              margin: EdgeInsets.only(bottom: 12.h),
                              padding: EdgeInsets.symmetric(
                                horizontal: 48.h,
                                vertical: 12.h,
                              ),
                              decoration: AppDecoration.outlineGrayC.copyWith(
                                borderRadius: BorderRadiusStyle.circleBorder32,
                              ),
                              width: double.maxFinite,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      CustomImageView(
                                        imagePath:
                                            ImageConstant.imgNavPrimary24x24,
                                        height: 24.h,
                                        width: 24.h,
                                      ),
                                      Text(
                                        "lbl68".tr,
                                        style:
                                            CustomTextStyles.labelMediumPrimary,
                                      ),
                                    ],
                                  ),
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      CustomImageView(
                                        imagePath: ImageConstant.imgNav,
                                        height: 24.h,
                                        width: 24.h,
                                      ),
                                      Text(
                                        "lbl69".tr,
                                        style: theme.textTheme.labelMedium,
                                      ),
                                    ],
                                  ),
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      CustomImageView(
                                        imagePath:
                                            ImageConstant.imgNavGray50024x24,
                                        height: 24.h,
                                        width: 24.h,
                                      ),
                                      Text(
                                        "lbl70".tr,
                                        style: theme.textTheme.labelMedium,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      customStatusBuilder: (message, {required context}) {
                        return Container();
                      },
                    ),
                  ),
                  Container(
                    height: 772.h,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        CustomImageView(
                          imagePath: ImageConstant.imgUnion772x374,
                          height: 772.h,
                          width: double.maxFinite,
                        ),
                        Container(
                          width: double.maxFinite,
                          margin: EdgeInsets.symmetric(horizontal: 16.h),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                width: double.maxFinite,
                                child: _buildAppbar(),
                              ),
                              SizedBox(height: 16.h),
                              Container(
                                width: double.maxFinite,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 12.h,
                                  vertical: 24.h,
                                ),
                                decoration:
                                    AppDecoration.outlineGray90066.copyWith(
                                  borderRadius:
                                      BorderRadiusStyle.roundedBorder16,
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    _buildRowmusicone(),
                                    SizedBox(height: 26.h),
                                    Container(
                                      width: double.maxFinite,
                                      margin: EdgeInsets.symmetric(
                                        horizontal: 32.h,
                                      ),
                                      child: _buildRowfiwindOne(
                                        fiwindOne: ImageConstant.imgUChartLine,
                                        one: "lbl306".tr,
                                      ),
                                    ),
                                    SizedBox(height: 14.h),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 12.h,
                                        vertical: 4.h,
                                      ),
                                      decoration:
                                          AppDecoration.outlineGray.copyWith(
                                        borderRadius:
                                            BorderRadiusStyle.circleBorder12,
                                      ),
                                      child: Text(
                                        "msg21".tr,
                                        textAlign: TextAlign.left,
                                        style: theme.textTheme.bodySmall,
                                      ),
                                    ),
                                    SizedBox(height: 8.h),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 12.h,
                                        vertical: 4.h,
                                      ),
                                      decoration:
                                          AppDecoration.outlineGray.copyWith(
                                        borderRadius:
                                            BorderRadiusStyle.circleBorder12,
                                      ),
                                      child: Text(
                                        "msg22".tr,
                                        textAlign: TextAlign.left,
                                        style: theme.textTheme.bodySmall,
                                      ),
                                    ),
                                    SizedBox(height: 26.h),
                                    Container(
                                      width: double.maxFinite,
                                      margin: EdgeInsets.symmetric(
                                        horizontal: 32.h,
                                      ),
                                      child: _buildRowfiwindOne(
                                        fiwindOne: ImageConstant.imgFiWind,
                                        one: "lbl307".tr,
                                      ),
                                    ),
                                    SizedBox(height: 14.h),
                                    _buildTf(),
                                    SizedBox(height: 8.h),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 12.h,
                                        vertical: 4.h,
                                      ),
                                      decoration: AppDecoration.outlineGray2001
                                          .copyWith(
                                        borderRadius:
                                            BorderRadiusStyle.circleBorder12,
                                      ),
                                      child: Text(
                                        "msg24".tr,
                                        textAlign: TextAlign.left,
                                        style: theme.textTheme.bodySmall,
                                      ),
                                    ),
                                    SizedBox(height: 26.h),
                                    Container(
                                      width: double.maxFinite,
                                      margin: EdgeInsets.symmetric(
                                        horizontal: 32.h,
                                      ),
                                      child: _buildRowfiwindOne(
                                        fiwindOne: ImageConstant.imgFiBookOpen,
                                        one: "lbl308".tr,
                                      ),
                                    ),
                                    SizedBox(height: 14.h),
                                    _buildTf1(),
                                    SizedBox(height: 8.h),
                                    _buildTf2(),
                                    SizedBox(height: 104.h),
                                  ],
                                ),
                              ),
                              SizedBox(height: 16.h),
                              _buildSearchone(),
                              SizedBox(height: 32.h),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "lbl303".tr,
                                    style: CustomTextStyles.bodyMediumPrimary13,
                                  ),
                                  CustomImageView(
                                    imagePath: ImageConstant.imgArrowUp,
                                    height: 20.h,
                                    width: 20.h,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppbar() {
    return CustomAppBar(
      height: 36.h,
      leadingWidth: 36.h,
      leading: AppbarLeadingImage(
        imagePath: ImageConstant.imgClock,
        height: 36.h,
        width: 36.h,
      ),
      title: AppbarTitleOne(
        text: "lbl_fixfate".tr,
        margin: EdgeInsets.only(left: 16.h),
      ),
      actions: [
        AppbarTrailingImage(
          imagePath: ImageConstant.imgWhiteA7001,
          margin: EdgeInsets.only(right: 7.h),
        ),
      ],
    );
  }

  /// Section Widget
  Widget _buildRowmusicone() {
    return SizedBox(
      width: double.maxFinite,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgMusicPrimary,
            height: 24.h,
            width: 24.h,
            alignment: Alignment.bottomCenter,
          ),
          Container(
            width: 240.h,
            margin: EdgeInsets.only(left: 8.h, bottom: 12.h),
            padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 6.h),
            decoration: AppDecoration.gray100.copyWith(
              borderRadius: BorderRadiusStyle.customBorderTL161,
            ),
            child: Column(
              spacing: 2,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "msg20".tr,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodySmall,
                ),
                Text(
                  "msg_app5".tr,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: CustomTextStyles.pingFangTC1Bluegray400.copyWith(
                    height: 1.40,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildTf() {
    return CustomOutlinedButton(
      height: 24.h,
      text: "msg23".tr,
      margin: EdgeInsets.symmetric(horizontal: 20.h),
      buttonStyle: CustomButtonStyles.outlineGray,
      buttonTextStyle: theme.textTheme.bodySmall!,
    );
  }

  /// Section Widget
  Widget _buildTf1() {
    return CustomOutlinedButton(
      height: 24.h,
      text: "msg25".tr,
      margin: EdgeInsets.symmetric(horizontal: 20.h),
      buttonStyle: CustomButtonStyles.outlineGray,
      buttonTextStyle: theme.textTheme.bodySmall!,
    );
  }

  /// Section Widget
  Widget _buildTf2() {
    return CustomOutlinedButton(
      height: 24.h,
      text: "msg26".tr,
      margin: EdgeInsets.symmetric(horizontal: 20.h),
      buttonStyle: CustomButtonStyles.outlineGray,
      buttonTextStyle: theme.textTheme.bodySmall!,
    );
  }

  /// Section Widget
  Widget _buildSearchone() {
    return CustomTextFormField(
      controller: controller.searchoneController,
      hintText: "lbl226".tr,
      hintStyle: CustomTextStyles.bodyMediumGray50013,
      textInputAction: TextInputAction.done,
      suffix: Padding(
        padding: EdgeInsets.fromLTRB(30.h, 12.h, 12.h, 12.h),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomImageView(
              imagePath: ImageConstant.imgUuploadalt,
              height: 24.h,
              width: 24.h,
              margin: EdgeInsets.symmetric(horizontal: 30.h, vertical: 12.h),
            ),
            CustomImageView(
              imagePath: ImageConstant.imgMenu,
              height: 24.h,
              width: 24.h,
            ),
            CustomImageView(
              imagePath: ImageConstant.imgSend,
              height: 24.h,
              width: 24.h,
            ),
          ],
        ),
      ),
      suffixConstraints: BoxConstraints(maxHeight: 48.h),
      contentPadding: EdgeInsets.only(left: 16.h, top: 12.h, bottom: 12.h),
      borderDecoration: TextFormFieldStyleHelper.fillWhiteA,
      fillColor: appTheme.whiteA700,
    );
  }

  /// Common widget
  Widget _buildColumnfileOne({required String fileOne, required String one}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomImageView(imagePath: fileOne, height: 24.h, width: 24.h),
        Text(
          one,
          style: theme.textTheme.labelMedium!.copyWith(color: appTheme.gray500),
        ),
      ],
    );
  }

  /// Common widget
  Widget _buildRowfiwindOne({required String fiwindOne, required String one}) {
    return Row(
      children: [
        CustomImageView(imagePath: fiwindOne, height: 16.h, width: 16.h),
        Padding(
          padding: EdgeInsets.only(left: 8.h),
          child: Text(
            one,
            style: theme.textTheme.labelLarge!.copyWith(
              color: theme.colorScheme.errorContainer,
            ),
          ),
        ),
      ],
    );
  }
}
