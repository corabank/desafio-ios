import UIKit

final class Button: UIButton {
    enum Style: CGFloat {
        case large = 64
        case medium = 48
    }
    
    init(title: String,
         titleColor: UIColor,
         action: UIAction,
         icon: UIImage? = nil,
         style: Style
    ) {
        super.init(frame: .zero)
        configuration = defaultConfiguration(title: title,
                                             titleColor: titleColor,
                                             icon: icon)
        addAction(action, for: .touchUpInside)
        tintColor = .clear
        height(style.rawValue)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func defaultConfiguration(
        title: String,
        titleColor: UIColor,
        icon: UIImage? = nil
    ) -> UIButton.Configuration {
        var config = UIButton.Configuration.filled()
        
        let attributes =  AttributeContainer([
            .font: Font.Regular.primarySubtitle,
            .foregroundColor: titleColor
        ])
        
        config.attributedTitle = AttributedString(title, attributes: attributes)
        
        if let icon = icon {
            config.image = icon
            config.imagePlacement = .trailing
            config.imagePadding = 150
            config.titleAlignment = .leading
        } else {
            config.titleAlignment = .center
        }
        
        return config
    }
}
