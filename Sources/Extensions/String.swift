import UIKit

extension String {
    func capitalizingFirstLetter() -> String {
        let first = String(prefix(1)).capitalized
        let other = String(dropFirst())
        return first + other
    }
    
    func withBoldText(text: String, regularFont: UIFont?, boldFont: UIFont?) -> NSMutableAttributedString? {
        guard let regularFont = regularFont, let boldFont = boldFont else { return nil }
        let fullString = NSMutableAttributedString(string: self, attributes: [NSAttributedString.Key.font: regularFont])
        let boldFontAttribute: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: boldFont]
        let range = (self as NSString).range(of: text)
        fullString.addAttributes(boldFontAttribute, range: range)
        return fullString
    }
}
