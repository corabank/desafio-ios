//
//  ExtractViewController.swift
//  DesafioiOS
//
//  Created by Allana Castenharo Santamaria on 28/05/22.
//

import UIKit
import Photos

protocol ExtractDisplaying: AnyObject {
    func displayExtract()
}

final class ExtractViewController: CoraViewController<ExtractInteracting> {
    typealias Strings = Localization.Extract

    private lazy var coraFilterViewController: UIViewController = {
        let controller = FilterFactory.make(delegate: self)
        return controller
    }()
        
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.axis = .vertical
        return stackView
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(DetailTransactionCell.self, forCellReuseIdentifier: DetailTransactionCell.identifier)
        tableView.tableFooterView = UIView()
        tableView.sectionFooterHeight = .leastNormalMagnitude
        tableView.sectionHeaderTopPadding = .zero
        tableView.separatorColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor.fetch()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    func showAlertSaveExtract() {

        var alertController = UIAlertController()
//
        switch PHPhotoLibrary.authorizationStatus() {
        case .authorized:
            saveImage()
            alertController = ExtractAlertManager.showAlertAuthorized()
        case .restricted, .denied:
            alertController = ExtractAlertManager.showAlertDenied()
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization {  [weak self] status in
                if  status == .authorized {
                    self?.saveImage()
                    alertController = ExtractAlertManager.showAlertAuthorized()
                } else {
                    alertController = ExtractAlertManager.showAlertDenied()
                }
                
                DispatchQueue.main.async { [weak self] in
                    self?.present(alertController, animated: true)
                }
            }
            
            return
        case .limited:
            alertController = ExtractAlertManager.showAlertLimited()
        @unknown default:
            alertController = ExtractAlertManager.showAlertDenied()
        }
        
        present(alertController, animated: true)
    }
    
    func saveImage() {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, true, UIScreen.main.scale)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        UIImageWriteToSavedPhotosAlbum(image!, nil, nil, nil)
    }
}

extension ExtractViewController: ViewCode {
    func buildViewHierarchy() {
        view.addSubview(containerView)
        containerView.addSubview(stackView)
        
        stackView.addArrangedSubview(coraFilterViewController.view)
        addChild(coraFilterViewController)
        coraFilterViewController.didMove(toParent: self)
        
        stackView.addArrangedSubview(tableView)
    }
    
    func setupConstraints() {
        coraFilterViewController.view.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        containerView.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            /// Extract Transactions
            stackView.topAnchor.constraint(equalTo: containerView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            
            coraFilterViewController.view.heightAnchor.constraint(equalToConstant: .coraSpacing(.base11))
        ])
    }
    
    func setupAdditionalConfiguration() {
        view.backgroundColor = .coraColor(.white)
        title = Strings.navigationTitle
        let image = Asset.download.image
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: image,
                                                                 style: .plain,
                                                                 target: self,
                                                                 action: #selector(didTapSaveButton))
    }
}

@objc
extension ExtractViewController {
    func didTapSaveButton() {
        showAlertSaveExtract()
    }
}

extension ExtractViewController: FilterViewControllerDelegate {
    func didTapFilter(type: FilterType) {
        interactor.filterTransaction(type: type)
    }
}

extension ExtractViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        interactor.numberOfSection()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        interactor.numberOfRows(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailTransactionCell", for: indexPath) as! DetailTransactionCell
        cell.setup(model: interactor.getCellModel(index: indexPath))
        return cell
    }
}

extension ExtractViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = HeaderTransactionView(frame: .zero)
        view.setup(model: interactor.getHeaderTransaction(section: section))
        return view
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        interactor.didTapTransaction()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        36
    }
}

extension ExtractViewController: ExtractDisplaying {
    func displayExtract() {
        UIView.transition(with: tableView, duration: 0.35, options: .curveLinear, animations: { [weak self] in
            self?.tableView.reloadData()
        })
    }
}

