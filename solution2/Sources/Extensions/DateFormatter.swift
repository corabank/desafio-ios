import Foundation

extension DateFormatter {
    static let defaultLocale = Locale(identifier: "pt_BR")
    
    static var decoderDateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter
    }
    
    /// Formated date using relative days like "Today", "Yesterday" or weekdays name
    static func relativeWeekday(from date: Date) -> String {
        let relativeDateFormatted = DateFormatter()
        relativeDateFormatted.dateStyle = .short
        relativeDateFormatted.locale = defaultLocale
        relativeDateFormatted.doesRelativeDateFormatting = true

        let weekdayFormatter = DateFormatter()
        weekdayFormatter.locale = defaultLocale
        weekdayFormatter.setLocalizedDateFormatFromTemplate("EEEE")
        
        let relativeDay = relativeDateFormatted.string(from: date)
        let weekday: String
    
        if relativeDay.rangeOfCharacter(from: .decimalDigits) == nil {
            weekday = relativeDay
        } else {
            weekday = weekdayFormatter.string(from: date)
        }
        return weekday
    }
}
