# K19Screen 連接狀態欄功能

## 功能概述

連接狀態欄是一個半透明浮動的狀態指示器，用於顯示 WebSocket 連接的實時狀態。它浮動在聊天內容上方，讓用戶清楚了解當前的連接狀況，同時不會遮擋整個頁面。

## 功能特點

### 🎨 視覺設計
- **半透明背景**：85% 透明度，不遮擋聊天內容
- **圓角設計**：18px 圓角，與整體 UI 風格一致
- **動畫效果**：狀態變化時有平滑的過渡動畫
- **陰影效果**：提供視覺層次感
- **緊湊設計**：36px 高度，最小化對聊天內容的影響

### 📊 狀態類型
1. **已連線** (🟢 綠色)
   - 狀態：`ConnectionStatus.connected`
   - 顯示：隱藏狀態欄
   - 說明：WebSocket 正常連接且可以發送訊息

2. **正在連線** (🟠 橙色)
   - 狀態：`ConnectionStatus.connecting`
   - 顯示：`正在連線...`
   - 說明：WebSocket 正在建立連接

3. **連線不穩定** (🟡 黃色)
   - 狀態：`ConnectionStatus.unstable`
   - 顯示：`連線不穩定，訊息可能延遲`
   - 說明：連接存在但可能影響訊息發送

4. **離線** (🔴 紅色)
   - 狀態：`ConnectionStatus.disconnected`
   - 顯示：`離線模式，訊息將在連線後發送`
   - 說明：WebSocket 未連接，提供重連按鈕

5. **重新連線中** (🔵 藍色)
   - 狀態：`ConnectionStatus.reconnecting`
   - 顯示：`重新連線中...`
   - 說明：正在嘗試重新建立連接

### 🔧 互動功能
- **手動重連**：離線狀態下點擊「重連」按鈕
- **自動隱藏**：連線正常時自動隱藏狀態欄
- **即時更新**：狀態變化時立即反映

## 技術實現

### 文件結構
```
lib/presentation/k19_screen/
├── widgets/
│   └── connection_status_bar.dart    # 狀態欄組件
├── controller/
│   └── k19_controller.dart           # 控制器（已擴展）
└── k19_screen.dart                   # 主畫面（已整合）
```

### 核心組件

#### ConnectionStatusBar
```dart
class ConnectionStatusBar extends StatefulWidget {
  final K19Controller controller;
  
  // 使用 StatefulWidget 和定時器來更新狀態
  // 每 500ms 檢查一次連接狀態
  // 避免 GetX 的複雜性，提供更穩定的狀態更新
}
```

#### K19Controller 擴展
```dart
class K19Controller extends GetxController {
  // 新增公開方法
  bool get isWebSocketConnected => socketService.isConnected;
  bool get canSendMessage => socketService.canSendMessage;
  void retryConnection() => socketService.manualReconnect();
}
```

### 整合方式
```dart
// 在 K19Screen 的聊天內容區域使用 Stack
Container(
  child: Stack(
    children: [
      // 聊天內容
      ListView.builder(...),
      
      // 🔥 浮動狀態欄 - 放在聊天內容上方
      Positioned(
        top: 8,
        left: 8,
        right: 8,
        child: ConnectionStatusBar(controller: controller),
      ),
    ],
  ),
)
```

## 技術實現細節

### 狀態更新機制
- **智能偵測**：只在 K19Screen 可見時才開始偵測
- **定時器更新**：每 500ms 檢查一次連接狀態
- **狀態比較**：只有狀態變化時才觸發 UI 更新
- **記憶體管理**：組件銷毀時自動取消定時器

### 性能優化
- **避免頻繁重建**：只在狀態變化時更新 UI
- **輕量級檢查**：直接訪問 WebSocket 服務狀態
- **自動清理**：dispose 時清理資源
- **智能啟動**：只在需要時才開始偵測

### 偵測行為
```dart
void _checkVisibility() {
  final isK19Visible = widget.controller.cc.isK19Visible.value;
  
  if (isK19Visible && !_isVisible) {
    // K19Screen 變為可見，開始偵測
    _isVisible = true;
    _startMonitoring();
    print('🔍 狀態欄：開始偵測連接狀態');
  } else if (!isK19Visible && _isVisible) {
    // K19Screen 變為隱藏，停止偵測
    _isVisible = false;
    _stopMonitoring();
    print('🔍 狀態欄：停止偵測連接狀態');
  }
}
```

