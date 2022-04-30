import UIKit
import ViewCode
import Resources
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
    
    private lazy var icon: UIImageView = {
        let view: UIImageView = UIImageView()
        view.image = view.image?.withRenderingMode(.alwaysTemplate)
        return view
    }()
    
    private lazy var timeBox: UIView = {
        let view: UIView = UIView(frame: .zero)
        return view
    }()
    
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = Colors.darkGray
        label.font = UIFont.systemFont(ofSize: Dimensions.fontMinimal)
        return label
    }()
    
    required init?(coder: NSCoder) { return nil }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: "statement_cell")
        setupView()
    }
    
    func set(statement: StatementItem) {
        valueLabel.text = statement.value.toReal()
        statusLabel.text = statement.status
        nameLabel.text = statement.person.name
        timeLabel.text = statement.time
        setStyle(statement)
    }
    
    private func setStyle(_ statement: StatementItem) {
        switch statement.paymentType {
        case .pay:
            setPaymentStyle(statement.paymentStatus)
        case .ticket:
            setTicketStyle(statement.paymentStatus)
        case .reversal:
            setReversalStyle()
        case .future:
            icon.image = UIImage(imageLiteralResourceName: Images.clock)
        }
    }
    
    private func setPaymentStyle(_ status: PaymentStatus) {
        if (status == .income) {
            icon.image = UIImage(imageLiteralResourceName: Images.income)
            blueText()
        } else {
            icon.image = UIImage(imageLiteralResourceName: Images.outcome)
        }
    }
    
    private func setTicketStyle(_ status: PaymentStatus) {
        icon.image = UIImage(imageLiteralResourceName: Images.ticket)
        if (status == .income) {
            blueText()
            icon.tintColor = Colors.blue
        }
    }
    
    private func setReversalStyle() {
        valueLabel.strikeThrough()
        icon.image = UIImage(imageLiteralResourceName: Images.reverse)
    }
    
    private func blueText() {
        valueLabel.textColor = Colors.blue
        statusLabel.textColor = Colors.blue
        nameLabel.textColor = Colors.blue
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
        iconBox.addSubview(icon)
        timeBox.addSubview(timeLabel)
        icon.size(height: Dimensions.medium,
                  width: Dimensions.medium)
        timeLabel.size(height: 20, width: 32)
    }
    
    func setConstraints() {
        stack.anchor(top: self.topAnchor,
                     leading: self.leadingAnchor,
                     bottom: self.bottomAnchor,
                     trailing: self.trailingAnchor,
                     paddingTop: Dimensions.medium,
                     paddingBottom: Dimensions.medium)
        iconBox.size(width: 64)
        iconBox.setHeightEqual(to: stack)
        icon.centerXEqual(to: iconBox)
        icon.anchor(top: iconBox.topAnchor,
                    paddingTop: 0)
        timeBox.size(width: 64)
        timeBox.setHeightEqual(to: stack)
        timeLabel.centerXYEqual(to: timeBox)
        textStack.size(height: 64)
        valueLabel.setWidthEqual(to: textStack)
        statusLabel.setWidthEqual(to: textStack)
        nameLabel.setWidthEqual(to: textStack)
    }
}
