import Foundation

struct StatementHeaderContent {
    private let dayInfo: DayInfo
    
    init(dayInfo: DayInfo) {
        self.dayInfo = dayInfo
    }
    
    private var dayOfMonthDateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = DateFormatter.defaultLocale
        dateFormatter.setLocalizedDateFormatFromTemplate("MMMM dd")
        return dateFormatter
    }

    var formattedDate: String {
        let dayOfMonth = dayOfMonthDateFormatter.string(from: dayInfo.date)
        let weekday = DateFormatter.relativeWeekday(from: dayInfo.date)
        
        return "\(weekday) - \(dayOfMonth)".capitalizingFirstLetter()
    }
    
    var dayBalance: String {
        dayInfo.dayBalance.getCurrencyString()
    }
}
