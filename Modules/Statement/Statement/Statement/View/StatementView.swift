import Foundation
import UIKit
import ViewCode
import Components

final class StatementView: UIViewController {
    
    private var viewModel: StatementViewDelegate?
    private lazy var sections: [StatementSection] = []
    
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
    
    private lazy var navigation: NavigationBar = {
        let nav = NavigationBar(title: navTitle, share: true)
        nav.set(delegate: self)
        return nav
    }()
    
    private lazy var table: UITableView = {
        let table = UITableView(frame: .zero)
        table.register(StatementItemCell.self, forCellReuseIdentifier: "statement_cell")
        table.sectionHeaderHeight = 0
        table.delegate = self
        table.dataSource = self
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

extension StatementView: StatementViewProtocol {
    func set(delegate: StatementViewDelegate) {
        self.viewModel = delegate
    }
}

extension StatementView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Tapped cell \(sections[indexPath.row])")
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sections[section].itens.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.sections.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: StatementItemCell = self.table.dequeueReusableCell(withIdentifier: "statement_cell") as? StatementItemCell else {
            return UITableViewCell(frame: .zero)
        }
        let item = sections[indexPath.section].itens[indexPath.row]
        cell.set(statement: item)
        return cell
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
