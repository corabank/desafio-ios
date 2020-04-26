//
//  OrderListTableViewDataSource.swift
//  DesafioCoraBank
//
//  Created by Roger Sanoli on 25/04/20.
//  Copyright © 2020 RogerSanoli. All rights reserved.
//

import UIKit

class OrderListTableViewDataSource: NSObject {
    var cells: [OrderValueViewModel] = []
    var onSelect: ((OrderValueViewModel)->Void)?
    var shouldAnimate: Bool
    
    init(_ tableView: UITableView) {
        
        shouldAnimate = true
        super.init()
        
        //tableView.isAccessibilityElement = true
        tableView.separatorStyle = .none
        tableView.rowHeight = 64
        tableView.register(OrderListTableViewCell.self, forCellReuseIdentifier: "orderCell")
        tableView.showsVerticalScrollIndicator = false
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension OrderListTableViewDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "orderCell", for: indexPath) as? OrderListTableViewCell
        cell?.setup(cells[indexPath.row], isFirst: indexPath.row == 0)
        return cell ?? UITableViewCell()
    }
}

extension OrderListTableViewDataSource: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        onSelect?(cells[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        guard
            let cell = cell as? OrderListTableViewCell,
            shouldAnimate
        else { return }
        
        cell.orderValueView.alpha = 0
        cell.orderValueView.transform = CGAffineTransform(translationX: 0, y: 10)

        UIView.animate(withDuration: 0.5, delay: 0.05 * Double(indexPath.row), animations: {
            cell.orderValueView.alpha = 1
            cell.orderValueView.transform = .identity
        })
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        shouldAnimate = false
    }
}
