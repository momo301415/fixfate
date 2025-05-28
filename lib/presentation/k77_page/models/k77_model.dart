import 'package:pulsedevice/presentation/k77_page/models/list_item_model.dart';

import '../../../core/app_export.dart';

/// This class defines the variables used in the [k77_screen],
/// and is typically used to hold data that is passed between different parts of the application.
class K77Model {
  Rx<List<ListRecordItemModel>> listItemList = Rx([]);

  Rx<List<ListHistoryItemModel>> listItemList2 = Rx([]);
}
