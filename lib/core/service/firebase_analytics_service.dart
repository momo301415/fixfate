import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';

/// Firebase Analytics 服務
/// 統一管理所有分析事件追蹤
class FirebaseAnalyticsService {
  static final FirebaseAnalyticsService _instance =
      FirebaseAnalyticsService._internal();
  factory FirebaseAnalyticsService() => _instance;
  FirebaseAnalyticsService._internal();

  static FirebaseAnalyticsService get instance => _instance;

  late FirebaseAnalytics _analytics;
  bool _isInitialized = false;

  /// 初始化 Firebase Analytics
  Future<void> initialize() async {
    try {
      _analytics = FirebaseAnalytics.instance;
      _isInitialized = true;

      // 設定分析收集啟用狀態
      await _analytics.setAnalyticsCollectionEnabled(true);

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
      await _analytics.setUserId(id: userId);
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
      await _analytics.setUserProperty(name: name, value: value);
      if (kDebugMode) {
        print('📊 設定用戶屬性: $name = $value');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ 設定用戶屬性失敗: $e');
      }
    }
  }

  /// 登入事件
  Future<void> logLogin({
    String? loginMethod,
    Map<String, Object>? parameters,
  }) async {
    if (!_isInitialized) return;
    try {
      await _analytics.logLogin(
        loginMethod: loginMethod ?? 'unknown',
        parameters: parameters,
      );
      if (kDebugMode) {
        print('📊 記錄登入事件: $loginMethod');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ 記錄登入事件失敗: $e');
      }
    }
  }

  /// 註冊事件
  Future<void> logSignUp({
    String? signUpMethod,
    Map<String, Object>? parameters,
  }) async {
    if (!_isInitialized) return;
    try {
      await _analytics.logSignUp(
        signUpMethod: signUpMethod ?? 'unknown',
        parameters: parameters,
      );
      if (kDebugMode) {
        print('📊 記錄註冊事件: $signUpMethod');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ 記錄註冊事件失敗: $e');
      }
    }
  }

  // ==================== GA4 埋設事件 - 用戶認證流程 ====================

  /// 登入頁面瀏覽
  Future<void> logViewLoginPage({
    Map<String, Object>? parameters,
  }) async {
    if (!_isInitialized) return;
    try {
      await _analytics.logEvent(
        name: 'view_login_page',
        parameters: {
          'timestamp': DateTime.now().millisecondsSinceEpoch,
          ...?parameters,
        },
      );
      if (kDebugMode) {
        print('📊 記錄登入頁面瀏覽');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ 記錄登入頁面瀏覽失敗: $e');
      }
    }
  }

  /// 登入按鈕點擊
  Future<void> logClickLoginButton({
    String? loginMethod,
    Map<String, Object>? parameters,
  }) async {
    if (!_isInitialized) return;
    try {
      await _analytics.logEvent(
        name: 'click_login_button',
        parameters: {
          'login_method': loginMethod ?? 'unknown',
          'timestamp': DateTime.now().millisecondsSinceEpoch,
          ...?parameters,
        },
      );
      if (kDebugMode) {
        print('📊 記錄登入按鈕點擊: $loginMethod');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ 記錄登入按鈕點擊失敗: $e');
      }
    }
  }

  /// 登入成功
  Future<void> logLoginSuccess({
    String? loginMethod,
    Map<String, Object>? parameters,
  }) async {
    if (!_isInitialized) return;
    try {
      await _analytics.logEvent(
        name: 'login_success',
        parameters: {
          'login_method': loginMethod ?? 'unknown',
          'timestamp': DateTime.now().millisecondsSinceEpoch,
          ...?parameters,
        },
      );
      if (kDebugMode) {
        print('📊 記錄登入成功: $loginMethod');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ 記錄登入成功失敗: $e');
      }
    }
  }

  /// 註冊帳號頁面瀏覽
  Future<void> logViewSignUpPage({
    Map<String, Object>? parameters,
  }) async {
    if (!_isInitialized) return;
    try {
      await _analytics.logEvent(
        name: 'view_sign_up_page',
        parameters: {
          'timestamp': DateTime.now().millisecondsSinceEpoch,
          ...?parameters,
        },
      );
      if (kDebugMode) {
        print('📊 記錄註冊帳號頁面瀏覽');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ 記錄註冊帳號頁面瀏覽失敗: $e');
      }
    }
  }

