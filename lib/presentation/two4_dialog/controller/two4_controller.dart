import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../models/two4_model.dart';

/// A controller class for the Two4Dialog.
///
/// This class manages the state of the Two4Dialog, including the
/// current two4ModelObj
class Two4Controller extends GetxController {
  Rx<Two4Model> two4ModelObj = Two4Model().obs;
}
