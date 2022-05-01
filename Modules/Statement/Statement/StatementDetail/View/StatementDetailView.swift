import UIKit
import Resources
import ViewCode
import Components

final class StatementDetailView: UIViewController {
    
    private var viewModel: StatementDetailViewDelegate?
    
    private lazy var navTitle: String = ""
    
    private lazy var stackScroll: StackScrollView = StackScrollView(spacing: Dimensions.medium)
    private lazy var backGround: UIView = UIView(frame: .zero)
    
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
    
    private lazy var shareButton: RegularButton = {
        let button = RegularButton()
        button.set(title: "Compartilhar comprovante ", alignment: .left, style: .pink, icon: .share)
        button.addTarget(self, action: #selector(shareActionCallback), for: .touchUpInside)
        return button
    }()
    
    private lazy var cancelButton: RegularButton = {
        let button = RegularButton()
        button.set(title: "Cancelar agendamento", alignment: .center, style: .white)
        button.addTarget(self, action: #selector(cancelActionCallback), for: .touchUpInside)
        return button
    }()
    
    required init?(coder: NSCoder) { return nil }
    init() {
        super.init(nibName: nil, bundle: nil)
        setupView()
    }
    
    @objc
    private func shareActionCallback() {
        shareAction()
    }
    
    @objc
    private func cancelActionCallback() {
        cancelAction()
    }
}

extension StatementDetailView: ViewCode {
    func setSubviews() {
        view.addSubviews([backGround, navigation, stackScroll])
        
        stackScroll.addView(Spacer(size: Dimensions.small))
        stackScroll.addView(titleStack, paddingLeft: Dimensions.medium, paddingRight: Dimensions.medium)
        stackScroll.addView(dateSection, paddingLeft: Dimensions.medium, paddingRight: Dimensions.medium)
        stackScroll.addView(valueSection, paddingLeft: Dimensions.medium, paddingRight: Dimensions.medium)
        stackScroll.addView(personFrom, paddingLeft: Dimensions.medium, paddingRight: Dimensions.medium)
        stackScroll.addView(personTo, paddingLeft: Dimensions.medium, paddingRight: Dimensions.medium)
        stackScroll.addView(descriptionSection, paddingLeft: Dimensions.medium, paddingRight: Dimensions.medium)
        stackScroll.addView(buttonStack, paddingLeft: Dimensions.medium, paddingRight: Dimensions.medium)
        stackScroll.addView(Spacer(size: Dimensions.verySmall))
        titleStack.addArrangedSubview(titleIcon)
        titleStack.addArrangedSubview(titleLabel)
        buttonStack.addArrangedSubview(shareButton)
        buttonStack.addArrangedSubview(cancelButton)
    }
    
    func setConstraints() {
        backGround.setAnchorsEqual(to: view)
        navigation.anchor(top: view.safeAreaLayoutGuide.topAnchor)
        navigation.setWidthEqual(to: view)
        
        stackScroll.anchor(top: navigation.bottomAnchor,
                           leading: view.leadingAnchor,
                           bottom: view.bottomAnchor,
                           trailing: view.trailingAnchor)
        
        buttonStack.setWidthEqual(to: view)
        shareButton.size(height: Dimensions.large)
        shareButton.setWidthEqual(to: buttonStack)
        cancelButton.size(height: Dimensions.veryLarge)
        cancelButton.setWidthEqual(to: buttonStack)
        titleIcon.size(height: Dimensions.medium, width: Dimensions.medium)
    }
    
    func extraSetups() {
        backGround.backgroundColor = Colors.lightGray
        stackScroll.backgroundColor = Colors.white
    }
}

extension StatementDetailView: StatementDetailViewProtocol {
    func setInto(statement: StatementItem, owner: Person) {
        navTitle = "test"
        valueSection.set(title: "Valor", desc: statement.value.toReal())
        // mock
        dateSection.set(title: "Data da tranferência", desc: statement.date.toBrDateDetail())
        personFrom.set(title: "De", name: statement.person.name,
                       cpf: "CPF \(statement.person.cpf)", bank: statement.person.bank,
                       account: "Agência \(statement.person.agency) - Conta \(statement.person.account)")
        
        personTo.set(title: "To", name: owner.name,
                     cpf: "CPF \(owner.cpf)", bank: owner.bank,
                     account: "Agência \(owner.agency) - Conta \(owner.account)")
        
        descriptionSection.set(title: "Descrição", desc: statement.desc, plain: true)
    }
    
    func set(delegate: StatementDetailViewDelegate) {
        self.viewModel = delegate
    }
    
    func shareAction() {
        
    }
    
    func cancelAction() {
        
    }
}

extension StatementDetailView: NavigationBarDelegate {
    func tapBack() {
        viewModel?.tapBack()
    }
    
    func tapShare() { }
}
