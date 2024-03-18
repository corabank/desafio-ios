//
//  File.swift
//  
//
//  Created by João Gabriel Dourado Cervo on 17/03/24.
//

import Foundation

public extension String {
    public func asDate(currentFormat: String = "yyyy-MM-dd'T'HH:mm:ss'Z'", toFormat: String = "HH:mm") -> String {
        let dateFormatter = DateFormatter.shared
        dateFormatter.dateFormat = currentFormat
        dateFormatter.locale = Locale(identifier: "pt_BR")
        
        let date = dateFormatter.date(from: self) ?? Date()
        dateFormatter.dateFormat = toFormat
        return dateFormatter.string(from: date)
    }
}
