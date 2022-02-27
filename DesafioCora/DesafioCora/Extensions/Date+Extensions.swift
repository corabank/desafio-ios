//
//  Date+Extensions.swift
//  DesafioCora
//
//  Created by user205543 on 2/27/22.
//

import Foundation

extension Date {
    static func dateFrom(_ dateString: String) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter.date(from: dateString) ?? Date()
    }
    
    func formattedString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter.string(from: self)
    }
}
