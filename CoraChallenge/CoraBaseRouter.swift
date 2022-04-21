//
//  CoraBaseRouter.swift
//  CoraChallenge
//
//  Created by Fellipe Ricciardi Chiarello on 4/21/22.
//

import UIKit

open class CoraBaseRouter: NSObject {
    
    public static let sharedInstance = CoraBaseRouter()
    
    open var navigationController: UINavigationController? {
        didSet {
            mainViewController = navigationController?.topViewController
        }
    }
    
    open var mainViewController: UIViewController?
}
