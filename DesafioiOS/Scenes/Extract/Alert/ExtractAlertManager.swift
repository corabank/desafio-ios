//
//  ExtractAlertManager.swift
//  DesafioiOS
//
//  Created by Allana Castenharo Santamaria on 03/06/22.
//

import UIKit

final class ExtractAlertManager {
    typealias Strings = Localization.Alert

    static func showAlertAuthorized() -> UIAlertController {
        return createAlert(title: Strings.Authorized.title,
                           message: Strings.Authorized.message)
    }
    
    static func showAlertDenied() -> UIAlertController {
        return createAlert(title: Strings.Denied.title,
                           message: Strings.Denied.message)
    }
    
    static func showAlertLimited() -> UIAlertController {
        return createAlert(title: Strings.Limited.title,
                           message: Strings.Limited.message)
    }
    
    private static func createAlert(title: String, message: String) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let actionOK = UIAlertAction(title: Strings.ActionOK.title,
                                     style: .cancel,
                                     handler: nil)
        alertController.addAction(actionOK)
        return alertController
    }
}
