import '../../../core/app_export.dart';
import 'gridframe_item_model.dart';

/// This class defines the variables used in the [k89_bottomsheet],
/// and is typically used to hold data that is passed between different parts of the application.

// ignore_for_file: must_be_immutable
class K89Model {
  Rx<List<GridframeItemModel>> gridframeItemList = Rx([
    GridframeItemModel(frame: "lbl_01".tr.obs),
    GridframeItemModel(frame: "lbl_02".tr.obs),
    GridframeItemModel(frame: "lbl_03".tr.obs),
    GridframeItemModel(frame: "lbl_04".tr.obs),
    GridframeItemModel(frame: "lbl_05".tr.obs),
    GridframeItemModel(frame: "lbl_06".tr.obs),
    GridframeItemModel(frame: "lbl_07".tr.obs),
    GridframeItemModel(frame: "lbl_08".tr.obs),
    GridframeItemModel(frame: "lbl_09".tr.obs),
    GridframeItemModel(frame: "lbl_103".tr.obs),
    GridframeItemModel(frame: "lbl_112".tr.obs),
    GridframeItemModel(frame: "lbl_122".tr.obs)
  ]);
}
