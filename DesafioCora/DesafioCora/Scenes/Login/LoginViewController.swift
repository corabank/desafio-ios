import UIKit

protocol LoginDisplay: AnyObject {
    func errorMessage(_ message: String)
    func clearMessage()
    func disableTextFields()
    func enableTextFields()
    func startButtonLoading()
    func stopButtonLoading()
}

class LoginViewController: UIViewController, ViewBuilderProtocol {
    typealias Localizable = LoginLocalizable
    private enum Layout {
        enum Stack {
            static let spacing: CGFloat = 24
            static let sideConstraint: CGFloat = 24
        }
        
        enum Button {
            static let height: CGFloat = 40
            static let cornerRadius: CGFloat = 20
        }
    }

    private let interactor: LoginInteracting
    private lazy var usernameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocapitalizationType = .none
        textField.spellCheckingType = .no
        textField.keyboardType = .emailAddress
        textField.borderStyle = .roundedRect
        textField.placeholder = Localizable.Placeholder.username
        return textField
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.isSecureTextEntry = true
        textField.borderStyle = .roundedRect
        textField.placeholder = Localizable.Placeholder.password
        return textField
    }()
    
    private lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: UIFont.smallSystemFontSize)
        return label
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(Localizable.Button.normalText, for: .normal)
        button.setTitleColor(Color.Base.branding300, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = Layout.Button.cornerRadius
        button.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = Layout.Stack.spacing
        stack.distribution = .fill
        stack.axis = .vertical
        return stack
    }()
    
    init(_ interactor: LoginInteracting) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not implemented yet!")
    }
    
    override func viewDidLoad() {
        interactor.setup()
        buildLayout()
    }
    
    func setupHierarchy() {
        stackView.addArrangedSubview(usernameTextField)
        stackView.addArrangedSubview(passwordTextField)
        stackView.addArrangedSubview(messageLabel)
        stackView.addArrangedSubview(button)
        view.addSubview(stackView)
    }
    
    func setupConstraints() {
        let stackLeading = stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Layout.Stack.sideConstraint)
        let stackTrailing = stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Layout.Stack.sideConstraint * -1)
        let stackCenterY = stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        
        let buttonHeight = button.heightAnchor.constraint(equalToConstant: Layout.Button.height)
        
        NSLayoutConstraint.activate([stackLeading, stackTrailing, stackCenterY, buttonHeight])
    }
    
    func setupViews() {
        view.backgroundColor = Color.Base.branding300
        title = Localizable.View.title
    }
}

extension LoginViewController: LoginDisplay {
    func errorMessage(_ message: String) {
        messageLabel.text = message
    }
    
    func clearMessage() {
        messageLabel.text = String()
    }
    
    func disableTextFields() {
        textFields(enabled: false)
    }
    
    func enableTextFields() {
        textFields(enabled: true)
    }
    
    func startButtonLoading() {
        button(enable: false)
    }
    
    func stopButtonLoading() {
        button(enable: true)
    }
}

private extension LoginViewController {
    func textFields(enabled: Bool) {
        usernameTextField.isEnabled = enabled
        passwordTextField.isEnabled = enabled
    }
    
    func button(enable: Bool) {
        let text = enable ? Localizable.Button.normalText : Localizable.Button.loadingText
        button.setTitle(text, for: .normal)
        button.isEnabled = enable
    }
}

@objc
private extension LoginViewController {
    func didTapLoginButton() {
        let username = usernameTextField.text ?? String()
        let password = passwordTextField.text ?? String()
        interactor.login(username, password: password)
    }
}
