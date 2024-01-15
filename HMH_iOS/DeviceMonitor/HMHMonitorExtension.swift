//
//  HMHMonitorExtension.swift
//  DeviceMonitor
//
//  Created by 지희의 MAC on 1/15/24.
//

import Foundation
import DeviceActivity
import ManagedSettings

class MyMonitorExtension: DeviceActivityMonitor {
    let store = ManagedSettingsStore()
    
    
    // You can use the `store` property to shield apps when an interval starts, ends, or meets a threshold.
    override func intervalDidStart(for activity: DeviceActivityName) {
        super.intervalDidStart(for: activity)
        
        
        // Shield selected applications.
//        let model = MyModel()
//        let applications = model.selectionToShield.applications
//        store.shield.applications = applications.isEmpty ? nil : applications
    }
}
