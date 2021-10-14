import Foundation

extension Array where Element: Numeric {
    var total: Element { reduce(0, +) }
}
