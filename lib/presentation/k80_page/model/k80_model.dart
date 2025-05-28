import 'package:pulsedevice/presentation/k80_page/model/list_item_model.dart';

import '../../../core/app_export.dart';

/// This class defines the variables used in the [k80_page],
/// and is typically used to hold data that is passed between different parts of the application.
class K80Model {
  Rx<List<ListRecordItemModel>> listItemList = Rx([]);

  Rx<List<ListHistoryItemModel>> listItemList2 = Rx([]);
}
