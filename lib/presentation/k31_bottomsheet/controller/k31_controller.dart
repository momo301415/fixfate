import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../models/k31_model.dart';

/// A controller class for the K31Bottomsheet.
///
/// This class manages the state of the K31Bottomsheet, including the
/// current k31ModelObj
class K31Controller extends GetxController {
  Rx<K31Model> k31ModelObj = K31Model().obs;
}
