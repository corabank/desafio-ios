import Foundation

class CachedNumberFormatter {
    struct Key: Equatable, Hashable {
        let numberStyle: NumberFormatter.Style
        let locale: Locale
        
        static func == (lhs: Key, rhs: Key) -> Bool {
            return lhs.numberStyle == rhs.numberStyle &&
                   lhs.locale == rhs.locale
        }
    }
    
    static let shared = CachedNumberFormatter()
    
    private init() { }
    
    private var cachedNumberFormatter = [Key: NumberFormatter]()
    
    private func cachedNumberFormatter(numberStyle: NumberFormatter.Style,
                                       locale: Locale = Locale(identifier: "pt_BR")) -> NumberFormatter {
        let key = Key(numberStyle: numberStyle, locale: locale)
        if let cached = self.cachedNumberFormatter[key] {
            return cached
        }
        
        let formatter = NumberFormatter()
        formatter.numberStyle = numberStyle
        formatter.locale = locale
        
        self.cachedNumberFormatter[key] = formatter
        
        return formatter
    }
}

extension CachedNumberFormatter {
    func currencyFormat() -> NumberFormatter {
        return self.cachedNumberFormatter(numberStyle: .currency)
    }
}
