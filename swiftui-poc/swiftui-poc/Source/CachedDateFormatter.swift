import Foundation

class CachedDateFormatter {
    struct Key: Equatable, Hashable {
        let format: String
        let locale: Locale
        
        static func == (lhs: Key, rhs: Key) -> Bool {
            return lhs.format == rhs.format &&
                   lhs.locale == rhs.locale
        }
    }
    
    static let shared = CachedDateFormatter()
    
    private init() { }
    
    private var cachedDateFormatters = [Key: DateFormatter]()
    
    private func cachedDateFormatter(dateFormat: String,
                                     locale: Locale = Locale(identifier: "pt_BR")) -> DateFormatter {
        let key = Key(format: dateFormat, locale: locale)
        if let cached = self.cachedDateFormatters[key] {
            return cached
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = locale
        dateFormatter.dateFormat = dateFormat
        
        self.cachedDateFormatters[key] = dateFormatter
        
        return dateFormatter
    }
}

extension CachedDateFormatter {
    func parseFormat() -> DateFormatter {
        let format = "yyyy-MM-dd'T'HH:mm:ssZ"
        return self.cachedDateFormatter(dateFormat: format)
    }
    
    func presentationFormat() -> DateFormatter {
        let format = "dd/MM/yy"
        return self.cachedDateFormatter(dateFormat: format)
    }
}
