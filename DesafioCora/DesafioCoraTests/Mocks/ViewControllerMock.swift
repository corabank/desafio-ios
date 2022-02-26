//
//  ViewControllerMock.swift
//  DesafioCoraTests
//
//  Created by user205543 on 2/26/22.
//

import Foundation
import UIKit

class ViewControllerMock: UIViewController {
    var presentedVC: UIViewController?
    
    override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        presentedVC = viewControllerToPresent
        completion?()
    }
}
