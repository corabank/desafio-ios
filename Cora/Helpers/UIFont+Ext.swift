import UIKit

extension UIFont {
    static var homeTitle: UIFont { getFontOrDefault(name: "Avenir-Heavy", size: 28) }
    static var homeSubTitle: UIFont { getFontOrDefault(name: "Avenir-Roman", size: 28) }
    static var body1: UIFont { getFontOrDefault(name: "Avenir-Roman", size: 16) }
    static var body2: UIFont { getFontOrDefault(name: "Avenir-Roman", size: 14) }
    static var title3: UIFont { getFontOrDefault(name: "Avenir-Roman", size: 22) }
    static var title3Bold: UIFont { getFontOrDefault(name: "Avenir-Heavy", size: 22) }
    static var caption: UIFont { getFontOrDefault(name: "Avenir-Roman", size: 12) }
    static var captionBold: UIFont { getFontOrDefault(name: "Avenir-Heavy", size: 12) }

    private static func getFontOrDefault(name: String, size: CGFloat) -> UIFont {
        UIFont(name: name, size: size) ?? .systemFont(ofSize: size)
    }
}
