import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:pulsedevice/core/utils/date_time_utils.dart';
import 'package:pulsedevice/presentation/k13_screen/widgets/nutrition_card_widget.dart';
import 'package:pulsedevice/presentation/one_bottomsheet/controller/one_controller.dart';
import '../../../core/app_export.dart';
import '../../../core/utils/dialog_utils.dart';
import '../../eight_dialog/controller/eight_controller.dart';
import '../../eight_dialog/eight_dialog.dart';
import '../../k1_dialog/controller/k1_controller.dart';
import '../../k1_dialog/k1_dialog.dart';
import '../../one_bottomsheet/one_bottomsheet.dart';
import '../../six_dialog/controller/six_controller.dart';
import '../../six_dialog/six_dialog.dart';
import '../../three_bottomsheet/controller/three_controller.dart';
import '../../three_bottomsheet/three_bottomsheet.dart';
import '../../two_bottomsheet/controller/two_controller.dart';
import '../../two_bottomsheet/two_bottomsheet.dart';
import '../models/k2_model.dart';

/// A controller class for the K2Screen.
///
/// This class manages the state of the K2Screen, including the
/// current k2ModelObj
class EditYsController extends GetxController {
  late NutritionCardData nutritionData;
  final formKey = GlobalKey<FormState>();
  var typeData = "".obs;
  var foodNameData = "".obs;
  final RxList<FoodTypeData> typeListData = <FoodTypeData>[].obs;
  Rx<DateTime> dayData = DateTime.now().obs;
  Rx<DateTime> timeData = DateTime.now().obs;
  var calorieValueData = 0.0.obs;
  var carbohydrateValueData = 0.0.obs;
  var fatValueData = 0.0.obs;
  var fiberValueData = 0.0.obs;
  var imagePathData = "".obs;
  var numberData = 0.obs;
  var kcalData = 0.obs;
  var pieceData = "".obs;


  @override
  void onInit() {
    super.onInit();
    var data = Get.arguments;
    if(data!=null){
      nutritionData = Get.arguments as NutritionCardData;
      // 初始化obs变量
      _initializeObservables(nutritionData);
    }
  }
  // 初始化obs变量的方法
  void _initializeObservables(nutritionData) {
    if(nutritionData==null) return;
    typeData.value = nutritionData.getType(nutritionData.type);
    foodNameData.value = nutritionData.foodName;
    // dayData.value =  DateTime.parse(nutritionData.day??"");
    // timeData.value = DateTime.parse(nutritionData.time??"");
    typeListData.value = nutritionData.data;
    dayData.value =  DateTime.now();
    timeData.value = DateTime.now();
    imagePathData.value = nutritionData.imagePath;
    numberData.value = nutritionData.number;
    kcalData.value = nutritionData.kcal;
    pieceData.value = nutritionData.piece;
  }

  Rx<K2Model> k2ModelObj = K2Model().obs;

  Future<void> showInputFoodName() async {
    final result = await DialogHelper.showCustomDialog(
        Get.context!, K1Dialog("lbl407".tr,Get.put(K1Controller())));
    print(result);
    if (result != null && result.isNotEmpty) {
      foodNameData.value = result;
    }
  }

  Future<void> showInputFoodNumber() async {
    final result = await DialogHelper.showCustomDialog(
        Get.context!, K1Dialog("lbl334".tr,Get.put(K1Controller())));
    print(result);
    if (result != null && result.isNotEmpty) {
      numberData.value = int.parse(result);
    }
  }

  Future<void> showInputFoodPiece() async {
    final result = await DialogHelper.showCustomBottomSheet(
        Get.context!, TwoBottomsheet(Get.put(TwoController())));
    if (result != null && result.isNotEmpty) {
      pieceData.value = result;
    }
  }

  Future<void> showInputKcal() async {
    final result = await DialogHelper.showCustomDialog(
        Get.context!, SixDialog(Get.put(SixController())));
    if (result != null && result.isNotEmpty) {
      kcalData.value = int.parse(result);
    }
  }

  Future<dynamic> showBottomFoodName() async {
    return await DialogHelper.showCustomBottomSheet(
        Get.context!, ThreeBottomsheet(Get.put(ThreeController())));
  }

  Future<dynamic> showFoodKG(name) async {
    return await DialogHelper.showCustomBottomSheet(
        Get.context!, EightDialog(name ?? "",Get.put(EightController())));
  }

  Future<dynamic> showMealCategorySelection() async {
    final result = await DialogHelper.showCustomBottomSheet(
        Get.context!, OneBottomsheet(Get.put(OneController())));
     if (result != null && result.isNotEmpty) {
       typeData.value = result;
     }
  }

  Future<dynamic> showDatePicker() async {
    DatePicker.showDatePicker(Get.context!,
        showTitleActions: true,
        minTime: DateTime(2025, 8, 20),
        maxTime: DateTime(2099, 12, 30),
        onChanged: (date) {
          print('change $date');
        }, onConfirm: (date) {
          print('confirm $date');
          dayData.value = date;
        }, currentTime: DateTime.now(), locale: LocaleType.zh);
  }

  Future<dynamic> showTimePicker() async {
    DatePicker.showTimePicker(Get.context!,
        showTitleActions: true, onChanged: (date) {
          print('change $date in time zone ' +
              date.timeZoneOffset.inHours.toString());
        }, onConfirm: (date) {
          timeData.value = date;
          print('confirm ${date.format(pattern:"H:m:s")}');
        }, currentTime: DateTime.now(),locale: LocaleType.zh);
    // DatePicker.showDatePicker(Get.context!,
    //     showTitleActions: true,
    //     minTime: DateTime(2025, 8, 20),
    //     maxTime: DateTime(2099, 12, 30),
    //     onChanged: (date) {
    //       print('change $date');
    //     }, onConfirm: (date) {
    //       print('confirm $date');
    //     }, currentTime: DateTime.now(), locale: LocaleType.zh);
  }


  void saveChanges() {
    final updatedData = nutritionData.copyWith(
      time: dayData.value.format(pattern: "H:s"),
    );
    foodNameData = "".obs;
    imagePathData = "".obs;
    numberData = 0.obs;
    kcalData = 0.obs;
    pieceData = "".obs;
    // 返回更新后的数据
    Get.back(result: updatedData);
  }

  void cancel() {
    Get.back(); // 不返回数据
  }


    @override
  void onClose() {
    super.onClose();
  }

}
