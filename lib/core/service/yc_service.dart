import 'package:yc_product_plugin/yc_product_plugin.dart';

/// YC 服務
class YcService {
  static void startRunStep() async {
    var res = await YcProductPlugin()
        .appControlSport(DeviceSportState.start, DeviceSportType.run);
    if (res != null && res.statusCode == PluginState.succeed) {
      print("開啟實時跑步");
    } else {
      print("開啟實時跑步失敗");
    }
  }

  static void stopRunStep() async {
    var res = await YcProductPlugin()
        .appControlSport(DeviceSportState.stop, DeviceSportType.run);
    if (res != null && res.statusCode == PluginState.succeed) {
      print("停止實時跑步");
    } else {
      print("停止實時跑步失敗");
    }
  }

  static void setListeningTime(int interval) async {
    var res =
        await YcProductPlugin().setDeviceHealthMonitoringMode(interval: 60);
    if (res != null && res.statusCode == PluginState.succeed) {
      print("設定偵測時間成功");
    } else {
      print("設定偵測時間失敗");
    }
  }
}
