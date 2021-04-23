//
//  OrdersViewController.swift
//  cora
//
//  Created by Lucas Silveira on 16/04/21.
//

import UIKit

//sourcery: AutoMockable
protocol OrdersViewControllerDelegate: class {
    func showDetail(order: Order)
}

class OrdersViewController: UIViewController {
    var viewModel: OrdersViewModelProtocol?
    
    // needs strong reference to be used in tableview
    var delegate: OrdersViewControllerDelegate?
    var orderID: UUID?
    
    var tableView = UITableView()
    var orders = [Order]()
    
    struct Cells {
        static let orderCell = "OrderCell"
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel?.fetchOrders()
        makeView()
        makeTableView()
        scrollIfNeeds()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel?.onUpdated = handleState
    }
    
    func handleState(state: OrdersViewModelState) {
        switch state {
        case .success(let orders):
            self.orders = orders
        default:
            break
        }
    }

    fileprivate func makeView() {
        title = "Orders"
        view.backgroundColor = .white
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    fileprivate func makeTableView() {
        view.addSubview(tableView)
        tableView.separatorColor = .clear
        tableView.showsVerticalScrollIndicator = false
        setTableViewDelegates()
        tableView.rowHeight = 66
        tableView.register(OrderCell.self, forCellReuseIdentifier: Cells.orderCell)
        tableView.isScrollEnabled = true
        tableView.accessibilityIdentifier = "ordersTableView"
        tableView.pin(to: view)
    }

    fileprivate func setTableViewDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    fileprivate func scrollIfNeeds() {
        if let orderID = orderID {
            if let index = orders.firstIndex(where: { $0.id == orderID }) {
                let indexPath = NSIndexPath(row: index, section: 0)
                tableView.scrollToRow(at: indexPath as IndexPath, at: .top, animated: true)
            }
        }
    }
}

extension OrdersViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        orders.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.orderCell) as? OrderCell
        let order = orders[indexPath.row]
        cell?.set(order: order)
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
        self.delegate?.showDetail(order: self.orders[indexPath.row])
    }
}
