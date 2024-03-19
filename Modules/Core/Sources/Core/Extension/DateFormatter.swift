//
//  File.swift
//  
//
//  Created by João Gabriel Dourado Cervo on 17/03/24.
//

import Foundation

public extension DateFormatter {
    public static var shared = DateFormatter()
}

public extension Date {
    /**
        Gets the day of the week for current date. It uses the `EEEE` dateFormat
     
        - Returns: The day of the week, or `nil` if not possible.
     */
    func dayOfWeek() -> String? {
        let dateFormatter = DateFormatter.shared
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self).capitalized(with: Locale.current)
    }
}
