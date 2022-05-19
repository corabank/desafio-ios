import Foundation

struct StatementHeaderContent {
    private let dayInfo: DayInfo
    
    init(dayInfo: DayInfo) {
        self.dayInfo = dayInfo
    }
    
    private let locale = Locale(identifier: "pt_BR")
    
    private var relativeFormatter: DateFormatter {
        let relativeDateFormatted = DateFormatter()
        relativeDateFormatted.dateStyle = .short
        relativeDateFormatted.locale = locale
        relativeDateFormatted.doesRelativeDateFormatting = true
        return relativeDateFormatted
    }
    
    private var weekdayFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = locale
        dateFormatter.setLocalizedDateFormatFromTemplate("EEEE")
        return dateFormatter
    }
    
    private var dayOfMonthDateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = locale
        dateFormatter.setLocalizedDateFormatFromTemplate("MMMM dd")
        return dateFormatter
    }
    
    /// Formated date using relative days like "Today", "Yesterday" or weekdays name
    var formattedDate: String {
        let dayOfMonth = dayOfMonthDateFormatter.string(from: dayInfo.date)
        let relativeDay = relativeFormatter.string(from: dayInfo.date)
        let weekday: String
    
        if relativeDay.rangeOfCharacter(from: .decimalDigits) == nil {
            weekday = relativeDay
        } else {
            weekday = weekdayFormatter.string(from: dayInfo.date)
        }
    
        return "\(weekday) - \(dayOfMonth)".capitalizingFirstLetter()
    }
    
    var dayBalance: String {
        dayInfo.dayBalance.getCurrencyString()
    }
}
