//
//  LoginViewController.swift
//  DesafioCoraBank
//
//  Created by Roger Sanoli on 18/04/20.
//  Copyright © 2020 RogerSanoli. All rights reserved.
//

import Foundation
import UIKit

class LoginViewController: UIViewController {
    
    override func loadView() {
        let view = LoginView()
        view.backgroundColor = .cbDarkBlue
        self.view = view
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }


}
