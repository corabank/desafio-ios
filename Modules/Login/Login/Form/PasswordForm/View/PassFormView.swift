import Foundation
import UIKit
import ViewCode
import Components
import Resources

final class PassFormView: UIViewController {
    
    private var viewModel: PassFormViewDelegate?
    
    private let navTitle = "Login Cora"
    private let buttonTitle = "Próximo"
    private let titleLabelString = "Digite sua senha de acesso"
    private let forgotPassword   = "Esqueci minha senha"
    
    private lazy var backGround: UIView = UIView(frame: .zero)
    
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
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = titleLabelString
        label.numberOfLines = 0
        label.textAlignment = .justified
        label.textColor = Colors.black
        label.font = UIFont.systemFont(ofSize: Dimensions.fontMedium, weight: .bold)
        return label
    }()
    
    private lazy var forgotPassLabel: UILabel = {
        let label = UILabel()
        label.text = forgotPassword
        label.numberOfLines = 0
        label.textAlignment = .justified
        label.textColor = Colors.pink
        label.font = UIFont.systemFont(ofSize: Dimensions.fontTiny)
        return label
    }()
    
    private lazy var textField: UITextField = {
        let label = UITextField(frame: .zero)
        label.isSecureTextEntry = true
        label.keyboardType = .default
        return label
    }()
    
    private lazy var textFieldStack: UIStackView = {
        let stack: UIStackView = UIStackView(frame: .zero)
        stack.spacing = Dimensions.verySmall
        stack.alignment = .center
        stack.axis = .horizontal
        return stack
    }()
    
    private lazy var keyBoardSize: NSLayoutConstraint? = NSLayoutConstraint(item: keyboardHolder,
                                                                            attribute: .height,
                                                                            relatedBy: .equal,
                                                                            toItem: nil,
                                                                            attribute: .height,
                                                                            multiplier: 1,
                                                                            constant: view.frame.height/3.2)
    
    private lazy var nextButton: RegularButton = {
        let button = RegularButton()
        button.set(title: buttonTitle, alignment: .left, style: .pink, icon: .arrow)
        button.addTarget(self, action: #selector(nextActionCallback), for: .touchUpInside)
        return button
    }()
    
    private lazy var eyeButton: UIButton = {
        let button: UIButton = UIButton(frame: .zero)
        button.setImage(UIImage(named: Images.eye), for: .normal)
        button.addTarget(self, action: #selector(tapEye), for: .touchUpInside)
        return button
    }()
    
    private lazy var keyboardHolder: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
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
        nextWithInput(input: textField.text ?? "")
    }
    
    @objc
    private func keyboardWillShow() {
        keyBoardSize?.isActive = true
    }
    
    @objc
    private func keyboardWillHide() {
        keyBoardSize?.isActive = false
    }
    
    @objc
    private func tapEye() {
        textField.isSecureTextEntry = !textField.isSecureTextEntry
    }
    
    @objc
    func inputValue() {
        (String(textField.text ?? "").isEmpty) ?
        changeButtonStatus(.disabled) :
        changeButtonStatus(.enabled)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        textField.text = ""
        textField.becomeFirstResponder()
        changeButtonStatus(.disabled)
    }
}

extension PassFormView: ViewCode {
    func setSubviews() {
        view.addSubviews([backGround, stack, footerStack])
        stack.addArrangedSubview(navigation)
        stack.addArrangedSubview(Spacer(size: Dimensions.small))
        stack.addArrangedSubview(stackEmbedded)
        stackEmbedded.addArrangedSubview(titleLabel)
        stackEmbedded.addArrangedSubview(Spacer(size: Dimensions.verySmall))
        stackEmbedded.addArrangedSubview(textFieldStack)
        stackEmbedded.addArrangedSubview(Spacer(size: Dimensions.small))
        stackEmbedded.addArrangedSubview(forgotPassLabel)
        textFieldStack.addArrangedSubview(textField)
        textFieldStack.addArrangedSubview(eyeButton)
        footerStack.addArrangedSubview(nextButton)
        footerStack.addArrangedSubview(keyboardHolder)
    }
    
    func setConstraints() {
        navigation.setWidthEqual(to: stack)
        stack.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                     leading: view.leadingAnchor,
                     trailing: view.trailingAnchor)
        
        backGround.setWidthEqual(to: view)
        backGround.anchor(top: stack.topAnchor, bottom: view.bottomAnchor)
        
        stackEmbedded.anchor(leading: stack.leadingAnchor,
                             trailing: stack.trailingAnchor,
                             paddingLeft: Dimensions.medium,
                             paddingRight: Dimensions.medium)
        
        titleLabel.setWidthEqual(to: stack)
        
        forgotPassLabel.setWidthEqual(to: stackEmbedded)
        forgotPassLabel.size(height: 20)
        
        textFieldStack.setWidthEqual(to: stackEmbedded)
        
        textField.size(height: 32)
        textField.setWidthEqual(to: stackEmbedded)
        
        eyeButton.size(height: 32, width: 32)
        
        nextButton.size(height: 50)
        nextButton.setWidthEqual(to: footerStack)
        footerStack.anchor(leading: view.leadingAnchor,
                           bottom: view.safeAreaLayoutGuide.bottomAnchor,
                           trailing: view.trailingAnchor,
                           paddingBottom: Dimensions.mediumSmall,
                           paddingLeft: Dimensions.medium,
                           paddingRight: Dimensions.medium)
        
        if let constraint = keyBoardSize {
            keyboardHolder.addConstraints([constraint])
            keyBoardSize?.isActive = false
        }
    }
    
    func extraSetups() {
        view.backgroundColor = Colors.white
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
        
        textField.addTarget(self, action: #selector(inputValue), for: .editingChanged)
        
        nextButton.state(.disabled)
        
        backGround.backgroundColor = Colors.white
        view.backgroundColor = Colors.lightGray
    }
}

extension PassFormView: PassFormViewProtocol {
    func nextWithInput(input: String) {
        viewModel?.inputPassword(textField.text ?? "")
    }
    
    func goBack() {
        viewModel?.tapBack()
    }
    
    func changeButtonStatus(_ value: ButtonState) {
        nextButton.state(value)
    }
    
    func set(delegate: PassFormViewDelegate) {
        self.viewModel = delegate
    }
}

extension PassFormView: NavigationBarDelegate {
    func tapBack(){
        goBack()
    }
    
    func tapShare() {}
}
