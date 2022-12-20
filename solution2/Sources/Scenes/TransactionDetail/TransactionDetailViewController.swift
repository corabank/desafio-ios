import UIKit

protocol TransactionDetailDisplaying: AnyObject {
    func displayContent(viewModel: TransactionDetailViewModel)
}

final class TransactionDetailViewController: BaseViewController<TransactionDetailInteracting> {
    private typealias Localizable = Strings.TransactionDetail
    
    private lazy var iconImage: UIImageView = {
       let imageView = UIImageView()
        imageView.tintColor = Colors.offBlack.color
        return imageView
    }()
    
    private lazy var transactionDescription: UILabel = {
        let label = UILabel()
        label.textColor = Colors.offBlack.color
        label.font = Font.Highlighted.tertiaryTitle
        return label
    }()
    
    private lazy var transactionStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [iconImage, transactionDescription])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = Spacing.space02
        return stackView
    }()
    
    private lazy var valueTitle: UILabel = {
        let label = UILabel()
        label.text = Localizable.value
        label.textColor = Colors.offBlack.color
        label.font = Font.Regular.primarySubtitle
        return label
    }()
    
    private lazy var valueLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.offBlack.color
        return label
    }()
    
    private lazy var valueStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [valueTitle, valueLabel])
        stackView.axis = .vertical
        stackView.spacing = Spacing.space00
        return stackView
    }()
    
    private lazy var dateTitle: UILabel = {
        let label = UILabel()
        label.textColor = Colors.offBlack.color
        label.font = Font.Regular.primarySubtitle
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.offBlack.color
        label.font = Font.Highlighted.tertiaryTitle
        return label
    }()
    
    private lazy var dateStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [dateTitle, dateLabel])
        stackView.axis = .vertical
        stackView.spacing = Spacing.space00
        return stackView
    }()
    
    private lazy var descriptionTitle: UILabel = {
        let label = UILabel()
        label.text = Localizable.descriptionTitle
        label.textColor = Colors.offBlack.color
        label.font = Font.Regular.primarySubtitle
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = Localizable.description
        label.textColor = Colors.gray01.color
        label.font = Font.Regular.primarySubtitle
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var descriptionStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [descriptionTitle, descriptionLabel])
        stackView.axis = .vertical
        stackView.spacing = Spacing.space00
        return stackView
    }()
    
    private lazy var senderUserView = TransactionUserView()
    private lazy var receiverUserView = TransactionUserView()
    
    private lazy var rootStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [transactionStackView,
                                                       valueStackView,
                                                       dateStackView,
                                                       senderUserView,
                                                       receiverUserView,
                                                       descriptionStackView])
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = Spacing.space04
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: Spacing.space04,
                                               left: Spacing.space04,
                                               bottom: Spacing.space04,
                                               right: Spacing.space04)
        return stackView
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var shareButton: Button = {
        let action = UIAction { _ in self.didTapShareReceipt() }
        let button = Button(title: Localizable.shareReceipt,
                            titleColor: Colors.white.color,
                            action: action,
                            icon: Images.icShareIos.image,
                            style: .large)
        button.backgroundColor = Colors.branding00.color
        button.imageTintColor = Colors.white.color
        button.border(radius: Radius.large)
        return button
    }()
    
    private lazy var cancelScheduleButton: Button = {
        let action = UIAction { [weak self] _ in print("Cancel Clicked") }
        let button = Button(title: Localizable.cancelTransferSchedule,
                            titleColor: Colors.branding00.color,
                            action: action,
                            style: .medium)
        button.backgroundColor = .clear
        return button
    }()
    
    private lazy var buttonsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [shareButton, cancelScheduleButton])
        stackView.axis = .vertical
        stackView.spacing = Spacing.space03
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: Spacing.space03,
                                               left: Spacing.space04,
                                               bottom: Spacing.space03,
                                               right: Spacing.space04)
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = Localizable.title
        interactor.fetchContent()
        setupCustomNavigationBar()
    }
    
    // MARK: BuildableView
    
    override func setupHierarchy() {
        view.addSubviews(scrollView, buttonsStackView)
        scrollView.addSubview(rootStackView)
    }
    
    override func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: navigationBarHeight),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: buttonsStackView.topAnchor)
        ])
        
        NSLayoutConstraint.activate([
            buttonsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            buttonsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            buttonsStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            rootStackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            rootStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            rootStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            rootStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            rootStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
        iconImage.size(24)
    }
    
    override func setupStyles() {
        view.backgroundColor = Colors.white.color
    }
}

// MARK: - TransactionDetailDisplaying
extension TransactionDetailViewController: TransactionDetailDisplaying {
    func displayContent(viewModel: TransactionDetailViewModel) {
        iconImage.image = viewModel.icon
        transactionDescription.text = viewModel.description
        valueLabel.attributedText = viewModel.formattedValue
        dateTitle.text = viewModel.dateTitle
        dateLabel.text = viewModel.formattedDate
        cancelScheduleButton.isHidden = !viewModel.shouldShowCancelButton
        senderUserView.setup(content: viewModel.senderContent)
        receiverUserView.setup(content: viewModel.receiverContent)
    }
}

private extension TransactionDetailViewController {
    func getReceiptImage() -> UIImage? {
        rootStackView.getScreenshot()
    }
    
    func didTapShareReceipt() {
        guard let image = getReceiptImage() else { return }
        interactor.share(receipt: image)
    }
}
