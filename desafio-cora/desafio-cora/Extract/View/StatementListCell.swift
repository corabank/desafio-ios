import UIKit

public final class StatementListCell: UITableViewCell {
    
    private lazy var transactionImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .top
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var transactionValue: UILabel = {
        let label = UILabel()
        label.font = Typography.getFont(.bold(size: 16))()
        return label
    }()
    
    private lazy var transactionType: UILabel = {
        let label = UILabel()
        label.font = Typography.getFont(.regular(size: 14))()
        return label
    }()
    
    private lazy var name: UILabel = {
        let label = UILabel()
        label.font = Typography.getFont(.regular(size: 14))()
        label.textColor = Colors.gray1
        return label
    }()
    
    private lazy var transactionHour: UILabel = {
        let label = UILabel()
        label.font = Typography.getFont(.regular(size: 14))()
        label.textAlignment = .right
        label.textColor = Colors.gray1
        return label
    }()
    
    private lazy var statementStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [transactionValue, transactionType, name])
        stackView.axis = .vertical
        stackView.spacing = Spacing.space0
        return stackView
    }()
    
    private lazy var rootStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [transactionImage, statementStackView, transactionHour])
        stackView.spacing = Spacing.space4
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        buildView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        buildView()
    }
    
    func setup(model: StatementListCellModel) {
        transactionImage.image = model.image()
        transactionImage.tintColor = model.tintColor
        transactionValue.attributedText = model.value()
        transactionType.text = model.transactionText()
        transactionType.textColor = model.tintColor
        name.text = model.name
        transactionHour.text = model.hour
    }
}

extension StatementListCell: ViewSetup {
    func setupConstraints() {
        NSLayoutConstraint.activate([
            rootStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
            rootStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            rootStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            rootStackView.heightAnchor.constraint(equalToConstant: 64)
        ])
        
        NSLayoutConstraint.activate([
            transactionImage.heightAnchor.constraint(equalToConstant: 24),
            transactionImage.widthAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    func setupHierarchy() {
        contentView.addSubview(rootStackView)
    }
    
    func setupStyles() {
        contentView.backgroundColor = .clear
    }
}
