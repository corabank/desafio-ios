//
//  Date+withDatesBetweenDates.swift
//  cora
//
//  Created by Lucas Silveira on 17/04/21.
//

import Foundation

extension Date {
    func daysBetween(date: Date) -> Int {
        return Date.daysBetween(started: self, ended: date)
    }
    
    static func daysBetween(started: Date, ended: Date) -> Int {
        let calendar = Calendar.current
        let date1 = calendar.startOfDay(for: started)
        let date2 = calendar.startOfDay(for: ended)
        let result = calendar.dateComponents([.day], from: date1, to: date2)
        return result.value(for: .day)!
    }
}
