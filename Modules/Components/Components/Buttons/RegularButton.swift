import UIKit

public final class RegularButton: UIButton {

    public init() {
        super.init(frame: .zero)
    }

    required init?(coder: NSCoder) {
        return nil
    }

    public func set(title: String, alignment: UIControl.ContentHorizontalAlignment, style: RegularButtonStyle) {
        self.setTitle(title, for: .normal)
        // self.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        self.contentHorizontalAlignment = alignment
        self.titleEdgeInsets = UIEdgeInsets(top: 0,
                                            left: Dimensions.medium,
                                            bottom: 0,
                                            right: Dimensions.medium)
        self.layer.cornerRadius = Dimensions.border
        self.layer.borderWidth = Dimensions.minimal
        self.layer.borderColor = Colors.white.cgColor
        setStyle(style)
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
}

public enum RegularButtonStyle { case white, pink }
