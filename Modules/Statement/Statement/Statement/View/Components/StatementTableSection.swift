import UIKit
import ViewCode
import Components

final class StatementTableSection: UIView {
    
    private lazy var stack: UIStackView = {
        let stack: UIStackView = UIStackView(frame: .zero)
        stack.alignment = .center
        stack.axis = .horizontal
        return stack
    }()
    
    private lazy var contentWrapper: UIStackView = {
        let stack: UIStackView = UIStackView(frame: .zero)
        stack.axis = .vertical
        return stack
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .justified
        label.textColor = Colors.darkGray
        label.font = UIFont.systemFont(ofSize: Dimensions.fontMinimal)
        return label
    }()
    
    private lazy var valueLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .right
        label.textColor = Colors.darkGray
        label.font = UIFont.systemFont(ofSize: Dimensions.fontMinimal, weight: .bold)
        return label
    }()
    
    public init() {
        super.init(frame: .zero)
        setupView()
    }

    required init?(coder: NSCoder) {
        return nil
    }
    
    func set(date: String, value: String) {
        dateLabel.text = date
        valueLabel.text = value
    }
}

extension StatementTableSection: ViewCode {
    func setSubviews() {
        self.addSubview(contentWrapper)
        //contentWrapper.addArrangedSubview(Spacer(size: 8))
        contentWrapper.addArrangedSubview(stack)
        //contentWrapper.addArrangedSubview(Spacer(size: 12))
        stack.addArrangedSubview(dateLabel)
        stack.addArrangedSubview(valueLabel)
    }
    
    func setConstraints() {
        contentWrapper.setHeightEqual(to: self)
        contentWrapper.anchor(leading: self.leadingAnchor,
                     trailing: self.trailingAnchor,
                     paddingLeft: Dimensions.medium,
                     paddingRight: Dimensions.medium)
        
        dateLabel.setHeightEqual(to: stack)
        valueLabel.setHeightEqual(to: stack)
        valueLabel.size(width: 90)
    }
    
    func extraSetups() {
        self.backgroundColor = Colors.lightGray
    }
}
