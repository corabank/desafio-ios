import UIKit

protocol ExtractDetailDisplaying: AnyObject {
    func displaySomething()
}

private extension ExtractDetailViewController.Layout {
    enum Size {
        static let navBarHeight: CGFloat = 44.0
        static let titleStackViewHeight: CGFloat = 24.0
        static let valueStackViewHeight: CGFloat = 48.0
        static let buttonHeight: CGFloat = 64.0
    }
}

final class ExtractDetailViewController: UIViewController {
    fileprivate enum Layout {
        // template
    }
    
    private lazy var navBar: UINavigationBar = {
        let navBar = UINavigationBar()
        let navItem = UINavigationItem(title: Strings.extractDetailNavBarTitle)
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
    
    private lazy var extractDetailImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = interactor.getTransactionImage()
        imageView.tintColor = interactor.getTransactionColor()
        return imageView
    }()
    
    private lazy var extractDetailTitle: UILabel = {
        let label = UILabel()
        label.text = interactor.getTransactionType()
        label.font = Typography.getFont(.bold(size: 16))()
        label.numberOfLines = 0
        label.textColor = interactor.getTransactionColor()
        return label
    }()
    
    private lazy var titleStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [extractDetailImage, extractDetailTitle])
        stackView.alignment = .leading
        stackView.spacing = Spacing.space2
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var valueTitle: UILabel = {
        let label = UILabel()
        label.text = Strings.valueTitle
        label.font = Typography.getFont(.regular(size: 14))()
        label.numberOfLines = 0
        label.textColor = Colors.offBlack
        return label
    }()
    
    private lazy var valueContentTitle: UILabel = {
        let label = UILabel()
        label.text = interactor.getTransactionValue()
        label.font = Typography.getFont(.bold(size: 16))()
        label.numberOfLines = 0
        label.textColor = Colors.offBlack
        return label
    }()
    
    private lazy var valueStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [valueTitle, valueContentTitle])
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = Spacing.space0
        return stackView
    }()
    
    private lazy var dataTitle: UILabel = {
        let label = UILabel()
        label.text = Strings.dataTitle
        label.font = Typography.getFont(.regular(size: 14))()
        label.numberOfLines = 0
        label.textColor = Colors.offBlack
        return label
    }()
    
    private lazy var dataContentTitle: UILabel = {
        let label = UILabel()
        label.text = interactor.getTransactionDay()
        label.font = Typography.getFont(.bold(size: 16))()
        label.numberOfLines = 0
        label.textColor = Colors.offBlack
        return label
    }()
    
    private lazy var dataStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [dataTitle, dataContentTitle])
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = Spacing.space0
        return stackView
    }()
    
    private lazy var userSent: UserInfo = {
        let userRecieved = UserInfo()
        userRecieved.setupUserInfo(userData: interactor.getUserSentData(), type: Strings.sent)
        return userRecieved
    }()
    
    private lazy var userRecieved: UserInfo = {
        let userRecieved = UserInfo()
        userRecieved.setupUserInfo(userData: interactor.getUserRecievedData(), type: Strings.recieved)
        return userRecieved
    }()
    
    
    private lazy var descriptionTitle: UILabel = {
        let label = UILabel()
        label.text = Strings.descriptionTitle
        label.font = Typography.getFont(.regular(size: 14))()
        label.numberOfLines = 0
        label.textColor = Colors.offBlack
        return label
    }()
    
    private lazy var descriptionContentTitle: UILabel = {
        let label = UILabel()
        label.text = Strings.description
        label.font = Typography.getFont(.regular(size: 14))()
        label.numberOfLines = 0
        label.textColor = Colors.gray1
        return label
    }()
    
    private lazy var descriptionStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [descriptionTitle, descriptionContentTitle])
        stackView.axis = .vertical
        stackView.spacing = Spacing.space0
        stackView.alignment = .leading
        return stackView
    }()
    
    private lazy var rootStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [valueStackView,
                                                       dataStackView,
                                                       userSent,
                                                       userRecieved,
                                                       descriptionStackView])
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = Spacing.space5
        stackView.distribution = .fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var config: UIButton.Configuration = {
        var config = UIButton.Configuration.filled()
        config.baseForegroundColor = Colors.white
        config.buttonSize = .large
        config.cornerStyle = .large
        config.title = Strings.share
        config.baseBackgroundColor = Colors.backgroundColor
        config.contentInsets = .init(top: 20, leading: 20, bottom: 20, trailing: 20)
        config.titleAlignment = .leading
        config.image = Images.share
        config.imagePadding = 60
        config.imagePlacement = .trailing
        return config
    }()
    
    lazy var shareExtractButton: UIButton = {
        let action = UIAction(handler: { action in
            self.shareButtonTapped()
        })
        let button = UIButton(configuration: config, primaryAction: action)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var cancelTransfer: UILabel = {
        let label = UILabel()
        let action = UITapGestureRecognizer(target: self, action: #selector(cancelTransferButtonTapped))
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = Strings.cancelTransfer
        label.font = Typography.getFont(.regular(size: 16))()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = Colors.backgroundColor
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(action)
        label.isHidden = interactor.showCancelButton()
        return label
    }()
    
    private let interactor: ExtractDetailInteracting
    
    init(interactor: ExtractDetailInteracting) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildView()
    }
}

