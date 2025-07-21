import 'dart:async';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pulsedevice/core/global_controller.dart';
import 'location_enhancement_service.dart';
import 'app_lifecycle_observer.dart';

/// 智能同步監控器
/// 用於測試和監控前景背景動態切換的效果
class SmartSyncMonitor {
  static const String _tag = 'SmartSyncMonitor';

  /// 獲取完整的智能同步狀態報告
  static Map<String, dynamic> getSmartSyncStatusReport() {
    final gc = Get.find<GlobalController>();

    Map<String, dynamic> report = {
      'timestamp': DateTime.now().toIso8601String(),
      'currentMode': _getCurrentAppMode(),
      'mechanisms': {},
      'statistics': _getSyncStatistics(),
    };

    // 1. App生命週期狀態
    report['mechanisms']['appLifecycle'] = {
      'name': 'Smart App Lifecycle',
      'description': '智能前景背景切換',
      'currentMode': _getCurrentAppMode(),
      'status': 'active',
    };

    // 2. ForegroundTask 狀態
    report['mechanisms']['foregroundTask'] = {
      'name': 'Flutter Foreground Task',
      'description': '前台5分鐘定時器',
      'status': _getForegroundTaskStatus(),
      'interval': '5分鐘',
      'activeWhen': '前台模式',
    };

    // 3. BackgroundFetch 狀態
    report['mechanisms']['backgroundFetch'] = {
      'name': 'Background Fetch',
      'description': '系統原生背景任務',
      'status': 'configured',
      'interval': '系統決定',
      'activeWhen': '前台+背景模式',
    };

    // 4. LocationEnhancement 狀態
    try {
      final locationService = Get.find<LocationEnhancementService>();
      final isGpsRunning = _isGpsEnhancementRunning(locationService);

      report['mechanisms']['locationEnhancement'] = {
        'name': 'GPS Location Enhancement',
        'description': 'GPS定時請求背景喚醒',
        'permissionStatus':
            locationService.isLocationEnhancementEnabled ? 'granted' : 'denied',
        'currentStrategy': locationService.currentStrategy.name,
        'gpsStatus': isGpsRunning ? 'running' : 'stopped',
        'unifiedModeRunning': locationService.isUnifiedModeRunning,
        'syncCount': locationService.syncCount,
        'lastTrigger': locationService.lastSyncTrigger,
        'activeWhen':
            locationService.currentStrategy == LocationStrategy.smartSwitch
                ? '背景模式'
                : '前景+背景模式',
        'serviceStatus': locationService.getServiceStatus(),
      };
    } catch (e) {
      report['mechanisms']['locationEnhancement'] = {
        'name': 'GPS Location Enhancement',
        'description': 'GPS定時請求背景喚醒',
        'status': 'error',
        'error': e.toString(),
      };
    }

    return report;
  }

  /// 判斷當前App模式
  static String _getCurrentAppMode() {
    try {
      final gc = Get.find<GlobalController>();
      final isInForeground = gc.lifecycleObserver.isInForeground;
      return isInForeground ? '前台模式' : '背景模式';
    } catch (e) {
      return '未知';
    }
  }

  /// 判斷ForegroundTask狀態
  static String _getForegroundTaskStatus() {
    // 這需要根據實際的ForegroundTask狀態來判斷
    // 暫時返回假設狀態
    return 'unknown';
  }

  /// 判斷GPS增強是否正在運行
  static bool _isGpsEnhancementRunning(LocationEnhancementService service) {
    // 通過檢查服務狀態來判斷GPS是否正在運行
    final status = service.getDetailedServiceStatus();
    final isEnabled = status['isEnabled'] == true;
    final hasTimerActive = status['locationTimerActive'] == true;
    final isUnifiedRunning = status['isUnifiedModeRunning'] == true;

    // GPS增強正在運行的條件：
    // 1. 服務已啟用 AND
    // 2. (定時器運行中 OR 統一模式運行中)
    return isEnabled && (hasTimerActive || isUnifiedRunning);
  }

  /// 獲取同步統計資料
  static Map<String, dynamic> _getSyncStatistics() {
    try {
      final locationService = Get.find<LocationEnhancementService>();
      return {
        'totalSyncCount': locationService.syncCount,
        'lastSyncTrigger': locationService.lastSyncTrigger,
        'lastSyncTime': locationService.getServiceStatus()['lastSyncTime'],
      };
    } catch (e) {
      return {
        'totalSyncCount': 0,
        'lastSyncTrigger': 'unknown',
        'error': e.toString(),
      };
    }
  }

