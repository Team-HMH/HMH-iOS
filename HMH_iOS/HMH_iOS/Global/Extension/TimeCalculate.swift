//
//  TimeCalculate.swift
//  HMH_iOS
//
//  Created by 김보연 on 1/15/24.
//

import Foundation

func convertMillisecondsToHoursAndMinutes(milliseconds: Int) -> (hours: Int, minutes: Int) {
    let totalMinutes = milliseconds / (1000 * 60)
    let hours = totalMinutes / 60
    let remainingMinutes = totalMinutes % 60
    return (hours, remainingMinutes)
}
