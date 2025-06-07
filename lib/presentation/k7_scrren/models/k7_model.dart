import '../../../core/app_export.dart';
import 'list_one_item_model.dart';

/// This class defines the variables used in the [k7_screen],
/// and is typically used to hold data that is passed between different parts of the application.

// ignore_for_file: must_be_immutable
class K7Model {
  Rx<List<ListOneItemModel>> listOneItemList = Rx([
    ListOneItemModel(two: "lbl760".tr.obs, bpm: "msg_7075_03_71_16_70".tr.obs),
    ListOneItemModel(),
    ListOneItemModel(),
    ListOneItemModel(),
    ListOneItemModel(),
  ]);
}
