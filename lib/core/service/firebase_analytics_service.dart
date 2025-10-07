// import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';

/// Firebase Analytics 服務 - 混合模式架構
/// 第一層：GA4 標準事件
/// 第二層：通用業務事件
/// 第三層：具體語義方法
class FirebaseAnalyticsService {
  static final FirebaseAnalyticsService _instance =
      FirebaseAnalyticsService._internal();
  factory FirebaseAnalyticsService() => _instance;
  FirebaseAnalyticsService._internal();

  static FirebaseAnalyticsService get instance => _instance;

  // late FirebaseAnalytics _analytics;
  bool _isInitialized = false;

  /// 初始化 Firebase Analytics
  Future<void> initialize() async {
    try {
      // _analytics = FirebaseAnalytics.instance;
      _isInitialized = true;

      // 設定分析收集啟用狀態
      // await _analytics.setAnalyticsCollectionEnabled(true);

      if (kDebugMode) {
        print('✅ FirebaseAnalyticsService 初始化成功');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ FirebaseAnalyticsService 初始化失敗: $e');
      }
    }
  }

  /// 檢查是否已初始化
  bool get isInitialized => _isInitialized;

  // ==================== 用戶相關事件 ====================

  /// 設定用戶 ID
  Future<void> setUserId(String userId) async {
    if (!_isInitialized) return;
    try {
      // await _analytics.setUserId(id: userId);
      if (kDebugMode) {
        print('📊 設定用戶 ID: $userId');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ 設定用戶 ID 失敗: $e');
      }
    }
  }

  /// 設定用戶屬性
  Future<void> setUserProperty({
    required String name,
    required String value,
  }) async {
    if (!_isInitialized) return;
    try {
      // await _analytics.setUserProperty(name: name, value: value);
      if (kDebugMode) {
        print('📊 設定用戶屬性: $name = $value');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ 設定用戶屬性失敗: $e');
      }
    }
  }

  // ==================== 第一層：GA4 標準事件 ====================

  /// GA4 標準事件：頁面瀏覽
  Future<void> logScreenView({
    required String screenName,
    String? screenClass,
    Map<String, Object>? parameters,
  }) async {
    if (!_isInitialized) return;
    try {
      // await _analytics.logScreenView(
      //   screenName: screenName,
      //   screenClass: screenClass ?? screenName,
      //   parameters: {
      //     'timestamp': DateTime.now().millisecondsSinceEpoch,
      //     ...?parameters,
      //   },
      // );
      if (kDebugMode) {
        print('📊 [GA4] 頁面瀏覽事件已發送: $screenName');
        print('📊 [GA4] 參數: ${parameters.toString()}');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ 記錄頁面瀏覽失敗: $e');
      }
    }
  }

  /// GA4 標準事件：內容選擇 (按鈕點擊、連結點擊等)
  Future<void> logSelectContent({
    required String contentType,
    required String contentId,
    String? contentName,
    Map<String, Object>? parameters,
  }) async {
    if (!_isInitialized) return;
    try {
      // await _analytics.logSelectContent(
      //   contentType: contentType,
      //   itemId: contentId,
      //   parameters: {
      //     if (contentName != null) 'content_name': contentName,
      //     'timestamp': DateTime.now().millisecondsSinceEpoch,
      //     ...?parameters,
      //   },
      // );
      if (kDebugMode) {
        print('📊 [GA4] 內容選擇事件已發送: $contentType - $contentId');
        print('📊 [GA4] 參數: ${parameters.toString()}');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ 記錄內容選擇失敗: $e');
      }
    }
  }

  /// GA4 標準事件：開始搜尋
  Future<void> logSearch({
    required String searchTerm,
    Map<String, Object>? parameters,
  }) async {
    if (!_isInitialized) return;
    try {
      // await _analytics.logSearch(
      //   searchTerm: searchTerm,
      //   parameters: {
      //     'timestamp': DateTime.now().millisecondsSinceEpoch,
      //     ...?parameters,
      //   },
      // );
      if (kDebugMode) {
        print('📊 記錄搜尋: $searchTerm');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ 記錄搜尋失敗: $e');
      }
    }
  }

  /// GA4 標準事件：登入
  Future<void> logLogin({
    String? loginMethod,
    Map<String, Object>? parameters,
  }) async {
    if (!_isInitialized) return;
    try {
      // await _analytics.logLogin(
      //   loginMethod: loginMethod ?? 'unknown',
      //   parameters: {
      //     'timestamp': DateTime.now().millisecondsSinceEpoch,
      //     ...?parameters,
      //   },
      // );
      if (kDebugMode) {
        print('📊 記錄登入事件: $loginMethod');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ 記錄登入事件失敗: $e');
      }
    }
  }

