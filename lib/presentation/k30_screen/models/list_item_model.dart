import '../../../core/app_export.dart';

/// This class is used in the [list_item_widget] screen.

// ignore_for_file: must_be_immutable
class ListItemModel {
  ListItemModel({this.tf, this.tf1, this.id}) {
    tf = tf ?? Rx("lbl74".tr);
    tf1 = tf1 ?? Rx("lbl54".tr);
    id = id ?? Rx("");
  }

  Rx<String>? tf;

  Rx<String>? tf1;

  Rx<String>? id;
}

// class ListItemModels {
//   final RxString tf;
//   final RxString tf1;
//   final RxString id;

//   ListItemModels({
//     String tf = "lbl74",
//     String tf1 = "lbl54",
//     String id = "",
//   })  : tf = tf.tr.obs,
//         tf1 = tf1.tr.obs,
//         id = id.obs;
// }
