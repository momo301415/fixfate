import '../../../core/app_export.dart';

/// This class defines the variables used in the [k67_screen],
/// and is typically used to hold data that is passed between different parts of the application.
class K67Model {
  Rx<List<ItemModel>> itemList = Rx([]);
}

class ItemModel {
  ItemModel({
    this.two,
    this.tf,
    this.path,
    this.isAlert,
    this.familyId,
  }) {
    two = two ?? Rx("lbl204".tr);
    tf = tf ?? Rx("msg_2023_03_24".tr);
    path = path ?? Rx(ImageConstant.imgEllipse8296x96);
    isAlert = isAlert ?? Rx(false);
    familyId = familyId ?? Rx("");
  }

  Rx<String>? two;

  Rx<String>? tf;

  Rx<String>? path;

  Rx<bool>? isAlert;

  Rx<String>? familyId;
}
