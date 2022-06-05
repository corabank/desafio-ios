//
//  UINavigationControllerSpy.swift
//  DesafioiOSTests
//
//  Created by Allana Castenharo Santamaria on 01/06/22.
//

import UIKit

final class UINavigationControllerSpy: UINavigationController {
    private(set) var pushViewControllerCallCount = 0
    private(set) var popViewControllerCallCount = 0
    private(set) var presentViewControllerCallCount = 0
    private(set) var dismissViewControllerCallCount = 0
    private(set) var setViewControllersCallCount = 0
    private(set) var popToRootViewControllerCallCount = 0

    private(set) var pushedViewController: UIViewController?
    private(set) var popedViewController: UIViewController?
    private(set) var viewControllerPresented: UIViewController?

    override var presentedViewController: UIViewController? {
        viewControllerPresented
    }

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        pushedViewController = viewController
        pushViewControllerCallCount += 1
        super.pushViewController(viewController, animated: false)
    }

    override func popViewController(animated: Bool) -> UIViewController? {
        let viewController = super.popViewController(animated: false)
        popedViewController = viewController
        popViewControllerCallCount += 1
        return viewController
    }

    override func popToRootViewController(animated: Bool) -> [UIViewController]? {
        let viewControllersList = super.popToRootViewController(animated: false)
        popToRootViewControllerCallCount += 1
        return viewControllersList
    }

    override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        viewControllerPresented = viewControllerToPresent
        presentViewControllerCallCount += 1
        super.present(viewControllerToPresent, animated: false)
        completion?()
    }

    override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        dismissViewControllerCallCount += 1
        super.dismiss(animated: false)
        completion?()
    }

    override func setViewControllers(_ viewControllers: [UIViewController], animated: Bool) {
        setViewControllersCallCount += 1
        super.setViewControllers(viewControllers, animated: false)
    }
}
