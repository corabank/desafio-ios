import UIKit

protocol LoginDisplaying: AnyObject {
    func displaySomething()
    
}

private extension LoginViewController.Layout {
    // example
    enum Size {
        static let imageHeight: CGFloat = 90.0
    }
}

final class LoginViewController: UIViewController {
    fileprivate enum Layout { 
        // template
    }
    
    private lazy var navBar: UINavigationBar = {
        //acertar layout
        let navBar = UINavigationBar()
        navBar.backgroundColor = Colors.gray4
        navBar.translatesAutoresizingMaskIntoConstraints = false
        let navItem = UINavigationItem(title: Strings.loginNavBarTitle)
        let backItem = UIBarButtonItem(image: UIImage(named: "leftArrow"), style: .done, target: self, action: #selector(backButtonTapped))
        backItem.tintColor = Colors.backgroundColor
        navItem.leftBarButtonItem = backItem
        navBar.setItems([navItem], animated: false)
        return navBar
    }()
    
    private lazy var loginTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = Strings.loginTitle
        label.font = Typography.setFont(.regular(size: 16))()
        label.numberOfLines = 0
        label.textColor = Colors.gray1
        return label
    }()
    
    private lazy var loginSubtitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = Strings.loginSubtitle
        label.font = Typography.setFont(.bold(size: 22))()
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
        textField.placeholder = "Digite aqui seu CPF"
        textField.borderStyle = .roundedRect
        textField.font = Typography.setFont(.medium(size: 24))()
        textField.delegate = self
        return textField
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        //ajustar layout
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Próximo", for: [])
        button.setTitleColor(Colors.white, for: [])
        button.layer.cornerRadius = 16
        button.backgroundColor = Colors.gray2
        button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        button.isEnabled = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        buildView()
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

// MARK: - @objc Private Methods
@objc private extension LoginViewController {
    func backButtonTapped(){
        navigationController?.popToRootViewController(animated: true)
    }
    
    func loginButtonTapped() {
        interactor.passwordScene()
    }
}



extension LoginViewController: UITextFieldDelegate {
    //formatar cpf
    //fechar ao ter 9 digitos
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.loginTextField.resignFirstResponder()
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        loginButton.isEnabled = true
        loginButton.backgroundColor = Colors.backgroundColor
        return true
    }
}

extension LoginViewController: ViewSetup {
    func setupConstraints() {
        NSLayoutConstraint.activate([
            navBar.topAnchor.constraint(equalTo: view.topAnchor, constant: Spacing.space7),
            navBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navBar.heightAnchor.constraint(equalToConstant: 44.0)
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
            loginTextField.heightAnchor.constraint(equalToConstant: 32.0)
        ])
        
        NSLayoutConstraint.activate([
            loginButton.bottomAnchor.constraint(equalTo: view.keyboardLayoutGuide.topAnchor, constant: -Spacing.space5),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Spacing.space5),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Spacing.space5),
            loginButton.heightAnchor.constraint(equalToConstant: 48.0)
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
    func displaySomething() { 
        // template
    }
}
