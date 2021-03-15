//
//  BaseViewController.swift
//  DesafioCora
//
//  Created by Euclides Medeiros on 15/03/21.
//

import UIKit
import FSnapChatLoading

class BaseViewController: UIViewController {
    
    let loadingView = FSnapChatLoadingView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNeedsStatusBarAppearanceUpdate()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    
    func showAlert(alertText : String, alertMessage : String) {
        let alert = UIAlertController(title: alertText, message: alertMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Got it", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func hiddenLoadingAnimation() {
        loadingView.hide()
    }
    
    func showLoadingAnimation() {
        loadingView.show(view: self.view, color: UIColor(red: 192.0/255.0, green: 51.0/255.0, blue: 98.0/255.0, alpha: 1.0))
    }
}
