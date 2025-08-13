import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';
import '../controller/k19_controller.dart';

enum ConnectionStatus {
  connected, // 🟢 已連線
  connecting, // 🔄 正在連線
  unstable, // ⚠️ 連線不穩定
  disconnected, // ❌ 離線
  reconnecting, // 🔄 重新連線中
  rateLimited, // 🚫 已達使用上限
}

class ConnectionStatusBar extends StatefulWidget {
  final K19Controller controller;

  const ConnectionStatusBar({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<ConnectionStatusBar> createState() => _ConnectionStatusBarState();
}

class _ConnectionStatusBarState extends State<ConnectionStatusBar>
    with WidgetsBindingObserver {
  Timer? _updateTimer;
  ConnectionStatus _currentStatus = ConnectionStatus.connected;
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    // 檢查 K19Screen 是否可見
    _checkVisibility();

    // 監聽 K19Screen 可見性變化
    ever(widget.controller.cc.isK19Visible, (bool visible) {
      _checkVisibility();
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _updateTimer?.cancel();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    _checkVisibility();
  }

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

  void _startMonitoring() {
    // 立即檢查一次狀態
    _updateStatus();

    // 每 500ms 更新一次狀態
    _updateTimer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      if (_isVisible) {
        _updateStatus();
      } else {
        timer.cancel();
      }
    });
  }

  void _stopMonitoring() {
    _updateTimer?.cancel();
    _updateTimer = null;
  }

  void _updateStatus() {
    if (!_isVisible) return;

    final newStatus = _getConnectionStatus();
    if (newStatus != _currentStatus) {
      setState(() {
        _currentStatus = newStatus;
      });
      print('🔍 狀態欄檢測：${_getStatusText(newStatus)}');
    }
  }

  @override
  Widget build(BuildContext context) {
    // 如果 K19Screen 不可見，不顯示狀態欄
    if (!_isVisible) {
      print('🔍 狀態欄：K19Screen 不可見，隱藏狀態欄');
      return const SizedBox.shrink();
    }

    // 如果已連線且穩定，隱藏狀態欄
    if (_currentStatus == ConnectionStatus.connected) {
      print('🔍 狀態欄：連線正常，隱藏狀態欄');
      return const SizedBox.shrink();
    }

    print('🔍 狀態欄：顯示狀態 - ${_getStatusText(_currentStatus)}');

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 36,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: _getStatusColor(_currentStatus).withOpacity(0.85),
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(
              _getStatusIcon(_currentStatus),
              color: Colors.white,
              size: 14,
            ),
            const SizedBox(width: 6),
            Expanded(
              child: Text(
                _getStatusText(_currentStatus),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            if (_currentStatus == ConnectionStatus.disconnected)
              GestureDetector(
                onTap: () => _retryConnection(),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    '重連',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  ConnectionStatus _getConnectionStatus() {
    // 🔥 優先檢查 429 錯誤狀態
    if (widget.controller.socketService.isRateLimited) {
      print('🔍 狀態欄檢測：已達使用上限');
      return ConnectionStatus.rateLimited;
    }

    // 直接從 WebSocket 服務獲取狀態
    final isConnected = widget.controller.socketService.isConnected;
    final canSend = widget.controller.socketService.canSendMessage;
    final isReplying = widget.controller.isAiReplying.value;

    print('🔍 狀態欄檢測詳細信息：');
    print('  - isConnected: $isConnected');
    print('  - canSend: $canSend');
    print('  - isReplying: $isReplying');
    print('  - sessionId: ${widget.controller.socketService.sessionId}');

    // 使用傳入的參數來檢查狀態
    if (!isConnected) {
      print('🔍 狀態欄檢測：離線狀態');
      return ConnectionStatus.disconnected;
    }

    // 檢查是否可以發送訊息
    if (!canSend) {
      // 如果已連接但無法發送，可能是正在初始化或連線不穩定
      if (isReplying) {
        print('🔍 狀態欄檢測：連線不穩定');
        return ConnectionStatus.unstable;
      } else {
        print('🔍 狀態欄檢測：正在連線');
        return ConnectionStatus.connecting;
      }
    }

    // 檢查是否正在回覆但連線不穩定
    if (isReplying) {
      // 如果正在回覆但沒有有效的 session，可能是連線不穩定
      if (!canSend) {
        print('🔍 狀態欄檢測：回覆中但連線不穩定');
        return ConnectionStatus.unstable;
      }
    }

    print('🔍 狀態欄檢測：已連線');
    return ConnectionStatus.connected;
  }

  IconData _getStatusIcon(ConnectionStatus status) {
    switch (status) {
      case ConnectionStatus.connected:
        return Icons.wifi;
      case ConnectionStatus.connecting:
        return Icons.wifi_find;
      case ConnectionStatus.unstable:
        return Icons.wifi_off;
      case ConnectionStatus.disconnected:
        return Icons.wifi_off;
      case ConnectionStatus.reconnecting:
        return Icons.refresh;
      case ConnectionStatus.rateLimited:
        return Icons.block;
    }
  }

  Color _getStatusColor(ConnectionStatus status) {
    switch (status) {
      case ConnectionStatus.connected:
        return const Color(0xFF4CAF50); // 綠色
      case ConnectionStatus.connecting:
        return const Color(0xFFFF9800); // 橙色
      case ConnectionStatus.unstable:
        return const Color(0xFFFFC107); // 黃色
      case ConnectionStatus.disconnected:
        return const Color(0xFFF44336); // 紅色
      case ConnectionStatus.reconnecting:
        return const Color(0xFF2196F3); // 藍色
      case ConnectionStatus.rateLimited:
        return const Color(0xFF9C27B0); // 紫色
    }
  }

  String _getStatusText(ConnectionStatus status) {
    switch (status) {
      case ConnectionStatus.connected:
        return '已連線';
      case ConnectionStatus.connecting:
        return '正在連線...';
      case ConnectionStatus.unstable:
        return '連線不穩定，訊息可能延遲';
      case ConnectionStatus.disconnected:
        return '連線中，訊息將在連線後發送';
      case ConnectionStatus.reconnecting:
        return '重新連線中...';
      case ConnectionStatus.rateLimited:
        return '已達使用上限';
    }
  }

  void _retryConnection() {
    print('🔄 手動重連...');
    widget.controller.retryConnection();
  }
}
