//
//  LoginViewController.swift
//  cora
//
//  Created by Lucas Silveira on 16/04/21.
//

import UIKit
import ViewAnimator

protocol LoginViewControllerDelegate: class {
    func authenticated()
}

class LoginViewController: UIViewController {
    var loginViewModel: LoginViewModelProtocol?
    weak var delegate: LoginViewControllerDelegate?
    
    private var logo: UIImageView!
    private var scrollView: UIScrollView!
    
    // Login
    private var mainStack: UIStackView!
    private var emailTextInput: UITextField!
    private var passwordTextInput: UITextField!
    private var errorLabel: UILabel!
    private var button: UIButton!
    private var loading: UIActivityIndicatorView!
    
    // Logged
    private var userNameLabel: UILabel!
    private var ordersLabel: UILabel!
    private var ordersAmountLabel: UILabel!
    
    // Logo Constraints
    var logoWidthConstraint: NSLayoutConstraint!
    var logoHeightConstraint: NSLayoutConstraint!
    var logoCenterXConstraint: NSLayoutConstraint!
    var logoTopConstraint: NSLayoutConstraint!
    var logoBottomConstraint: NSLayoutConstraint!
    var logoLeftConstraint: NSLayoutConstraint!
    var logoRightConstraint: NSLayoutConstraint!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        makeView()
        addTargets()
        addConstraints()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        registerKeyboardNotifications()
        
        emailTextInput.text = ""
        passwordTextInput.text = ""
        loginViewModel?.onUpdated = handleState
        
        logo.layer.opacity = 0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startAnimation()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

// MARK: Controller Functions
extension LoginViewController {
    
