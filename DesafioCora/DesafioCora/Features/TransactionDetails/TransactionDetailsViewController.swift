//
//  TransactionDetailsViewController.swift
//  DesafioCora
//
//  Created by user205543 on 2/27/22.
//

import Foundation
import UIKit

protocol TransactionDetailsDisplaying: AnyObject {
    func displayTransaction(_ transaction: TransactionModel)
}

final class TransactionDetailsVewController: UIViewController {
    
    let interactor: TransactionDetailsInteracting
    
    init(interactor: TransactionDetailsInteracting) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        
    }
    
    private func setupViews() {
        
    }
    
    private func setupConstraints() {
        
    }
}

extension TransactionDetailsVewController: TransactionDetailsDisplaying {
    func displayTransaction(_ transaction: TransactionModel) {
        
    }
}
