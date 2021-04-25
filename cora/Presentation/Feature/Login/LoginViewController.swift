//
//  LoginViewController.swift
//  cora
//
//  Created by Lucas Silveira on 16/04/21.
//

import UIKit
import ViewAnimator

//sourcery: AutoMockable
protocol LoginViewControllerDelegate: class {
    func authenticated()
}

class LoginViewController: UIViewController {
    var viewModel: LoginViewModelProtocol?
    weak var delegate: LoginViewControllerDelegate?
    
    private var logo: UIImageView!
    private var scrollView: UIScrollView!
    
    // Login
    var mainStack: UIStackView!
    var spacer: UIView!
    var emailTextInput: UITextField!
    var passwordTextInput: UITextField!
    var errorLabel: UILabel!
    var button: UIButton!
    var loading: UIActivityIndicatorView!
    
    // Logged
    var userNameLabel: UILabel!
    var ordersLabel: UILabel!
    var ordersAmountLabel: UILabel!
    
    // Logo Constraints
    private var logoWidthConstraint: NSLayoutConstraint!
    private var logoHeightConstraint: NSLayoutConstraint!
    private var logoCenterXConstraint: NSLayoutConstraint!
    private var logoTopConstraint: NSLayoutConstraint!
    private var logoBottomConstraint: NSLayoutConstraint!
    private var logoLeftConstraint: NSLayoutConstraint!
    private var logoRightConstraint: NSLayoutConstraint!
        
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
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tapGesture)
        
        emailTextInput.text = ""
        passwordTextInput.text = ""
        viewModel?.onUpdated = handleState
        
        logo.layer.opacity = 0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startAnimation()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(
            self,
            name: UIResponder.keyboardWillChangeFrameNotification,
            object: nil)
        
        NotificationCenter.default.removeObserver(
            self,
            name: UIResponder.keyboardWillHideNotification,
            object: nil)
    }
}

// MARK: Controller Functions
extension LoginViewController {
    
    func makeView() {
//        self.view.backgroundColor = #colorLiteral(red: 0.168922931, green: 0.2577900887, blue: 0.3287529945, alpha: 1)
        let backgroundImage = UIImage(named: "background")!.resized(to: UIScreen.main.bounds.size)!
        self.view.backgroundColor = UIColor(patternImage: backgroundImage)
        
//        self.view.backgroundColor =
        
        // scrolliew
        scrollView = UIScrollView(frame: CGRect(x: 10,
                                                y: 10,
                                                width: view.frame.width - 20,
                                                height: UIScreen.main.bounds.height - 20))
        scrollView.showsVerticalScrollIndicator = false
        scrollView.contentSize = CGSize(width: scrollView.frame.width,
                                        height: UIScreen.main.bounds.height)
        scrollView.keyboardDismissMode = .onDrag
        
        // main stack
        mainStack = UIStackView()
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        mainStack.axis = .vertical
        mainStack.alignment = .fill
        mainStack.distribution = .fill
        mainStack.spacing = 18
        
        // logo
        let image = UIImage(named: "logo-cora")
        logo = UIImageView(image: image)
        logo.translatesAutoresizingMaskIntoConstraints = false
//        logo.layer.cornerRadius = 30
        scrollView.addSubview(logo)
        
        // spacer
        spacer = UIView()
        mainStack.addArrangedSubview(spacer)
        
        // email text field
        emailTextInput = UITextField()
        emailTextInput.translatesAutoresizingMaskIntoConstraints = false
        emailTextInput.backgroundColor = .clear
        emailTextInput.borderStyle = .roundedRect
        emailTextInput.layer.borderColor = #colorLiteral(red: 0.09308306845, green: 0.1587566097, blue: 0.2415137913, alpha: 1)
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
        emailTextInput.accessibilityIdentifier = "emailTextInput"
        mainStack.addArrangedSubview(emailTextInput)
        
        // password text field
        passwordTextInput = UITextField()
        passwordTextInput.translatesAutoresizingMaskIntoConstraints = false
        passwordTextInput.backgroundColor = .clear
        passwordTextInput.borderStyle = .roundedRect
        passwordTextInput.layer.borderColor = #colorLiteral(red: 0.09308306845, green: 0.1587566097, blue: 0.2415137913, alpha: 1)
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
        passwordTextInput.accessibilityIdentifier = "passwordTextInput"
        mainStack.addArrangedSubview(passwordTextInput)
        
        // error label
        errorLabel = UILabel()
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.text = ""
        errorLabel.textColor = #colorLiteral(red: 0.9820479751, green: 0.2470019758, blue: 0.432462424, alpha: 1)
        errorLabel.font = errorLabel.font.withSize(11)
        errorLabel.textAlignment = .center
        errorLabel.accessibilityIdentifier = "errorLabel"
        mainStack.addArrangedSubview(errorLabel)
        
        // button
        button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Acessar minha conta", for: .normal)
        button.setImage(UIImage(named: "arrow.right"), for: .normal)
        button.tintColor = .white
        button.semanticContentAttribute = .forceRightToLeft
        
        var spacing: CGFloat = 0
        switch UIScreen.main.bounds.width {
        case 320.0:
            spacing = -80.dp
        case 375.0, 390.0:
            spacing = -120.dp
        default:
            spacing = -140.dp
        }
        
        button.centerTextAndImage(spacing: spacing)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.9820479751, green: 0.2470019758, blue: 0.432462424, alpha: 1)
        button.layer.cornerRadius = 10
        button.accessibilityIdentifier = "button"
        mainStack.addArrangedSubview(button)
        
