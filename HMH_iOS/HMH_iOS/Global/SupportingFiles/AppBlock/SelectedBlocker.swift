//
//  SelectedBlocker.swift
//  HMH_iOS
//
//  Created by 지희의 MAC on 1/4/24.
//

import Foundation
import SwiftUI
import ManagedSettings
import DeviceActivity
import FamilyControls

class SelectedBlocker: ObservableObject {
    
    @AppStorage ("selectedApps", store: UserDefaults(suiteName: "group.65NSM7Z327.com.HMH.group"))
    var shieldedApps = FamilyActivitySelection()
    
    let store = ManagedSettingsStore()
    let model = BlockingApplicationModel.shared
    
    // 앱 차단 로직
    func block(completion: @escaping (Result<Void, Error>) -> Void) {
        // 선택한 앱 토큰 가져오기
        let selectedAppTokens = model.selectedAppsTokens
        
        // DeviceActivityCenter를 사용하여 모든 선택한 앱 토큰에 대한 액티비티 차단
        let deviceActivityCenter = DeviceActivityCenter()
        
        // 모니터 DeviceActivitySchedule 설정
        let blockSchedule = DeviceActivitySchedule(
            intervalStart: DateComponents(hour: 0, minute: 0),
            intervalEnd: DateComponents(hour: 23, minute: 59),
            repeats: true
        )
        
        store.shield.applications = shieldedApps.applicationTokens
        do {
            try deviceActivityCenter.startMonitoring(DeviceActivityName.once, during: blockSchedule)
            
        } catch {
            completion(.failure(error))
            return
        }
        completion(.success(()))
    }
    
    func unblockAllApps() {
        store.shield.applications = []
    }
    
}
