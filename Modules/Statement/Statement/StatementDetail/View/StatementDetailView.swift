import UIKit
import Resources
import ViewCode
import Components

final class StatementDetailView: UIViewController {
    
    private var viewModel: StatementDetailViewDelegate?
    
    private lazy var navTitle: String = ""
    
    private lazy var stackScroll: StackScrollView = StackScrollView(spacing: Dimensions.medium)
    private lazy var backGround: UIView = UIView(frame: .zero)
    
    private lazy var mainStack: UIStackView = {
        let stack: UIStackView = UIStackView(frame: .zero)
        stack.alignment = .center
        stack.axis = .vertical
        stack.spacing = Dimensions.medium
        return stack
    }()
    
    private lazy var titleStack: UIStackView = {
        let stack: UIStackView = UIStackView(frame: .zero)
        stack.alignment = .center
        stack.axis = .horizontal
        stack.spacing = 12
        return stack
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "mock"
        label.numberOfLines = 0
        label.textAlignment = .justified
        label.textColor = Colors.black
        label.font = UIFont.systemFont(ofSize: Dimensions.fontSmall, weight: .bold)
        return label
    }()
    
    private lazy var titleIcon: UIImageView = {
        let view: UIImageView = UIImageView()
        view.image = UIImage(imageLiteralResourceName: Images.clock)
        return view
    }()
    
    private lazy var valueSection: TitleDescSection = TitleDescSection()
    private lazy var dateSection: TitleDescSection = TitleDescSection()
    private lazy var personFrom: MultiLabelSection = MultiLabelSection()
    private lazy var personTo: MultiLabelSection = MultiLabelSection()
    private lazy var descriptionSection: TitleDescSection = TitleDescSection()
    
    private lazy var buttonStack: UIStackView = {
        let stack: UIStackView = UIStackView(frame: .zero)
        stack.alignment = .center
        stack.axis = .vertical
        return stack
    }()
    
    private lazy var navigation: NavigationBar = {
        let nav = NavigationBar(title: navTitle)
        nav.set(delegate: self)
        return nav
    }()
    
    required init?(coder: NSCoder) { return nil }
    init() {
        super.init(nibName: nil, bundle: nil)
        self.navTitle = "test"
        setupView()
    }
}

extension StatementDetailView: ViewCode {
    func setSubviews() {
        view.addSubviews([backGround, navigation, stackScroll])
        stackScroll.addView(view: mainStack)
        mainStack.addArrangedSubview(titleStack)
        mainStack.addArrangedSubview(dateSection)
        mainStack.addArrangedSubview(valueSection)
        mainStack.addArrangedSubview(personFrom)
        mainStack.addArrangedSubview(personTo)
        mainStack.addArrangedSubview(descriptionSection)
        mainStack.addArrangedSubview(buttonStack)
        
        titleStack.addArrangedSubview(titleIcon)
        titleStack.addArrangedSubview(titleLabel)
    }
    
    func setConstraints() {
        backGround.setAnchorsEqual(to: view)
        navigation.anchor(top: view.safeAreaLayoutGuide.topAnchor)
        navigation.setWidthEqual(to: view)
        
        stackScroll.anchor(top: navigation.bottomAnchor,
                           leading: view.leadingAnchor,
                           bottom: view.bottomAnchor,
                           trailing: view.trailingAnchor)

        mainStack.setHeightEqual(to: stackScroll)
        mainStack.anchor(leading: stackScroll.leadingAnchor,
                         trailing: stackScroll.trailingAnchor,
                         paddingLeft: Dimensions.medium,
                         paddingRight: Dimensions.medium)
        
        titleStack.setWidthEqual(to: mainStack)
        valueSection.setWidthEqual(to: mainStack)
        dateSection.setWidthEqual(to: mainStack)
        personFrom.setWidthEqual(to: mainStack)
        personTo.setWidthEqual(to: mainStack)
        descriptionSection.setWidthEqual(to: mainStack)
        buttonStack.setWidthEqual(to: mainStack)
        
        titleIcon.size(height: Dimensions.medium, width: Dimensions.medium)
    }
    
    func extraSetups() {
        backGround.backgroundColor = Colors.lightGray
        stackScroll.backgroundColor = Colors.white
    }
}

extension StatementDetailView: StatementDetailViewProtocol {
    func setInto(statement: StatementItem, owner: Person) {
        valueSection.set(title: "Valor", desc: statement.value.toReal())
        // mock
        dateSection.set(title: "Data da tranferência", desc: "Segunda-feira - 13/01/2020")
        personFrom.set(title: "De", name: statement.person.name,
                       cpf: "CPF \(statement.person.cpf)", bank: statement.person.bank,
                       account: "Agência \(statement.person.agency) - Conta \(statement.person.account)")
        
        personTo.set(title: "To", name: owner.name,
                     cpf: "CPF \(owner.cpf)", bank: owner.bank,
                     account: "Agência \(owner.agency) - Conta \(owner.account)")
        
        // mock
        descriptionSection.set(title: "Descrição", desc: "Developed by the Intel Corporation, HDCP stands for high-bandwidth digital content protection. As the descriptive name implies.", plain: true)
    }
    
    func set(delegate: StatementDetailViewDelegate) {
        self.viewModel = delegate
    }
}

extension StatementDetailView: NavigationBarDelegate {
    func tapBack() {
        viewModel?.tapBack()
    }
    
    func tapShare() { }
}
