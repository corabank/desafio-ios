//
//  ExtractPresenter.swift
//  DesafioiOS
//
//  Created by Allana Castenharo Santamaria on 28/05/22.
//

import UIKit

protocol ExtractPresenting: AnyObject {
    var viewController: ExtractDisplaying? {get set}
    func presentExtract()
    func presentError()
    func presentReceipt()
}

final class ExtractPresenter: CoraPresenter<ExtractCoordinating> {
    weak var viewController: ExtractDisplaying?
}

extension ExtractPresenter: ExtractPresenting {
    func presentReceipt() {
        coordinator.showReceipt()
    }
    
    func presentExtract() {
        viewController?.displayExtract()
    }
    
    func presentError() {
        //TODO
    }
}
