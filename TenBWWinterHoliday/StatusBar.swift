//
//  StatusBar.swift
//  TenBWWinterHoliday
//
//  Created by Alan Richard on 1/30/21.
//

import Foundation

struct StatusBar {
    var time: Date
    var batteryPercentage: Int
    
    var formattedTime: String {
        DateFormatter.localizedString(from: time, dateStyle: .none, timeStyle: .short)
    }
    
    var formattedTimeShort: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        var result = formatter.string(from: time)
        if result.starts(with: "0") {
            result.removeFirst()
        }
        if result.contains(" ") {
            result = String(result.split(separator: " ")[0])
        }
        return result
    }
    
    init() {
        self.time = StatusBar.getRandomTime()
        self.batteryPercentage = StatusBar.getRandomBatteryPercentage()
    }
    
    static func getRandomTime() -> Date {
        let rangeStartsFromSecond = 6 * 3600 // 6:00 AM
        let rangeEndsAtSecond = 23 * 3600    // 11:00 PM
        return Date(timeIntervalSince1970: TimeInterval(Int.random(in: rangeStartsFromSecond...rangeEndsAtSecond)))
    }
    
    static func getRandomBatteryPercentage() -> Int {
        return Int.random(in: 20...100)
    }
}