  /// 發送OTP按鈕點擊
  Future<void> logClickSendOtp({
    Map<String, Object>? parameters,
  }) async {
    if (!_isInitialized) return;
    try {
      await _analytics.logEvent(
        name: 'click_send_otp',
        parameters: {
          'timestamp': DateTime.now().millisecondsSinceEpoch,
          ...?parameters,
        },
      );
      if (kDebugMode) {
        print('📊 記錄發送OTP按鈕點擊');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ 記錄發送OTP按鈕點擊失敗: $e');
      }
    }
  }

  /// 接受條款按鈕點擊
  Future<void> logClickAcceptTerms({
    String? termsType,
    Map<String, Object>? parameters,
  }) async {
    if (!_isInitialized) return;
    try {
      await _analytics.logEvent(
        name: 'click_accept_terms',
        parameters: {
          'terms_type': termsType ?? 'general',
          'timestamp': DateTime.now().millisecondsSinceEpoch,
          ...?parameters,
        },
      );
      if (kDebugMode) {
        print('📊 記錄接受條款按鈕點擊: $termsType');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ 記錄接受條款按鈕點擊失敗: $e');
      }
    }
  }

  /// OTP驗證頁面瀏覽
  Future<void> logViewOtpPage({
    Map<String, Object>? parameters,
  }) async {
    if (!_isInitialized) return;
    try {
      await _analytics.logEvent(
        name: 'view_otp_page',
        parameters: {
          'timestamp': DateTime.now().millisecondsSinceEpoch,
          ...?parameters,
        },
      );
      if (kDebugMode) {
        print('📊 記錄OTP驗證頁面瀏覽');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ 記錄OTP驗證頁面瀏覽失敗: $e');
      }
    }
  }

  /// 重新發送OTP按鈕點擊
  Future<void> logClickResendOtp({
    int? resendCount,
    Map<String, Object>? parameters,
  }) async {
    if (!_isInitialized) return;
    try {
      await _analytics.logEvent(
        name: 'click_resend_otp',
        parameters: {
          'resend_count': resendCount ?? 1,
          'timestamp': DateTime.now().millisecondsSinceEpoch,
          ...?parameters,
        },
      );
      if (kDebugMode) {
        print('📊 記錄重新發送OTP按鈕點擊: 第${resendCount ?? 1}次');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ 記錄重新發送OTP按鈕點擊失敗: $e');
      }
    }
  }

  /// 完成註冊按鈕點擊
  Future<void> logClickCompleteRegistration({
    Map<String, Object>? parameters,
  }) async {
    if (!_isInitialized) return;
    try {
      await _analytics.logEvent(
        name: 'click_complete_registration',
        parameters: {
          'timestamp': DateTime.now().millisecondsSinceEpoch,
          ...?parameters,
        },
      );
      if (kDebugMode) {
        print('📊 記錄完成註冊按鈕點擊');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ 記錄完成註冊按鈕點擊失敗: $e');
      }
    }
  }

  /// 使用者條款頁面瀏覽
  Future<void> logViewAcceptTermsPage({
    String? termsType,
    Map<String, Object>? parameters,
  }) async {
    if (!_isInitialized) return;
    try {
      await _analytics.logEvent(
        name: 'view_accept_terms_page',
        parameters: {
          'terms_type': termsType ?? 'general',
          'timestamp': DateTime.now().millisecondsSinceEpoch,
          ...?parameters,
        },
      );
      if (kDebugMode) {
        print('📊 記錄使用者條款頁面瀏覽: $termsType');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ 記錄使用者條款頁面瀏覽失敗: $e');
      }
    }
  }

  /// 註冊成功
  Future<void> logSignUpSuccess({
    String? signUpMethod,
    Map<String, Object>? parameters,
  }) async {
    if (!_isInitialized) return;
    try {
      await _analytics.logEvent(
        name: 'sign_up_success',
        parameters: {
          'sign_up_method': signUpMethod ?? 'unknown',
          'timestamp': DateTime.now().millisecondsSinceEpoch,
          ...?parameters,
        },
      );
      if (kDebugMode) {
        print('📊 記錄註冊成功: $signUpMethod');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ 記錄註冊成功失敗: $e');
      }
    }
  }

