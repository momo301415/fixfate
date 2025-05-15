import '../../../core/app_export.dart';
import '../models/one7_model.dart';

/// A controller class for the One7Bottomsheet.
///
/// This class manages the state of the One7Bottomsheet, including the
/// current one7ModelObj
class One7Controller extends GetxController {
  Rx<One7Model> one7ModelObj = One7Model().obs;
  var year = DateTime.now().year.obs;
  var month = DateTime.now().month.obs;

  void incrementYear() => year.value++;
  void decrementYear() => year.value--;
  void selectMonth(int m) => month.value = m;
  void resetToToday() {
    final now = DateTime.now();
    year.value = now.year;
    month.value = now.month;
  }
}
