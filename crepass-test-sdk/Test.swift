//
//  Test.swift
//  crepass-test-sdk
//
//  Created by 백승용 on 9/19/24.
//

import Foundation
import UIKit
import CoreTelephony
import CoreLocation
public class Test{
    public init() {}
     
     // 기기 이름 수집
     public func getDeviceName() -> String {
         return UIDevice.current.name
     }
     
     // iOS 버전 수집
     public func getOSVersion() -> String {
         return UIDevice.current.systemVersion
     }
     
     // 배터리 상태 수집
     public func getBatteryLevel() -> Int {
         UIDevice.current.isBatteryMonitoringEnabled = true
         return Int(UIDevice.current.batteryLevel * 100) // 퍼센트로 반환
     }
     
     // 화면 밝기 수집
     public func getScreenBrightness() -> Float {
         return Float(UIScreen.main.brightness)
     }
     
     // 위치 서비스 활성화 여부 수집
     public func isLocationServicesEnabled() -> Bool {
         return CLLocationManager.locationServicesEnabled()
     }
     
     // 통신사 정보 수집
     public func getCarrierName() -> String? {
         let networkInfo = CTTelephonyNetworkInfo()
         let carrier = networkInfo.subscriberCellularProvider
         return carrier?.carrierName
     }
     
     // 기기 모델 수집
     public func getDeviceModel() -> String {
         return UIDevice.current.model
     }
     
     // 권한 정보 수집
     public func getRequestedPermissions() -> [String] {
         // 수동으로 작성해야 하는 부분
         return [
             "NSLocationWhenInUseUsageDescription",
             "NSCameraUsageDescription",
             "NSMicrophoneUsageDescription"
         ]
     }
     
     // 부여된 권한 정보 수집
     public func getGrantedPermissions() -> [String] {
         // 실제로 권한을 확인하는 로직 필요 (임시 값)
         return [
             "NSLocationWhenInUseUsageDescription"
         ]
     }
     
     // 기기 탈옥 여부 확인
     public func isDeviceJailbroken() -> Bool {
         // 간단한 탈옥 여부 확인 방법 (더 정교한 방법이 필요할 수 있음)
         let paths = ["/Applications/Cydia.app",
                      "/Library/MobileSubstrate/MobileSubstrate.dylib",
                      "/bin/bash",
                      "/usr/sbin/sshd",
                      "/etc/apt"]
         for path in paths {
             if FileManager.default.fileExists(atPath: path) {
                 return true
             }
         }
         return false
     }
     
     // 전체 정보를 JSON 형태로 반환
     public func collectAllInfo() -> [String: Any] {
         let settingsInformation: [String: Any] = [
             "battery_level": getBatteryLevel(),
             "location_services_enabled": isLocationServicesEnabled() ? "true" : "false",
             "screen_brightness": getScreenBrightness()
         ]
         
         let requestedPermissions = getRequestedPermissions()
         let grantedPermissions = getGrantedPermissions()
         
         let settings: [String: Any] = [
             "settings_information": settingsInformation,
             "requested_permissions": requestedPermissions,
             "granted_permissions": grantedPermissions,
             "ios_version_name": getOSVersion(),
             "manufacturer": "Apple",
             "model": getDeviceModel(),
             "device": "iPhone",
             "brand": "Apple",
             "is_device_jailbroken": isDeviceJailbroken() ? "true" : "false"
         ]
         
         let hardware: [String: Any] = [
             "device_information": [
                 "Product": "iPhone",
                 "Model": "iPhone 13 Pro" // 실제 모델명으로 수정 필요
             ]
         ]
         
         let allInfo: [String: Any] = [
             "settings": settings,
             "hardware": hardware
         ]
         
         return allInfo
     }

}
