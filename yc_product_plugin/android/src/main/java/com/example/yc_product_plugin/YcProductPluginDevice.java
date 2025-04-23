package com.example.yc_product_plugin;

import android.Manifest;
import android.app.Activity;
import android.app.Application;
import android.content.Context;
import android.content.pm.PackageManager;
import android.graphics.Color;
import android.os.Build;
import android.os.Handler;
import android.provider.CalendarContract;
import android.text.TextUtils;
import android.util.Log;
import android.view.View;

import androidx.annotation.NonNull;
import androidx.core.app.ActivityCompat;
import androidx.core.content.ContextCompat;

import com.realsil.sdk.core.preference.SharedPrefesHelper;
import com.wevey.selector.dialog.DialogInterface;
import com.wevey.selector.dialog.MDAlertDialog;
import com.yucheng.ycbtsdk.Constants;
import com.yucheng.ycbtsdk.YCBTClient;
import com.yucheng.ycbtsdk.bean.ScanDeviceBean;
import com.yucheng.ycbtsdk.response.BleConnectResponse;
import com.yucheng.ycbtsdk.response.BleScanListResponse;
import com.yucheng.ycbtsdk.response.BleScanResponse;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;

import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.MethodChannel;

public class YcProductPluginDevice {

    static boolean isNeedReplay = true;

    static ArrayList<Map<String, Object>> list = new ArrayList<Map<String, Object>>();

    static ArrayList<Map<String, Object>> deviceList = new ArrayList<Map<String, Object>>();

    /**
     * 连接设备
     *
     * @param arguments
     * @param result
     */
    public static void connectDevice(Object arguments, @NonNull MethodChannel.Result result) {

        Log.d("MARK-", "发起设备连接 Android connectDevice : ");
        isNeedReplay = true;
        String macAddress = (String) arguments;
        YCBTClient.connectBle(macAddress, new BleConnectResponse() {
            @Override
            public void onConnectResponse(int i) {

                if (isNeedReplay == false) {
                    return;
                }

                Log.d("MARK-", "设备连接 onConnectResponse: " + i);

                isNeedReplay = false;
                result.success(0 == i ||
                        YCBTClient.connectState() == Constants.BLEState.ReadWriteOK);
            }
        });
    }

    /**
     * 断开设备连接
     *
     * @param arguments
     * @param result
     */
    public static void disConnectDevice(Object arguments, @NonNull MethodChannel.Result result) {
        String macAddress = (String) arguments;
        YCBTClient.disconnectBle();
        result.success(true);
    }


    /**
     * 停止扫描
     *
     * @param result
     */
    public static void stopScanDevice(@NonNull MethodChannel.Result result) {

        YCBTClient.stopScanBle();
        result.success(null);
    }