  /// GA4 標準事件：註冊
  Future<void> logSignUp({
    String? signUpMethod,
    Map<String, Object>? parameters,
  }) async {
    if (!_isInitialized) return;
    try {
      // await _analytics.logSignUp(
      //   signUpMethod: signUpMethod ?? 'unknown',
      //   parameters: {
      //     'timestamp': DateTime.now().millisecondsSinceEpoch,
      //     ...?parameters,
      //   },
      // );
      if (kDebugMode) {
        print('📊 記錄註冊事件: $signUpMethod');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ 記錄註冊事件失敗: $e');
      }
    }
  }

  // ==================== 第二層：通用業務事件 ====================

  /// 通用：頁面瀏覽
  Future<void> logPageView(String pageName, {Map<String, Object>? parameters}) {
    return logScreenView(
      screenName: pageName,
      screenClass: 'page',
      parameters: parameters,
    );
  }

  /// 通用：按鈕點擊
  Future<void> logButtonClick(
    String buttonId, {
    String? pageName,
    String? buttonName,
    Map<String, Object>? parameters,
  }) {
    return logSelectContent(
      contentType: 'button',
      contentId: buttonId,
      contentName: buttonName,
      parameters: {
        if (pageName != null) 'page_name': pageName,
        ...?parameters,
      },
    );
  }

  /// 通用：功能使用
  Future<void> logFeatureUsage({
    required String featureName,
    String? action,
    Map<String, Object>? parameters,
  }) async {
    if (!_isInitialized) return;
    try {
      // await _analytics.logEvent(
      //   name: 'feature_usage',
      //   parameters: {
      //     'feature_name': featureName,
      //     'action': action ?? 'use',
      //     'timestamp': DateTime.now().millisecondsSinceEpoch,
      //     ...?parameters,
      //   },
      // );
      if (kDebugMode) {
        print('📊 記錄功能使用: $featureName - $action');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ 記錄功能使用失敗: $e');
      }
    }
  }

  // ==================== 第三層：具體語義方法 (向後兼容) ====================

  // -------------------- 頁面瀏覽語義方法 --------------------

  /// 登入頁面瀏覽
  Future<void> logViewLoginPage({Map<String, Object>? parameters}) =>
      logPageView('login_page', parameters: parameters);

  /// 註冊帳號頁面瀏覽
  Future<void> logViewSignUpPage({Map<String, Object>? parameters}) =>
      logPageView('sign_up_page', parameters: parameters);

  /// OTP驗證頁面瀏覽
  Future<void> logViewOtpPage({Map<String, Object>? parameters}) =>
      logPageView('otp_page', parameters: parameters);

  /// 使用者條款頁面瀏覽
  Future<void> logViewAcceptTermsPage({
    String? termsType,
    Map<String, Object>? parameters,
  }) =>
      logPageView('accept_terms_page', parameters: {
        'terms_type': termsType ?? 'general',
        ...?parameters,
      });

  /// 個人資料頁面瀏覽
  Future<void> logViewProfilePage({Map<String, Object>? parameters}) =>
      logPageView('profile_page', parameters: parameters);

  /// 用藥提醒設定頁面瀏覽
  Future<void> logViewMedicationPage({Map<String, Object>? parameters}) =>
      logPageView('medication_page', parameters: parameters);

  /// 測量設定頁面瀏覽
  Future<void> logViewMeasurementPage({
    String? measurementType,
    Map<String, Object>? parameters,
  }) =>
      logPageView('measurement_page', parameters: {
        'measurement_type': measurementType ?? 'general',
        ...?parameters,
      });

  /// 目標設定頁面瀏覽
  Future<void> logViewGoalPage({
    String? goalType,
    Map<String, Object>? parameters,
  }) =>
      logPageView('goal_page', parameters: {
        'goal_type': goalType ?? 'general',
        ...?parameters,
      });

  /// 家人管理頁面瀏覽
  Future<void> logViewFamilyMembers({
    int? familyCount,
    Map<String, Object>? parameters,
  }) =>
      logPageView('family_members', parameters: {
        'family_count': familyCount ?? 0,
        ...?parameters,
      });

  /// 家人綁定頁面瀏覽
  Future<void> logViewFamilyBindingPage({Map<String, Object>? parameters}) =>
      logPageView('family_binding_page', parameters: parameters);

