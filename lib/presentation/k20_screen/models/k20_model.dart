import 'package:pulsedevice/presentation/k20_screen/models/chat_message_model.dart';

import '../../../core/app_export.dart';
import 'list1_item_model.dart';
import 'list2_item_model.dart';
import 'list_item_model.dart';

/// This class defines the variables used in the [k20_screen],
/// and is typically used to hold data that is passed between different parts of the application.

// ignore_for_file: must_be_immutable
class K20Model {
  Rx<List<ListItemModel>> listItemList = Rx([
    ListItemModel(two: "lbl311".tr.obs),
    ListItemModel(two: "lbl312".tr.obs),
  ]);

  Rx<List<List1ItemModel>> list1ItemList = Rx([
    List1ItemModel(two: "lbl313".tr.obs),
    List1ItemModel(two: "lbl314".tr.obs),
  ]);

  Rx<List<List2ItemModel>> list2ItemList = Rx([
    List2ItemModel(tf: "lbl315".tr.obs),
    List2ItemModel(tf: "msg27".tr.obs),
    List2ItemModel(tf: "msg28".tr.obs),
    List2ItemModel(tf: "lbl311".tr.obs),
  ]);

  RxList<ChatMessageModel> listItems = <ChatMessageModel>[].obs;

  K20Model({List<ChatMessageModel>? initialItems}) {
    if (initialItems != null) {
      listItems.value = initialItems;
    }
  }

  factory K20Model.fromJson(Map<String, dynamic> json) {
    final List<dynamic> history = json['history'] ?? [];
    final List<ChatMessageModel> items = history
        .map((e) => ChatMessageModel.fromJson(e as Map<String, dynamic>))
        .toList();
    return K20Model(initialItems: items);
  }
}