// MARK: - @objc Private Methods
@objc private extension ExtractDetailViewController {
    func backButtonTapped(){
        navigationController?.popViewController(animated: true)
    }
    
    func shareButtonTapped() {
        interactor.share()
    }
    
    func cancelTransferButtonTapped() {
        interactor.cancelTransaction()
    }
}

// MARK: - View Setup
extension ExtractDetailViewController: ViewSetup {
    func setupConstraints() {
        NSLayoutConstraint.activate([
            navBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            navBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navBar.heightAnchor.constraint(equalToConstant: Layout.Size.navBarHeight)
        ])
        
        NSLayoutConstraint.activate([
            titleStackView.topAnchor.constraint(equalTo: navBar.bottomAnchor, constant: Spacing.space6),
            titleStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Spacing.space5),
            titleStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Spacing.space5),
            titleStackView.heightAnchor.constraint(equalToConstant: Layout.Size.titleStackViewHeight)
        ])
        
        NSLayoutConstraint.activate([
            rootStackView.topAnchor.constraint(equalTo: titleStackView.bottomAnchor, constant: Spacing.space5),
            rootStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Spacing.space5),
            rootStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Spacing.space5),
            rootStackView.bottomAnchor.constraint(equalTo: shareExtractButton.topAnchor, constant: -Spacing.space5)
        ])
        
        NSLayoutConstraint.activate([
            shareExtractButton.bottomAnchor.constraint(equalTo: cancelTransfer.topAnchor, constant: -Spacing.space5),
            shareExtractButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Spacing.space5),
            shareExtractButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Spacing.space5),
            shareExtractButton.heightAnchor.constraint(equalToConstant: Layout.Size.buttonHeight)
        ])
        
        NSLayoutConstraint.activate([
            cancelTransfer.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Spacing.space6),
            cancelTransfer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Spacing.space5),
            cancelTransfer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Spacing.space5),
            cancelTransfer.heightAnchor.constraint(equalToConstant: 24)
        ])
        
        NSLayoutConstraint.activate([
            extractDetailImage.heightAnchor.constraint(equalToConstant: 24),
            extractDetailImage.widthAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    func setupHierarchy() {
        view.addSubview(navBar)
        view.addSubview(titleStackView)
        view.addSubview(rootStackView)
        view.addSubview(shareExtractButton)
        view.addSubview(cancelTransfer)
    }
    
    func setupStyles() {
        view.backgroundColor = Colors.white
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
}

// MARK: - ExtractDetailDisplaying
extension ExtractDetailViewController: ExtractDetailDisplaying {
    func displaySomething() {
        // template
    }
}
