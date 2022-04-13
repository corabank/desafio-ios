import UIKit

protocol ExtractDisplaying: AnyObject {
    func showStatementList(statementList: [StatementData])
}

private extension ExtractViewController.Layout {
    enum Size {
        static let imageHeight: CGFloat = 90.0
    }
}

class MobileBrand {
    var brandName: String?
    var modelName: [String]?
    var name: String?
    
    init(brandName: String, name: String, modelName: [String]) {
        self.brandName = brandName
        self.name = name
        self.modelName = modelName
    }
}

final class ExtractViewController: UIViewController {
    fileprivate enum Layout {}
    
    private lazy var navBar: UINavigationBar = {
        let navBar = UINavigationBar()
        let navItem = UINavigationItem(title: Strings.extractNavBarTitle)
        let backItem = UIBarButtonItem(image: Images.leftArrow, style: .done, target: self, action: #selector(backButtonTapped))
        let signOutItem = UIBarButtonItem(image: Images.signOut, style: .done, target: self, action: #selector(signOutButtonTapped))
        let textAttributes = [NSAttributedString.Key.foregroundColor: Colors.gray1!]
        backItem.tintColor = Colors.backgroundColor
        signOutItem.tintColor = Colors.backgroundColor
        navItem.leftBarButtonItem = backItem
        navItem.rightBarButtonItem = signOutItem
        navBar.backgroundColor = Colors.gray4
        navBar.titleTextAttributes = textAttributes
        navBar.translatesAutoresizingMaskIntoConstraints = false
        navBar.setItems([navItem], animated: false)
        return navBar
    }()
    
    private lazy var sectionControl: CustomSegmentedControl = {
        let control = CustomSegmentedControl()
        let items = [Strings.sectionItem1, Strings.sectionItem2, Strings.sectionItem3, Strings.sectionItem4]
        control.setButtonTitles(buttonTitles: items)
        control.translatesAutoresizingMaskIntoConstraints = false
        control.delegate = self
        return control
    }()
    
    private lazy var rowsToDisplay = [StatementData]()
    
    private lazy var filterImage: UIImageView = {
        let image = UIImageView()
        let action = UITapGestureRecognizer(target: self, action: #selector(filterButtonTapped))
        image.image = Images.filter
        image.translatesAutoresizingMaskIntoConstraints = false
        image.isUserInteractionEnabled = true
        image.addGestureRecognizer(action)
        return image
    }()
    
    private lazy var sectionStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [sectionControl, filterImage])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var extractTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor.getExtractData()
        buildView()
        self.change(to: 0)
    }
    
    private let interactor: ExtractInteracting
    
    init(interactor: ExtractInteracting) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

@objc private extension ExtractViewController {
    func backButtonTapped(){
        navigationController?.popViewController(animated: true)
    }
    
    func signOutButtonTapped(){
        navigationController?.popToRootViewController(animated: true)
    }
    
    func filterButtonTapped() {
        print("Filtro")
    }
}

extension ExtractViewController: CustomSegmentedControlDelegate {
    func change(to index: Int) {
//        switch index {
//        case 1:
//            rowsToDisplay = [mobileBrand[index]]
//        case 2:
//            rowsToDisplay = [mobileBrand[index]]
//        case 3:
//            rowsToDisplay = [mobileBrand[index]]
//        default:
//            rowsToDisplay = mobileBrand
//        }
        extractTableView.reloadData()
    }
}

extension ExtractViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return rowsToDisplay.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowsToDisplay[section].transactions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = rowsToDisplay[indexPath.section].transactions[indexPath.row].customerName
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 32))
        view.backgroundColor = Colors.gray4
        
        let dateLabel = UILabel(frame: CGRect(x: 15, y: 0, width: view.frame.width - 15, height: 32))
        dateLabel.font = Typography.setFont(.regular(size: 12))()
        dateLabel.textColor = Colors.gray1
        dateLabel.text = rowsToDisplay[section].transactionDay
        let valueLabel = UILabel(frame: CGRect(x: view.frame.width - 90, y: 0, width: view.frame.width - 15, height: 32))
        valueLabel.font = Typography.setFont(.bold(size: 12))()
        valueLabel.textColor = Colors.gray1
        valueLabel.text = rowsToDisplay[section].transactionTotalValue
        view.addSubview(dateLabel)
        view.addSubview(valueLabel)
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 32
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 112
    }
}

extension ExtractViewController: ViewSetup {
    func setupConstraints() {
        NSLayoutConstraint.activate([
            navBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            navBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navBar.heightAnchor.constraint(equalToConstant: 44.0)
        ])
        
        NSLayoutConstraint.activate([
            sectionStackView.topAnchor.constraint(equalTo: navBar.bottomAnchor),
            sectionStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            sectionStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            sectionStackView.heightAnchor.constraint(equalToConstant: 56.0)
        ])
        
        NSLayoutConstraint.activate([
            sectionControl.topAnchor.constraint(equalTo: sectionStackView.topAnchor, constant: 12),
            sectionControl.bottomAnchor.constraint(equalTo: sectionStackView.bottomAnchor, constant: 12),
            sectionControl.leadingAnchor.constraint(equalTo: sectionStackView.leadingAnchor),
            sectionControl.trailingAnchor.constraint(equalTo: sectionStackView.trailingAnchor, constant: -72),
            sectionControl.heightAnchor.constraint(equalToConstant: 32.0)
        ])

        NSLayoutConstraint.activate([
            filterImage.widthAnchor.constraint(equalToConstant: 24.0),
            filterImage.heightAnchor.constraint(equalToConstant: 24.0)
        ])
        
        NSLayoutConstraint.activate([
            extractTableView.topAnchor.constraint(equalTo: sectionStackView.bottomAnchor, constant: 6),
            extractTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            extractTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            extractTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func setupHierarchy() {
        view.addSubview(navBar)
        view.addSubview(sectionStackView)
        view.addSubview(extractTableView)
    }
    
    func setupStyles() {
        view.backgroundColor = Colors.white
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
}

// MARK: - ExtractDisplaying
extension ExtractViewController: ExtractDisplaying {
    func showStatementList(statementList: [StatementData]) {
        rowsToDisplay = statementList
    }
}
