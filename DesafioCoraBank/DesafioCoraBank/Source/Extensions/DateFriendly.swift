//
//  DateFriendly.swift
//  DesafioCoraBank
//
//  Created by Roger Sanoli on 23/04/20.
//  Copyright © 2020 RogerSanoli. All rights reserved.
//

import Foundation

extension Date {
    
    func friendlyDescription() -> String {
        
        let currentDate: Date = Date()
        let calendar: Calendar = Calendar.current
        let components: DateComponents = calendar.dateComponents([.minute, .hour, .day, .weekOfMonth, .month, .year], from: self, to: currentDate)
        
        let year = components.year ?? 0
        let month = components.month ?? 0
        let weekOfMonth = components.weekOfMonth ?? 0
        let day = components.day ?? 0
        let hour = components.hour ?? 0
        let minute = components.minute ?? 0
        
        if year > 0 {
            return "\(year) \(year == 1 ? "time_year".localized : "time_year_plural".localized) " + "time_ago".localized
        } else if month > 0 {
            return "\(month) \(month == 1 ? "time_month".localized : "time_month_plural".localized) " + "time_ago".localized
        } else if weekOfMonth > 0 {
            return "\(weekOfMonth) \(weekOfMonth == 1 ? "time_week".localized : "time_week_plural".localized) " + "time_ago".localized
        } else if day > 0 {
            return "\(day) \(day == 1 ? "time_day".localized : "time_day_plural".localized) " + "time_ago".localized
        } else if hour > 0 {
            return "\(hour) \(hour == 1 ? "time_hour".localized : "time_hour_plural".localized) " + "time_ago".localized
        } else if minute > 0 {
            return "\(minute) \(minute == 1 ? "time_minute".localized : "time_minute_plural".localized) " + "time_ago".localized
        } else {
            return "time_just_now".localized
            
        }}
    
}