  // ==================== GA4 埋設事件 - 用戶設定流程 ====================

  /// 個人資料頁面瀏覽
  Future<void> logViewProfilePage({
    Map<String, Object>? parameters,
  }) async {
    if (!_isInitialized) return;
    try {
      await _analytics.logEvent(
        name: 'view_profile_page',
        parameters: {
          'timestamp': DateTime.now().millisecondsSinceEpoch,
          ...?parameters,
        },
      );
      if (kDebugMode) {
        print('📊 記錄個人資料頁面瀏覽');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ 記錄個人資料頁面瀏覽失敗: $e');
      }
    }
  }

  /// 更新個人資料按鈕點擊
  Future<void> logClickUpdateProfile({
    String? updateType,
    Map<String, Object>? parameters,
  }) async {
    if (!_isInitialized) return;
    try {
      await _analytics.logEvent(
        name: 'click_update_profile',
        parameters: {
          'update_type': updateType ?? 'general',
          'timestamp': DateTime.now().millisecondsSinceEpoch,
          ...?parameters,
        },
      );
      if (kDebugMode) {
        print('📊 記錄更新個人資料按鈕點擊: $updateType');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ 記錄更新個人資料按鈕點擊失敗: $e');
      }
    }
  }

  /// 用藥提醒設定頁面瀏覽
  Future<void> logViewMedicationPage({
    Map<String, Object>? parameters,
  }) async {
    if (!_isInitialized) return;
    try {
      await _analytics.logEvent(
        name: 'view_medication_page',
        parameters: {
          'timestamp': DateTime.now().millisecondsSinceEpoch,
          ...?parameters,
        },
      );
      if (kDebugMode) {
        print('📊 記錄用藥提醒設定頁面瀏覽');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ 記錄用藥提醒設定頁面瀏覽失敗: $e');
      }
    }
  }

  /// 設定用藥提醒成功
  Future<void> logSetMedicationReminderSuccess({
    String? medicationType,
    int? reminderCount,
    Map<String, Object>? parameters,
  }) async {
    if (!_isInitialized) return;
    try {
      await _analytics.logEvent(
        name: 'set_medication_reminder_success',
        parameters: {
          'medication_type': medicationType ?? 'unknown',
          'reminder_count': reminderCount ?? 1,
          'timestamp': DateTime.now().millisecondsSinceEpoch,
          ...?parameters,
        },
      );
      if (kDebugMode) {
        print('📊 記錄設定用藥提醒成功: $medicationType, 數量: $reminderCount');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ 記錄設定用藥提醒成功失敗: $e');
      }
    }
  }

  /// 測量設定頁面瀏覽
  Future<void> logViewMeasurementPage({
    String? measurementType,
    Map<String, Object>? parameters,
  }) async {
    if (!_isInitialized) return;
    try {
      await _analytics.logEvent(
        name: 'view_measurement_page',
        parameters: {
          'measurement_type': measurementType ?? 'general',
          'timestamp': DateTime.now().millisecondsSinceEpoch,
          ...?parameters,
        },
      );
      if (kDebugMode) {
        print('📊 記錄測量設定頁面瀏覽: $measurementType');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ 記錄測量設定頁面瀏覽失敗: $e');
      }
    }
  }

  /// 儲存測量設定按鈕點擊
  Future<void> logClickSaveMeasurement({
    String? measurementType,
    Map<String, Object>? parameters,
  }) async {
    if (!_isInitialized) return;
    try {
      await _analytics.logEvent(
        name: 'click_save_measurement',
        parameters: {
          'measurement_type': measurementType ?? 'general',
          'timestamp': DateTime.now().millisecondsSinceEpoch,
          ...?parameters,
        },
      );
      if (kDebugMode) {
        print('📊 記錄儲存測量設定按鈕點擊: $measurementType');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ 記錄儲存測量設定按鈕點擊失敗: $e');
      }
    }
  }

