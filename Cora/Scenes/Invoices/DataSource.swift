import UIKit

final class DataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    private var source: [InvoiceViewModel]

    init(source: [InvoiceViewModel]) {
        self.source = source
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        source.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: InvoiceCell.description(),
                                                 for: indexPath) as? InvoiceCell
        let viewModel = source[indexPath.row]
        cell?.show(viewModel: viewModel)
        return cell ?? UITableViewCell()
    }

    func update(data: [InvoiceViewModel]) {
        source = data
    }
}
