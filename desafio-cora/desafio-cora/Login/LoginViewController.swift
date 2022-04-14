import UIKit

protocol LoginDisplaying: AnyObject {
    //Display Protocol
}

private extension LoginViewController.Layout {
    enum Size {
        static let navBarHeight: CGFloat = 44.0
        static let loginTextFieldHeight: CGFloat = 32.0
        static let loginButtonHeight: CGFloat = 48.0
    }
}

final class LoginViewController: UIViewController {
    fileprivate enum Layout {}
    
    private lazy var navBar: UINavigationBar = {
        let navBar = UINavigationBar()
        let navItem = UINavigationItem(title: Strings.loginNavBarTitle)
        let backItem = UIBarButtonItem(image: Images.leftArrow, style: .done, target: self, action: #selector(backButtonTapped))
        let textAttributes = [NSAttributedString.Key.foregroundColor: Colors.gray1]
        backItem.tintColor = Colors.backgroundColor
        navItem.leftBarButtonItem = backItem
        navBar.backgroundColor = Colors.gray4
        navBar.titleTextAttributes = textAttributes
        navBar.translatesAutoresizingMaskIntoConstraints = false
        navBar.setItems([navItem], animated: false)
        return navBar
    }()
    
    private lazy var loginTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = Strings.loginTitle
        label.font = Typography.getFont(.regular(size: 16))()
        label.numberOfLines = 0
        label.textColor = Colors.gray1
        return label
    }()
    
    private lazy var loginSubtitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = Strings.loginSubtitle
        label.font = Typography.getFont(.bold(size: 22))()
        label.numberOfLines = 0
        label.textColor = Colors.offBlack
        return label
    }()
    
    private lazy var labelsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [loginTitle, loginSubtitle])
        stackView.spacing = Spacing.space1
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var loginTextField: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.keyboardType = .phonePad
        textField.backgroundColor = .clear
        textField.tintColor = Colors.gray4
        textField.textColor = Colors.offBlack
        textField.borderStyle = .none
        textField.font = Typography.getFont(.medium(size: 24))()
        textField.delegate = self
        return textField
    }()
    
    private lazy var config: UIButton.Configuration = {
        var config = UIButton.Configuration.filled()
        config.baseForegroundColor = Colors.white
        config.buttonSize = .large
        config.cornerStyle = .large
        config.title = Strings.nextButtonTitle
        config.baseBackgroundColor = Colors.gray2
        config.contentInsets = .init(top: 20, leading: 20, bottom: 20, trailing: 20)
        config.titleAlignment = .leading
        config.image = Images.rightArrowWhite
        config.imagePadding = 200
        config.imagePlacement = .trailing
        return config
    }()
    
    private lazy var loginButton: UIButton = {
        let action = UIAction(handler: { action in
            self.loginButtonTapped()
        })
        let button = UIButton(configuration: config, primaryAction: action)
        button.isEnabled = false
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loginTextField.becomeFirstResponder()
    }
    
    private let interactor: LoginInteracting
    
    init(interactor: LoginInteracting) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Private Extension
private extension LoginViewController {
    func formattedNumber(number: String) -> String {
        let CPFNumber = number.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        let mask = Strings.cpfMask
        var result = ""
        var index = CPFNumber.startIndex
        for ch in mask where index < CPFNumber.endIndex {
            if ch == "#" {
                result.append(CPFNumber[index])
                index = CPFNumber.index(after: index)
            } else {
                result.append(ch)
            }
        }
        return result
    }
}

// MARK: - @objc Private Methods
@objc private extension LoginViewController {
    func backButtonTapped(){
        navigationController?.popViewController(animated: true)
    }
    
    func loginButtonTapped() {
        interactor.passwordScene()
    }
}

// MARK: - TextField
extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.loginTextField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return false }
        let newString = (text as NSString).replacingCharacters(in: range, with: string)
        textField.text = formattedNumber(number: newString)
        if textField.text?.count == 14 {
            loginButton.isEnabled = true
            loginButton.configuration?.baseBackgroundColor = Colors.backgroundColor
        } else {
            loginButton.isEnabled = false
            loginButton.configuration?.baseBackgroundColor = Colors.gray2
        }
        return false
    }
}

// MARK: - View Setup
extension LoginViewController: ViewSetup {
    func setupConstraints() {
        NSLayoutConstraint.activate([
            navBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            navBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navBar.heightAnchor.constraint(equalToConstant: Layout.Size.navBarHeight)
        ])
        
        NSLayoutConstraint.activate([
            labelsStackView.topAnchor.constraint(equalTo: navBar.bottomAnchor, constant: Spacing.space7),
            labelsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Spacing.space5),
            labelsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Spacing.space5)
        ])
        
        NSLayoutConstraint.activate([
            loginTextField.topAnchor.constraint(equalTo: labelsStackView.bottomAnchor, constant: Spacing.space6),
            loginTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Spacing.space5),
            loginTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Spacing.space5),
            loginTextField.heightAnchor.constraint(equalToConstant: Layout.Size.loginTextFieldHeight)
        ])
        
        NSLayoutConstraint.activate([
            loginButton.bottomAnchor.constraint(equalTo: view.keyboardLayoutGuide.topAnchor, constant: -Spacing.space5),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Spacing.space5),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Spacing.space5),
            loginButton.heightAnchor.constraint(equalToConstant: Layout.Size.loginButtonHeight)
        ])
    }
    
    func setupHierarchy() {
        view.addSubview(navBar)
        view.addSubview(labelsStackView)
        view.addSubview(loginTextField)
        view.addSubview(loginButton)
    }
    
    func setupStyles() {
        view.backgroundColor = Colors.white
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
}

// MARK: - LoginDisplaying
extension LoginViewController: LoginDisplaying {
    //Para implementar ações na tela por meio de protocolo
}