### 偵測時機
1. **K19Screen 顯示時**：開始偵測連接狀態
2. **K19Screen 隱藏時**：停止偵測，節省資源
3. **App 生命週期變化時**：自動調整偵測狀態
4. **狀態變化時**：立即更新 UI 並記錄日誌

## 設計優勢

### 1. 不影響頁面佈局
- **局部顯示**：只在聊天內容上方顯示，不影響整個頁面
- **滑動覆蓋**：K19Screen 作為滑動覆蓋層時，狀態欄不會遮擋底層頁面
- **精確定位**：使用 Positioned 精確控制狀態欄位置

### 2. 用戶體驗優化
- **非侵入性**：不遮擋重要內容
- **只在需要時顯示**：連線正常時自動隱藏
- **即時反饋**：狀態變化時立即反映

### 3. 視覺設計
- **緊湊尺寸**：36px 高度，最小化影響
- **半透明效果**：85% 透明度，保持可讀性
- **圓角設計**：18px 圓角，與聊天氣泡風格一致

## 使用方式

### 1. 自動顯示
狀態欄會根據 WebSocket 連接狀態自動顯示/隱藏：
- 連線正常時：隱藏
- 連線異常時：顯示對應狀態

### 2. 手動重連
當顯示離線狀態時，用戶可以：
1. 點擊「重連」按鈕
2. 系統會嘗試重新建立連接
3. 狀態會更新為「正在連線」

### 3. 狀態監控
狀態欄會實時監控：
- WebSocket 連接狀態
- Session ID 有效性
- AI 回覆狀態

## 設計原則

### 1. 局部化顯示
- 只在聊天內容區域顯示
- 不影響整個頁面佈局
- 適合滑動覆蓋層設計

### 2. 用戶友好
- 清晰的狀態描述
- 直觀的顏色編碼
- 簡單的互動操作

### 3. 性能優化
- 使用 Obx 進行響應式更新
- 避免不必要的重建
- 平滑的動畫效果

## 未來擴展

### 可能的改進
1. **網路狀態檢測**：結合系統網路狀態
2. **離線訊息佇列**：支援離線時訊息暫存
3. **自定義樣式**：支援主題切換
4. **統計資訊**：顯示連接時間、重連次數等

### 配置選項
```dart
class ConnectionStatusBarConfig {
  final bool showWhenConnected;     // 連線時是否顯示
  final Duration autoHideDelay;     // 自動隱藏延遲
  final bool enableRetryButton;     // 是否啟用重連按鈕
  final Color backgroundColor;      // 自定義背景色
  final double opacity;             // 自定義透明度
}
```

## 注意事項

1. **狀態檢測頻率**：避免過於頻繁的狀態檢查
2. **動畫性能**：確保動畫不會影響滾動性能
3. **記憶體管理**：正確處理組件生命週期
4. **錯誤處理**：妥善處理異常狀態

## 測試建議

### 測試場景
1. **正常連線**：驗證自動隱藏
2. **網路中斷**：驗證離線狀態顯示
3. **連線恢復**：驗證狀態更新
4. **手動重連**：驗證重連功能
5. **狀態切換**：驗證動畫效果
6. **滑動覆蓋**：驗證不影響底層頁面

### 測試方法
```dart
// 模擬不同狀態
controller.socketService.disconnect();  // 模擬離線
controller.socketService.connect();     // 模擬連線
controller.isAiReplying.value = true;   // 模擬回覆中
```

## 修正說明

### 問題描述
原本設計將狀態欄放在整個頁面層級，導致 K19Screen 作為滑動覆蓋層時會遮擋底層頁面。

### 解決方案
將狀態欄移到 K19Screen 內部，使用 Stack 佈局讓狀態欄浮動在聊天內容上方，這樣：
- ✅ 不會遮擋底層頁面
- ✅ 只在聊天區域顯示
- ✅ 保持原有的功能完整性
- ✅ 視覺效果更加精確 