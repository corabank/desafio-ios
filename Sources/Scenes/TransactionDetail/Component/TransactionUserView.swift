import UIKit

final class TransactionUserView: UIView {
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.offBlack.color
        label.font = Font.Regular.primarySubtitle
        return label
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.offBlack.color
        label.font = Font.Highlighted.tertiaryTitle
        return label
    }()
    
    private lazy var cpfLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.gray01.color
        label.font = Font.Regular.primarySubtitle
        return label
    }()
    
    private lazy var bankNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.gray01.color
        label.font = Font.Regular.primarySubtitle
        return label
    }()
    
    private lazy var bankInfoLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.gray01.color
        label.font = Font.Regular.primarySubtitle
        return label
    }()
    
    private lazy var rootStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, nameLabel, cpfLabel, bankNameLabel, bankInfoLabel])
        stackView.axis = .vertical
        stackView.spacing = Spacing.space00
        return stackView
    }()
    
    init() {
        super.init(frame: .zero)
        buildView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(content: TransactionUserContent) {
        titleLabel.text = content.title
        nameLabel.text = content.name
        cpfLabel.text = content.cpf
        bankNameLabel.text = content.bankName
        bankInfoLabel.text = content.backInfo
    }
}

extension TransactionUserView: BuildableView {
    func setupHierarchy() {
        addSubview(rootStackView)
    }
    
    func setupConstraints() {
        rootStackView.fitToParent()
    }
    
    func setupStyles() {
        backgroundColor = .clear
    }
}
