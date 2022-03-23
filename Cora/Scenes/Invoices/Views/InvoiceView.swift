import UIKit

final class InvoiceView: UIView {
    private let tableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = .white
        table.register(InvoiceCell.self, forCellReuseIdentifier: InvoiceCell.description())
        return table
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        backgroundColor = .white
        addViews()
        addConstraints()
    }

    private func addViews() {
        addSubview(tableView)
    }

    private func addConstraints() {
        tableView.edgesToSuperview(usingSafeArea: true)
    }

    func setupTable(dataSource: UITableViewDataSource, delegate: UITableViewDelegate) {
        tableView.delegate = delegate
        tableView.dataSource = dataSource
    }

    func reloadData() {
        tableView.reloadData()
    }
}
