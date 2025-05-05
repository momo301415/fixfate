import 'package:pulsedevice/presentation/k40_screen/models/listpulsering_item_model.dart';

import '../../../core/app_export.dart';

/// This class defines the variables used in the [k40_screen],
/// and is typically used to hold data that is passed between different parts of the application.
class K40Model {
  Rx<List<ListpulseringItemModel>> listpulseringItemList = Rx([]);
}
