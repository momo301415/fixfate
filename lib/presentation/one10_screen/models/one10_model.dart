import '../../../core/app_export.dart';
import 'list_one_item_model.dart';

/// This class defines the variables used in the [one10_screen],
/// and is typically used to hold data that is passed between different parts of the application.

// ignore_for_file: must_be_immutable
class One10Model {
  Rx<List<ListOneItemModel>> listOneItemList = Rx([
    ListOneItemModel(two: "lbl204".tr.obs, tf: "msg_2023_03_24".tr.obs),
    ListOneItemModel(two: "lbl205".tr.obs, tf: "msg_2023_03_24".tr.obs),
    ListOneItemModel(two: "lbl206".tr.obs, tf: "msg_2023_03_24".tr.obs),
    ListOneItemModel(two: "lbl207".tr.obs, tf: "msg_2023_03_24".tr.obs),
    ListOneItemModel(two: "lbl208".tr.obs, tf: "msg_2023_03_24".tr.obs)
  ]);
}
