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
        case .pink:
            self.backgroundColor = Colors.pink
            self.setTitleColor(Colors.white, for: .normal)
        }
    }
    
    private func setIcon(_ icon: Icon) {
        switch icon {
        case .arrow:
            self.setImage(UIImage(named: Images.arrow), for: .normal)
        case .share:
            self.setImage(.actions, for: .normal)
        case .nothing:
            self.setImage(.none, for: .normal)
        }
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        guard let imageView = imageView else { return }
        imageEdgeInsets = UIEdgeInsets(top: 5, left: (bounds.width - 35), bottom: 5, right: 5)
        titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: (imageView.frame.width))
    }
}

public enum RegularButtonStyle { case white, pink }
public enum Icon { case nothing, arrow, share }
