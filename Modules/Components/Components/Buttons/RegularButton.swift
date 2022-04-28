import UIKit
import Resources

public final class RegularButton: UIButton {

    public init() {
        super.init(frame: .zero)
    }

    required init?(coder: NSCoder) {
        return nil
    }

    public func set(title: String, alignment: UIControl.ContentHorizontalAlignment, style: RegularButtonStyle, icon: Icon = .nothing) {
        self.setTitle(title, for: .normal)
        self.contentHorizontalAlignment = alignment
        self.titleEdgeInsets = UIEdgeInsets(top: 0,
                                            left: Dimensions.medium,
                                            bottom: 0,
                                            right: Dimensions.medium)
        self.layer.cornerRadius = Dimensions.border
        self.layer.borderWidth = Dimensions.minimal
        self.layer.borderColor = Colors.white.cgColor
        setStyle(style)
        setIcon(icon)
    }
    
    private func setStyle(_ style: RegularButtonStyle) {
        switch style {
        case .white:
            self.backgroundColor = Colors.white
            self.setTitleColor(Colors.pink, for: .normal)
            self.tintColor = Colors.pink
        case .pink:
            self.backgroundColor = Colors.pink
            self.setTitleColor(Colors.white, for: .normal)
            self.tintColor = Colors.white
        }
    }
    
    private func setIcon(_ icon: Icon) {
        var image: UIImage?
        
        switch icon {
        case .arrow:
            image = UIImage(named: Images.arrow)
        case .share:
            image = UIImage(named: Images.download)
        case .nothing:
            image = nil
        }
        
        let tintImage = image?.withRenderingMode(.alwaysTemplate)
        self.setImage(tintImage, for: .normal)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        guard let imageView = imageView else { return }
        imageEdgeInsets = UIEdgeInsets(top: 5, left: (bounds.width - 35), bottom: 5, right: 5)
        titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: (imageView.frame.width))
    }
}

extension RegularButton: RegularButtonProtocol {
    public func state(_ state: ButtonState) {
        switch state {
        case .disabled:
            self.backgroundColor = Colors.mediumGray
            self.isEnabled = false
        case .enabled:
            self.backgroundColor = .systemPink
            self.isEnabled = true
        }
    }
}

public enum RegularButtonStyle { case white, pink }
public enum Icon { case nothing, arrow, share }