  /// 目標設定頁面瀏覽
  Future<void> logViewGoalPage({
    String? goalType,
    Map<String, Object>? parameters,
  }) async {
    if (!_isInitialized) return;
    try {
      await _analytics.logEvent(
        name: 'view_goal_page',
        parameters: {
          'goal_type': goalType ?? 'general',
          'timestamp': DateTime.now().millisecondsSinceEpoch,
          ...?parameters,
        },
      );
      if (kDebugMode) {
        print('📊 記錄目標設定頁面瀏覽: $goalType');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ 記錄目標設定頁面瀏覽失敗: $e');
      }
    }
  }

  /// 設定目標按鈕點擊
  Future<void> logClickSetGoal({
    String? goalType,
    int? goalValue,
    Map<String, Object>? parameters,
  }) async {
    if (!_isInitialized) return;
    try {
      await _analytics.logEvent(
        name: 'click_set_goal',
        parameters: {
          'goal_type': goalType ?? 'general',
          'goal_value': goalValue ?? 0,
          'timestamp': DateTime.now().millisecondsSinceEpoch,
          ...?parameters,
        },
      );
      if (kDebugMode) {
        print('📊 記錄設定目標按鈕點擊: $goalType, 值: $goalValue');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ 記錄設定目標按鈕點擊失敗: $e');
      }
    }
  }

  // ==================== GA4 埋設事件 - 社交功能 ====================

  /// 家人管理頁面瀏覽
  Future<void> logViewFamilyMembers({
    int? familyCount,
    Map<String, Object>? parameters,
  }) async {
    if (!_isInitialized) return;
    try {
      await _analytics.logEvent(
        name: 'view_family_members',
        parameters: {
          'family_count': familyCount ?? 0,
          'timestamp': DateTime.now().millisecondsSinceEpoch,
          ...?parameters,
        },
      );
      if (kDebugMode) {
        print('📊 記錄家人管理頁面瀏覽: 家人數量 $familyCount');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ 記錄家人管理頁面瀏覽失敗: $e');
      }
    }
  }

  /// 家人綁定頁面瀏覽
  Future<void> logViewFamilyBindingPage({
    Map<String, Object>? parameters,
  }) async {
    if (!_isInitialized) return;
    try {
      await _analytics.logEvent(
        name: 'view_family_binding_page',
        parameters: {
          'timestamp': DateTime.now().millisecondsSinceEpoch,
          ...?parameters,
        },
      );
      if (kDebugMode) {
        print('📊 記錄家人綁定頁面瀏覽');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ 記錄家人綁定頁面瀏覽失敗: $e');
      }
    }
  }

  /// 掃描QR Code按鈕點擊
  Future<void> logClickScanQrcode({
    String? qrType,
    Map<String, Object>? parameters,
  }) async {
    if (!_isInitialized) return;
    try {
      await _analytics.logEvent(
        name: 'click_scan_qrcode',
        parameters: {
          'qr_type': qrType ?? 'family_binding',
          'timestamp': DateTime.now().millisecondsSinceEpoch,
          ...?parameters,
        },
      );
      if (kDebugMode) {
        print('📊 記錄掃描QR Code按鈕點擊: $qrType');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ 記錄掃描QR Code按鈕點擊失敗: $e');
      }
    }
  }

  /// 綁定家人按鈕點擊
  Future<void> logClickBindFamily({
    Map<String, Object>? parameters,
  }) async {
    if (!_isInitialized) return;
    try {
      await _analytics.logEvent(
        name: 'click_bind_family',
        parameters: {
          'timestamp': DateTime.now().millisecondsSinceEpoch,
          ...?parameters,
        },
      );
      if (kDebugMode) {
        print('📊 記錄綁定家人按鈕點擊');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ 記錄綁定家人按鈕點擊失敗: $e');
      }
    }
  }

  // ==================== GA4 埋設事件 - 輔助功能 ====================

  /// 警報紀錄頁面瀏覽
  Future<void> logViewAlertHistory({
    int? alertCount,
    Map<String, Object>? parameters,
  }) async {
    if (!_isInitialized) return;
    try {
      await _analytics.logEvent(
        name: 'view_alert_history',
        parameters: {
          'alert_count': alertCount ?? 0,
          'timestamp': DateTime.now().millisecondsSinceEpoch,
          ...?parameters,
        },
      );
      if (kDebugMode) {
        print('📊 記錄警報紀錄頁面瀏覽: 警報數量 $alertCount');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ 記錄警報紀錄頁面瀏覽失敗: $e');
      }
    }
  }

