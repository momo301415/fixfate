import 'package:pulsedevice/core/app_export.dart';

/// Checks if string is phone number
bool isValidPhone(String? inputString, {bool isRequired = false}) {
  bool isInputStringValid = false;
  if (!isRequired && (inputString == null ? true : inputString.isEmpty)) {
    isInputStringValid = true;
  }
  if (inputString != null && inputString.isNotEmpty) {
    if (inputString.length > 16 || inputString.length < 6) return false;
    const pattern = r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$';
    final regExp = RegExp(pattern);
    isInputStringValid = regExp.hasMatch(inputString);
  }
  return isInputStringValid;
}

/// Password should have,
/// at least a upper case letter
///  at least a lower case letter
///  at least a digit
///  at least a special character [@#$%^&+=]
///  length of at least 4
/// no white space allowed
bool isValidPassword(String? inputString, {bool isRequired = false}) {
  bool isInputStringValid = false;
  if (!isRequired && (inputString == null ? true : inputString.isEmpty)) {
    isInputStringValid = true;
  }
  if (inputString != null && inputString.isNotEmpty) {
    const pattern =
        r'^(?=.*?[A-Z])(?=(.*[a-z]){1,})(?=(.*[\d]){1,})(?=(.*[\W]){1,})(?!.*\s).{8,}$';
    final regExp = RegExp(pattern);
    isInputStringValid = regExp.hasMatch(inputString);
  }
  return isInputStringValid;
}

String? validPassword(String? inputSyring) {
  if (inputSyring == null || inputSyring.isEmpty)
    return "err_msg_please_enter_password".tr;

  if (inputSyring.length < 8)
    return "err_msg_please_enter_than_8_characters".tr;

  if (!RegExp(r'[A-Z]').hasMatch(inputSyring)) {
    return "err_msg_please_enter_less_upper_case".tr;
  }

  if (!RegExp(r'[a-z]').hasMatch(inputSyring)) {
    return "err_msg_please_enter_less_lower_case".tr;
  }

  if (!RegExp(r'\d').hasMatch(inputSyring)) {
    return "err_msg_please_enter_less_number".tr;
  }

  if (inputSyring.contains(' ')) return "err_msg_please_not_enter_space";
  return null;
}
