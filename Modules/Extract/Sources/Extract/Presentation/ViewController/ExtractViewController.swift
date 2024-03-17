//
//  ExtractViewController.swift
//  
//
//  Created by João Gabriel Dourado Cervo on 16/03/24.
//

import UIKit
import Core

class ExtractViewController: UIViewController, PresentableExtractView {
    
    enum ExtractConstants {
        static let filterBarItems = ["Tudo", "Entrada", "Saída", "Futuro"]
    }
    
    //MARK: - properties
    
    private let navigationService: ExtractCoordinator
    
    //MARK: - views
    
    private lazy var filterBarView: FilterBarView = {
        let filterBarView = FilterBarView(
            items: ExtractConstants.filterBarItems,
            selectedItemIndex: .zero
        )
        
        filterBarView.translatesAutoresizingMaskIntoConstraints = false
        return filterBarView
    }()
    
    //MARK: - setup
    
    init(navigationService: ExtractCoordinator) {
        self.navigationService = navigationService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.topItem?.title = ""
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: Images.Extract.signOutIcon, style: .plain, target: nil, action: nil)
        title = "Extrato"
    }
    
    private func prepareView() {
        view.backgroundColor = AppColors.navigationBarBackground
        view.addSubview(filterBarView)
        
        NSLayoutConstraint.activate([
            filterBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            filterBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            filterBarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ])
    }
}
