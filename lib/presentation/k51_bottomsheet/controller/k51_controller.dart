import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../models/k51_model.dart';

/// A controller class for the K51Bottomsheet.
///
/// This class manages the state of the K51Bottomsheet, including the
/// current k51ModelObj
class K51Controller extends GetxController {
  Rx<K51Model> k51ModelObj = K51Model().obs;
}
