//
//  ReceiptViewController.swift
//  DesafioiOS
//
//  Created by Allana Castenharo Santamaria on 28/05/22.
//

import UIKit

protocol ReceiptDisplaying: AnyObject {
    func displayReceipt()
}

final class ReceiptViewController: CoraViewController<ReceiptInteracting> {
    typealias Strings = Localization.Receipt

    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView()
        tableView.separatorColor = .clear
        tableView.dataSource = self
        return tableView
    }()
    
    func registerCell() {
        tableView.register(ReceiptStatusCell.self, forCellReuseIdentifier: ReceiptStatusCell.identifier)
        tableView.register(ReceiptInfoCell.self, forCellReuseIdentifier: ReceiptInfoCell.identifier)
        tableView.register(ReceiptDetailCell.self, forCellReuseIdentifier: ReceiptDetailCell.identifier)
        tableView.register(ReceiptDescriptionCell.self, forCellReuseIdentifier: ReceiptDescriptionCell.identifier)
        tableView.register(ReceiptButtonsCell.self, forCellReuseIdentifier: ReceiptButtonsCell.identifier)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        setupView()
        interactor.fetch()
    }
}

extension ReceiptViewController: ViewCode {
    func buildViewHierarchy() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            
            /// TableView Receipt
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    func setupAdditionalConfiguration() {
        title = Strings.navigationTitle
    }
}

extension ReceiptViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ReceiptCell.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch ReceiptCell.allCases[indexPath.row] {
            
        case .status:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "ReceiptStatusCell", for: indexPath) as? ReceiptStatusCell {
                cell.setup(statusIcon: interactor.model?.icon, statusTitle: interactor.model?.status)
                return cell
            }
        case .information:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "ReceiptInfoCell", for: indexPath) as? ReceiptInfoCell {
                cell.setup(value: interactor.model?.value, date: interactor.model?.date)
                return cell
            }
        case .payer:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "ReceiptDetailCell", for: indexPath) as? ReceiptDetailCell {
                cell.setup(model: .init(title: interactor.model?.addresseeInfo.title,
                                        name: interactor.model?.addresseeInfo.name,
                                        cpf: interactor.model?.addresseeInfo.cpf,
                                        bank: interactor.model?.addresseeInfo.bank,
                                        account: interactor.model?.addresseeInfo.account))
                return cell
            }
        case .beneficiary:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "ReceiptDetailCell", for: indexPath) as? ReceiptDetailCell {
                cell.setup(model: .init(title: interactor.model?.beneficiaryInfo.title,
                                        name: interactor.model?.beneficiaryInfo.name,
                                        cpf: interactor.model?.beneficiaryInfo.cpf,
                                        bank: interactor.model?.beneficiaryInfo.bank,
                                        account: interactor.model?.beneficiaryInfo.account))
                return cell
            }
        case .description:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "ReceiptDescriptionCell", for: indexPath) as? ReceiptDescriptionCell {
                cell.setup(description: interactor.model?.description)
                return cell
            }
        case .bottom:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "ReceiptButtonsCell", for: indexPath) as? ReceiptButtonsCell {
                cell.delegate = self
                return cell
            }
        }
        
        return UITableViewCell()
    }
}


extension ReceiptViewController: ReceiptDisplaying {
    func displayReceipt() {
        tableView.reloadData()
    }
}

extension ReceiptViewController {
    enum ReceiptCell: CaseIterable {
        case status
        case information
        case payer
        case beneficiary
        case description
        case bottom
    }
}

extension ReceiptViewController: ReceiptButtonsCellDelegate {
    func sharedReceipt() {
        let image = UIImage()
        let controller = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        navigationController?.present(controller, animated: true, completion: nil)
    }

    func cancelScheduling() {
        //TODO
    }
}