  /// 通知消息頁面瀏覽
  Future<void> logViewNotificationPage({
    int? notificationCount,
    Map<String, Object>? parameters,
  }) async {
    if (!_isInitialized) return;
    try {
      await _analytics.logEvent(
        name: 'view_notification_page',
        parameters: {
          'notification_count': notificationCount ?? 0,
          'timestamp': DateTime.now().millisecondsSinceEpoch,
          ...?parameters,
        },
      );
      if (kDebugMode) {
        print('📊 記錄通知消息頁面瀏覽: 通知數量 $notificationCount');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ 記錄通知消息頁面瀏覽失敗: $e');
      }
    }
  }

  /// Chatbot頁面瀏覽
  Future<void> logViewChatbotPage({
    Map<String, Object>? parameters,
  }) async {
    if (!_isInitialized) return;
    try {
      await _analytics.logEvent(
        name: 'view_chatbot_page',
        parameters: {
          'timestamp': DateTime.now().millisecondsSinceEpoch,
          ...?parameters,
        },
      );
      if (kDebugMode) {
        print('📊 記錄Chatbot頁面瀏覽');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ 記錄Chatbot頁面瀏覽失敗: $e');
      }
    }
  }

  /// 開始Chatbot會話
  Future<void> logStartChatbotSession({
    String? sessionType,
    Map<String, Object>? parameters,
  }) async {
    if (!_isInitialized) return;
    try {
      await _analytics.logEvent(
        name: 'start_chatbot_session',
        parameters: {
          'session_type': sessionType ?? 'general',
          'timestamp': DateTime.now().millisecondsSinceEpoch,
          ...?parameters,
        },
      );
      if (kDebugMode) {
        print('📊 記錄開始Chatbot會話: $sessionType');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ 記錄開始Chatbot會話失敗: $e');
      }
    }
  }

  // ==================== GA4 埋設事件 - 核心功能 ====================

  /// 我的設備頁面瀏覽
  Future<void> logViewMyDevices({
    int? deviceCount,
    Map<String, Object>? parameters,
  }) async {
    if (!_isInitialized) return;
    try {
      await _analytics.logEvent(
        name: 'view_my_devices',
        parameters: {
          'device_count': deviceCount ?? 0,
          'timestamp': DateTime.now().millisecondsSinceEpoch,
          ...?parameters,
        },
      );
      if (kDebugMode) {
        print('📊 記錄我的設備頁面瀏覽: 設備數量 $deviceCount');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ 記錄我的設備頁面瀏覽失敗: $e');
      }
    }
  }

  /// 健康數據頁面瀏覽
  Future<void> logViewHealthHeartrateDataPage({
    String? dataType,
    Map<String, Object>? parameters,
  }) async {
    if (!_isInitialized) return;
    try {
      await _analytics.logEvent(
        name: 'view_health_heartrate_data_page',
        parameters: {
          'data_type': dataType ?? 'heartrate',
          'timestamp': DateTime.now().millisecondsSinceEpoch,
          ...?parameters,
        },
      );
      if (kDebugMode) {
        print('📊 記錄健康數據頁面瀏覽: $dataType');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ 記錄健康數據頁面瀏覽失敗: $e');
      }
    }
  }

  /// 運動監測頁面瀏覽
  Future<void> logViewWorkoutPage({
    String? workoutType,
    Map<String, Object>? parameters,
  }) async {
    if (!_isInitialized) return;
    try {
      await _analytics.logEvent(
        name: 'view_workout_page',
        parameters: {
          'workout_type': workoutType ?? 'general',
          'timestamp': DateTime.now().millisecondsSinceEpoch,
          ...?parameters,
        },
      );
      if (kDebugMode) {
        print('📊 記錄運動監測頁面瀏覽: $workoutType');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ 記錄運動監測頁面瀏覽失敗: $e');
      }
    }
  }