    /**
     * 搜索设备
     *
     * @param result
     */
    public static void scanDevice(Context context, Object arguments, @NonNull MethodChannel.Result result) {


        if (!hasPermission(context)) {
            return;
        }
        YCBTClient.stopScanBle();
        int time = (int) arguments; // 这里是秒

       // deviceList.clear();

//        YCBTClient.startScanBle(new BleScanResponse() {
//            @Override
//            public void onScanResponse(int i, ScanDeviceBean scanDeviceBean) {
//                Log.d("LHY", "获取设备: onScanResponse");
//                if (scanDeviceBean != null) {
//
//                    Log.d("LHY", "获取设备: " + scanDeviceBean.getDeviceName() + ", " +
//                            scanDeviceBean.getDeviceMac() + "," + scanDeviceBean.getDeviceRssi());
//
//                    Map<String, Object> deviceInfo =
//                            new HashMap<String, Object>();
//                    if(TextUtils.isEmpty(scanDeviceBean.getDeviceName())){
//                        String name = SharedPrefesHelper.getSharedPreferences(context,"flutter").getString(scanDeviceBean.getDeviceMac(),"");
//                        deviceInfo.put("name", name);
//                    }else{
//                        deviceInfo.put("name", scanDeviceBean.getDeviceName());
//                        SharedPrefesHelper.getSharedPreferences(context,"flutter").edit().putString(scanDeviceBean.getDeviceMac(),scanDeviceBean.getDeviceName());
//                    }
//
//                    deviceInfo.put("macAddress", scanDeviceBean.getDeviceMac());
//                    deviceInfo.put("deviceIdentifier", scanDeviceBean.getDeviceMac());
//                    deviceInfo.put("rssiValue", scanDeviceBean.getDeviceRssi());
//
//                    deviceInfo.put("deviceColor", scanDeviceBean.ringColor);
//                    deviceInfo.put("deviceIndex", scanDeviceBean.ringNumber);
//                    deviceInfo.put("imageIndex", scanDeviceBean.imageId);
//
//                    boolean isHasDevice = false;
//                     for (int j = 0; j < list.size(); j++) {
//                         if (scanDeviceBean.getDeviceMac().equals(list.get(j).get("macAddress"))) {
////                             isHasDevice = true;
////                             break;
//                             list.remove(j);
//                             j--;
//                         }
//                     }
//                //    if (!isHasDevice) {
//                        list.add(deviceInfo);
//                  //  }
//
//                } else {
//                    Log.d("LHY", "获取设备: null");
//                }
//            }
//        }, time);

        int productId = 0x7810;

        YCBTClient.startScanBle(new BleScanListResponse() {
//            @Override
//            public void onScanResponse(int code, ScanDeviceBean scanDeviceBean) {
//                //   parseScanResult(code,scanDeviceBean);
//                if (scanDeviceBean != null) {
//                    Log.d("LHY", "获取设备onScanResponse: " + scanDeviceBean.getDeviceName() + ", " +
//                            scanDeviceBean.getDeviceMac() + "," + scanDeviceBean.getDeviceRssi());
//                } else {
//                    Log.d("LHY", "获取设备onScanResponse: null");
//                }
//            }

            @Override
            public void onScanListResponse(int i, List<ScanDeviceBean> deviceBeanList) {
                if(deviceBeanList!=null) {
                    Log.d("LHY", "获取设备onScanListResponse: " + deviceBeanList.size());
//                deviceList.addAll(deviceBeanList);
//                Collections.sort(deviceList);

                    if (deviceBeanList.size() > 0) {
                        for (int j = 0; j < deviceBeanList.size(); j++) {
                            Log.d("LHY", "获取设备: " + deviceBeanList.get(j).getDeviceName() + ", " +
                                    deviceBeanList.get(j).getDeviceMac() + "," + deviceBeanList.get(j).getDeviceRssi());

                            Map<String, Object> deviceInfo =
                                    new HashMap<String, Object>();
                            if (TextUtils.isEmpty(deviceBeanList.get(j).getDeviceName())) {
                                String name = SharedPrefesHelper.getSharedPreferences(context, "flutter").getString(deviceBeanList.get(j).getDeviceMac(), "");
                                deviceInfo.put("name", name);
                            } else {
                                deviceInfo.put("name", deviceBeanList.get(j).getDeviceName());
                                SharedPrefesHelper.getSharedPreferences(context, "flutter").edit().putString(deviceBeanList.get(j).getDeviceMac(), deviceBeanList.get(j).getDeviceName());
                            }

                            deviceInfo.put("macAddress", deviceBeanList.get(j).getDeviceMac());
                            deviceInfo.put("deviceIdentifier", deviceBeanList.get(j).getDeviceMac());
                            deviceInfo.put("rssiValue", deviceBeanList.get(j).getDeviceRssi());

                        deviceInfo.put("deviceColor", deviceBeanList.get(j).ringColor);
                        deviceInfo.put("deviceIndex", deviceBeanList.get(j).ringNumber);
                        deviceInfo.put("imageIndex", deviceBeanList.get(j).imageId);

                            deviceList.add(deviceInfo);
                        }
                    }
                }
            }
        }, time);

        // 定时任务
        new Handler().postDelayed(new Runnable() {
                    @Override
                    public void run() {
                        result.success(deviceList);
                    }
                }, time * 1000);
    }


    /**
     * 设置蓝牙状态监听
     */
    public static void setupDeviceStateObserver(
            Handler handler,
            EventChannel.EventSink eventSink) {

        YCBTClient.registerBleStateChange(code -> {
            int state = setupBlutetoothState(code);
         Log.d("LHY", "setupDeviceStateObserver: 蓝牙状态" + state);

            Map map = new HashMap();
            map.put(YcProductPluginFlutterType.NativeEventType.bluetoothStateChange, state);

            // 如果是DFU怎么办
            if (code == Constants.BLEState.ReadWriteOK) {

                Map<String, Object> deviceInfo =
                        new HashMap<String, Object>();

                deviceInfo.put("name", YCBTClient.getBindDeviceName());
                deviceInfo.put("macAddress", YCBTClient.getBindDeviceMac());
                deviceInfo.put("deviceIdentifier", YCBTClient.getBindDeviceMac());
                deviceInfo.put("rssiValue", 0);

                map.put(YcProductPluginFlutterType.NativeEventType.deviceInfo, deviceInfo);
            }

            handler.post(new Runnable() {
                @Override
                public void run() {
                    eventSink.success(map);
                }
            });



        });
    }

    public static boolean hasPermission(Context context) {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
            if (ContextCompat.checkSelfPermission(context, Manifest.permission.BLUETOOTH_SCAN) != PackageManager.PERMISSION_GRANTED
                    || ContextCompat.checkSelfPermission(context, Manifest.permission.BLUETOOTH_CONNECT) != PackageManager.PERMISSION_GRANTED) {

                return false;
            }
        }
        return true;
    }

    /**
     * 获取当前状态
     *
     * @param result
     */
    public static void getBluetoothState(@NonNull MethodChannel.Result result) {
        int state = setupBlutetoothState(YCBTClient.connectState());
        result.success(state);
    }

    /**
     * 适配蓝牙状态
     *
     * @param getState
     * @return
     */
    private static int setupBlutetoothState(int getState) {

        int state =
                YcProductPluginFlutterType.BluetoothState.off;

        if (getState == Constants.BLEState.ReadWriteOK) {
            state = YcProductPluginFlutterType.BluetoothState.connected;
        } else if (getState == Constants.BLEState.TimeOut) {
            state = YcProductPluginFlutterType.BluetoothState.connectFailed;
        } else if (getState == Constants.BLEState.Disconnect) {
            state = YcProductPluginFlutterType.BluetoothState.disconnected;
        } else if (getState == Constants.BLEState.NotOpen) {
            state = YcProductPluginFlutterType.BluetoothState.off;
        } else {
            state = YcProductPluginFlutterType.BluetoothState.on;
        }

        return state;
    }
}
