//
//  ExtractCoordinator.swift
//  DesafioiOS
//
//  Created by Allana Castenharo Santamaria on 28/05/22.
//

import UIKit

protocol ExtractCoordinating: AnyObject {
    func showReceipt()
}

final class ExtractCoordinator {
    weak var viewController: UIViewController?
}

extension ExtractCoordinator: ExtractCoordinating {
    func showReceipt() {
        let controller = ReceiptFactory.make()
        viewController?.navigationController?.pushViewController(controller, animated: true)
    }
}