  /// 開始運動按鈕點擊
  Future<void> logClickStartWorkout({
    String? workoutType,
    Map<String, Object>? parameters,
  }) async {
    if (!_isInitialized) return;
    try {
      await _analytics.logEvent(
        name: 'click_start_workout',
        parameters: {
          'workout_type': workoutType ?? 'general',
          'timestamp': DateTime.now().millisecondsSinceEpoch,
          ...?parameters,
        },
      );
      if (kDebugMode) {
        print('📊 記錄開始運動按鈕點擊: $workoutType');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ 記錄開始運動按鈕點擊失敗: $e');
      }
    }
  }

  /// 結束運動按鈕點擊
  Future<void> logClickEndWorkout({
    String? workoutType,
    int? duration,
    Map<String, Object>? parameters,
  }) async {
    if (!_isInitialized) return;
    try {
      await _analytics.logEvent(
        name: 'click_end_workout',
        parameters: {
          'workout_type': workoutType ?? 'general',
          'duration_seconds': duration ?? 0,
          'timestamp': DateTime.now().millisecondsSinceEpoch,
          ...?parameters,
        },
      );
      if (kDebugMode) {
        print('📊 記錄結束運動按鈕點擊: $workoutType, 時長: ${duration}s');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ 記錄結束運動按鈕點擊失敗: $e');
      }
    }
  }

  /// 運動數據頁面瀏覽
  Future<void> logViewWorkoutDataPage({
    String? workoutId,
    String? workoutType,
    Map<String, Object>? parameters,
  }) async {
    if (!_isInitialized) return;
    try {
      await _analytics.logEvent(
        name: 'view_workout_data_page',
        parameters: {
          'workout_id': workoutId ?? 'unknown',
          'workout_type': workoutType ?? 'general',
          'timestamp': DateTime.now().millisecondsSinceEpoch,
          ...?parameters,
        },
      );
      if (kDebugMode) {
        print('📊 記錄運動數據頁面瀏覽: $workoutType');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ 記錄運動數據頁面瀏覽失敗: $e');
      }
    }
  }

  /// 裝置綁定頁面瀏覽
  Future<void> logViewDevicePairingPage({
    Map<String, Object>? parameters,
  }) async {
    if (!_isInitialized) return;
    try {
      await _analytics.logEvent(
        name: 'view_device_pairing_page',
        parameters: {
          'timestamp': DateTime.now().millisecondsSinceEpoch,
          ...?parameters,
        },
      );
      if (kDebugMode) {
        print('📊 記錄裝置綁定頁面瀏覽');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ 記錄裝置綁定頁面瀏覽失敗: $e');
      }
    }
  }

  /// 搜尋裝置按鈕點擊
  Future<void> logClickSearchDevice({
    String? deviceType,
    Map<String, Object>? parameters,
  }) async {
    if (!_isInitialized) return;
    try {
      await _analytics.logEvent(
        name: 'click_search_device',
        parameters: {
          'device_type': deviceType ?? 'unknown',
          'timestamp': DateTime.now().millisecondsSinceEpoch,
          ...?parameters,
        },
      );
      if (kDebugMode) {
        print('📊 記錄搜尋裝置按鈕點擊: $deviceType');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ 記錄搜尋裝置按鈕點擊失敗: $e');
      }
    }
  }

  /// 選擇裝置按鈕點擊
  Future<void> logClickSelectDevice({
    String? deviceName,
    String? deviceType,
    Map<String, Object>? parameters,
  }) async {
    if (!_isInitialized) return;
    try {
      await _analytics.logEvent(
        name: 'click_select_device',
        parameters: {
          'device_name': deviceName ?? 'unknown',
          'device_type': deviceType ?? 'unknown',
          'timestamp': DateTime.now().millisecondsSinceEpoch,
          ...?parameters,
        },
      );
      if (kDebugMode) {
        print('📊 記錄選擇裝置按鈕點擊: $deviceName');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ 記錄選擇裝置按鈕點擊失敗: $e');
      }
    }
  }

  /// 開始配對按鈕點擊
  Future<void> logClickStartPairing({
    String? deviceName,
    Map<String, Object>? parameters,
  }) async {
    if (!_isInitialized) return;
    try {
      await _analytics.logEvent(
        name: 'click_start_pairing',
        parameters: {
          'device_name': deviceName ?? 'unknown',
          'timestamp': DateTime.now().millisecondsSinceEpoch,
          ...?parameters,
        },
      );
      if (kDebugMode) {
        print('📊 記錄開始配對按鈕點擊: $deviceName');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ 記錄開始配對按鈕點擊失敗: $e');
      }
    }
  }