  /// 警報紀錄頁面瀏覽
  Future<void> logViewAlertHistory({
    int? alertCount,
    Map<String, Object>? parameters,
  }) =>
      logPageView('alert_history', parameters: {
        'alert_count': alertCount ?? 0,
        ...?parameters,
      });

  /// 通知消息頁面瀏覽
  Future<void> logViewNotificationPage({
    int? notificationCount,
    Map<String, Object>? parameters,
  }) =>
      logPageView('notification_page', parameters: {
        'notification_count': notificationCount ?? 0,
        ...?parameters,
      });

  /// Chatbot頁面瀏覽
  Future<void> logViewChatbotPage({Map<String, Object>? parameters}) =>
      logPageView('chatbot_page', parameters: parameters);

  /// 我的設備頁面瀏覽
  Future<void> logViewMyDevices({
    int? deviceCount,
    Map<String, Object>? parameters,
  }) =>
      logPageView('my_devices', parameters: {
        'device_count': deviceCount ?? 0,
        ...?parameters,
      });

  /// 健康數據頁面瀏覽
  Future<void> logViewHealthHeartrateDataPage({
    String? dataType,
    Map<String, Object>? parameters,
  }) =>
      logPageView('health_data_page', parameters: {
        'data_type': dataType ?? 'heartrate',
        ...?parameters,
      });

  /// 運動監測頁面瀏覽
  Future<void> logViewWorkoutPage({
    String? workoutType,
    Map<String, Object>? parameters,
  }) =>
      logPageView('workout_page', parameters: {
        'workout_type': workoutType ?? 'general',
        ...?parameters,
      });

  /// 運動數據頁面瀏覽
  Future<void> logViewWorkoutDataPage({
    String? workoutId,
    String? workoutType,
    Map<String, Object>? parameters,
  }) =>
      logPageView('workout_data_page', parameters: {
        if (workoutId != null) 'workout_id': workoutId,
        'workout_type': workoutType ?? 'general',
        ...?parameters,
      });

  /// 裝置綁定頁面瀏覽
  Future<void> logViewDevicePairingPage({Map<String, Object>? parameters}) =>
      logPageView('device_pairing_page', parameters: parameters);

  /// K77 心率頁面瀏覽
  Future<void> logViewHeartRatePage({
    String? heartRateValue,
    bool? hasAlert,
    Map<String, Object>? parameters,
  }) =>
      logPageView('heart_rate_page', parameters: {
        'data_type': 'heart_rate',
        if (heartRateValue != null) 'current_value': heartRateValue,
        // if (hasAlert != null) 'has_alert': hasAlert,
        ...?parameters,
      });

  /// K78 血氧頁面瀏覽
  Future<void> logViewBloodOxygenPage({
    String? oxygenValue,
    bool? hasAlert,
    Map<String, Object>? parameters,
  }) =>
      logPageView('blood_oxygen_page', parameters: {
        'data_type': 'blood_oxygen',
        if (oxygenValue != null) 'current_value': oxygenValue,
        // if (hasAlert != null) 'has_alert': hasAlert,
        ...?parameters,
      });

  /// K79 體溫頁面瀏覽
  Future<void> logViewTemperaturePage({
    String? temperatureValue,
    bool? hasAlert,
    Map<String, Object>? parameters,
  }) =>
      logPageView('temperature_page', parameters: {
        'data_type': 'temperature',
        if (temperatureValue != null) 'current_value': temperatureValue,
        // if (hasAlert != null) 'has_alert': hasAlert,
        ...?parameters,
      });

  /// K80 壓力頁面瀏覽
  Future<void> logViewStressPage({
    String? stressValue,
    bool? hasAlert,
    Map<String, Object>? parameters,
  }) =>
      logPageView('pressure_page', parameters: {
        'data_type': 'pressure',
        if (stressValue != null) 'current_value': stressValue,
        // if (hasAlert != null) 'has_alert': hasAlert,
        ...?parameters,
      });

  /// K81 步數頁面瀏覽
  Future<void> logViewStepsPage({
    String? stepsValue,
    Map<String, Object>? parameters,
  }) =>
      logPageView('steps_page', parameters: {
        'data_type': 'steps',
        if (stepsValue != null) 'current_value': stepsValue,
        ...?parameters,
      });

  /// K82 睡眠頁面瀏覽
  Future<void> logViewSleepPage({
    String? sleepValue,
    Map<String, Object>? parameters,
  }) =>
      logPageView('sleep_page', parameters: {
        'data_type': 'sleep',
        if (sleepValue != null) 'current_value': sleepValue,
        ...?parameters,
      });

