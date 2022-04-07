import UIKit

protocol PasswordDisplaying: AnyObject {
    //Display Protocol
}

private extension PasswordViewController.Layout {
    enum Size {
        static let imageHeight: CGFloat = 90.0
    }
}

final class PasswordViewController: UIViewController {
    fileprivate enum Layout {}
    
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
    
    private lazy var passwordTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = Strings.passwordTitle
        label.font = Typography.setFont(.bold(size: 22))()
        label.numberOfLines = 0
        label.textColor = Colors.offBlack
        return label
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.keyboardType = .phonePad
        textField.placeholder = "Digite aqui sua senha"
        textField.borderStyle = .roundedRect
        textField.font = Typography.setFont(.medium(size: 24))()
        textField.delegate = self
        return textField
    }()
    
    private lazy var lostPassword: UILabel = {
        let label = UILabel()
        //tornar clicavel
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = Strings.lostPassword
        label.font = Typography.setFont(.regular(size: 14))()
        label.numberOfLines = 0
        label.textColor = Colors.backgroundColor
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(UIGestureRecognizer(target: self, action: #selector(lostPasswordButtonTapped)))
        return label
    }()
    
    private lazy var passwordButton: UIButton = {
        let button = UIButton()
        //ajustar layout
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Próximo", for: [])
        button.setTitleColor(Colors.white, for: [])
        button.layer.cornerRadius = 16
        button.backgroundColor = Colors.gray2
        button.addTarget(self, action: #selector(passwordButtonTapped), for: .touchUpInside)
        button.isEnabled = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildView()
    }
    
    private let interactor: PasswordInteracting
    
    init(interactor: PasswordInteracting) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - @objc Private Methods
@objc private extension PasswordViewController {
    func backButtonTapped(){
        navigationController?.popToRootViewController(animated: true)
    }
    
    func lostPasswordButtonTapped(sender: UIGestureRecognizer) {
        print("Perdi minha senha")
    }
    
    func passwordButtonTapped() {
        
    }
}

extension PasswordViewController: UITextFieldDelegate {
    //formatar cpf
    //fechar ao ter 9 digitos
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.passwordTextField.resignFirstResponder()
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        passwordButton.isEnabled = true
        passwordButton.backgroundColor = Colors.backgroundColor
        return true
    }
}

extension PasswordViewController: ViewSetup {
    func setupConstraints() {
        NSLayoutConstraint.activate([
            navBar.topAnchor.constraint(equalTo: view.topAnchor, constant: Spacing.space7),
            navBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navBar.heightAnchor.constraint(equalToConstant: 44.0)
        ])
        
        NSLayoutConstraint.activate([
            passwordTitle.topAnchor.constraint(equalTo: navBar.bottomAnchor, constant: Spacing.space5),
            passwordTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Spacing.space5),
            passwordTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Spacing.space5),
            passwordTitle.heightAnchor.constraint(equalToConstant: 32.0)
        ])
        
        NSLayoutConstraint.activate([
            passwordTextField.topAnchor.constraint(equalTo: passwordTitle.bottomAnchor, constant: Spacing.space6),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Spacing.space5),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Spacing.space5),
            passwordTextField.heightAnchor.constraint(equalToConstant: 32.0)
        ])
        
        NSLayoutConstraint.activate([
            lostPassword.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: Spacing.space7),
            lostPassword.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Spacing.space5),
            lostPassword.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Spacing.space5),
            lostPassword.heightAnchor.constraint(equalToConstant: 20.0)
        ])
        
        NSLayoutConstraint.activate([
            passwordButton.bottomAnchor.constraint(equalTo: view.keyboardLayoutGuide.topAnchor, constant: -Spacing.space5),
            passwordButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Spacing.space5),
            passwordButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Spacing.space5),
            passwordButton.heightAnchor.constraint(equalToConstant: 48.0)
        ])
    }
    
    func setupHierarchy() {
        view.addSubview(navBar)
        view.addSubview(passwordTitle)
        view.addSubview(passwordTextField)
        view.addSubview(lostPassword)
        view.addSubview(passwordButton)
    }
    
    func setupStyles() {
        view.backgroundColor = Colors.white
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
}

// MARK: - PasswordDisplaying
extension PasswordViewController: PasswordDisplaying {
    //Para implementar ações na tela por meio de protocolo
}
