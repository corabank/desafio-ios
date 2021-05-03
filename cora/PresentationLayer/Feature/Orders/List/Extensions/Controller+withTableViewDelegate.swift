//
//  Controller+withTableViewDelegate.swift
//  cora
//
//  Created by Lucas Silveira on 30/04/21.
//

import UIKit

extension OrdersViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        orders.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let order = orders[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.orderCell) as? OrderCell
        let cellBackgroundView = UIView()

        cellBackgroundView.backgroundColor = .selectedCellBackgroundColor
        cell?.selectedBackgroundView = cellBackgroundView
        cell?.set(order: order)
        cell?.accessibilityIdentifier = "order\(indexPath.row)"
        self.tableView.sizeToFit()

        return cell ?? UITableViewCell()
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell,
                   forRowAt indexPath: IndexPath) {
        let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, 0, 200, 0)
        cell.layer.transform = rotationTransform
        cell.alpha = 0
        UIView.animate(withDuration: 0.45) {
            cell.layer.transform = CATransform3DIdentity
            cell.alpha = 1
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.showDetail(order: self.orders[indexPath.row])
    }
}
