//
//  Date+withDatesBetweenDates.swift
//  cora
//
//  Created by Lucas Silveira on 17/04/21.
//

import Foundation

extension Date {
    /// Returns an Integer with number of days until today's date
    var numberOfDaysTilToday: Int {
        return Date.daysBetween(started: self, ended: Date())
    }
    
    /// Returns the number of days between to  dates
    /// - Parameter started: Date
    /// - Parameter ended: Date
    static func daysBetween(started: Date, ended: Date) -> Int {
        let calendar = Calendar.current
        let date1 = calendar.startOfDay(for: started)
        let date2 = calendar.startOfDay(for: ended)
        let result = calendar.dateComponents([.day], from: date1, to: date2)
        return result.value(for: .day)!
    }
}
