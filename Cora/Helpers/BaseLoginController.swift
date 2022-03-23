import UIKit

class BaseLoginController: UIViewController {

    var keyboardDidAppear: ((CGFloat) -> Void)?
    var keyboardDidDisappear: (() -> Void)?

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavBar()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(onKeyboardAppear),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(onKeyboardDisappear),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }

    override func viewWillDisappear(_ animated: Bool) {
        clearNavBar()
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillShowNotification,
                                                  object: nil)

        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillHideNotification,
                                                  object: nil)
    }

    private func setupNavBar() {
        navigationItem.title = L10n.Login.title
        navigationController?.navigationBar.backgroundColor = .gray4
        navigationController?.navigationBar.tintColor = .mainCora

        let textAttributes = [NSAttributedString.Key.font: UIFont.body2,
                              NSAttributedString.Key.foregroundColor: UIColor.gray1]
        navigationController?.navigationBar.titleTextAttributes = textAttributes

        let customBackButton = UIBarButtonItem(image: Images.iconArrowLeft.image,
                                               style: .plain,
                                               target: self,
                                               action: #selector(onBackButtonTapped))
        navigationItem.leftBarButtonItem = customBackButton
    }

    private func clearNavBar() {
        navigationController?.navigationBar.backgroundColor = .clear
    }

    @objc
    private func onBackButtonTapped() {
        navigationController?.popViewController(animated: true)
    }

    @objc
    private func onKeyboardAppear(_ notification: Notification) {
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue
        else { return }
        keyboardDidAppear?(keyboardFrame.cgRectValue.height)
    }

    @objc
    private func onKeyboardDisappear() {
        keyboardDidDisappear?()
    }
}
