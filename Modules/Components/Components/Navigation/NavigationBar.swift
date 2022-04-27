import UIKit
import ViewCode
import Resources

public final class NavigationBar: UIView {
    
    public init() {
        super.init(frame: .zero)
        setupView()
    }

    required init?(coder: NSCoder) {
        return nil
    }
    
    private lazy var stack: UIStackView = {
        let stack: UIStackView = UIStackView(frame: .zero)
        stack.alignment = .center
        stack.axis = .horizontal
        stack.spacing = Dimensions.small
        return stack
    }()
    
    private lazy var leadingIconBox: UIView = {
        let view: UIView = UIView(frame: .zero)
        return view
    }()
    
    private lazy var leadingIcon: UIImageView = {
        let view: UIImageView = UIImageView(image: UIImage(imageLiteralResourceName: Images.arrow))
        return view
    }()
    
    private lazy var trailingIconBox: UIView = {
        let view: UIView = UIView(frame: .zero)
        return view
    }()
    
    private lazy var trailingIcon: UIImageView = {
        let view: UIImageView = UIImageView(image: UIImage(imageLiteralResourceName: Images.arrow))
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Extrato"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = Colors.darkGray
        label.font = UIFont.systemFont(ofSize: Dimensions.fontTiny)
        return label
    }()
}

extension NavigationBar: ViewCode {
    public func setSubviews() {
        self.addSubview(stack)
        stack.addArrangedSubview(leadingIconBox)
        stack.addArrangedSubview(titleLabel)
        stack.addArrangedSubview(trailingIconBox)
        leadingIconBox.addSubview(leadingIcon)
        trailingIconBox.addSubview(trailingIcon)
    }
    
    public func setConstraints() {
        leadingIconBox.size(width: 40)
        leadingIconBox.anchor(top: stack.topAnchor,
                              leading: stack.leadingAnchor,
                              bottom: stack.bottomAnchor)
        leadingIcon.size(height: Dimensions.medium, width: Dimensions.medium)
        leadingIcon.anchor(top: leadingIconBox.topAnchor,
                           leading: leadingIconBox.leadingAnchor,
                           paddingTop: Dimensions.small,
                           paddingLeft: Dimensions.small)
        
        trailingIconBox.size(width: 40)
        trailingIconBox.anchor(top: stack.topAnchor,
                               bottom: stack.bottomAnchor,
                               trailing: stack.trailingAnchor)
        trailingIcon.size(height: Dimensions.medium, width: Dimensions.medium)
        trailingIcon.anchor(top: trailingIconBox.topAnchor,
                           trailing: trailingIconBox.trailingAnchor,
                           paddingTop: Dimensions.small,
                           paddingRight: Dimensions.small)
        
        self.size(height: 60)
    }
    
    public func extraSetups() {
        self.backgroundColor = Colors.lightGray
    }
}
