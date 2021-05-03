//
//  OrdersViewController.swift
//  cora
//
//  Created by Lucas Silveira on 16/04/21.
//

import UIKit

//sourcery: AutoMockable
protocol OrdersViewControllerDelegate: AnyObject {
    func showDetail(order: Order)
}

class OrdersViewController: UIViewController {
    weak var delegate: OrdersViewControllerDelegate?
    var viewModel: OrdersViewModelProtocol?
    var emptyView: UIView!
    var orderID: UUID?
    var tableView: UITableView!
    var orders = [Order]()
    var lastLocation: CGPoint = CGPoint(x: 0, y: 0)
    
    var topLimit: CGFloat!
    let rowHeight = 66.dp
    let initY = 175.dp
    let bottomLimit = 50.dp
    
    struct Cells {
        static let orderCell = "OrderCell"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.fetchOrders()
        makeView()
        makeTableView()
        makeEmpty()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.onUpdated = handleState
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if !orders.isEmpty && view.frame.size.height < tableView.contentSize.height {
            view.frame = CGRect(x: 0, y: initY,
                                width: UIScreen.main.bounds.width,
                                height: tableView.contentSize.height + 50.dp)
            return
        }
        
        view.frame = CGRect(x: 0, y: 175.dp, width: view.frame.width, height: view.frame.height)
        topLimit = UIScreen.main.bounds.height - view.frame.height - 175.dp
    }
    
    fileprivate func handleState(state: OrdersViewModelState) {
        switch state {
        case .success(let orders):
            self.orders = orders
            addGesture()
            tableView.isHidden = false
        case .empty:
            emptyView.isHidden = false
        default:
            break
        }
    }
    
    fileprivate func makeEmpty() {
        let label = UILabel.customLabel(textColor: .ordersTitleColor, text: "Nenhum pedido encontrado",
                                        fontSize: 16)
        label.textAlignment = .center
        
        let button = UIButton(type: .custom)
        let image = UIImage(named: "plus.circle")?.withRenderingMode(.alwaysTemplate)
        button.setImage(image, for: .normal)
        button.tintColor = UIColor.systemPink
        button.imageView?.layer.transform = CATransform3DMakeScale(2, 2, 2)
        
        emptyView = UIView()
        emptyView.addSubview(label)
        emptyView.addSubview(button)
        view.addSubview(emptyView)
        emptyView.pin(to: view)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
        label.topAnchor.constraint(equalTo: emptyView.topAnchor, constant: 150.dp).isActive = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
        button.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 20.dp).isActive = true
        emptyView.isHidden = true
    }

    fileprivate func makeView() {
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    fileprivate func addGesture() {
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(wasDragged(recognizer:)))
        gesture.maximumNumberOfTouches = 1
        gesture.delaysTouchesBegan = true
        gesture.cancelsTouchesInView = true
        gesture.delegate = self
        
        self.view?.addGestureRecognizer(gesture)
        self.view?.isUserInteractionEnabled = true
    }

    fileprivate func makeTableView() {
        tableView = UITableView()
        view.addSubview(tableView)
        setTableViewDelegates()

        let screenWidth = UIScreen.main.bounds.width
        if screenWidth == 375.0 || UIScreen.main.bounds.width == 390.0 {
            tableView.contentInset = UIEdgeInsets(top: -30.dp, left: 0, bottom: 0, right: 0)
        }
        
        tableView.panGestureRecognizer.isEnabled = false
        tableView.separatorColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.rowHeight = rowHeight
        tableView.register(OrderCell.self, forCellReuseIdentifier: Cells.orderCell)
        tableView.isScrollEnabled = false
        tableView.accessibilityIdentifier = "ordersTableView"
        tableView.pin(to: view)
        tableView.isHidden = true
    }

    fileprivate func setTableViewDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func showDetail(order: Order) {
        delegate?.showDetail(order: order)
    }
}
