//
//  Date+Extension.swift
//  CoraChallenge
//
//  Created by Fellipe Ricciardi Chiarello on 4/24/22.
//

import Foundation

extension String {
    func formatStringDate(withFormat format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SZZZZZ"
        let date = dateFormatter.date(from: self)
        dateFormatter.dateFormat = format
        
        let finalDateStr = dateFormatter.string(from: date!)

        return finalDateStr
    }
    
    func stringToDate() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SZZZZZ"
        let date = dateFormatter.date(from: self)
        
        dateFormatter.dateFormat = "dd/MM/yyyy"
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: date!)
        
        let finalDate = calendar.date(from: components)
        
        return finalDate!
    }
    
    
}