  /// K83 卡路里頁面瀏覽
  Future<void> logViewCaloriesPage({
    String? caloriesValue,
    Map<String, Object>? parameters,
  }) =>
      logPageView('calories_page', parameters: {
        'data_type': 'calories',
        if (caloriesValue != null) 'current_value': caloriesValue,
        ...?parameters,
      });

  /// K84 移動距離頁面瀏覽
  Future<void> logViewDistancePage({
    String? distanceValue,
    Map<String, Object>? parameters,
  }) =>
      logPageView('distance_page', parameters: {
        'data_type': 'distance',
        if (distanceValue != null) 'current_value': distanceValue,
        ...?parameters,
      });

  // -------------------- 按鈕點擊語義方法 --------------------

  /// 登入按鈕點擊
  Future<void> logClickLoginButton({
    String? loginMethod,
    Map<String, Object>? parameters,
  }) =>
      logButtonClick(
        'login_button',
        pageName: 'login_page',
        parameters: {
          'login_method': loginMethod ?? 'unknown',
          ...?parameters,
        },
      );

  /// 發送OTP按鈕點擊
  Future<void> logClickSendOtp({Map<String, Object>? parameters}) =>
      logButtonClick('send_otp_button',
          pageName: 'sign_up_page', parameters: parameters);

  /// 接受條款按鈕點擊
  Future<void> logClickAcceptTerms({
    String? termsType,
    Map<String, Object>? parameters,
  }) =>
      logButtonClick(
        'accept_terms_button',
        pageName: 'accept_terms_page',
        parameters: {
          'terms_type': termsType ?? 'general',
          ...?parameters,
        },
      );

  /// 重新發送OTP按鈕點擊
  Future<void> logClickResendOtp({
    int? resendCount,
    Map<String, Object>? parameters,
  }) =>
      logButtonClick(
        'resend_otp_button',
        pageName: 'otp_page',
        parameters: {
          'resend_count': resendCount ?? 1,
          ...?parameters,
        },
      );

  /// 完成註冊按鈕點擊
  Future<void> logClickCompleteRegistration(
          {Map<String, Object>? parameters}) =>
      logButtonClick('complete_registration_button',
          pageName: 'otp_page', parameters: parameters);

  /// 更新個人資料按鈕點擊
  Future<void> logClickUpdateProfile({
    String? updateType,
    Map<String, Object>? parameters,
  }) =>
      logButtonClick(
        'update_profile_button',
        pageName: 'profile_page',
        parameters: {
          'update_type': updateType ?? 'general',
          ...?parameters,
        },
      );

  /// 儲存測量設定按鈕點擊
  Future<void> logClickSaveMeasurement({
    String? measurementType,
    Map<String, Object>? parameters,
  }) =>
      logButtonClick(
        'save_measurement_button',
        pageName: 'measurement_page',
        parameters: {
          'measurement_type': measurementType ?? 'general',
          ...?parameters,
        },
      );

  /// 設定目標按鈕點擊
  Future<void> logClickSetGoal({
    String? goalType,
    int? goalValue,
    Map<String, Object>? parameters,
  }) =>
      logButtonClick(
        'set_goal_button',
        pageName: 'goal_page',
        parameters: {
          'goal_type': goalType ?? 'general',
          if (goalValue != null) 'goal_value': goalValue,
          ...?parameters,
        },
      );

  /// 掃描QR Code按鈕點擊
  Future<void> logClickScanQrcode({
    String? qrType,
    Map<String, Object>? parameters,
  }) =>
      logButtonClick(
        'scan_qrcode_button',
        pageName: 'family_binding_page',
        parameters: {
          'qr_type': qrType ?? 'family_binding',
          ...?parameters,
        },
      );

  /// 綁定家人按鈕點擊
  Future<void> logClickBindFamily({Map<String, Object>? parameters}) =>
      logButtonClick('bind_family_button',
          pageName: 'family_binding_page', parameters: parameters);

  /// 開始運動按鈕點擊
  Future<void> logClickStartWorkout({
    String? workoutType,
    Map<String, Object>? parameters,
  }) =>
      logButtonClick(
        'start_workout_button',
        pageName: 'workout_page',
        parameters: {
          'workout_type': workoutType ?? 'general',
          ...?parameters,
        },
      );