  /// 觸發手動測試各種模式
  static Future<Map<String, dynamic>> runSmartSyncTests() async {
    final results = <String, dynamic>{
      'timestamp': DateTime.now().toIso8601String(),
      'tests': [],
    };

    try {
      final gc = Get.find<GlobalController>();

      // 測試1: 核心同步邏輯
      final test1Start = DateTime.now();
      await gc.safeRunSync();
      final test1Duration = DateTime.now().difference(test1Start);

      results['tests'].add({
        'name': 'Core Sync Test',
        'description': '核心同步邏輯測試',
        'duration': '${test1Duration.inMilliseconds}ms',
        'status': 'completed',
      });

      // 測試2: 前景模式切換
      try {
        final lifecycleObserver = gc.lifecycleObserver;
        final test2Start = DateTime.now();
        await lifecycleObserver.forceForegroundMode();
        final test2Duration = DateTime.now().difference(test2Start);

        results['tests'].add({
          'name': 'Foreground Mode Switch',
          'description': '強制切換到前景模式',
          'duration': '${test2Duration.inMilliseconds}ms',
          'status': 'completed',
        });
      } catch (e) {
        results['tests'].add({
          'name': 'Foreground Mode Switch',
          'description': '強制切換到前景模式',
          'status': 'failed',
          'error': e.toString(),
        });
      }

      // 測試3: 背景模式切換
      try {
        final lifecycleObserver = gc.lifecycleObserver;
        final test3Start = DateTime.now();
        await lifecycleObserver.forceBackgroundMode();
        final test3Duration = DateTime.now().difference(test3Start);

        results['tests'].add({
          'name': 'Background Mode Switch',
          'description': '強制切換到背景模式',
          'duration': '${test3Duration.inMilliseconds}ms',
          'status': 'completed',
        });
      } catch (e) {
        results['tests'].add({
          'name': 'Background Mode Switch',
          'description': '強制切換到背景模式',
          'status': 'failed',
          'error': e.toString(),
        });
      }

      // 測試4: GPS增強手動觸發
      try {
        final locationService = Get.find<LocationEnhancementService>();
        final test4Start = DateTime.now();
        await locationService.manualTriggerSync();
        final test4Duration = DateTime.now().difference(test4Start);

        results['tests'].add({
          'name': 'GPS Enhancement Test',
          'description': 'GPS增強手動觸發測試',
          'duration': '${test4Duration.inMilliseconds}ms',
          'status': 'completed',
        });
      } catch (e) {
        results['tests'].add({
          'name': 'GPS Enhancement Test',
          'description': 'GPS增強手動觸發測試',
          'status': 'failed',
          'error': e.toString(),
        });
      }
    } catch (e) {
      results['tests'].add({
        'name': 'General Test',
        'description': '一般測試失敗',
        'status': 'failed',
        'error': e.toString(),
      });
    }

    return results;
  }

