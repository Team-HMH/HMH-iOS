//
//  DeviceReport.swift
//  DeviceReport
//
//  Created by 지희의 MAC on 1/4/24.
//

import DeviceActivity
import SwiftUI

@main
struct DeviceReport: DeviceActivityReportExtension {
    var body: some DeviceActivityReportScene {
        // Create a report for each DeviceActivityReport.Context that your app supports.
        TotalActivityReport { totalActivity in
            TotalActivityView(totalActivity: totalActivity)
        }
        // Add more reports here...
    }
}