  /// 裝置配對成功
  Future<void> logDevicePairingSuccess({
    String? deviceName,
    String? deviceType,
    Map<String, Object>? parameters,
  }) async {
    if (!_isInitialized) return;
    try {
      await _analytics.logEvent(
        name: 'device_pairing_success',
        parameters: {
          'device_name': deviceName ?? 'unknown',
          'device_type': deviceType ?? 'unknown',
          'timestamp': DateTime.now().millisecondsSinceEpoch,
          ...?parameters,
        },
      );
      if (kDebugMode) {
        print('📊 記錄裝置配對成功: $deviceName');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ 記錄裝置配對成功失敗: $e');
      }
    }
  }

  // ==================== 運動相關事件 ====================

  /// 運動開始事件
  Future<void> logWorkoutStart({
    String? workoutType,
    Map<String, Object>? parameters,
  }) async {
    if (!_isInitialized) return;
    try {
      await _analytics.logEvent(
        name: 'workout_start',
        parameters: {
          'workout_type': workoutType ?? 'unknown',
          ...?parameters,
        },
      );
      if (kDebugMode) {
        print('📊 記錄運動開始: $workoutType');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ 記錄運動開始失敗: $e');
      }
    }
  }

  /// 運動結束事件
  Future<void> logWorkoutEnd({
    String? workoutType,
    int? duration,
    int? steps,
    double? distance,
    Map<String, Object>? parameters,
  }) async {
    if (!_isInitialized) return;
    try {
      await _analytics.logEvent(
        name: 'workout_end',
        parameters: {
          'workout_type': workoutType ?? 'unknown',
          if (duration != null) 'duration_seconds': duration,
          if (steps != null) 'steps': steps,
          if (distance != null) 'distance_meters': distance,
          ...?parameters,
        },
      );
      if (kDebugMode) {
        print('📊 記錄運動結束: $workoutType, 時長: ${duration}s, 步數: $steps');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ 記錄運動結束失敗: $e');
      }
    }
  }

  /// 步數里程碑事件
  Future<void> logStepMilestone({
    required int steps,
    String? milestone,
  }) async {
    if (!_isInitialized) return;
    try {
      await _analytics.logEvent(
        name: 'step_milestone',
        parameters: {
          'steps': steps,
          'milestone': milestone ?? '${steps}_steps',
        },
      );
      if (kDebugMode) {
        print('📊 記錄步數里程碑: $steps 步');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ 記錄步數里程碑失敗: $e');
      }
    }
  }

  /// 心率異常事件
  Future<void> logHeartRateAlert({
    required int heartRate,
    String? alertType,
    Map<String, Object>? parameters,
  }) async {
    if (!_isInitialized) return;
    try {
      await _analytics.logEvent(
        name: 'heart_rate_alert',
        parameters: {
          'heart_rate': heartRate,
          'alert_type': alertType ?? 'unknown',
          ...?parameters,
        },
      );
      if (kDebugMode) {
        print('📊 記錄心率異常: $heartRate bpm, 類型: $alertType');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ 記錄心率異常失敗: $e');
      }
    }
  }

  // ==================== 設備相關事件 ====================

  /// 藍牙設備連接事件
  Future<void> logBluetoothConnect({
    required String deviceName,
    String? deviceType,
    Map<String, Object>? parameters,
  }) async {
    if (!_isInitialized) return;
    try {
      await _analytics.logEvent(
        name: 'bluetooth_connect',
        parameters: {
          'device_name': deviceName,
          'device_type': deviceType ?? 'unknown',
          ...?parameters,
        },
      );
      if (kDebugMode) {
        print('📊 記錄藍牙連接: $deviceName');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ 記錄藍牙連接失敗: $e');
      }
    }
  }

