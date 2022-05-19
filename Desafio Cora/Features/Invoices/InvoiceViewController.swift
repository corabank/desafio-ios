//
//  InvoiceViewController.swift
//  Desafio Cora
//
//  Created by João Pedro DTI on 13/05/22.
//

import UIKit

class InvoiceViewController: UIViewController {
    weak var coordinator: InvoiceCoordinator?
    var screen: InvoiceScreen?

    override func loadView() {
        screen = InvoiceScreen()
        screen?.delegate = self
        self.view = screen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Faturas"
        setupInvoiceNavigationBar()
        coordinator?.getInvoiceData(onSuccess: { result in
            self.screen?.configure(data: result )
        }, onFailure: { _ in

        })
    }
}

extension InvoiceViewController: InvoiceScreenDelegate {
    func payButtonPressed() {
        coordinator?.showAlert(title: "Pagar Fatura!", message: "Pagar Fatura!")
    }
    
    func automaticDebitPressed() {
        coordinator?.showAlert(title: "Débito Automático!", message: "Débito Automático!")
    }

    func barChartPressed() {
        coordinator?.showAlert(title: "Alterando Mês!", message: "Alterando Mês!")
    }
}

extension InvoiceViewController {
    func setupInvoiceNavigationBar() {
        let downloadInvoiceButton = UIBarButtonItem(image: Images.exportIcon, style: .plain, target: self, action: #selector(downloadInvoiceButtonTapped))
        let infoButton = UIBarButtonItem(image: Images.questionIcon, style: .plain, target: self, action: #selector(infoButtonTapped))

        self.navigationItem.rightBarButtonItems = [infoButton, downloadInvoiceButton]
        
        let appearance = UINavigationBarAppearance()
        UINavigationBar.appearance().tintColor = .primary
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .black
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]

        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }

    @objc func downloadInvoiceButtonTapped(sender: AnyObject){
        coordinator?.showAlert(title: "Fatura Baixada!", message: "Fatura Baixada!")
    }

    @objc func infoButtonTapped(sender: AnyObject){
        coordinator?.showAlert(title: "Informações", message: "Infos")
    }
}
