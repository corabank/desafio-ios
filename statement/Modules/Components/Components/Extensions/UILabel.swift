import UIKit

public extension UILabel {
    func strikeThrough() {
        let attributedText = NSAttributedString(
            string: self.text ?? "",
            attributes: [.strikethroughStyle: NSUnderlineStyle.single.rawValue]
        )
        
        self.attributedText = attributedText
    }
}
