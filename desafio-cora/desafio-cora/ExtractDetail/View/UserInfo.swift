import UIKit

class UserInfo: UIView {
    private lazy var userTitle: UILabel = {
        let label = UILabel()
        label.font = Typography.getFont(.regular(size: 14))()
        label.numberOfLines = 0
        label.textColor = Colors.offBlack
        return label
    }()
    
    private lazy var userContentTitle: UILabel = {
        let label = UILabel()
        label.font = Typography.getFont(.bold(size: 16))()
        label.numberOfLines = 0
        label.textColor = Colors.offBlack
        return label
    }()
    
    private lazy var userStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [userTitle, userContentTitle])
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = Spacing.space0
       return stackView
    }()
    
    private lazy var cpfTitle: UILabel = {
        let label = UILabel()
        label.font = Typography.getFont(.regular(size: 14))()
        label.numberOfLines = 0
        label.textColor = Colors.gray1
        return label
    }()
    
    private lazy var bankTitle: UILabel = {
        let label = UILabel()
        label.font = Typography.getFont(.regular(size: 14))()
        label.numberOfLines = 0
        label.textColor = Colors.gray1
        return label
    }()
    
    private lazy var bankContentTitle: UILabel = {
        let label = UILabel()
        label.font = Typography.getFont(.regular(size: 14))()
        label.numberOfLines = 0
        label.textColor = Colors.gray1
        return label
    }()
    
    private lazy var userDataStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [cpfTitle, bankTitle, bankContentTitle])
        stackView.axis = .vertical
        stackView.alignment = .leading
       return stackView
    }()
    
    private lazy var rootStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [userStackView, userDataStackView])
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = Spacing.space0
        stackView.translatesAutoresizingMaskIntoConstraints = false
       return stackView
    }()
    
    init() {
        super.init(frame: .zero)
        buildView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUserInfo(userData: UserData, type: String){
        userTitle.text = type
        userContentTitle.text = userData.name
        cpfTitle.text = userData.cpf
        bankTitle.text = "Banco \(userData.bank)"
        bankContentTitle.text = "Agência \(userData.agency) - Conta \(userData.account)"
    }
}

extension UserInfo: ViewSetup {
    func setupConstraints() {
        NSLayoutConstraint.activate([
            rootStackView.topAnchor.constraint(equalTo: topAnchor),
            rootStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            rootStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            rootStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func setupHierarchy() {
        addSubview(rootStackView)
    }
    
    func setupStyles() {
        backgroundColor = .clear
    }
}
