import 'package:pulsedevice/presentation/k13_screen/widgets/selection_popup_model.dart';

import '../../../core/app_export.dart';


/// This class defines the variables used in the [k13_screen],
/// and is typically used to hold data that is passed between different parts of the application.

// ignore_for_file: must_be_immutable
class K13Model {
  Rx<List<SelectionPopupModel>> dropdownItemList = Rx([
    SelectionPopupModel(id: 1, title: "Item One", isSelected: true),
    SelectionPopupModel(id: 2, title: "Item Two"),
    SelectionPopupModel(id: 3, title: "Item Three"),
  ]);
}
