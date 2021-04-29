//
//  OrderDetailViewController.swift
//  cora
//
//  Created by Lucas Silveira on 18/04/21.
//

import UIKit

//sourcery: AutoMockable
protocol OrderDetailViewcontrollerDelegate: class {
    func back()
}

class OrderDetailViewcontroller: UIViewController {
    weak var delegate: OrderDetailViewcontrollerDelegate?
    var viewModel: OrderDetailViewModel?
    var detailView: OrderDetailview!
    private var backButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.accessibilityIdentifier = "OrderDetail"
        makeView()
        setConstraints()
        addTargets()
    }
    
    func makeBackButton() {
        backButton = UIButton()
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.setTitle("", for: .normal)
        backButton.setImage(UIImage(named: "chevron.down"), for: .normal)
        backButton.tintColor = .systemPink
        backButton.accessibilityIdentifier = "backButton"
        view.addSubview(backButton)
    }
    
    func makeView() {
        view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        navigationController?.setNavigationBarHidden(true, animated: false)
        detailView = OrderDetailview()
        detailView.viewModel = self.viewModel
        detailView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(detailView)
        detailView.pin(to: view)
        makeBackButton()
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20.dp),
            backButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                                                constant: -20.dp)
        ])
    }
    
    func addTargets() {
        backButton.addTarget(self, action: #selector(back), for: .touchUpInside)
    }
    
    @objc func back() {
        delegate?.back()
    }
}
