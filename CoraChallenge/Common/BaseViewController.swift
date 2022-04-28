//
//  BaseViewController.swift
//  CoraChallenge
//
//  Created by Fellipe Ricciardi Chiarello on 4/28/22.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
    }
    
    func setupNavigationBar() {
        self.navigationController?.isNavigationBarHidden = false

        let navBar = self.navigationController?.navigationBar
        self.title = "Detalhes do agendamento"
        navBar?.titleTextAttributes = [NSAttributedString.Key.font : UIFont(name: "Avenir-Roman", size: 14)!,
                                       NSAttributedString.Key.foregroundColor : UIColor.coraDarkGray]
        navBar?.backgroundColor = .coraLightGray
        navBar?.tintColor = .coraPink
        navigationItem.backButtonTitle = " "
        
        let backButtonImage = UIImage(named: "nav_bar_back_button")
        navBar?.backIndicatorImage = backButtonImage
        navBar?.backIndicatorTransitionMaskImage = backButtonImage
    }

}
