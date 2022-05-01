import UIKit
import Resources
import ViewCode
import Components

final class StatementDetailView: UIViewController {
    
    private var viewModel: StatementDetailViewDelegate?
    
    private lazy var navTitle: String = ""
    
    private lazy var stackScroll: StackScrollView = StackScrollView(spacing: Dimensions.medium)
    
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
    
    private lazy var valueStack: UIStackView = {
        let stack: UIStackView = UIStackView(frame: .zero)
        stack.alignment = .center
        stack.axis = .vertical
        return stack
    }()
    
    private lazy var valueTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Valor"
        label.numberOfLines = 0
        label.textAlignment = .justified
        label.textColor = Colors.darkGray
        label.font = UIFont.systemFont(ofSize: Dimensions.fontTiny)
        return label
    }()
    
    private lazy var valueLabel: UILabel = {
        let label = UILabel()
        label.text = "R$ 150,00"
        label.numberOfLines = 0
        label.textAlignment = .justified
        label.textColor = Colors.black
        label.font = UIFont.systemFont(ofSize: Dimensions.fontSmall, weight: .bold)
        return label
    }()
    
    private lazy var dateStack: UIStackView = {
        let stack: UIStackView = UIStackView(frame: .zero)
        stack.alignment = .center
        stack.axis = .vertical
        return stack
    }()
    
    private lazy var personFromStack: UIStackView = {
        let stack: UIStackView = UIStackView(frame: .zero)
        stack.alignment = .center
        stack.axis = .vertical
        return stack
    }()
    
    private lazy var personToStack: UIStackView = {
        let stack: UIStackView = UIStackView(frame: .zero)
        stack.alignment = .center
        stack.axis = .vertical
        return stack
    }()
    
    private lazy var descriptionStack: UIStackView = {
        let stack: UIStackView = UIStackView(frame: .zero)
        stack.alignment = .center
        stack.axis = .vertical
        return stack
    }()
    
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
        view.addSubview(stackScroll)
        stackScroll.addView(view: navigation)
        stackScroll.addView(view: mainStack)
        mainStack.addArrangedSubview(titleStack)
        mainStack.addArrangedSubview(valueStack)
        mainStack.addArrangedSubview(dateStack)
        mainStack.addArrangedSubview(personFromStack)
        mainStack.addArrangedSubview(personToStack)
        mainStack.addArrangedSubview(descriptionStack)
        mainStack.addArrangedSubview(buttonStack)
        
        titleStack.addArrangedSubview(titleIcon)
        titleStack.addArrangedSubview(titleLabel)
        
        valueStack.addArrangedSubview(valueTitleLabel)
        valueStack.addArrangedSubview(valueLabel)
    }
    
    func setConstraints() {
        stackScroll.setAnchorsEqual(to: view)
        mainStack.setHeightEqual(to: stackScroll)
        mainStack.anchor(leading: stackScroll.leadingAnchor,
                         trailing: stackScroll.trailingAnchor,
                         paddingLeft: Dimensions.medium,
                         paddingRight: Dimensions.medium)
        
        titleStack.setWidthEqual(to: mainStack)
        valueStack.setWidthEqual(to: mainStack)
        dateStack.setWidthEqual(to: mainStack)
        personFromStack.setWidthEqual(to: mainStack)
        personToStack.setWidthEqual(to: mainStack)
        descriptionStack.setWidthEqual(to: mainStack)
        buttonStack.setWidthEqual(to: mainStack)
        
        titleIcon.size(height: Dimensions.medium, width: Dimensions.medium)
        valueTitleLabel.size(height: 20)
        valueTitleLabel.setWidthEqual(to: valueStack)
        valueLabel.size(height: Dimensions.medium)
        valueLabel.setWidthEqual(to: valueStack)
    }
    
    func extraSetups() {
        self.view.backgroundColor = Colors.white
        setNeedsStatusBarAppearanceUpdate()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

extension StatementDetailView: StatementDetailViewProtocol {
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
