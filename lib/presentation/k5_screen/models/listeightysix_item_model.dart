import '../../../core/app_export.dart';

/// This class is used in the [listeightysix_item_widget] screen.

// ignore_for_file: must_be_immutable
class ListeightysixItemModel {
  ListeightysixItemModel({this.image, this.eightysix, this.bpm, this.id}) {
    image = image ?? Rx(ImageConstant.imgFavoriteWhiteA700);
    eightysix = eightysix ?? Rx("lbl_862".tr);
    bpm = bpm ?? Rx("lbl_bpm".tr);
    id = id ?? Rx("");
  }

  Rx<String>? image;

  Rx<String>? eightysix;

  Rx<String>? bpm;

  Rx<String>? id;
}
