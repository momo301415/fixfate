import 'package:get/get.dart';

class ListRecordItemModel {
  Rx<String>? label;
  Rx<String>? type;
  Rx<String>? value;
  Rx<DateTime>? time;
  Rx<String>? unit;
  ListRecordItemModel(
      {this.label, this.type, this.value, this.time, this.unit});
}

class ListHistoryItemModel {
  Rx<String>? value;
  Rx<String>? unit;
  Rx<DateTime>? time;
  ListHistoryItemModel({this.value, this.unit, this.time});
}
