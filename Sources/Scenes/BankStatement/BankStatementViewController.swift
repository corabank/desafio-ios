import UIKit

protocol BankStatementDisplaying: AnyObject {
    func displaySomething()
}

final class BankStatementViewController: BaseViewController<BankStatementInteracting> {
    private typealias Localizable = Strings.BankStatement
    
    private lazy var segmentedControl: SegmentedControl = {
        let titles = [Localizable.Segment.all, Localizable.Segment.input, Localizable.Segment.output, Localizable.Segment.future]
        let segmentedControl = SegmentedControl(titles: titles, selectedIndex: 0)
        segmentedControl.delegate = self
        return segmentedControl
    }()
    
    private lazy var filterButton: UIButton = {
        let action = UIAction { _ in print("Filter Clicked") }
        let button = UIButton()
        button.addAction(action, for: .touchUpInside)
        button.setImage(Images.icFilter.image, for: [])
        button.tintColor = Colors.branding00.color
        return button
    }()
    
    private lazy var segmentsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [segmentedControl, filterButton])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = Spacing.space04
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: .zero,
                                               left: Spacing.space04,
                                               bottom:  .zero,
                                               right: Spacing.space04)
        return stackView
    }()
    
    override func viewDidLoad() {
        title = Localizable.title
        super.viewDidLoad()
        setupCustomNavigationBar()
        setRightButtonItem(icon: Images.icDownload.image)
    }
    
    override func setupHierarchy() {
        view.addSubview(segmentsStackView)
    }
    
    override func setupConstraints() {
        NSLayoutConstraint.activate([
            segmentsStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: navigationBarHeight),
            segmentsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            segmentsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            segmentsStackView.heightAnchor.constraint(equalToConstant: 52)
        ])
        
        filterButton.size(24)
    }
    
    override func setupStyles() {
        view.backgroundColor = Colors.white.color
    }
}

extension BankStatementViewController: BankStatementDisplaying {
    func displaySomething() { 
        // template
    }
}

extension BankStatementViewController: SegmentedControlDelegate {
    func didChangeSelection(to index: Int) {
        print("Selected index: \(index)")
    }
}
