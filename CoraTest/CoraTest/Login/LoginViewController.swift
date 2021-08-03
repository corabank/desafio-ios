import UIKit

class LoginViewController: UIViewController {
    private lazy var usernameTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .bezel
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .bezel
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Login", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.addTarget(self, action: #selector(loginDeVerdade(username:pwd:)), for: .touchUpInside)
        return button
    }()
    
    private let viewModel: LoginViewModeling
    
    init(viewModel: LoginViewModeling) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configViews()
        configConstraints()
    }
    
    private func configViews() {
        view.addSubview(usernameTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
        view.backgroundColor = .white
    }
    
    private func configConstraints() {
        // UserName Text
        let usernameTextFieldTopConstraint = NSLayoutConstraint(item: usernameTextField, attribute: .top, relatedBy: .equal, toItem: view, attribute: .topMargin, multiplier: 1, constant: 60)
        let userNameTextFieldYAxisConstraint = NSLayoutConstraint(item: usernameTextField, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0)
        let usernameTextFieldWidthConstraint = NSLayoutConstraint(item: usernameTextField, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: 60)
        let usernameTextFieldHeightConstraint = NSLayoutConstraint(item: usernameTextField, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 40)
        
        
        NSLayoutConstraint.activate([usernameTextFieldTopConstraint, userNameTextFieldYAxisConstraint, usernameTextFieldWidthConstraint, usernameTextFieldHeightConstraint])
        
        // Password Text
        let passwordTextFieldTopConstraint = NSLayoutConstraint(item: passwordTextField, attribute: .top, relatedBy: .equal, toItem: usernameTextField, attribute: .bottom, multiplier: 1, constant: 16)
        let passwordTextFieldYAxisConstraint = NSLayoutConstraint(item: passwordTextField, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0)
        let passwordTextFieldWidthConstraint = NSLayoutConstraint(item: passwordTextField, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: 60)
        let passwordTextFieldHeightConstraint = NSLayoutConstraint(item: passwordTextField, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 40)
        
        NSLayoutConstraint.activate([passwordTextFieldTopConstraint, passwordTextFieldYAxisConstraint, passwordTextFieldWidthConstraint, passwordTextFieldHeightConstraint])
        
        // Login Button
        let buttonBottomConstraint = NSLayoutConstraint(item: loginButton, attribute: .top, relatedBy: .equal, toItem: passwordTextField, attribute: .bottom, multiplier: 1, constant: 16)
        let buttonXAxisConstraint = NSLayoutConstraint(item: loginButton, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0)
        let buttonWidthConstraint = NSLayoutConstraint(item: loginButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: 60)
        NSLayoutConstraint.activate([buttonBottomConstraint, buttonXAxisConstraint, buttonWidthConstraint])
    }
    
    @objc
    private func loginDeVerdade(username: String, pwd: String) {
        viewModel.login(with: username, and: pwd)
    }
}
