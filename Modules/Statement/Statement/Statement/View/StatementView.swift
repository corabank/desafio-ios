import Foundation
import UIKit
import ViewCode
import Components

final class StatementView: UIViewController {
    
    private var viewModel: StatementViewDelegate?
    
    // mock data, remove after
    private let todos = [
        ["a", "b", "c"],
        ["1", "2", "3"],
        ["31a", "22b", "41c"],
        ["aaaa", "bbbbb", "ccccc"],
        ["31a", "22b", "41c"],
    ]
    
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
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
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
}

extension StatementView: StatementViewProtocol {
    func set(delegate: StatementViewDelegate) {
        self.viewModel = delegate
    }
}

extension StatementView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Tapped cell \(todos[indexPath.row])")
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.todos[section].count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.todos.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: UITableViewCell = self.table.dequeueReusableCell(withIdentifier: "cell") else {
            return UITableViewCell(frame: .zero)
        }
        cell.textLabel?.text = self.todos[indexPath.section][indexPath.row]
        cell.backgroundColor = .red
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
