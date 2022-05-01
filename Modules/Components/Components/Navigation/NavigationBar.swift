import UIKit
import ViewCode
import Resources

public final class NavigationBar: UIView {
    
    private var delegate: NavigationBarDelegate?
    private var share: Bool = false
    
    public init(title: String = "", share: Bool = false) {
        super.init(frame: .zero)
        self.share = share
        titleLabel.text = title
        setupView()
    }

    required init?(coder: NSCoder) {
        return nil
    }
    
    private lazy var nav: UIStackView = {
        let stack: UIStackView = UIStackView(frame: .zero)
        stack.axis = .vertical
        return stack
    }()
    
    private lazy var stack: UIStackView = {
        let stack: UIStackView = UIStackView(frame: .zero)
        stack.alignment = .center
        stack.axis = .horizontal
        stack.spacing = Dimensions.small
        return stack
    }()
    
    private lazy var leadingButton: UIButton = {
        let button: UIButton = UIButton(frame: .zero)
        button.setImage(UIImage(named: Images.back), for: .normal)
        button.addTarget(self, action: #selector(tapBack), for: .touchUpInside)
        return button
    }()
    
    private lazy var trailingButton: UIButton = {
        let button: UIButton = UIButton(frame: .zero)
        if share { button.setImage(UIImage(named: Images.download), for: .normal) }
        button.addTarget(self, action: #selector(tapShare), for: .touchUpInside)
        return button
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = Colors.darkGray
        label.font = UIFont.systemFont(ofSize: Dimensions.fontTiny)
        return label
    }()
}

extension NavigationBar: ViewCode {
    public func setSubviews() {
        self.addSubview(nav)
        nav.addArrangedSubview(stack)
        stack.addArrangedSubview(leadingButton)
        stack.addArrangedSubview(titleLabel)
        stack.addArrangedSubview(trailingButton)
    }
    
    public func setConstraints() {
        nav.setWidthEqual(to: self)
        nav.anchor(top: self.topAnchor,
                   bottom: self.bottomAnchor)
        
        stack.size(height: 56)
        stack.setWidthEqual(to: nav)
        
        titleLabel.setHeightEqual(to: stack)
        leadingButton.size(height: 40, width: 40)
        trailingButton.size(height: 40, width: 40)
    }
    
    public func extraSetups() {
        self.backgroundColor = Colors.lightGray
    }
}

extension NavigationBar: NavigationBarProtocol {
    @objc
    public func tapBack() {
        delegate?.tapBack()
    }
    
    @objc
    public func tapShare() {
        delegate?.tapShare()
    }
    
    public func set(delegate: NavigationBarDelegate) {
        self.delegate = delegate
    }
    
    public func set(title: String) {
        titleLabel.text = title
    }
}
