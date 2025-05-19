import 'package:get/get_rx/src/rx_types/rx_types.dart';

class ListViewItemModel {
  ListViewItemModel({
    this.icon,
    this.label,
    this.value,
    this.unit,
    this.loadTime,
    this.isAlert,
  });

  /// 資料圖示 Icon Path（SVG）
  Rx<String>? icon;

  /// 資料標題（例如：心率）
  Rx<String>? label;

  /// 資料值（例如：79）
  Rx<String>? value;

  /// 單位（例如：次/分鐘）
  Rx<String>? unit;

  /// 幾分鐘前（例如：1分鐘前）
  Rx<String>? loadTime;

  /// 是否為異常狀態（顯示紅色標記）
  Rx<bool>? isAlert;
}
