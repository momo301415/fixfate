import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:yc_product_plugin/yc_product_plugin.dart';
import 'dart:io';

class AppControlWidget extends StatefulWidget {
  const AppControlWidget({super.key});

  @override
  State<AppControlWidget> createState() => _AppControlWidgetState();

}

class _AppControlWidgetState extends State<AppControlWidget> {
  String _displayedText = "";

  final _items = [
    "Find device",
    "System operator",
    "BloodPressure calibration",
    "Temperature calibration",
    "Blood glucose calibration",
    "Today weather",
    "Tomorrow weather",
    "UricAcid calibration",
    "BloodFat calibration",
    "Android Push Notifications",

    "Set business card",
    "Query business card",

    "Set JL Contacts",
    "Query JL Contacts",

    "Real data upload",

    "Menstrual cycle",
    "UUID",

    // "Measure HR",
    // "Measure BP",
    // "Measure Spo2",
    // "Measure Temperature",

    "YC Contacts",
  ];

  @override
  void initState() {
    super.initState();

    YcProductPlugin().onListening((event) {
      if (event.keys.contains(NativeEventType.deviceRealStep)) {
        final stepInfo = event[NativeEventType.deviceRealStep];
        debugPrint('步数变化: $stepInfo');
         setState(() {
           _displayedText = stepInfo.toString();
         });
      }

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("App control"),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                _displayedText,
                textAlign: TextAlign.left,
                style: const TextStyle(
                  fontSize: 16.0,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: ListView.separated(
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      EasyLoading.show(status: "");
                      setState(() {
                        _displayedText = "";
                      });

                      switch (index) {
                        case 0:
                          YcProductPlugin().findDevice().then((value) {
                            if (value?.statusCode == PluginState.succeed) {
                              EasyLoading.showSuccess(_items[index]);
                              // final info = value?.data ;
                              // setState(() {
                              //   _displayedText = info.toString();
                              // });
                            } else {
                              EasyLoading.showError("${_items[index]} failed");
                            }
                          });


                        case 1:
                          YcProductPlugin().deviceSystemOperator(DeviceSystemOperator.shutDown).then((value) {
                            if (value?.statusCode == PluginState.succeed) {
                              EasyLoading.showSuccess(_items[index]);
                              // final info = value?.data ;
                              // setState(() {
                              //   _displayedText = info.toString();
                              // });
                            } else {
                              EasyLoading.showError("${_items[index]} failed");
                            }
                          });

                        case 2:
                          YcProductPlugin().bloodPressureCalibration(120, 80).then((value) {
                            if (value?.statusCode == PluginState.succeed) {
                              EasyLoading.showSuccess(_items[index]);
                              // final info = value?.data ;
                              // setState(() {
                              //   _displayedText = info.toString();
                              // });
                            } else {
                              EasyLoading.showError("${_items[index]} failed");
                            }
                          });

                        case 3:
                          YcProductPlugin().temperatureCalibration().then((value) {
                            if (value?.statusCode == PluginState.succeed) {
                              EasyLoading.showSuccess(_items[index]);
                              // final info = value?.data ;
                              // setState(() {
                              //   _displayedText = info.toString();
                              // });
                            } else {
                              EasyLoading.showError("${_items[index]} failed");
                            }
                          });

                        case 4:
                          YcProductPlugin().bloodGlucoseCalibration(DeviceBloodGlucoseCalibrationaMode.afterMeal, "7.2").then((value) {
                            if (value?.statusCode == PluginState.succeed) {
                              EasyLoading.showSuccess(_items[index]);
                              // final info = value?.data ;
                              // setState(() {
                              //   _displayedText = info.toString();
                              // });
                            } else {
                              EasyLoading.showError("${_items[index]} failed");
                            }
                          });

                        case 5: // 今日天气
                          YcProductPlugin().sendTodayWeather(DeviceWeatherType.snow, -20, 18, 12).then((value) {
                            if (value?.statusCode == PluginState.succeed) {
                              EasyLoading.showSuccess(_items[index]);
                              // final info = value?.data ;
                              // setState(() {
                              //   _displayedText = info.toString();
                              // });
                            } else {
                              EasyLoading.showError("${_items[index]} failed");
                            }
                          });

                        case 6: // 明日天气
                          YcProductPlugin().sendTomorrowWeather(DeviceWeatherType.sunny, 16, 33, 0).then((value) {
                            if (value?.statusCode == PluginState.succeed) {
                              EasyLoading.showSuccess(_items[index]);
                              // final info = value?.data ;
                              // setState(() {
                              //   _displayedText = info.toString();
                              // });
                            } else {
                              EasyLoading.showError("${_items[index]} failed");
                            }
                          });

                        case 7:
                          YcProductPlugin().uricAcidCalibration(800).then((value) {
                            if (value?.statusCode == PluginState.succeed) {
                              EasyLoading.showSuccess(_items[index]);
                              // final info = value?.data ;
                              // setState(() {
                              //   _displayedText = info.toString();
                              // });
                            } else {
                              EasyLoading.showError("${_items[index]} failed");
                            }
                          });

                        case 8:
                          YcProductPlugin().bloodFatCalibration("5.6").then((value) {
                            if (value?.statusCode == PluginState.succeed) {
                              EasyLoading.showSuccess(_items[index]);
                              // final info = value?.data ;
                              // setState(() {
                              //   _displayedText = info.toString();
                              // });
                            } else {
                              EasyLoading.showError("${_items[index]} failed");
                            }
                          });

                        case 9:
                          YcProductPlugin().appPushNotifications(AndroidDevicePushNotificationType.wechat, "你好", "吃了吗？").then((value) {
                            if (value?.statusCode == PluginState.succeed) {
                              EasyLoading.showSuccess(_items[index]);
                              // final info = value?.data ;
                              // setState(() {
                              //   _displayedText = info.toString();
                              // });
                            } else {
                              EasyLoading.showError("${_items[index]} failed");
                            }
                          });

                        case 10:
                          YcProductPlugin().sendBusinessCard(DeviceBusinessCardType.wechat, "https://me.wechat/xxxx").then((value) {
                            if (value?.statusCode == PluginState.succeed) {
                              EasyLoading.showSuccess(_items[index]);
                              // final info = value?.data ;
                              // setState(() {
                              //   _displayedText = info.toString();
                              // });
                            } else {
                              EasyLoading.showError("${_items[index]} failed");
                            }
                          });

                        case 11:
                          YcProductPlugin().queryBusinessCard(DeviceBusinessCardType.wechat).then((value) {
                            if (value?.statusCode == PluginState.succeed) {
                              EasyLoading.showSuccess(_items[index]);
                              final info = value?.data ;
                              setState(() {
                                _displayedText = info.toString();
                              });
                            } else {
                              EasyLoading.showError("${_items[index]} failed");
                            }
                          });

                        case 12:
                          final items = [
                            DeviceContactInfo("jack", "13800138000"),
                            DeviceContactInfo("聪明的一休哥！", "9553395587"),
                          ];
                          YcProductPlugin().updateJieLiDeviceContacts(items).then((value) {
                            if (value?.statusCode == PluginState.succeed) {
                              EasyLoading.showSuccess(_items[index]);

                            } else {
                              EasyLoading.showError("${_items[index]} failed");
                            }
                          });

                        case 13:
                          YcProductPlugin().queryJieLiDeviceContacts().then((value) {
                            if (value?.statusCode == PluginState.succeed) {
                              EasyLoading.showSuccess(_items[index]);
                              final info = value?.data ;
                              setState(() {
                                _displayedText = info.toString();
                              });
                            } else {
                              EasyLoading.showError("${_items[index]} failed");
                            }

                          });

                        case 14:
                          YcProductPlugin().realTimeDataUpload(true).then((value) {

                            if (value?.statusCode == PluginState.succeed) {
                              EasyLoading.showSuccess(_items[index]);
                              final info = value?.data ;
                              setState(() {
                                _displayedText = info.toString();
                              });
                            } else {
                              EasyLoading.showError("${_items[index]} failed");
                            }

                          });

                        case 15:
                          int time = DateTime.now().millisecondsSinceEpoch ~/ 1000;
                          YcProductPlugin().sendDeviceMenstrualCycle(time, 3, 28).then((value) {
                            if (value?.statusCode == PluginState.succeed) {
                              EasyLoading.showSuccess(_items[index]);
                              final info = value?.data ;
                              setState(() {
                                _displayedText = info.toString();
                              });
                            } else {
                              EasyLoading.showError("${_items[index]} failed");
                            }
                          });

                        case 16:
                          String uuid = "ABCD-1234678-4321-1131321";
                          YcProductPlugin().sendPhoneUUIDToDevice(uuid).then((value) {
                            if (value?.statusCode == PluginState.succeed) {
                              EasyLoading.showSuccess(_items[index]);
                              final info = value?.data ;
                              setState(() {
                                _displayedText = info.toString();
                              });
                            } else {
                              EasyLoading.showError("${_items[index]} failed");
                            }
                          });

                        case 17: // 设置玉成通讯录
                          final items = [
                            DeviceContactInfo("jack", "13800138000"),
                            DeviceContactInfo("聪明的一休哥！", "9553395587"),
                          ];
                          YcProductPlugin().updateDeviceContacts(items).then((value) {
                            if (value?.statusCode == PluginState.succeed) {
                              EasyLoading.showSuccess(_items[index]);

                            } else {
                              EasyLoading.showError("${_items[index]} failed");
                            }
                          });


                        default:
                          break;
                      }
                    },
                    child: ListTile(
                      title: Text("${index + 1}. ${_items[index]}"),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider();
                },
                itemCount: _items.length),
          ),
        ],
      ),
    );
  }
}
