import Foundation
import UIKit
import ViewCode
import Components
import Resources

final class StatementView: UIViewController {
    
    var viewModel: StatementViewDelegate?
    var sections: [StatementDay] = []
    
    private let navTitle = "Extrato"
    
    private lazy var stack: UIStackView = {
        let stack: UIStackView = UIStackView(frame: .zero)
        stack.alignment = .center
        stack.axis = .vertical
        return stack
    }()
    
    private lazy var header: UIStackView = {
        let stack: UIStackView = UIStackView(frame: .zero)
        stack.alignment = .center
        stack.axis = .vertical
        return stack
    }()
    
    private lazy var filterStack: UIStackView = {
        let stack: UIStackView = UIStackView(frame: .zero)
        stack.alignment = .center
        stack.spacing = Dimensions.medium
        stack.axis = .horizontal
        return stack
    }()
    
    private lazy var filterIcon: UIImageView = {
        let view: UIImageView = UIImageView(image: UIImage(imageLiteralResourceName: Images.filter))
        return view
    }()
    
    private lazy var filterPicker: StatementSegmentControl = {
        let filter: StatementSegmentControl = StatementSegmentControl()
        filter.set(delegate: self)
        return filter
    }()
    
    private lazy var navigation: NavigationBar = {
        let nav = NavigationBar(title: navTitle, share: true)
        nav.set(delegate: self)
        return nav
    }()
    
    lazy var table: UITableView = {
        let table = UITableView(frame: .zero)
        table.register(StatementItemCell.self, forCellReuseIdentifier: "statement_cell")
        table.sectionHeaderHeight = 0
        table.sectionFooterHeight = 0
        table.separatorColor = .clear
        table.delegate = self
        table.dataSource = self
        table.sectionHeaderTopPadding = 0
        table.frame = view.bounds
        return table
    }()
    
    required init?(coder: NSCoder) { return nil }
    init() {
        super.init(nibName: nil, bundle: nil)
        setupView()
    }
}

extension StatementView: ViewCode {
    func setSubviews() {
        view.addSubviews([stack, table])
        stack.addArrangedSubview(header)
        header.addArrangedSubview(navigation)
        header.addArrangedSubview(filterStack)
        filterStack.addArrangedSubview(filterPicker)
        filterStack.addArrangedSubview(filterIcon)
    }
    
    func setConstraints() {
        stack.anchor(top: view.safeAreaLayoutGuide.topAnchor)
        stack.setWidthEqual(to: view)
        header.setWidthEqual(to: stack)
        navigation.setWidthEqual(to: header)
        
        table.anchor(top: stack.bottomAnchor, bottom: view.bottomAnchor)
        table.setWidthEqual(to: view)
        
        filterStack.setWidthEqual(to: header)
        filterStack.anchor(leading: header.leadingAnchor,
                           trailing: header.trailingAnchor,
                           paddingLeft: Dimensions.medium,
                           paddingRight: Dimensions.medium)
        filterStack.size(height: 56)
        filterPicker.setHeightEqual(to: filterStack)
        filterIcon.size(height: Dimensions.medium, width: Dimensions.medium)
    }
    
    func extraSetups() {
        view.backgroundColor = Colors.lightGray
        filterStack.backgroundColor = Colors.white
        header.backgroundColor = Colors.white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setData()
    }
    
    private func setData() {
        guard let data = viewModel?.getData() else { return }
        sections = data
    }
}

extension StatementView: StatementViewProtocol {
    func set(delegate: StatementViewDelegate) {
        self.viewModel = delegate
    }
}

extension StatementView: NavigationBarDelegate {
    func tapBack() {
        viewModel?.tapBack()
    }
    
    func tapShare() {
        viewModel?.tapShare()
    }
}

extension StatementView: StatementSegmentControlDelegate {
    func tapAll() {
        print("all")
    }
    
    func tapIncome() {
        print("income")
    }
    
    func tapOutcome() {
        print("outcome")
    }
    
    func tapFuture() {
        print("future")
    }
}