  /// 顯示智能同步狀態對話框
  static void showSmartSyncStatusDialog(BuildContext context) {
    final report = getSmartSyncStatusReport();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('🎯 智能背景同步狀態'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // 當前模式顯示
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: report['currentMode'] == '前台模式'
                      ? Colors.green.withOpacity(0.1)
                      : Colors.blue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '當前模式: ${report['currentMode']}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: report['currentMode'] == '前台模式'
                        ? Colors.green
                        : Colors.blue,
                  ),
                ),
              ),

              SizedBox(height: 8),
              Text('更新時間: ${report['timestamp']}'),
              SizedBox(height: 16),

              // 顯示各個機制狀態
              ...((report['mechanisms'] as Map<String, dynamic>)
                  .entries
                  .map((entry) {
                final mechanism = entry.value as Map<String, dynamic>;
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          mechanism['name'] ?? '未知',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(mechanism['description'] ?? ''),
                        if (mechanism['status'] != null)
                          Text('狀態: ${mechanism['status']}'),
                        if (mechanism['currentMode'] != null)
                          Text('當前模式: ${mechanism['currentMode']}'),
                        if (mechanism['permissionStatus'] != null)
                          Text('權限: ${mechanism['permissionStatus']}'),
                        if (mechanism['currentStrategy'] != null)
                          Text('策略: ${mechanism['currentStrategy']}'),
                        if (mechanism['gpsStatus'] != null)
                          Text('GPS: ${mechanism['gpsStatus']}'),
                        if (mechanism['unifiedModeRunning'] != null)
                          Text(
                              '統一模式: ${mechanism['unifiedModeRunning'] ? '運行中' : '已停止'}'),
                        if (mechanism['interval'] != null)
                          Text('間隔: ${mechanism['interval']}'),
                        if (mechanism['activeWhen'] != null)
                          Text('啟用時機: ${mechanism['activeWhen']}'),
                        if (mechanism['syncCount'] != null)
                          Text('同步次數: ${mechanism['syncCount']}'),
                        if (mechanism['lastTrigger'] != null &&
                            mechanism['lastTrigger'].toString().isNotEmpty)
                          Text('最後觸發: ${mechanism['lastTrigger']}'),
                      ],
                    ),
                  ),
                );
              }).toList()),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('關閉'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop();
              await runSmartSyncTests();
              showSmartSyncStatusDialog(context); // 重新顯示更新後的狀態
            },
            child: const Text('運行測試'),
          ),
        ],
      ),
    );
  }

  /// 持續監控智能同步效果
  static StreamSubscription<void>? startContinuousMonitoring() {
    print('📊 [$_tag] 開始持續監控智能同步效果...');

    return Stream.periodic(const Duration(minutes: 1)).listen((_) {
      final report = getSmartSyncStatusReport();
      print('📊 [$_tag] 智能同步狀態報告:');
      print('   時間: ${report['timestamp']}');
      print('   模式: ${report['currentMode']}');

      final mechanisms = report['mechanisms'] as Map<String, dynamic>;
      for (final entry in mechanisms.entries) {
        final mechanism = entry.value as Map<String, dynamic>;
        print(
            '   ${mechanism['name']}: ${mechanism['status'] ?? mechanism['permissionStatus']}');
      }
    });
  }

  /// 停止持續監控
  static void stopContinuousMonitoring(StreamSubscription<void>? subscription) {
    subscription?.cancel();
    print('🛑 [$_tag] 已停止持續監控');
  }

  /// 生成智能同步使用指南
  static List<String> getSmartSyncUsageGuide() {
    return [
      '🎯 雙策略同步系統特點：',
      '',
      '🔄 智能切換策略（默認）：',
      '  📱 前台模式（App使用中）：',
      '    • GPS增強自動停止（省電）',
      '    • ForegroundTask每5分鐘觸發',
      '    • 同步頻率高，穩定性優先',
      '  🌙 背景模式（App在背景）：',
      '    • GPS增強自動啟動（保活）',
      '    • 🎯 每3分鐘GPS請求觸發（保活優先）',
      '    • BackgroundFetch輔助觸發',
      '',
      '🌍 統一GPS策略（保活最大化）：',
      '  • 忽略前台背景切換',
      '  • 🎯 GPS增強持續運行（3分鐘間隔）',
      '  • 最大化同步穩定性和保活效果',
      '  • 健康數據完整性優先',
      '',
      '🎛️ 策略切換：',
      '  • gc.enableUnifiedGpsStrategy() - 切換到統一GPS',
      '  • gc.enableSmartSwitchStrategy() - 切換到智能切換',
      '  • gc.getCurrentLocationStrategy() - 查看當前策略',
      '',
      '🧪 測試建議：',
      '  • 對比兩種策略的背景穩定性',
      '  • 監控電池消耗差異',
      '  • 檢查iPad位置權限錯誤解決效果',
      '  • 使用 gc.testUnifiedGpsMode() 測試',
    ];
  }

  /// 打印智能同步使用指南
  static void printSmartSyncUsageGuide() {
    print('🎯 [$_tag] ===== 智能背景同步使用指南 =====');
    print('');

    final guide = getSmartSyncUsageGuide();
    for (final line in guide) {
      print(line);
    }

    print('');
    print('📊 使用 SmartSyncMonitor.getSmartSyncStatusReport() 查看狀態');
    print('🔧 使用 SmartSyncMonitor.runSmartSyncTests() 運行測試');
    print('👁️  使用 SmartSyncMonitor.showSmartSyncStatusDialog() 顯示狀態');
    print('');
    print('===============================================');
  }
}
