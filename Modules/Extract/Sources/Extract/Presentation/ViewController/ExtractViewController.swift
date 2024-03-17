//
//  ExtractViewController.swift
//  
//
//  Created by João Gabriel Dourado Cervo on 16/03/24.
//

import UIKit
import Core

class ExtractViewController: UIViewController, PresentableExtractView {
    
    //MARK: - properties
    
    private let navigationService: ExtractCoordinator
    
    //MARK: - views
    
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
    }
}
