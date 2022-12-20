import UIKit

protocol BankStatementDisplaying: AnyObject {
    func displayTransactions()
}

final class BankStatementViewController: BaseViewController<BankStatementInteracting> {
    private typealias Localizable = Strings.BankStatement
    
    private lazy var segmentedControl: SegmentedControl = {
        let titles = BankStatementSegment.allCases.map { $0.description }
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
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.sectionFooterHeight = 24
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = Localizable.title
        setupCustomNavigationBar()
        setRightButtonItem(icon: Images.icDownload.image)
    }
    
    override func setupHierarchy() {
        view.addSubviews(segmentsStackView, tableView)
    }
    
    // MARK: BuildableView
    
    override func setupConstraints() {
        NSLayoutConstraint.activate([
            segmentsStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: navigationBarHeight),
            segmentsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            segmentsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            segmentsStackView.heightAnchor.constraint(equalToConstant: 52)
        ])
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: segmentsStackView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        filterButton.size(24)
    }
    
    override func setupStyles() {
        view.backgroundColor = Colors.white.color
    }
}

extension BankStatementViewController: BankStatementDisplaying {
    func displayTransactions() {
        UIView.transition(with: tableView,
                          duration: 0.15,
                          options: .transitionCrossDissolve,
                          animations: {
            self.tableView.reloadData()
        })
    }
}

extension BankStatementViewController: SegmentedControlDelegate {
    func didChangeSelection(to index: Int) {
        interactor.selectSegment(at: index)
    }
}

extension BankStatementViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        interactor.didSelectTransaction(section: indexPath.section, at: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return StatementHeaderView(content: interactor.dayInfo(for: section))
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        32
    }
}

extension BankStatementViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        interactor.numberOfDays()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        interactor.numberOfTransactions(at: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = String(describing: StatementItemCell.self)
        let cell = StatementItemCell(style: .default, reuseIdentifier: identifier)
        cell.setup(content: interactor.transactionInfo(section: indexPath.section, at: indexPath.row))
        return cell
    }
}
