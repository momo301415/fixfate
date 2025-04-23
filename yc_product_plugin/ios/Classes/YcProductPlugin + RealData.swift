//
//  YcProductPlugin + RealData.swift
//  Pods
//
//  Created by LiuHuiYang on 2023/11/17.
//

import Flutter
import UIKit
import YCProductSDK

// MARK: - 设备控制
extension YcProductPlugin {
    
    
    /// 设置设备监听
    public func setupDeviceRealDataObserver() {
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(receiveRealTimeData(_ :)),
            name: YCProduct.receivedRealTimeNotification,
            object: nil
        )
        
    }
    
    /// 接收到实时数据
    @objc private func receiveRealTimeData( _ notification: Notification
    ) {
        
        guard let info = notification.userInfo as? [String: Any] else {
            return
        }
        
        // 实时心率
        if let response = info[YCReceivedRealTimeDataType.heartRate.toString]
            as? YCReceivedDeviceReportInfo,
           //                       let device = response.device,
           let heartRate = response.data as? UInt8,
           heartRate > 0 {
            
            eventSink?(
                [NativeEventType.deviceRealHeartRate: heartRate]
            )
        }
        
        // 血压
        else if let response =
                    info[YCReceivedRealTimeDataType.bloodPressure.toString] as?
                    YCReceivedDeviceReportInfo,
                //           let device = response.device,
                let bloodPressureInfo = response.data as?
                    YCReceivedRealTimeBloodPressureInfo ,
                bloodPressureInfo.heartRate >= 0,
                bloodPressureInfo.systolicBloodPressure >= 0,
                bloodPressureInfo.diastolicBloodPressure >= 0,
                bloodPressureInfo.systolicBloodPressure >=
                    bloodPressureInfo.diastolicBloodPressure {
            
            var info = [
                "heartRate": bloodPressureInfo.heartRate,
                "systolicBloodPressure": bloodPressureInfo.systolicBloodPressure,
                "diastolicBloodPressure":
                    bloodPressureInfo.diastolicBloodPressure,
            ]
            
            // 有 HRV 就传 HRV
            if bloodPressureInfo.hrv > 0,
               bloodPressureInfo.hrv <= 150 {
                info["hrv"] = bloodPressureInfo.hrv
                eventSink?(
                    [
                        NativeEventType.deviceRealHRV: "\(bloodPressureInfo.hrv)"
                    ]
                )
                return
            }
            
            eventSink?(
                [
                    NativeEventType.deviceRealBloodPressure: info
                ]
            )
        }
        
        
        // 血氧
        else if let response = info[YCReceivedRealTimeDataType.bloodOxygen.toString]
                    as? YCReceivedDeviceReportInfo,
                //                    let device = response.device,
                let bloodOxygen = response.data as? UInt8,
                bloodOxygen > 0 {
            
            eventSink?([NativeEventType.deviceRealBloodOxygen: bloodOxygen])
        }
        
        // 温度
        else if let response = info[YCReceivedRealTimeDataType.comprehensiveData.toString] as? YCReceivedDeviceReportInfo,
                let info = response.data as? YCReceivedComprehensiveDataModeInfo  {
            
            let temperature = "\(info.temperature)"
            
            let bloodGlucose = "\(info.bloodGlucose)"
            if( !bloodGlucose.isEmpty && info.bloodGlucose != 0 && info.bloodGlucose != 0x0F){
                eventSink?([NativeEventType.deviceRealBloodGlucose: bloodGlucose])
                return
            }
            
            guard let temperatureString = String(format: "%.1f", temperature).components(separatedBy: ".").last,
                  let temperatureDecimal = Int(temperatureString),
                  temperatureDecimal != 0x0F else {
                
                return
            }
            
            eventSink?([NativeEventType.deviceRealTemperature: temperature])
        }

        // 压力
        else if let response = info[YCReceivedRealTimeDataType.bodyIndexData.toString] as? YCReceivedDeviceReportInfo,
                let info = response.data as? YCReceivedBodyIndexInfo,
                let pressure: Double? = info.pressureIndex,
                pressure ?? 0>0{
           
                eventSink?([NativeEventType.deviceRealPressure: pressure])
           
        }
        
        // 实时步数
        else if let response = notification.userInfo as? [String: Any],
                let info = response[YCReceivedRealTimeDataType.step.toString] as?
                    YCReceivedDeviceReportInfo,
                //           let device = response.device,
                let sportInfo = info.data as? YCReceivedRealTimeStepInfo {
            
            let distance = sportInfo.distance
            let step = sportInfo.step
            let calories = sportInfo.calories
            
            eventSink?(
                [
                    NativeEventType.deviceRealStep: [
                        "distance": distance,
                        "step": step,
                        "calories": calories
                    ]
                ]
            )
        }
        
        /// 实时运动状态
        else if let response =
                    info[YCReceivedRealTimeDataType.realTimeMonitoringMode.toString] as?
                    YCReceivedDeviceReportInfo,
                //              let device = response.device,
                let data = response.data as? YCReceivedMonitoringModeInfo {
            
            
            let sportTime = data.startTimeStamp
            let sportHearRate = data.heartRate
            let sportStep = Int(data.modeStep)
            let sportCalories = Int(data.modeCalories)
            let sportDistance = Int(data.modeDistance)

            let ppi = Int(data.ppi)
            let vo2max = Int(data.vo2max)

            // if(sportTime == 0 && vo2max != 0){
            //     eventSink?(
            //     [
            //         NativeEventType.deviceRealVo2max: [
            //             "vo2max": vo2max
            //         ]
            //     ]
            // )
            // return
            // }
            
            eventSink?(
                [
                    NativeEventType.deviceRealSport: [
                        "time": sportTime,
                        "heartRate": sportHearRate,
                        "distance": sportDistance,
                        "step": sportStep,
                        "calories": sportCalories,
                        "ppi": ppi,
                        "vo2max": vo2max
                    ]
                ]
            )
        }
        
        // 实时PPG
        else if let response =
                    info[YCReceivedRealTimeDataType.ppg.toString] as?
                    YCReceivedDeviceReportInfo,
                //              let device = response.device,
                let ppgData = response.data as? [Int32] {
            
            //            print("++== ecg的数据: \(ppgData)")
            eventSink?([NativeEventType.deviceRealPPGData: ppgData])
        }
        
        // 实时ECG
        else if let response =
                    info[YCReceivedRealTimeDataType.ecg.toString] as?
                    YCReceivedDeviceReportInfo,
                //              let device = response.device,
                let ecgDatas = response.data as? [Int32] {
            
            // 进行滤波操作
            let mvDatas = parseECGdata(ecgDatas)
            
            eventSink?(
                [
                    NativeEventType.deviceRealECGData: ecgDatas,
                    NativeEventType.deviceRealECGFilteredData: mvDatas
                ]
            )
        }
    }
    
    
    /// 解析ECG数据
    /// - Parameter datas: <#datas description#>
    private func parseECGdata(_ datas: [Int32]) -> [Float] {
        
        var mvDatas = [Float]()
        for data in datas {
            
            var ecgValue: Float = 0
            ecgValue = ecgAlgorithmManager.processECGData(Int(data))
            
            if (ecgDataCount % 3 == 0) {
                
                let tmpEcgData =
                (ecgValue + previousData + previousPreviousData) / 3.0
                
                // 转换为 mv => / 40 / 1000
                let realValue = tmpEcgData / 40.0 / 1000.0
                
                //                if realValue >= 500 {
                //                    mvDatas.append(500)
                //                } else if realValue <= -500 {
                //                    mvDatas.append(-500)
                //                } else {
                //                    mvDatas.append(realValue)
                //                }
                
                mvDatas.append(realValue)
            }
            
            ecgDataCount += 1
            previousPreviousData = previousData
            previousData = ecgValue
        }
        
        return mvDatas
    }
}