  /// 藍牙設備斷線事件
  Future<void> logBluetoothDisconnect({
    required String deviceName,
    String? reason,
    Map<String, Object>? parameters,
  }) async {
    if (!_isInitialized) return;
    try {
      await _analytics.logEvent(
        name: 'bluetooth_disconnect',
        parameters: {
          'device_name': deviceName,
          'disconnect_reason': reason ?? 'unknown',
          ...?parameters,
        },
      );
      if (kDebugMode) {
        print('📊 記錄藍牙斷線: $deviceName, 原因: $reason');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ 記錄藍牙斷線失敗: $e');
      }
    }
  }

  /// 數據同步事件
  Future<void> logDataSync({
    required String syncType,
    bool? success,
    int? dataCount,
    Map<String, Object>? parameters,
  }) async {
    if (!_isInitialized) return;
    try {
      await _analytics.logEvent(
        name: 'data_sync',
        parameters: {
          'sync_type': syncType,
          'success': success ?? false,
          if (dataCount != null) 'data_count': dataCount,
          ...?parameters,
        },
      );
      if (kDebugMode) {
        print('📊 記錄數據同步: $syncType, 成功: $success, 數量: $dataCount');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ 記錄數據同步失敗: $e');
      }
    }
  }

  // ==================== App 使用事件 ====================

  /// 頁面瀏覽事件
  Future<void> logPageView({
    required String pageName,
    String? pageTitle,
    Map<String, Object>? parameters,
  }) async {
    if (!_isInitialized) return;
    try {
      await _analytics.logScreenView(
        screenName: pageName,
        screenClass: pageTitle ?? pageName,
        parameters: parameters,
      );
      if (kDebugMode) {
        print('📊 記錄頁面瀏覽: $pageName');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ 記錄頁面瀏覽失敗: $e');
      }
    }
  }

  /// 按鈕點擊事件
  Future<void> logButtonClick({
    required String buttonName,
    String? pageName,
    Map<String, Object>? parameters,
  }) async {
    if (!_isInitialized) return;
    try {
      await _analytics.logEvent(
        name: 'button_click',
        parameters: {
          'button_name': buttonName,
          'page_name': pageName ?? 'unknown',
          ...?parameters,
        },
      );
      if (kDebugMode) {
        print('📊 記錄按鈕點擊: $buttonName');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ 記錄按鈕點擊失敗: $e');
      }
    }
  }

  /// 功能使用事件
  Future<void> logFeatureUsage({
    required String featureName,
    String? action,
    Map<String, Object>? parameters,
  }) async {
    if (!_isInitialized) return;
    try {
      await _analytics.logEvent(
        name: 'feature_usage',
        parameters: {
          'feature_name': featureName,
          'action': action ?? 'use',
          ...?parameters,
        },
      );
      if (kDebugMode) {
        print('📊 記錄功能使用: $featureName - $action');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ 記錄功能使用失敗: $e');
      }
    }
  }

  /// 錯誤事件
  Future<void> logError({
    required String errorType,
    String? errorMessage,
    String? pageName,
    Map<String, Object>? parameters,
  }) async {
    if (!_isInitialized) return;
    try {
      await _analytics.logEvent(
        name: 'app_error',
        parameters: {
          'error_type': errorType,
          'error_message': errorMessage ?? 'unknown',
          'page_name': pageName ?? 'unknown',
          ...?parameters,
        },
      );
      if (kDebugMode) {
        print('📊 記錄錯誤事件: $errorType - $errorMessage');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ 記錄錯誤事件失敗: $e');
      }
    }
  }

  // ==================== 自訂事件 ====================

  /// 記錄自訂事件
  Future<void> logCustomEvent({
    required String eventName,
    Map<String, Object>? parameters,
  }) async {
    if (!_isInitialized) return;
    try {
      await _analytics.logEvent(
        name: eventName,
        parameters: parameters,
      );
      if (kDebugMode) {
        print('📊 記錄自訂事件: $eventName');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ 記錄自訂事件失敗: $e');
      }
    }
  }

  // ==================== 設定相關 ====================

  /// 設定分析收集啟用狀態
  Future<void> setAnalyticsCollectionEnabled(bool enabled) async {
    if (!_isInitialized) return;
    try {
      await _analytics.setAnalyticsCollectionEnabled(enabled);
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
      await _analytics.setDefaultEventParameters(parameters);
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
