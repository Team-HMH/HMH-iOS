//
//  ActivityReport.swift
//  DeviceReport
//
//  Created by 지희의 MAC on 1/15/24.
//

import Foundation

// MARK: - Device Activity Report 관련 데이터 모델이 정의되어 있는 파일입니다.
import Foundation
import ManagedSettings

struct ActivityReport {
    let totalDuration: TimeInterval
    let apps: [AppDeviceActivity]
}

struct AppDeviceActivity: Identifiable {
    var id: String
    var displayName: String
    var duration: TimeInterval
    var numberOfPickups: Int
    var token: ApplicationToken?
}

extension TimeInterval {
    /// TimeInterval 타입 값을 00:00 형식의 String으로 변환해주는 메서드
    func toString() -> String {
        let time = NSInteger(self)
        let minutes = (time / 60) % 60
        let hours = (time / 3600)
        return String(format: "%0.2d:%0.2d", hours,minutes)
    }
}
