//
//  Extensions.swift
//  DesafioCora
//
//  Created by Euclides Medeiros on 09/03/21.
//

import UIKit

extension UITextField {
    func setLeftPaddingPoints( _ space: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: space, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
}

extension UIViewController {
        func showError(error: NSError, buttonLabel: String) {
            let alert: UIAlertController = UIAlertController(title: error.domain, message: error.localizedDescription, preferredStyle: .alert)
            let actionOk: UIAlertAction = UIAlertAction(title: buttonLabel, style: .default, handler: nil)
            alert.addAction(actionOk)
            self.present(alert, animated: true, completion: nil)
        }
}

extension UIStackView {
    func changeBackgroundColor(cgColor: UIColor) {
        let backgroundLayer = CAShapeLayer()
        self.layer.insertSublayer(backgroundLayer, at: 0)
        backgroundLayer.path = UIBezierPath(rect: self.bounds).cgPath
        backgroundLayer.fillColor = cgColor.cgColor
    }
}