    func makeView() {
        self.view.backgroundColor = #colorLiteral(red: 0.09706496447, green: 0.1710169911, blue: 0.2268731296, alpha: 1)
        
        // scrolliew
        scrollView = UIScrollView(frame: CGRect(x: 10,
                                                y: 10,
                                                width: view.frame.width - 20,
                                                height: UIScreen.main.bounds.height - 20))
        scrollView.showsVerticalScrollIndicator = false
        scrollView.contentSize = CGSize(width: scrollView.frame.width,
                                        height: UIScreen.main.bounds.height)
        
        // main stack
        mainStack = UIStackView()
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        mainStack.axis = .vertical
        mainStack.alignment = .fill
        mainStack.distribution = .fill
        mainStack.spacing = 18
        
        // logo
        let image = UIImage(named: "logo-cora2")?.withRoundedCorners(radius: 70)
        logo = UIImageView(image: image)
        logo.translatesAutoresizingMaskIntoConstraints = false
        logo.layer.cornerRadius = 30
        scrollView.addSubview(logo)
        
        // email text field
        emailTextInput = UITextField()
        emailTextInput.translatesAutoresizingMaskIntoConstraints = false
        emailTextInput.backgroundColor = #colorLiteral(red: 0.1517894864, green: 0.2267394066, blue: 0.2804006934, alpha: 1)
        emailTextInput.borderStyle = .roundedRect
        emailTextInput.textColor = .white
        let emailPlaceholderText = NSAttributedString(
            string: "Fill your email",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        
        emailTextInput.attributedPlaceholder = emailPlaceholderText
        emailTextInput.font = emailTextInput.font?.withSize(12)
        emailTextInput.layer.cornerRadius = 20
        emailTextInput.keyboardType = .emailAddress
        emailTextInput.autocapitalizationType = .none
        emailTextInput.autocorrectionType = .no
        mainStack.addArrangedSubview(emailTextInput)
        
        // password text field
        passwordTextInput = UITextField()
        passwordTextInput.translatesAutoresizingMaskIntoConstraints = false
        passwordTextInput.backgroundColor = #colorLiteral(red: 0.1517894864, green: 0.2267394066, blue: 0.2804006934, alpha: 1)
        passwordTextInput.borderStyle = .roundedRect
        passwordTextInput.textColor = .white
        passwordTextInput.font = passwordTextInput.font?.withSize(12)
        passwordTextInput.layer.cornerRadius = 20
        passwordTextInput.isSecureTextEntry = true
        passwordTextInput.autocorrectionType = .no
        passwordTextInput.autocapitalizationType = .none
        let passwordPlaceholderText = NSAttributedString(
            string: "Fill your password",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        
        passwordTextInput.attributedPlaceholder = passwordPlaceholderText
        mainStack.addArrangedSubview(passwordTextInput)
        
        // error label
        errorLabel = UILabel()
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.text = ""
        errorLabel.textColor = #colorLiteral(red: 0.9348247647, green: 0.1218132153, blue: 0.3848077953, alpha: 1)
        errorLabel.font = errorLabel.font.withSize(11)
        errorLabel.textAlignment = .center
        mainStack.addArrangedSubview(errorLabel)
        
        // button
        button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Acessar minha conta", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.9348247647, green: 0.1218132153, blue: 0.3848077953, alpha: 1)
        button.layer.cornerRadius = 10
        mainStack.addArrangedSubview(button)
        
        scrollView.addSubview(mainStack)
        view.addSubview(scrollView)
        
        // loading
        loading = UIActivityIndicatorView(style: .white)
        loading.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loading)
    }
    
    // Header View
    func makeHeaderView(user: User) {
        userNameLabel = UILabel()
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        userNameLabel.text = "Olá, \(user.name)"
        userNameLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        userNameLabel.font = UIFont.systemFont(ofSize: 16)
        userNameLabel.textAlignment = .left
        
        ordersLabel = UILabel()
        ordersLabel.translatesAutoresizingMaskIntoConstraints = false
        ordersLabel.text = "Pedidos"
        ordersLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        ordersLabel.font = UIFont.boldSystemFont(ofSize: 24)
        ordersLabel.textAlignment = .left
        
        ordersAmountLabel = UILabel()
        ordersAmountLabel.translatesAutoresizingMaskIntoConstraints = false
        ordersAmountLabel.text = "320 pedidos, totalizando R$ 115.345,45"
        ordersAmountLabel.textColor = #colorLiteral(red: 0.4828443527, green: 0.5140886903, blue: 0.551874876, alpha: 1)
        ordersAmountLabel.font = UIFont.systemFont(ofSize: 16)
        ordersAmountLabel.textAlignment = .left
        
        scrollView.addSubview(userNameLabel)
        scrollView.addSubview(ordersLabel)
        scrollView.addSubview(ordersAmountLabel)
    }
    
    func addTargets() {
        self.button.addTarget(self, action: #selector(onButtonTap), for: .touchUpInside)
    }
        
    func handleFailures(state: LoginViewModelState) {
        switch state {
        case .invalidEmail:
            disableLoading()
            invalidEmail()
        case .wrongEmailAndPassword:
            disableLoading()
            wrongEmailAndPassword()
        case .emailEmpty:
            disableLoading()
            emailEmpty()
        case .passwordEmpty:
            disableLoading()
            passwordEmpty()
        case .emailAndPasswordEmpty:
            disableLoading()
            passwordEmpty()
            emailEmpty()
        default: break
        }
    }
    
    func handleLogin(state: LoginViewModelState) {
        switch state {
        case .authenticating: authenticating()
        case .authenticated(let user): authenticated(user: user)
        default: break
        }
    }
    
    func handleState(state: LoginViewModelState) {
        handleLogin(state: state)
        handleFailures(state: state)
    }
    
    private func authenticating() {
        loading.startAnimating()
    }
    
    private func authenticated(user: User) {
        disableLoading()
        endAnimation(user: user)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.delegate?.authenticated()
        }
    }
    
    private func invalidEmail() {
        self.errorLabel.text = "Usuário ou senha inválidos"
    }
    
    private func wrongEmailAndPassword() {
        self.errorLabel.text = "Usuário ou senha inválidos"
        self.passwordTextInput.text = ""
        self.passwordTextInput.becomeFirstResponder()
    }
    
    private func emailEmpty() {
        errorLabel.text = "O usuárioi é obrigatório"
    }
    
    private func passwordEmpty() {
        errorLabel.text = "A senha é obrigatória"
    }
    
    private func disableLoading() {
        loading.stopAnimating()
    }
    
    private func startAnimation() {
        button.layer.opacity = 0
        
        let animation = AnimationType.from(direction: .bottom, offset: 230.0)
        scrollView.animate(animations: [animation])
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.button.layer.opacity = 1
            let buttonAnimation = AnimationType.zoom(scale: 0.2)
            self.button.animate(animations: [buttonAnimation])
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.logo.layer.opacity = 1
            let logoanimation = AnimationType.zoom(scale: 0.2)
            self.logo.animate(animations: [logoanimation])
        }
    }
    
