//
//  ScreenTime.swift
//  HMH_iOS
//
//  Created by 지희의 MAC on 1/10/24.
//

import SwiftUI
import Foundation
import FamilyControls
import ManagedSettings
import DeviceActivity

class ScreenTime: ObservableObject {
    
    static let shared = ScreenTime()
    private init() {}

    var selectedApps = FamilyActivitySelection()
    {
        didSet {
            parsedApps = selectedApps.rawValue
            print(selectedApps)
            handleStartDeviceActivityMonitoring(interval: 50)
        }
    }
    
    let store = ManagedSettingsStore()
    let deviceActivityCenter = DeviceActivityCenter()
    
    @AppStorage("parsedApps", store: UserDefaults(suiteName: "group.65NSM7Z327.com.HMH.group"))
    var parsedApps = "하이"
    var hashValue: [Int] = []
    
    func saveHashValue() {
        selectedApps.applicationTokens.forEach {
            hashValue.append($0.hashValue)
        }
    }
    
    func handleResetSelection() {
        selectedApps = FamilyActivitySelection()
    }
    
    func handleStartDeviceActivityMonitoring(includeUsageThreshold: Bool = true, interval: Int) {
        //datacomponent타입을 써야함
        let dateComponents = Calendar.current.dateComponents([.hour, .minute, .second], from: Date())
        
        // 새 스케쥴 시간 설정
        let schedule = DeviceActivitySchedule(
            intervalStart: DateComponents(hour: dateComponents.hour, minute: dateComponents.minute, second: dateComponents.second),
            intervalEnd: DateComponents(hour: 23, minute: 59, second: 59),
            repeats: false,
            //warning Time 설정해야 알람
            warningTime: DateComponents(minute: 1)
        )
         //새 이벤트 생성
        let event = DeviceActivityEvent(
            applications: selectedApps.applicationTokens,
            categories: selectedApps.categoryTokens,
            webDomains: selectedApps.webDomainTokens,
            //threshold - 이 시간이 되면 특정한 event가 발생 deviceactivitymonitor에 eventdidreachthreshold
            threshold: DateComponents(second: interval)
            )
        
        do {
            ScreenTime.shared.deviceActivityCenter.stopMonitoring()
            try ScreenTime.shared.deviceActivityCenter.startMonitoring(
                .once,
                during: schedule,
                events: [.monitoring: event]
            )
            print("📺📺모니터링 시작📺📺")
        } catch {
            print("Unexpected error: \(error).")
        }
    }
    
    func handleSetBlockApplication() {
        store.shield.applications = selectedApps.applicationTokens.isEmpty ? nil : selectedApps.applicationTokens
        print(selectedApps.applicationTokens)
//        store.shield.applicationCategories = selectedApps.categoryTokens.isEmpty ? nil
//        : ShieldSettings.ActivityCategoryPolicy.specific(selectedApps.categoryTokens)
        store.shield.applicationCategories = ShieldSettings.ActivityCategoryPolicy.all()
    }
    
    func stopDeviceMonitoring(){
        ScreenTime.shared.deviceActivityCenter.stopMonitoring()
    }
    
}

//MARK: FamilyActivitySelection Parser
extension FamilyActivitySelection: RawRepresentable {
    public init?(rawValue: String) {
        guard let data = rawValue.data(using: .utf8),
            let result = try? JSONDecoder().decode(FamilyActivitySelection.self, from: data)
        else {
            return nil
        }
        self = result
    }

    public var rawValue: String {
        guard let data = try? JSONEncoder().encode(self),
            let result = String(data: data, encoding: .utf8)
        else {
            return "[]"
        }
        return result
    }
}

extension DeviceActivityName {
    static let once = Self("once")
}

extension DeviceActivityEvent.Name {
    static let monitoring = Self("monitoring")
}
