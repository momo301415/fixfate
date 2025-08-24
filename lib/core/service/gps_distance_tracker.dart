import 'dart:async';
import 'package:geolocator/geolocator.dart';

/// GPS距離追蹤器
/// 用於運動模式下計算累計移動距離
class GpsDistanceTracker {
  static const String _tag = 'GpsDistanceTracker';

  Position? _lastPosition;
  double _totalDistance = 0.0; // 累計距離(米)
  StreamSubscription<Position>? _positionStream;

  /// 距離更新回調
  Function(int)? _onDistanceUpdated;

  /// 開始GPS距離追蹤
  Future<void> startTracking() async {
    try {
      // 🔑 檢查定位服務
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        throw Exception('定位服務未啟用');
      }

      // 🔑 請求權限
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        throw Exception('定位權限被拒絕');
      }

      // 🎯 開始監聽位置變化
      const LocationSettings locationSettings = LocationSettings(
        accuracy: LocationAccuracy.high, // 高精度
        distanceFilter: 5, // 移動5米才觸發更新
      );

      _positionStream =
          Geolocator.getPositionStream(locationSettings: locationSettings)
              .listen(_onLocationUpdate, onError: _onLocationError);

      // 獲取初始位置
      _lastPosition = await Geolocator.getCurrentPosition();
      _totalDistance = 0.0;

      print('🗺️ [$_tag] GPS距離追蹤已啟動');
    } catch (e) {
      print('❌ [$_tag] GPS追蹤啟動失敗: $e');
      rethrow;
    }
  }

  /// 位置更新回調
  void _onLocationUpdate(Position newPosition) {
    if (_lastPosition != null) {
      print(
          '🗺️ [$_tag] 位置更新: ${newPosition.latitude}, ${newPosition.longitude}');
      // 🧮 計算距離
      double distance = Geolocator.distanceBetween(
        _lastPosition!.latitude,
        _lastPosition!.longitude,
        newPosition.latitude,
        newPosition.longitude,
      );

      // 🎯 精度過濾：只接受精度好的GPS點，並且有實際移動
      if (newPosition.accuracy <= 20.0 &&
          distance >= 2.0 &&
          distance <= 100.0) {
        _totalDistance += distance;
        print(
            '📍 [$_tag] GPS距離更新: +${distance.toInt()}m, 總計: ${_totalDistance.toInt()}m');

        // 🔄 通知UI更新
        _onDistanceUpdated?.call(_totalDistance.toInt());
      } else {
        print(
            '⚠️ [$_tag] GPS點被過濾: 精度${newPosition.accuracy.toInt()}m, 距離${distance.toInt()}m');
      }
    }

    _lastPosition = newPosition;
  }

  /// GPS錯誤處理
  void _onLocationError(dynamic error) {
    print('❌ [$_tag] GPS定位錯誤: $error');
  }

  /// 設置距離更新回調
  void setDistanceCallback(Function(int) callback) {
    _onDistanceUpdated = callback;
  }

  /// 停止追蹤
  void stopTracking() {
    _positionStream?.cancel();
    _positionStream = null;
    print('🛑 [$_tag] GPS距離追蹤已停止，總距離: ${_totalDistance.toInt()}m');
  }

  /// 獲取當前總距離
  int get totalDistanceInMeters => _totalDistance.toInt();

  /// 重置距離
  void resetDistance() {
    _totalDistance = 0.0;
    _lastPosition = null;
    print('🔄 [$_tag] GPS距離已重置');
  }
}
