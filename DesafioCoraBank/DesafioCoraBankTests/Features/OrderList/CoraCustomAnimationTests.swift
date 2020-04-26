//
//  CoraCustomAnimationTests.swift
//  DesafioCoraBankTests
//
//  Created by Roger Sanoli on 26/04/20.
//  Copyright © 2020 RogerSanoli. All rights reserved.
//

import XCTest
@testable import DungeonKit
@testable import DesafioCoraBank

class CoraCustomAnimationTests: XCTestCase {
    
    public static var loginViewController: LoginViewController!
    public static var orderListViewController: OrderListViewController!

    override func setUp() {
        CoraCustomAnimationTests.loginViewController = LoginViewController()
        CoraCustomAnimationTests.loginViewController.loadView()
        
        CoraCustomAnimationTests.orderListViewController = OrderListViewController()
        CoraCustomAnimationTests.orderListViewController.loadView()
    }
    
    override func tearDown() {
        
    }
    
    func testAnimation() {
        
        let context = MockContext()
        guard
            let logoImage = (context.viewController(forKey: .from) as? LoginViewController)?.codeView?.logoView.logoImage,
            let widthConstraint = logoImage.constraints.filter({ $0.identifier == "width" }).first,
            let heightConstraint = logoImage.constraints.filter({ $0.identifier == "height" }).first
        else { return }
        
        let animation = CoraCustomAnimation(logoImage: logoImage)
        
        let durationForPresenting = animation.durationForPresenting()
        let durationForDismissing = animation.durationForPresenting()
        XCTAssertNotNil(durationForPresenting, "Should have a duration for presenting.")
        XCTAssertNotNil(durationForDismissing, "Should have a duration for dismissing.")
        
        animation.animatePresentationWithContext(context: context)
        XCTAssertEqual(widthConstraint.constant, 30)
        XCTAssertEqual(heightConstraint.constant, 30)
        
        animation.animateDismissWithContext(context: context)
        XCTAssertFalse(context.containerView.subviews.isEmpty, "The views should be in the hierarchy")
    }
}

class MockContext: NSObject, UIViewControllerContextTransitioning {
    var containerView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 320, height: 568))
    
    func completeTransition(_ didComplete: Bool) {
    
    }
    
    func viewController(forKey key: UITransitionContextViewControllerKey) -> UIViewController? {
        switch key {
        case .from:
            return CoraCustomAnimationTests.loginViewController
        case .to:
            return CoraCustomAnimationTests.orderListViewController
        default:
            return nil
        }
    }

    var isAnimated: Bool = false
    var isInteractive: Bool = false
    var transitionWasCancelled: Bool = false
    var presentationStyle: UIModalPresentationStyle = .automatic
    var targetTransform: CGAffineTransform = .identity

    func updateInteractiveTransition(_ percentComplete: CGFloat) {}
    func finishInteractiveTransition() {}
    func cancelInteractiveTransition() {}
    func pauseInteractiveTransition() {}
    func view(forKey key: UITransitionContextViewKey) -> UIView? { return nil }
    func initialFrame(for vc: UIViewController) -> CGRect { return .zero }
    func finalFrame(for vc: UIViewController) -> CGRect { return .zero }
}
