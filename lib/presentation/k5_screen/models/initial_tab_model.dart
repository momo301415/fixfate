import '../../../core/app_export.dart';
import 'listeightysix_item_model.dart';

/// This class is used in the [initial_tab_page] screen.

// ignore_for_file: must_be_immutable
class InitialTabModel {
  Rx<List<ListeightysixItemModel>> listeightysixItemList = Rx([
    ListeightysixItemModel(
      image: ImageConstant.imgFavoriteWhiteA700.obs,
      eightysix: "lbl_862".tr.obs,
      bpm: "lbl_bpm".tr.obs,
    ),
    ListeightysixItemModel(
      image: ImageConstant.imgURulerWhiteA700.obs,
      eightysix: "lbl_1_320".tr.obs,
      bpm: "lbl193".tr.obs,
    ),
    ListeightysixItemModel(
      image: ImageConstant.imgSettings.obs,
      eightysix: "lbl_1_536".tr.obs,
      bpm: "lbl187".tr.obs,
    ),
  ]);
}
