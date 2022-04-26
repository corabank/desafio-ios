import Foundation
import UIKit
import ViewCode
import Components

final class StatementView: UIViewController {
    
    private var viewModel: StatementViewDelegate?
    
    // mock data, remove after
    private let todos = ["a", "b", "c"]
    
    private lazy var table: UITableView = {
        let table = UITableView(frame: .zero)
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
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
        view.addSubview(table)
    }
    
    func setConstraints() {
        table.setAnchorsEqual(to: self.view)
    }
    
    func extraSetups() {
        view.backgroundColor = .white
    }
}

extension StatementView: StatementViewProtocol {
    func set(delegate: StatementViewDelegate) {
        self.viewModel = delegate
    }
}

extension StatementView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.todos.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20.0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.todos.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: UITableViewCell = self.table.dequeueReusableCell(withIdentifier: "cell") else {
            return UITableViewCell(frame: .zero)
        }
        cell.textLabel?.text = self.todos[indexPath.row]
        cell.backgroundColor = .red
        return cell
    }
}
    
extension StatementView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Tapped cell \(todos[indexPath.row])")
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
