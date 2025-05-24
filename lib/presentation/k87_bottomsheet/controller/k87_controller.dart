import '../../../core/app_export.dart';
import '../models/k87_model.dart';

/// A controller class for the K87Bottomsheet.
///
/// This class manages the state of the K87Bottomsheet, including the
/// current k87ModelObj
class K87Controller extends GetxController {
  RxList<DateTime?> selectedDatesFromCalendar = <DateTime?>[].obs;

  void setInitialDate(DateTime date) {
    selectedDatesFromCalendar.value = [date];
  }
}
