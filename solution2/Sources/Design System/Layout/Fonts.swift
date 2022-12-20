import class UIKit.UIFont

fileprivate enum FontName {
    static let bold = "Avenir-Heavy"
    static let regular = "Avenir-Book"
}

enum Font {
    enum Highlighted {
        /// Bold 28
        static let primaryTitle = UIFont(name: FontName.bold, size: 28)
        
        /// Bold 22
        static let secondaryTitle = UIFont(name: FontName.bold, size: 22)
        
        /// Bold 16
        static let tertiaryTitle = UIFont(name: FontName.bold, size: 16)
        
        /// Regular 14
        static let primarySubtitle = UIFont(name: FontName.bold, size: 14)
        
        /// Bold 12
        static let secondarySubtitle = UIFont(name: FontName.bold, size: 12)
    }
    
    enum Regular {
        /// Regular 28
        static let primaryTitle = UIFont(name: FontName.regular, size: 28)
        
        /// Regular 22
        static let secondaryTitle = UIFont(name: FontName.regular, size: 22)
        
        /// Regular 16
        static let tertiaryTitle = UIFont(name: FontName.regular, size: 16)
        
        /// Regular 14
        static let primarySubtitle = UIFont(name: FontName.regular, size: 14)
        
        /// Regular 12
        static let secondarySubtitle = UIFont(name: FontName.regular, size: 12)
    }
}
