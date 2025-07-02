import 'package:flutter/material.dart';
import 'package:pulsedevice/presentation/k19_screen/models/chat_message_model.dart';
import '../../core/app_export.dart';
import '../../widgets/app_bar/appbar_leading_image.dart';
import '../../widgets/app_bar/appbar_title_one.dart';
import '../../widgets/app_bar/appbar_trailing_image.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_text_form_field.dart';
import 'controller/k19_controller.dart'; // ignore_for_file: must_be_immutable

/// 諮詢頁面--預設首頁
class K19Screen extends GetWidget<K19Controller> {
  const K19Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final deviceHeight = mediaQuery.size.height;
    var deviceH = 0;
    if (deviceHeight >= 600 && deviceHeight <= 700) {
      deviceH = 30;
    } else if (deviceHeight > 700 && deviceHeight <= 800) {
      deviceH = 50;
    } else if (deviceHeight > 800 && deviceHeight <= 900) {
      deviceH = 70;
    } else if (deviceHeight > 900) {
      deviceH = 70;
    }
    return Obx(() {
      if (controller.cc.isK19Visible.value) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          controller.ensureWebSocketConnected();
        });
      }

      return _buildScaffold(deviceH); // 這是你原本那段畫面邏輯抽成的 method
    });
  }

  Widget _buildScaffold(int bottomHeight) {
    return Scaffold(
      backgroundColor: appTheme.teal50,
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          // 背景圖片
          Positioned.fill(
            bottom: bottomHeight.h,
            child: CustomImageView(
              imagePath: ImageConstant.imgUnion772x374,
              fit: BoxFit.fill,
            ),
          ),
          SafeArea(
            top: true,
            child: Column(
              children: [
                // Header
                Padding(
                  padding: EdgeInsets.only(top: 30.h, left: 16.h, right: 16.h),
                  child: _buildAppbar(),
                ),
                SizedBox(height: 16.h),

                // 對話區塊（白底 + 自動滾動）
                Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 16.h),
                    decoration: AppDecoration.outlineGray90066.copyWith(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Obx(() {
                      final messages = controller.messages;
                      final presetWidgets = [
                        _buildRowmusicone(),
                        SizedBox(height: 24.h),
                        _buildRowfiwindOne(
                          fiwindOne: ImageConstant.imgUChartLine,
                          one: "lbl336".tr,
                        ),
                        SizedBox(height: 12.h),
                        _buildBubble("msg21".tr),
                        _buildBubble("msg22".tr),
                        SizedBox(height: 24.h),
                        _buildRowfiwindOne(
                          fiwindOne: ImageConstant.imgFiWind,
                          one: "lbl337".tr,
                        ),
                        SizedBox(height: 12.h),
                        _buildBubble("msg23".tr),
                        _buildBubble("msg24".tr),
                        SizedBox(height: 24.h),
                        _buildRowfiwindOne(
                          fiwindOne: ImageConstant.imgFiBookOpen,
                          one: "lbl338".tr,
                        ),
                        SizedBox(height: 12.h),
                        _buildBubble("msg25".tr),
                        _buildBubble("msg26".tr),
                      ];

                      if (controller.isHistoryLoading.value) {
                        return Center(child: CircularProgressIndicator());
                      }

                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        controller.scrollToBottom();
                      });

                      return ListView.builder(
                        controller: controller.scrollController,
                        padding: EdgeInsets.all(16.h),
                        itemCount: presetWidgets.length + messages.length,
                        itemBuilder: (context, index) {
                          if (index < presetWidgets.length) {
                            return presetWidgets[index];
                          }

                          final msg = messages[index - presetWidgets.length];
                          return msg.isUser
                              ? Align(
                                  alignment: Alignment.centerRight,
                                  child: _buildChatBubble(msg),
                                )
                              : _buildAiBubbleWithFeedback(msg);
                        },
                      );
                    }),
                  ),
                ),

                // 輸入欄
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.h, vertical: 16.v),
                  child: _buildSearchone(),
                ),

                SizedBox(height: 16.h),

                // 關閉對話按鈕
                _closeChat(),

                SizedBox(height: 12.h),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBubble(String text) {
    return GestureDetector(
        onTap: () {
          controller.searchoneController.text = text;
          controller.sendUserMessage();
        },
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 4.h, horizontal: 8.h),
          padding: EdgeInsets.symmetric(horizontal: 12.h, vertical: 6.h),
          decoration: BoxDecoration(
            color: Colors.white, // 建議明確設背景色，否則可能看不到陰影效果
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1), // 陰影顏色與透明度
                blurRadius: 4, // 模糊程度
                offset: Offset(0, 2), // 陰影位移 (x, y)
              ),
            ],
          ),
          child: Text(text, style: theme.textTheme.bodySmall),
        ));
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
          onTap: () {
            controller.goK20Screen();
          },
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

  /// 輸入匡
  Widget _buildSearchone() {
    return CustomTextFormField(
      controller: controller.searchoneController,
      hintText: "lbl226".tr,
      hintStyle: CustomTextStyles.bodyMediumGray50013,
      textInputAction: TextInputAction.done,
      suffix: Padding(
        padding: EdgeInsets.only(right: 8.h), // 整體右側留點空間
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 上傳圖示
            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 4.h),
            //   child: CustomImageView(
            //     imagePath: ImageConstant.imgUuploadalt,
            //     height: 24.h,
            //     width: 24.h,
            //   ),
            // ),

            // // 功能選單圖示
            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 4.h),
            //   child: CustomImageView(
            //     imagePath: ImageConstant.imgMenu,
            //     height: 24.h,
            //     width: 24.h,
            //   ),
            // ),

            // 傳送按鈕
            Padding(
              padding: EdgeInsets.only(left: 8.h), // 與前兩個圖示稍拉開
              child: GestureDetector(
                onTap: () {
                  print("send message");
                  controller.sendUserMessage();
                },
                child: Container(
                  width: 40.h,
                  height: 40.h,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: CustomImageView(
                      imagePath: ImageConstant.imgSend,
                      height: 17.h,
                      width: 17.h,
                    ),
                  ),
                ),
              ),
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

  /// 通用預設widget
  Widget _buildRowfiwindOne({required String fiwindOne, required String one}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.h),
      child: Row(
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
      ),
    );
  }

  /// 關閉chat事件
  Widget _closeChat() {
    return GestureDetector(
        onTap: () {
          controller.onClosePressed();
        },
        child: Padding(
          padding: EdgeInsets.only(top: 8.h, bottom: 8.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                "lbl330".tr,
                style: CustomTextStyles.bodyMediumPrimary15,
              ),
              CustomImageView(
                imagePath: ImageConstant.imgArrowUp,
                height: 20.h,
                width: 20.h,
              ),
            ],
          ),
        ));
  }

  /// 使用者的發話泡泡
  Widget _buildChatBubble(ChatMessageModel message) {
    final isUser = message.isUser;

    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8.h),
        padding: EdgeInsets.symmetric(horizontal: 12.h, vertical: 8.h),
        constraints: BoxConstraints(maxWidth: 260.h),
        decoration: BoxDecoration(
          color: isUser ? theme.colorScheme.primary : appTheme.gray200,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
            bottomLeft: Radius.circular(isUser ? 12 : 0),
            bottomRight: Radius.circular(isUser ? 0 : 12),
          ),
        ),
        child: Text(
          message.text,
          style: TextStyle(
            color: isUser ? Colors.white : Colors.black87,
            fontSize: 13,
          ),
        ),
      ),
    );
  }

  /// AI 的回覆泡泡
  Widget _buildAiBubbleWithFeedback(ChatMessageModel message) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 左側 AI icon
        Padding(
          padding: EdgeInsets.only(top: 4.h),
          child: CustomImageView(
            imagePath: ImageConstant.imgMusicPrimary, // 換成 AI LOGO 圖示
            height: 24.h,
            width: 24.h,
          ),
        ),
        SizedBox(width: 8.h),

        // 右側內容
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 回覆泡泡
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.h, vertical: 8.h),
                decoration: BoxDecoration(
                  color: appTheme.gray200,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  message.text,
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 13,
                  ),
                ),
              ),
              SizedBox(height: 4.h),

              // 互動按鈕列
              Row(
                children: [
                  _buildFeedbackButton(
                    label: "lbl333".tr,
                    imagePath: ImageConstant.imgFeedbackGood,
                    feedbackType: 1,
                    message: message,
                    onFeedbackTap: _onFeedbackAndSendMessage,
                  ),
                  SizedBox(width: 4.h),
                  _buildFeedbackButton(
                      label: "lbl334".tr,
                      imagePath: ImageConstant.imgFeedbackSoso,
                      feedbackType: 2,
                      message: message,
                      onFeedbackTap: _onFeedbackAndSendMessage),
                  SizedBox(width: 4.h),
                  _buildFeedbackButton(
                      label: "lbl335".tr,
                      imagePath: ImageConstant.imgFeedbackBad,
                      feedbackType: 0,
                      message: message,
                      onFeedbackTap: _onFeedbackAndSendMessage),
                ],
              )
            ],
          ),
        )
      ],
    );
  }

  Widget _buildFeedbackButton({
    required String label,
    required String imagePath,
    required int feedbackType, // 0: 差, 1: 好, 2: 還好
    required ChatMessageModel message,
    required void Function(String text, int rating)? onFeedbackTap,
  }) {
    final isSelected = message.feedbackRating == feedbackType;

    // 動態樣式
    late Color borderColor;
    late Color textColor;
    late Color? iconColor;

    switch (feedbackType) {
      case 0: // 不好
        borderColor = isSelected ? Colors.red : appTheme.gray300;
        textColor = isSelected ? Colors.red : appTheme.gray600;
        iconColor = isSelected ? Colors.red : null;
        break;
      case 1: // 好
        borderColor = isSelected ? Colors.green : appTheme.gray300;
        textColor = isSelected ? Colors.green : appTheme.gray600;
        iconColor = isSelected ? Colors.green : null;
        break;
      case 2: // 還好
        borderColor = isSelected ? Colors.orange : appTheme.gray300;
        textColor = isSelected ? Colors.orange : appTheme.gray600;
        iconColor = isSelected ? Colors.orange : null;
        break;
      default:
        borderColor = appTheme.gray300;
        textColor = appTheme.gray600;
        iconColor = null;
    }

    return GestureDetector(
      onTap: () {
        onFeedbackTap?.call(label, feedbackType);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 6.h, vertical: 4.h),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: borderColor),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            CustomImageView(
              imagePath: imagePath,
              height: 16.h,
              width: 16.h,
              color: iconColor, // ✅ 只有選中才加顏色
            ),
            SizedBox(width: 4.h),
            Text(
              label,
              style: TextStyle(fontSize: 11, color: textColor),
            ),
          ],
        ),
      ),
    );
  }

  void _onFeedbackAndSendMessage(String text, int rating) {
    print("Feedback: $text, Rating: $rating");
    controller.sendUserMessageByFeedback(text, rating);
  }
}
