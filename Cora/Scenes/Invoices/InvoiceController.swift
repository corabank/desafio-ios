import UIKit

final class InvoiceController: UIViewController {
    private let contentView = InvoiceView()
    private let dataSource = DataSource(source: [])
    private let presenter: InvoicePresenterType

    init(presenter: InvoicePresenterType) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = contentView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.setupTable(dataSource: dataSource, delegate: dataSource)
        presenter.loadTransactions()
    }
}

extension InvoiceController: InvoiceControllerType {
    func showTransactions(transactions: [InvoiceViewModel]) {
        dataSource.update(data: transactions)
        contentView.reloadData()
    }
}
