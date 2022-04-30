import Foundation
import UIKit
import ViewCode
import Components

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
        stack.axis = .horizontal
        return stack
    }()
    
    private lazy var filterPicker: UISearchBar = {
        let picker: UISearchBar = UISearchBar(frame: .zero)
        picker.delegate = self
        //picker.showsScopeBar = true
        //picker.searchRe
        picker.scopeButtonTitles  = ["Tudo", "Entrada", "Saída", "Future"]
        return picker
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
    }
    
    func setConstraints() {
        stack.anchor(top: view.topAnchor)
        stack.setWidthEqual(to: view)
        header.setWidthEqual(to: stack)
        navigation.setWidthEqual(to: header)
        
        table.anchor(top: stack.bottomAnchor, bottom: view.bottomAnchor)
        table.setWidthEqual(to: view)
        
        filterStack.setWidthEqual(to: header)
        filterStack.size(height: 56)
        filterPicker.setHeightEqual(to: filterStack)
    }
    
    func extraSetups() {
        view.backgroundColor = Colors.white
        filterStack.backgroundColor = .red
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setData()
    }
    
    private func setData() {
        guard let data = viewModel?.getData() else { return }
        sections = data
    }
}

extension StatementView: UISearchBarDelegate {
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