        print(UIScreen.main.bounds.width)
        
        scrollView.addSubview(mainStack)
        view.addSubview(scrollView)
        
        // loading
        loading = UIActivityIndicatorView(style: .white)
        loading.translatesAutoresizingMaskIntoConstraints = false
        loading.accessibilityIdentifier = "loading"
        view.addSubview(loading)
    }
    
    // Header View

    func makeHeaderView() {
        var ordersSum: Int {
            State.shared.user?.orders.count ?? 0
        }
        
        var ordersValueSum: Double {
            State.shared.user?.orders.reduce(0) { $0 + $1.value } ?? 0
        }
        
        userNameLabel = UILabel()
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        userNameLabel.text = "Olá, \(State.shared.user?.name ?? "")"
        userNameLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        userNameLabel.font = UIFont.systemFont(ofSize: 14.dp)
        userNameLabel.textAlignment = .left
        userNameLabel.accessibilityIdentifier = "userNameLabel"
        
        ordersLabel = UILabel()
        ordersLabel.translatesAutoresizingMaskIntoConstraints = false
        ordersLabel.text = "Pedidos"
        ordersLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        ordersLabel.font = UIFont.boldSystemFont(ofSize: 22.dp)
        ordersLabel.textAlignment = .left
        
        ordersAmountLabel = UILabel()
        ordersAmountLabel.translatesAutoresizingMaskIntoConstraints = false
        ordersAmountLabel.text = "\(ordersSum.description) pedidos, totalizando \(ordersValueSum.toCurrency)"
        ordersAmountLabel.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        ordersAmountLabel.font = UIFont.systemFont(ofSize: 14.dp)
        ordersAmountLabel.textAlignment = .left
        
        scrollView.addSubview(userNameLabel)
        scrollView.addSubview(ordersLabel)
        scrollView.addSubview(ordersAmountLabel)
    }
    
    func addTargets() {
        self.button.addTarget(self, action: #selector(onButtonTap), for: .touchUpInside)
    }
    
    @objc func onButtonTap() {
        // REMOVE
//        emailTextInput.text = "lucas.fernandes.silveira@gmail.com"
//        passwordTextInput.text = "caveira2021"
        //

        self.view.endEditing(true)
        loading.startAnimating()
        viewModel?.email = emailTextInput.text
        viewModel?.password = passwordTextInput.text
        viewModel?.login()
    }

    /// handleFailures
    /// - Parameter state: LoginViewModelState failures handled from LoginViewModel
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
            emailAndPasswordEmpty()
        default: break
        }
    }
    
    func handleLogin(state: LoginViewModelState) {
        switch state {
        case .authenticating: authenticating()
        case .authenticated: authenticated()
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
    
    private func authenticated() {
        disableLoading()
        endAnimation()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.delegate?.authenticated()
        }
    }
    
    private func invalidEmail() {
        self.errorLabel.text = "Email ou senha inválidos"
    }
    
    private func wrongEmailAndPassword() {
        self.errorLabel.text = "Email ou senha inválidos"
        self.passwordTextInput.text = ""
        self.passwordTextInput.becomeFirstResponder()
    }
    
    private func emailEmpty() {
        errorLabel.text = "O email é obrigatório"
    }
    
    private func passwordEmpty() {
        errorLabel.text = "A senha é obrigatória"
    }
    
    private func emailAndPasswordEmpty() {
        errorLabel.text = "Email e senha são obrigatórios"
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
    
    /// endAnimation() is fired when transition to show orders begins
    private func endAnimation() {
        UIView.transition(with: mainStack,
                          duration: 0.1,
                          options: .transitionCrossDissolve,
                          animations: {
                                self.mainStack.layer.opacity = 0
                          })
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.updateLogoConstraintsToAnimate()
            UIView.transition(with: self.logo,
                              duration: 0.3,
                              options: .curveEaseInOut,
                              animations: {
                                self.view.layoutIfNeeded()
                              })
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.makeHeaderView()
            self.addConstraintsForHeader()
            
            let zoomAnimation = AnimationType.from(direction: .top, offset: -100)
            self.userNameLabel.animate(animations: [zoomAnimation])
            self.ordersLabel.animate(animations: [zoomAnimation])
            self.ordersAmountLabel.animate(animations: [zoomAnimation])
        }
    }
    
    // MARK: Constraints
    func setLogoConstraintsForAnimation() {
        logoWidthConstraint = logo.widthAnchor.constraint(equalToConstant: 80.dp)
        logoHeightConstraint = logo.heightAnchor.constraint(equalToConstant: 80.dp)
        logoCenterXConstraint = logo.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor)
        logoTopConstraint = logo.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 80.dp)
        logoBottomConstraint = logo.bottomAnchor.constraint(equalTo: mainStack.topAnchor, constant: -30.dp)
        
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
        
        logoTopConstraint = logo.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 10.dp)
        logoLeftConstraint = logo.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 10.dp)
        logoWidthConstraint = logo.widthAnchor.constraint(equalToConstant: 40.dp)
        logoHeightConstraint = logo.heightAnchor.constraint(equalToConstant: 40.dp)
        
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
            spacer.widthAnchor.constraint(equalTo: mainStack.widthAnchor),
            spacer.heightAnchor.constraint(greaterThanOrEqualTo: logo.heightAnchor, multiplier: 0.5),
            
            emailTextInput.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 40.dp),
            emailTextInput.heightAnchor.constraint(equalToConstant: 54.dp),
            
            passwordTextInput.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 40.dp),
            passwordTextInput.heightAnchor.constraint(equalToConstant: 54.dp),
            
            button.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            button.heightAnchor.constraint(equalToConstant: 50.dp),
            
            errorLabel.heightAnchor.constraint(equalToConstant: 20.dp),
            
            loading.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 20.dp),
            loading.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    func addConstraintsForHeader() {
        NSLayoutConstraint.activate([
            // left side
            ordersLabel.topAnchor.constraint(greaterThanOrEqualTo: logo.bottomAnchor, constant: 15.dp),
            ordersLabel.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 10.dp),

            ordersAmountLabel.topAnchor.constraint(equalTo: ordersLabel.bottomAnchor, constant: 5.dp),
            ordersAmountLabel.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 10.dp),
            
            // right side
            userNameLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20.dp),
            userNameLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20.dp)
        ])
    }
    
    func registerKeyboardNotifications() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillChange(notification:)),
            name: UIResponder.keyboardWillChangeFrameNotification, object: nil)

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc func keyboardWillHide() {
        UIView.animate(withDuration: 0.2, animations: {
            self.view.frame.origin.y = 0
        })
    }

    @objc func keyboardWillChange(notification: NSNotification) {
        if ((notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey]) != nil) {
            if emailTextInput.isFirstResponder {
                UIView.animate(withDuration: 0.2, animations: {
                    self.view.frame.origin.y = -self.emailTextInput.frame.origin.y
                })
            }
            
            if passwordTextInput.isFirstResponder {
                UIView.animate(withDuration: 0.2, animations: {
                    self.view.frame.origin.y = -self.passwordTextInput.frame.origin.y
                })
            }
        }
    }
}


extension UIButton {
    func centerTextAndImage(spacing: CGFloat) {
        let insetAmount = spacing / 2
        imageEdgeInsets = UIEdgeInsets(top: 0, left: -insetAmount, bottom: 0, right: insetAmount)
        titleEdgeInsets = UIEdgeInsets(top: 0, left: insetAmount, bottom: 0, right: -insetAmount)
        contentEdgeInsets = UIEdgeInsets(top: 0, left: insetAmount, bottom: 0, right: insetAmount)
    }
}

//extension UIView {
//    var small: Boo
//}
