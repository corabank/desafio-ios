//
//  UIViewControllerSpy.swift
//  DesafioiOSTests
//
//  Created by Allana Castenharo Santamaria on 01/06/22.
//

import UIKit

final class UIViewControllerSpy: UIViewController {
    private(set) var dismissCount: Int = 0
    private(set) var presentViewControllerCounter = 0
    private(set) var presentViewController: UIViewController?

    override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        super.present(viewControllerToPresent, animated: flag, completion: completion)
        presentViewController = viewControllerToPresent
        presentViewControllerCounter += 1
    }

    override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        super.dismiss(animated: flag, completion: completion)
        dismissCount += 1
    }
}
