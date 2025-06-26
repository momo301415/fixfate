import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import '../../../core/app_export.dart';
import '../models/k19_model.dart';

/// A controller class for the K19Screen.
///
/// This class manages the state of the K19Screen, including the
/// current k19ModelObj
class K19Controller extends GetxController {
  TextEditingController searchoneController = TextEditingController();

  Rx<K19Model> k19ModelObj = K19Model().obs;

  Rx<types.User> chatUser = Rx(types.User(id: 'RECEIVER_USER'));

  Rx<List<types.Message>> messageList = Rx([
    types.TextMessage(
      type: types.MessageType.text,
      id: '2147:58298',
      author: types.User(id: 'RECEIVER_USER'),
      text: "異常",
      status: types.Status.delivered,
      createdAt: 1750846103480,
    ),
    types.TextMessage(
      type: types.MessageType.text,
      id: '2147:58322',
      author: types.User(id: 'SENDER_USER'),
      text: "異常",
      status: types.Status.delivered,
      createdAt: 1750846103480,
    ),
  ]);

  @override
  void onClose() {
    super.onClose();
    searchoneController.dispose();
  }
}
