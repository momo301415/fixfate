import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../models/k50_model.dart';

/// A controller class for the K50Bottomsheet.
///
/// This class manages the state of the K50Bottomsheet, including the
/// current k50ModelObj
class K50Controller extends GetxController {
  Rx<K50Model> k50ModelObj = K50Model().obs;
}