  /// 結束運動按鈕點擊
  Future<void> logClickEndWorkout({
    String? workoutType,
    int? duration,
    Map<String, Object>? parameters,
  }) =>
      logButtonClick(
        'end_workout_button',
        pageName: 'workout_page',
        parameters: {
          'workout_type': workoutType ?? 'general',
          if (duration != null) 'duration_seconds': duration,
          ...?parameters,
        },
      );

  /// 搜尋裝置按鈕點擊
  Future<void> logClickSearchDevice({
    String? deviceType,
    Map<String, Object>? parameters,
  }) =>
      logButtonClick(
        'search_device_button',
        pageName: 'device_pairing_page',
        parameters: {
          'device_type': deviceType ?? 'unknown',
          ...?parameters,
        },
      );

  /// 選擇裝置按鈕點擊
  Future<void> logClickSelectDevice({
    String? deviceName,
    String? deviceType,
    Map<String, Object>? parameters,
  }) =>
      logButtonClick(
        'select_device_button',
        pageName: 'device_pairing_page',
        parameters: {
          if (deviceName != null) 'device_name': deviceName,
          'device_type': deviceType ?? 'unknown',
          ...?parameters,
        },
      );

  /// 開始配對按鈕點擊
  Future<void> logClickStartPairing({
    String? deviceName,
    Map<String, Object>? parameters,
  }) =>
      logButtonClick(
        'start_pairing_button',
        pageName: 'device_pairing_page',
        parameters: {
          if (deviceName != null) 'device_name': deviceName,
          ...?parameters,
        },
      );

  // -------------------- 成功事件語義方法 --------------------

  /// 登入成功
  Future<void> logLoginSuccess({
    String? loginMethod,
    Map<String, Object>? parameters,
  }) =>
      logLogin(
        loginMethod: loginMethod,
        parameters: parameters,
      );

  /// 註冊成功
  Future<void> logSignUpSuccess({
    String? signUpMethod,
    Map<String, Object>? parameters,
  }) =>
      logSignUp(
        signUpMethod: signUpMethod,
        parameters: parameters,
      );

  /// 設定用藥提醒成功
  Future<void> logSetMedicationReminderSuccess({
    String? medicationType,
    int? reminderCount,
    Map<String, Object>? parameters,
  }) =>
      logFeatureUsage(
        featureName: 'medication_reminder',
        action: 'set_success',
        parameters: {
          'medication_type': medicationType ?? 'unknown',
          if (reminderCount != null) 'reminder_count': reminderCount,
          ...?parameters,
        },
      );

  /// 開始Chatbot會話
  Future<void> logStartChatbotSession({
    String? sessionType,
    Map<String, Object>? parameters,
  }) =>
      logFeatureUsage(
        featureName: 'chatbot',
        action: 'start_session',
        parameters: {
          'session_type': sessionType ?? 'general',
          ...?parameters,
        },
      );

  /// 裝置配對成功
  Future<void> logDevicePairingSuccess({
    String? deviceName,
    String? deviceType,
    Map<String, Object>? parameters,
  }) =>
      logFeatureUsage(
        featureName: 'device_pairing',
        action: 'success',
        parameters: {
          if (deviceName != null) 'device_name': deviceName,
          'device_type': deviceType ?? 'unknown',
          ...?parameters,
        },
      );

  // ==================== 通用工具方法 ====================

  /// 記錄自訂事件
  Future<void> logCustomEvent({
    required String eventName,
    Map<String, Object>? parameters,
  }) async {
    if (!_isInitialized) return;
    try {
      // await _analytics.logEvent(
      //   name: eventName,
      //   parameters: {
      //     'timestamp': DateTime.now().millisecondsSinceEpoch,
      //     ...?parameters,
      //   },
      // );
      if (kDebugMode) {
        print('📊 記錄自訂事件: $eventName');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ 記錄自訂事件失敗: $e');
      }
    }
  }

  /// 設定分析收集啟用狀態
  Future<void> setAnalyticsCollectionEnabled(bool enabled) async {
    if (!_isInitialized) return;
    try {
      // await _analytics.setAnalyticsCollectionEnabled(enabled);
      if (kDebugMode) {
        print('📊 設定分析收集: $enabled');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ 設定分析收集失敗: $e');
      }
    }
  }

  /// 設定預設事件參數
  Future<void> setDefaultEventParameters(Map<String, Object> parameters) async {
    if (!_isInitialized) return;
    try {
      // await _analytics.setDefaultEventParameters(parameters);
      if (kDebugMode) {
        print('📊 設定預設事件參數');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ 設定預設事件參數失敗: $e');
      }
    }
  }
}
