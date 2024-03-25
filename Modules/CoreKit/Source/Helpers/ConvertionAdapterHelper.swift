//
//  ConvertionAdapterHelper.swift
//  CoreKit
//
//  Created by Erik Santos on 17/03/24.
//

import Foundation

public final class ConvertionAdapterHelper {
    public static var shared = ConvertionAdapterHelper()
    
    public func convertToCurrency(_ value: CGFloat) -> String {
        let valorEmReais = value / 100
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "pt_BR")

        if let formattedString = formatter.string(from: NSNumber(value: Double(valorEmReais))) {
            let valueWithoutConcurrency = formattedString.removeCurrencyPrefix()
            return valueWithoutConcurrency
        } else {
            return "0,00"
        }
    }
    
    public func extractTimeWithoutSeconds(from dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormatterType.yyyMMDDTHHmmssZ.rawValue
        
        if let date = dateFormatter.date(from: dateString) {
            let calendar = Calendar.current
            let components = calendar.dateComponents([.hour, .minute], from: date)
            if let hour = components.hour, let minute = components.minute {
                return String(format: "%02d:%02d", hour, minute)
            }
        }
        return "Error"
    }
    
    public func converToDateDetails(_ dateString: String, formatter: DateFormatterType) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formatter.rawValue
        if let date = dateFormatter.date(from: dateString) {
            let calendar = Calendar.current

            if calendar.isDateInToday(date) {
                let formattedDateFormatter = DateFormatter()
                formattedDateFormatter.dateFormat = "'Hoje' - d 'de' MMMM"
                formattedDateFormatter.locale = Locale(identifier: "pt_BR")
                let formattedDate = formattedDateFormatter.string(from: date)
               return formattedDate
            } else {
                let formattedDateFormatter = DateFormatter()
                formattedDateFormatter.dateFormat = "EEEE - d 'de' MMMM"
                formattedDateFormatter.locale = Locale(identifier: "pt_BR")
                let formattedDate = formattedDateFormatter.string(from: date)
                return formattedDate
            }
        } else {
            return "Error"
        }
    }
    
    public func formatCPFOrCNPJ(_ document: String, type: String) -> String {
        guard let type = DocumentType(rawValue: type) else { return "" }
        let cleanDocument = document.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
       
        switch type {
        case .cpf:
            let firstGroup = cleanDocument.prefix(3)
            let secondGroup = cleanDocument.dropFirst(3).prefix(3)
            let thirdGroup = cleanDocument.dropFirst(6).prefix(3)
            let lastGroup = cleanDocument.suffix(2)
            
            return "\(firstGroup).\(secondGroup).\(thirdGroup)-\(lastGroup)"
        case .cnpj:
            let firstGroup = cleanDocument.prefix(2)
            let secondGroup = cleanDocument.dropFirst(2).prefix(3)
            let thirdGroup = cleanDocument.dropFirst(5).prefix(3)
            let fourthGroup = cleanDocument.dropFirst(8).prefix(4)
            let lastGroup = cleanDocument.suffix(2)
            
            return "\(firstGroup).\(secondGroup).\(thirdGroup)/\(fourthGroup)-\(lastGroup)"
        }
    }
}
