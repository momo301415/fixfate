import '../../../core/app_export.dart';
import 'list_one_item_model.dart';

/// This class defines the variables used in the [k29_page],
/// and is typically used to hold data that is passed between different parts of the application.

// ignore_for_file: must_be_immutable
class K29Model {
  Rx<List<ListOneItemModel>> listOneItemList = Rx([
    ListOneItemModel(one: ImageConstant.img102.obs, two: "lbl58".tr.obs),
    ListOneItemModel(one: ImageConstant.img10280x80.obs, two: "lbl59".tr.obs),
    ListOneItemModel(two: "lbl60".tr.obs)
  ]);
}
