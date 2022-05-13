//
//  InvoiceViewController.swift
//  Desafio Cora
//
//  Created by João Pedro DTI on 13/05/22.
//

import UIKit

class InvoiceViewController: UIViewController {
    weak var coordinator: InvoiceCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Faturas"
        self.view.backgroundColor = .black
    }
}
