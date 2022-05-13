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
        self.view.backgroundColor = .blue
        setupInvoiceNavigationBar()
    }
    
    @objc func didTapEditButton(sender: AnyObject){

    }

    @objc func didTapSearchButton(sender: AnyObject){

    }

    func setupInvoiceNavigationBar() {
        let editImage    = Images.rightArrowPink
        let searchImage  = Images.rightArrowPink

        let editButton   = UIBarButtonItem(image: editImage, style: .plain, target: self, action: #selector(didTapEditButton))
        let searchButton = UIBarButtonItem(image: searchImage, style: .plain, target: self, action: #selector(didTapSearchButton))

        self.navigationItem.rightBarButtonItems = [editButton, searchButton]
        
        let appearance = UINavigationBarAppearance()
        UINavigationBar.appearance().tintColor = .primary
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .black
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]

        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
}
