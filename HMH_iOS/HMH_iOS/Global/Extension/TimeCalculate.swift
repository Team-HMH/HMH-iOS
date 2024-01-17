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

func convertHoursAndMinutesToMilliseconds(hours: Int, minutes: Int) -> Int {
    let totalMinutes = hours * 60 + minutes
    let totalMilliseconds = totalMinutes * 60 * 1000
    return totalMilliseconds
}
