import 'package:pulsedevice/presentation/k78_page/models/list_item_model.dart';
import '../../../core/app_export.dart';

/// This class defines the variables used in the [k78_page],
/// and is typically used to hold data that is passed between different parts of the application.

// ignore_for_file: must_be_immutable
class K78Model {
  Rx<List<ListRecordItemModel>> listItemList = Rx([]);

  Rx<List<ListHistoryItemModel>> listItemList2 = Rx([]);
}
