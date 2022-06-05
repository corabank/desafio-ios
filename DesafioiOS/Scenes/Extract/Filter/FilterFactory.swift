//
//  FilterFactory.swift
//  DesafioiOS
//
//  Created by Allana Castenharo Santamaria on 30/05/22.
//

import UIKit

public struct FilterFactory {
    public static func make(delegate: FilterViewControllerDelegate) -> UIViewController {
        let viewController = FilterViewController()
        viewController.delegate = delegate
                
        return viewController
    }
}
