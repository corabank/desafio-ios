import Foundation
import UIKit
import ViewCode
import Components

final class CPFFormView: UIViewController {
    
    private var viewModel: CPFFormViewDelegate?
    
    private let navTitle = "Login Cora"
    private let welcome  = "Bem-vindo de volta!"
    private let buttonTitle = "Próximo"
    private let titleLabelString = "Qual seu CPF?"
    
    private lazy var stack: UIStackView = {
        let stack: UIStackView = UIStackView(frame: .zero)
        stack.alignment = .center
        stack.axis = .vertical
        stack.spacing = Dimensions.verySmall
        return stack
    }()
    
    private lazy var stackEmbedded: UIStackView = {
        let stack: UIStackView = UIStackView(frame: .zero)
        stack.alignment = .center
        stack.axis = .vertical
        stack.spacing = Dimensions.verySmall
        return stack
    }()
    
    private lazy var footerStack: UIStackView = {
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

    private lazy var welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = welcome
        label.numberOfLines = 0
        label.textAlignment = .justified
        label.textColor = Colors.darkGray
        label.font = UIFont.systemFont(ofSize: Dimensions.fontSmall)
        return label
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = titleLabelString
        label.numberOfLines = 0
        label.textAlignment = .justified
        label.textColor = Colors.black
        label.font = UIFont.systemFont(ofSize: Dimensions.fontMedium, weight: .bold)
        return label
    }()
    
    private lazy var textField: UITextField = {
        let field = UITextField(frame: .zero)
        return field
    }()
    
    private lazy var nextButton: RegularButton = {
        let button = RegularButton()
        button.set(title: buttonTitle, alignment: .left, style: .pink, icon: .arrow)
        button.addTarget(self, action: #selector(nextActionCallback), for: .touchUpInside)
        return button
    }()
    
    private lazy var keyboardHolder: UIView = {
        let view = UIView()
        return view
    }()
    
    required init?(coder: NSCoder) { return nil }
    init() {
        super.init(nibName: nil, bundle: nil)
        setupView()
    }
    
    @objc
    private func nextActionCallback() {
        nextButton.flash()
        viewModel?.inputCPF()
    }
    
    @objc
    private func keyboardWillShow() {
        footerStack.addArrangedSubview(keyboardHolder)
    }
    
    @objc
    private func keyboardWillHide() {
        keyboardHolder.removeFromSuperview()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
}

extension CPFFormView: ViewCode {
    func setSubviews() {
        view.addSubviews([stack, footerStack])
        stack.addArrangedSubview(navigation)
        stack.addArrangedSubview(Spacer(size: Dimensions.small))
        stack.addArrangedSubview(stackEmbedded)
        stackEmbedded.addArrangedSubview(welcomeLabel)
        stackEmbedded.addArrangedSubview(titleLabel)
        stackEmbedded.addArrangedSubview(textField)
        footerStack.addArrangedSubview(nextButton)
    }
    
    func setConstraints() {
        navigation.setWidthEqual(to: view)
        stack.anchor(top: view.topAnchor,
                     leading: view.leadingAnchor,
                     trailing: view.trailingAnchor)
        
        stackEmbedded.anchor(leading: stack.leadingAnchor,
                             trailing: stack.trailingAnchor,
                             paddingLeft: Dimensions.medium,
                             paddingRight: Dimensions.medium)
        
        welcomeLabel.setWidthEqual(to: stack)
        titleLabel.setWidthEqual(to: stack)
        
        textField.size(height: 32)
        textField.setWidthEqual(to: stackEmbedded)
        
        nextButton.size(height: 50)
        nextButton.setWidthEqual(to: footerStack)
        footerStack.anchor(leading: view.leadingAnchor,
                           bottom: view.bottomAnchor,
                           trailing: view.trailingAnchor,
                           paddingBottom: Dimensions.mediumSmall,
                           paddingLeft: Dimensions.medium,
                           paddingRight: Dimensions.medium)
        keyboardHolder.size(height: 250)
    }
    
    func extraSetups() {
        view.backgroundColor = Colors.white
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}

extension CPFFormView: CPFFormViewProtocol {
    func set(delegate: CPFFormViewDelegate) {
        self.viewModel = delegate
    }
}

extension CPFFormView: NavigationBarDelegate {
    func tapBack(){
        viewModel?.tapBack()
    }
    
    func tapShare() {}
}
