import 'package:flutter/material.dart';
import 'package:pulsedevice/presentation/k34_dialog/k34_dialog.dart';
import 'package:pulsedevice/presentation/k36_screen/widgets/k34_dialog.dart';
import '../../../core/app_export.dart';
import '../models/k36_model.dart';

/// A controller class for the K36Screen.
///
/// This class manages the state of the K36Screen, including the
/// current k36ModelObj
class K36Controller extends GetxController {
  Rx<K36Model> k36ModelObj = K36Model().obs;
  var isAutoComfirn = false.obs;
  var isComfirnNot = false.obs;

  void showDeteleialog() {
    showDialog(context: Get.context!, builder: (builder){
      return K34DeleteDialog();
    });
   
  }
}
