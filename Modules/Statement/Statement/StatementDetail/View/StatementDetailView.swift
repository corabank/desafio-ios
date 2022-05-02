import UIKit
import Resources
import ViewCode
import Components

final class StatementDetailView: UIViewController {
    
    private var viewModel: StatementDetailViewDelegate?
    
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
        label.textAlignment = .justified
        label.textColor = Colors.black
        label.font = UIFont.systemFont(ofSize: Dimensions.fontSmall, weight: .bold)
        return label
    }()
    
    private lazy var titleIcon: UIImageView = UIImageView()
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
        let nav = NavigationBar()
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
    
    private func setIconImage(_ type: PaymentType, _ status: PaymentStatus) {
        var image = UIImage()
        switch type {
        case .pay:
            (status == .income) ?
            (image = UIImage(imageLiteralResourceName: Images.income)) :
            (image = UIImage(imageLiteralResourceName: Images.outcome))
        case .ticket:
            image = UIImage(imageLiteralResourceName: Images.ticket)
        case .reversal:
            image = UIImage(imageLiteralResourceName: Images.reverse)
        case .future:
            image = UIImage(imageLiteralResourceName: Images.clock)
        }
        
        titleIcon.image = image
        titleIcon.image = titleIcon.image?.withRenderingMode(.alwaysTemplate)
        titleIcon.tintColor = Colors.black
    }
    
    private func setPersons(_ from: Person, _ to: Person) {
        personFrom.set(title: "De", name: from.name,
                       cpf: "CPF \(from.cpf)", bank: from.bank,
                       account: "Agência \(from.agency) - Conta \(from.account)")
        
        personTo.set(title: "Para", name: to.name,
                     cpf: "CPF \(to.cpf)", bank: to.bank,
                     account: "Agência \(to.agency) - Conta \(to.account)")
    }
    
    private func setNavTitle(_ status: String) {
    }
}

extension StatementDetailView: ViewCode {
    func setSubviews() {
        view.addSubviews([backGround, navigation, stackScroll])
        stackScroll.addView(Spacer(size: Dimensions.verySmall))
        stackScroll.addView(titleStack, paddingLeft: Dimensions.medium, paddingRight: Dimensions.medium)
        stackScroll.addView(valueSection, paddingLeft: Dimensions.medium, paddingRight: Dimensions.medium)
        stackScroll.addView(dateSection, paddingLeft: Dimensions.medium, paddingRight: Dimensions.medium)
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
        shareButton.size(height: Dimensions.veryLarge)
        shareButton.setWidthEqual(to: buttonStack)
        cancelButton.size(height: Dimensions.large)
        cancelButton.setWidthEqual(to: buttonStack)
        titleIcon.size(height: Dimensions.medium, width: Dimensions.medium)
    }
    
    func extraSetups() {
        backGround.backgroundColor = Colors.lightGray
        stackScroll.backgroundColor = Colors.white
    }
}

extension StatementDetailView: StatementDetailViewProtocol {
    func setInto(statement: StatementItem, from: Person, to: Person, navigationTitle: String, title: String) {
        navigation.set(title: navigationTitle)
        titleLabel.text = statement.status
        valueSection.set(title: "Valor", desc: statement.value.toReal())
        dateSection.set(title: title, desc: statement.date.toBrDateDetail())
        
        setPersons(from, to)
        descriptionSection.set(title: "Descrição", desc: statement.desc, plain: true)
        setIconImage(statement.paymentType, statement.paymentStatus)
        cancelButton.isHidden = !(statement.paymentType == .future)
    }
    
    func set(delegate: StatementDetailViewDelegate) {
        self.viewModel = delegate
    }
    
    func shareAction() {
        self.viewModel?.tapShare()
    }
    
    func cancelAction() {
        self.viewModel?.tapCancel()
    }
}

extension StatementDetailView: NavigationBarDelegate {
    func tapBack() {
        viewModel?.tapBack()
    }
    
    func tapShare() { }
}
