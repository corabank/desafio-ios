import Foundation
import UIKit
import Components
import Resources
import ViewCode

final class MultiLabelSection: UIView {
    
    private lazy var stack: UIStackView = {
        let stack: UIStackView = UIStackView(frame: .zero)
        stack.alignment = .center
        stack.axis = .vertical
        return stack
    }()
    
    private lazy var titleLabel: UILabel = {
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
        label.textColor = Colors.black
        label.font = UIFont.systemFont(ofSize: Dimensions.fontSmall, weight: .bold)
        return label
    }()
    
    private lazy var cpfLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .justified
        label.textColor = Colors.darkGray
        label.font = UIFont.systemFont(ofSize: Dimensions.fontTiny)
        return label
    }()
    
    private lazy var bankLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .justified
        label.textColor = Colors.darkGray
        label.font = UIFont.systemFont(ofSize: Dimensions.fontTiny)
        return label
    }()
    
    private lazy var accountLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .justified
        label.textColor = Colors.darkGray
        label.font = UIFont.systemFont(ofSize: Dimensions.fontTiny)
        return label
    }()

    required init?(coder: NSCoder) { return nil }
    public init() {
        super.init(frame: .zero)
        setupView()
    }
    
    func set(title: String, name: String, cpf: String, bank: String, account: String) {
        self.titleLabel.text = title
        self.nameLabel.text = name
        self.cpfLabel.text = cpf
        self.bankLabel.text = bank
        self.accountLabel.text = account
    }
}

extension MultiLabelSection: ViewCode {
    func setSubviews() {
        self.addSubview(stack)
        stack.addArrangedSubview(titleLabel)
        stack.addArrangedSubview(nameLabel)
        stack.addArrangedSubview(cpfLabel)
        stack.addArrangedSubview(bankLabel)
        stack.addArrangedSubview(accountLabel)
    }
    
    func setConstraints() {
        stack.setAnchorsEqual(to: self)
        titleLabel.setWidthEqual(to: stack)
        titleLabel.size(height: 20)
        
        nameLabel.setWidthEqual(to: stack)
        nameLabel.size(height: Dimensions.medium)
        
        cpfLabel.setWidthEqual(to: stack)
        cpfLabel.size(height: 20)
        
        bankLabel.setWidthEqual(to: stack)
        bankLabel.size(height: 20)
        
        accountLabel.setWidthEqual(to: stack)
        accountLabel.size(height: 20)
    }
}
