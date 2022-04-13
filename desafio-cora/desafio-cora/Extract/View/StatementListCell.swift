import UIKit

public final class StatementListCell: UITableViewCell {
    
    private lazy var transactionImage: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    private lazy var transactionValue: UILabel = {
        let label = UILabel()
        label.font = Typography.setFont(.bold(size: 16))()
        return label
    }()
    
    private lazy var transactionType: UILabel = {
        let label = UILabel()
        label.font = Typography.setFont(.regular(size: 14))()
        return label
    }()
    
    private lazy var name: UILabel = {
        let label = UILabel()
        label.font = Typography.setFont(.regular(size: 14))()
        label.textColor = Colors.gray1
        return label
    }()
    
    private lazy var transactionHour: UILabel = {
        let label = UILabel()
        label.font = Typography.setFont(.regular(size: 14))()
        label.textColor = Colors.gray1
        return label
    }()
    
    private lazy var statementStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [transactionValue, transactionType, name])
        stackView.axis = .vertical
        return stackView
    }()
    
    private lazy var rootStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [transactionImage, statementStackView, transactionHour])
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
    
    func setup() {
        
    }
}

extension StatementListCell: ViewSetup {
    func setupConstraints() {
        
    }
    
    func setupHierarchy() {
        
    }
    
    func setupStyles() {
        
    }
}
