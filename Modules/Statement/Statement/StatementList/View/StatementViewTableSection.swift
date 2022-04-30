import UIKit

extension StatementView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(sections[indexPath.section].itens[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 32
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let item = StatementTableSection()
        let mock = "Sext-feira whatever"
        //item.set(date: sections[section].date, value: String(sections[section].total()))
        item.set(date: mock, value: String(sections[section].total()))
        return item
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return .leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
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
