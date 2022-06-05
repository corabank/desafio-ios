//
//  ReceiptCoordinator.swift
//  DesafioiOS
//
//  Created by Allana Castenharo Santamaria on 28/05/22.
//

import UIKit

protocol ReceiptCoordinating: AnyObject {
    func showError()
}

final class ReceiptCoordinator {
    weak var viewController: UIViewController?
}

extension ReceiptCoordinator: ReceiptCoordinating {
    func showError() {
        //TODO
    }
}