    private func endAnimation(user: User) {
        UIView.transition(with: mainStack,
                          duration: 0.1,
                          options: .transitionCrossDissolve,
                          animations: {
                                self.mainStack.layer.opacity = 0
                          })
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.updateLogoConstraintsToAnimate()
            UIView.transition(with: self.logo,
                              duration: 0.3,
                              options: .curveEaseInOut,
                              animations: {
                                self.view.layoutIfNeeded()
                              })
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.makeHeaderView(user: user)
            self.addConstraintsForHeader()
            
            let zoomAnimation = AnimationType.from(direction: .top, offset: -100)
            self.userNameLabel.animate(animations: [zoomAnimation])
            self.ordersLabel.animate(animations: [zoomAnimation])
            self.ordersAmountLabel.animate(animations: [zoomAnimation])
        }
    }
    
    func registerKeyboardNotifications() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow(notification:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide(notification:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    // MARK: Constraints
    func setLogoConstraintsForAnimation() {
        logoWidthConstraint = logo.widthAnchor.constraint(equalToConstant: 140)
        logoHeightConstraint = logo.heightAnchor.constraint(equalToConstant: 140)
        logoCenterXConstraint = logo.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor)
        logoTopConstraint = logo.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 80)
        logoBottomConstraint = logo.bottomAnchor.constraint(equalTo: mainStack.topAnchor, constant: -30)
        
        NSLayoutConstraint.activate([
            logoWidthConstraint,
            logoHeightConstraint,
            logoCenterXConstraint,
            logoTopConstraint,
            logoBottomConstraint
        ])
    }
    
    func updateLogoConstraintsToAnimate() {
        NSLayoutConstraint.deactivate([
            logoWidthConstraint,
            logoHeightConstraint,
            logoCenterXConstraint,
            logoTopConstraint,
            logoBottomConstraint
        ])
        
        logoWidthConstraint = logo.widthAnchor.constraint(equalToConstant: 70)
        logoHeightConstraint = logo.heightAnchor.constraint(equalToConstant: 70)
        logoTopConstraint = logo.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20)
        logoLeftConstraint = logo.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 10)
        
        NSLayoutConstraint.activate([
            logoWidthConstraint,
            logoHeightConstraint,
            logoTopConstraint,
            logoLeftConstraint
        ])
    }

    func addConstraints() {
        setLogoConstraintsForAnimation()
        
        NSLayoutConstraint.activate([
            emailTextInput.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 40),
            emailTextInput.heightAnchor.constraint(equalToConstant: 54),
            
            passwordTextInput.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 40),
            passwordTextInput.heightAnchor.constraint(equalToConstant: 54),
            
            button.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            button.heightAnchor.constraint(equalToConstant: 50),
            
            errorLabel.heightAnchor.constraint(equalToConstant: 20),
            
            loading.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 20),
            loading.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    func addConstraintsForHeader() {
        NSLayoutConstraint.activate([
            // left side
            ordersLabel.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: 20),
            ordersLabel.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 10),

            ordersAmountLabel.topAnchor.constraint(equalTo: ordersLabel.bottomAnchor, constant: 10),
            ordersAmountLabel.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 10),
            
            // right side
            userNameLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 30),
            userNameLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20)
        ])
    }

    @objc func onButtonTap() {
        // REMOVE
        emailTextInput.text = "lucas.fernandes.silveira@gmail.com"
        passwordTextInput.text = "caveira2021"
        //
        
        loading.startAnimating()
        loginViewModel?.email = emailTextInput.text
        loginViewModel?.password = passwordTextInput.text
        loginViewModel?.login()
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        let userInfo: NSDictionary = notification.userInfo! as NSDictionary
        let keyboardInfo = userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue
        let keyboardSize = keyboardInfo?.cgRectValue.size
        let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize?.height ?? 0, right: 0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        scrollView.contentInset = .zero
        scrollView.scrollIndicatorInsets = .zero
    }
}
