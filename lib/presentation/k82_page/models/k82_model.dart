import 'package:pulsedevice/presentation/k82_page/models/list_item_model.dart';

import '../../../core/app_export.dart';

/// This class defines the variables used in the [k82_screen],
/// and is typically used to hold data that is passed between different parts of the application.
class K82Model {
  Rx<List<ListRecordItemModel>> listItemList = Rx([]);

  Rx<List<ListHistoryItemModel>> listItemList2 = Rx([]);
}
