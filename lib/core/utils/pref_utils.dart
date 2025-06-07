import 'package:shared_preferences/shared_preferences.dart';

// ignore_for_file: must_be_immutable
class PrefUtils {
  PrefUtils() {
    SharedPreferences.getInstance().then((value) {
      _sharedPreferences = value;
    });
  }

  static SharedPreferences? _sharedPreferences;

  Future<void> init() async {
    _sharedPreferences ??= await SharedPreferences.getInstance();
    print('SharedPreference Initialized');
  }

  ///will clear all the data stored in preference
  void clearPreferencesData() async {
    _sharedPreferences!.clear();
  }

  Future<void> setThemeData(String value) {
    return _sharedPreferences!.setString('themeData', value);
  }

  String getThemeData() {
    try {
      return _sharedPreferences!.getString('themeData')!;
    } catch (e) {
      return 'primary';
    }
  }

  /// set user id
  Future<void> setUserId(String userId) {
    return _sharedPreferences!.setString('currentUserId', userId);
  }

  /// set user password
  Future<void> setPassword(String password) {
    return _sharedPreferences!.setString('currentPassword', password);
  }

  /// api user id
  Future<void> setApiUserId(String usrid) {
    return _sharedPreferences!.setString('apiUserId', usrid);
  }

  /// 第一次sync資料到api
  Future<void> setIsSyncApi(String isSyncApi) {
    return _sharedPreferences!.setString('isSyncApi', isSyncApi);
  }

  String getUserId() {
    try {
      return _sharedPreferences!.getString('currentUserId')!;
    } catch (e) {
      return '';
    }
  }

  String getPassword() {
    try {
      return _sharedPreferences!.getString('currentPassword')!;
    } catch (e) {
      return '';
    }
  }

  String getApiUserId() {
    try {
      return _sharedPreferences!.getString('apiUserId')!;
    } catch (e) {
      return '';
    }
  }

  String getIsSyncApi() {
    try {
      return _sharedPreferences!.getString('isSyncApi')!;
    } catch (e) {
      return '';
    }
  }
}
