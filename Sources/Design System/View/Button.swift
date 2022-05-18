import UIKit

final class Button: UIButton {
    enum Style: CGFloat {
        case large = 64
        case medium = 48
        case small = 20
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
    
    var imageTintColor: UIColor = .clear {
        didSet {
            configuration?.baseForegroundColor = imageTintColor
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setImagePadding()
    }
    
    private func setImagePadding() {
        guard configuration?.image != nil,
              configuration?.imagePadding == .zero,
              let titleWidth = titleLabel?.frame.width else {
            return
        }
        let buttonWidth = frame.width
        let iconSize: CGFloat = 24
        let spacing = Spacing.space04 * 2
        
        configuration?.imagePadding = buttonWidth - titleWidth - spacing - iconSize
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
        }
        return config
    }
}
