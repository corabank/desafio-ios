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

    private var animatedLogo: AnimatedLogoView!
    private var scrollView: UIScrollView!
    
    // Login
    var mainStack: UIStackView!
    var emailTextInput: UITextField!
    var passwordTextInput: UITextField!
    var errorLabel: UILabel!
    var button: UIButton!
    var loading: UIActivityIndicatorView!
    
    // Logged
    var loginHeaderView: LoginHeaderview!
        
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
        
        animatedLogo.layer.opacity = 0
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
        let backgroundImage = UIImage(named: "background-2")!.resized(to: UIScreen.main.bounds.size)!
        self.view.backgroundColor = UIColor(patternImage: backgroundImage)
        
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
        animatedLogo = AnimatedLogoView()
        animatedLogo.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(animatedLogo)
        
        // email text field
        emailTextInput = .custom(withIdentifier: "emailTextInput",
                                              withPlaceholder: "Fill your email".localized)
        emailTextInput.delegate = self
        mainStack.addArrangedSubview(emailTextInput)
        
        // password text field
        passwordTextInput = .custom(withIdentifier: "passwordTextInput",
                                                 withPlaceholder: "Fill your password".localized)
        passwordTextInput.isSecureTextEntry = true
        passwordTextInput.delegate = self
        mainStack.addArrangedSubview(passwordTextInput)
        
        // error label
        errorLabel = .errorLabel
        mainStack.addArrangedSubview(errorLabel)
        
        // button
        button = .loginButton
        mainStack.addArrangedSubview(button)
        
        scrollView.addSubview(mainStack)
        view.addSubview(scrollView)
        
        // loading
        loading = UIActivityIndicatorView(style: .white)
        loading.translatesAutoresizingMaskIntoConstraints = false
        loading.accessibilityIdentifier = "loading"
        view.addSubview(loading)
    }
    
    /// Header View
    func makeHeaderView() {
        var ordersSum: Int {
            State.shared.user?.orders.count ?? 0
        }
        
        var ordersValueSum: Double {
            State.shared.user?.orders.reduce(0) { $0 + $1.value } ?? 0
        }
        
        loginHeaderView = LoginHeaderview(userName: State.shared.user?.name ?? "",
                                          ordersSum: ordersSum.description,
                                          ordersDescription: ordersValueSum.toCurrency)
        scrollView.addSubview(loginHeaderView)
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
        self.errorLabel.text = "Invalid email or password".localized
    }
    
    private func wrongEmailAndPassword() {
        self.errorLabel.text = "Invalid email or password".localized
        self.passwordTextInput.text = ""
        self.passwordTextInput.becomeFirstResponder()
    }
    
    private func emailEmpty() {
        errorLabel.text = "Email is required".localized
    }
    
    private func passwordEmpty() {
        errorLabel.text = "Password is required".localized
    }
    
    private func emailAndPasswordEmpty() {
        errorLabel.text = "Email and password are required".localized
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
            self.animatedLogo.layer.opacity = 1
            let logoanimation = AnimationType.from(direction: .bottom, offset: 230)
            self.animatedLogo.animate(animations: [logoanimation])
        }
    }
    
    /// endAnimation() is fired when transition to show orders begins
    private func endAnimation() {
        UIView.transition(with: mainStack, duration: 0.1, options: .transitionCrossDissolve,
                          animations: {
                                self.mainStack.layer.opacity = 0
                          })
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.animatedLogo.animate()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.makeHeaderView()
            let animation = AnimationType.from(direction: .top, offset: -100)
            self.loginHeaderView.animate(animations: [animation])
        }
    }
    
    // MARK: Constraints

    func addConstraints() {
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 260.dp),
            
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
