//
//  ExtractViewController.swift
//  desafio-ios
//
//  Created by Amaryllis Baldrez on 18/03/22.
//

import Foundation
import UIKit

class ExtractViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    // ui segmented control
    
    let tableHeaderView = ExtractHeaderView()
    
    let viewModel = ExtractViewModel()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let segmentedControl = UISegmentedControl(items:[ "Tudo", "Entrada", "Saída", "Futuro", UIImage(named: "ic_filter")])
    
    func configureSegmentedControl() {
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.tintColor = .principal
    }
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(ExtractCell.self, forCellReuseIdentifier: String(describing: ExtractCell.self))
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = .white
        tableView.tableHeaderView = segmentedControl
        tableView.separatorStyle = .none
        return tableView
    }()
    
    override func viewDidLoad() {
        setupButton()
        setupViews()
        tableHeaderView.translatesAutoresizingMaskIntoConstraints = false
        tableHeaderView.layoutIfNeeded()
        tableHeaderView.isUserInteractionEnabled = false
        self.viewModel.getExtracts {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        configureSegmentedControl()
//        navigationItem.backBarButtonItem = UIBarButtonItem(image: UIImage(named: <#T##String#>))
        // quando clicar no botao mudar a cor
        
    }
    
    func setupButton() {
        tableHeaderView.futureButton.addTarget(self, action: #selector(goToScheduleView), for: .touchUpInside)
    }
    
    @objc func goToScheduleView() {
        print("clicouu")
        let scheduleController = ScheduleViewController()
        navigationController?.pushViewController(scheduleController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("aoba")
        let scheduleController = ScheduleViewController()
        navigationController?.pushViewController(scheduleController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let day = viewModel.days[section]
        let extractHeaderTable = ExtractHeaderTable()
        extractHeaderTable.dateLabel.text = day.day
        extractHeaderTable.valueLabel.attributedText =  NSAttributedString(string: "R$" + String(day.total))
        return extractHeaderTable
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.days.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.days[section].extracts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let extract = viewModel.days[indexPath.section].extracts[indexPath.row]
        let cell = ExtractCell()
        cell.valueLabel.attributedText = NSAttributedString(string: "R$" + String(extract.value))
        cell.typeExtractLabel.text = extract.typeTransfer
        cell.nameLabel.text = extract.name
        cell.hourLabel.text = extract.hour
        
        if cell.typeExtractLabel.text == "Transferência recebida" || cell.typeExtractLabel.text == "Pagamento recebido" {
            cell.valueLabel.textColor = .secondary
            cell.typeExtractLabel.textColor = .secondary
        }
        
        switch cell.typeExtractLabel.text {
        case "Transferência recebida":
            cell.icon.image = UIImage(named: "ic_arrow-down-in")
        case "Pagamento recebido":
            cell.icon.image = UIImage(named: "ic_arrow-down-in")
        case "Transferência estornada":
            cell.icon.image = UIImage(named: "ic_arrow-return")
        case "Boleto pago", "Depósito via boleto":
            cell.icon.image = UIImage(named: "ic_bar-code")
        case "Transferência enviada":
            cell.icon.image = UIImage(named: "ic_arrow-up-out")
        case .none: break
        case .some(_): break
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func setupViews() {
        
        view.backgroundColor = .white
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        
    }
}
