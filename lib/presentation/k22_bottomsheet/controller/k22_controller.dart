import '../../../core/app_export.dart';
import '../models/k22_model.dart';

/// 自訂生日選擇器 Controller
class K22Controller extends GetxController {
  Rx<K22Model> k22ModelObj = K22Model().obs;

  RxInt selectedYear = 1994.obs;
  RxInt selectedMonth = 5.obs;
  RxInt selectedDay = 31.obs;

  List<int> get years {
    final currentYear = DateTime.now().year;
    return List.generate(currentYear - 1900 + 1, (index) => 1900 + index);
  }

  List<int> get months => List.generate(12, (index) => index + 1);

  List<int> get days {
    final year = selectedYear.value;
    final month = selectedMonth.value;
    final lastDay = DateTime(year, month + 1, 0).day;
    if (selectedDay.value > lastDay) {
      selectedDay.value = lastDay;
    }
    return List.generate(lastDay, (index) => index + 1);
  }

  void updateDayOnMonthYearChange() {
    final maxDay = DateTime(selectedYear.value, selectedMonth.value + 1, 0).day;
    if (selectedDay.value > maxDay) {
      selectedDay.value = maxDay;
    }
  }

  String getFormattedDate() {
    final y = selectedYear.value;
    final m = selectedMonth.value.toString().padLeft(2, '0');
    final d = selectedDay.value.toString().padLeft(2, '0');
    return "$y.$m.$d";
  }
}
