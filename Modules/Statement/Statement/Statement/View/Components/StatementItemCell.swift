import UIKit
import ViewCode
import Components

final class StatementItemCell: UITableViewCell {
    
    private lazy var stack: UIStackView = {
        let stack: UIStackView = UIStackView(frame: .zero)
        stack.alignment = .center
        stack.axis = .horizontal
        return stack
    }()

    private lazy var textStack: UIStackView = {
        let stack: UIStackView = UIStackView(frame: .zero)
        stack.alignment = .center
        stack.axis = .vertical
        return stack
    }()
    
    private lazy var valueLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .justified
        label.textColor = Colors.black
        label.font = UIFont.systemFont(ofSize: Dimensions.fontSmall, weight: .bold)
        return label
    }()
    
    private lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .justified
        label.textColor = Colors.black
        label.font = UIFont.systemFont(ofSize: Dimensions.fontTiny)
        return label
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .justified
        label.textColor = Colors.darkGray
        label.font = UIFont.systemFont(ofSize: Dimensions.fontTiny)
        return label
    }()
    
    private lazy var iconBox: UIView = {
        let view: UIView = UIView(frame: .zero)
        return view
    }()
    
    private lazy var timeBox: UIView = {
        let view: UIView = UIView(frame: .zero)
        return view
    }()
    
    required init?(coder: NSCoder) { return nil }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: "statement_cell")
        setupView()
    }
    
    func set(statement: StatementItem) {
        valueLabel.text = String(statement.value)
        statusLabel.text = statement.status
        nameLabel.text = statement.person.name
        if (statement.state == StateType.income) {
            valueLabel.textColor = Colors.blue
            statusLabel.textColor = Colors.blue
            nameLabel.textColor = Colors.blue
        }
    }
}

extension StatementItemCell: ViewCode {
    func setSubviews() {
        self.addSubview(stack)
        stack.addArrangedSubview(iconBox)
        stack.addArrangedSubview(textStack)
        stack.addArrangedSubview(timeBox)
        textStack.addArrangedSubview(valueLabel)
        textStack.addArrangedSubview(statusLabel)
        textStack.addArrangedSubview(nameLabel)
    }
    
    func setConstraints() {
        stack.anchor(top: self.topAnchor,
                     leading: self.leadingAnchor,
                     bottom: self.bottomAnchor,
                     trailing: self.trailingAnchor,
                     paddingTop: Dimensions.medium,
                     paddingBottom: Dimensions.medium)
        //stack.setAnchorsEqual(to: self)
        iconBox.size(width: 64)
        iconBox.setHeightEqual(to: stack)
        timeBox.size(width: 64)
        timeBox.setHeightEqual(to: stack)
        textStack.size(height: 64)
        valueLabel.setWidthEqual(to: textStack)
        statusLabel.setWidthEqual(to: textStack)
        nameLabel.setWidthEqual(to: textStack)
    }
}
