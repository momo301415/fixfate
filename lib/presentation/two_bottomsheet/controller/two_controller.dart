import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../models/two_model.dart';

/// A controller class for the TwoBottomsheet.
///
/// This class manages the state of the TwoBottomsheet, including the
/// current twoModelObj
class TwoController extends GetxController {
  Rx<TwoModel> twoModelObj = TwoModel().obs;
  final TextEditingController pieceController = TextEditingController();
}
