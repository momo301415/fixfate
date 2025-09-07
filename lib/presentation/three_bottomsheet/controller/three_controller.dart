import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../models/three_model.dart';

/// A controller class for the TwoBottomsheet.
///
/// This class manages the state of the TwoBottomsheet, including the
/// current twoModelObj
class ThreeController extends GetxController {
  Rx<ThreeModel> twoModelObj = ThreeModel().obs;
  final TextEditingController pieceController = TextEditingController();
}
