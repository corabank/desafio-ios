//
//  NavigationCoordinator.swift
//
//
//  Created by João Gabriel Dourado Cervo on 14/03/24.
//

import Foundation
import UIKit

public protocol ExternalNavigationService {
    func openLoginViewController()
    func openExtractViewController()
    func openDetailsViewController()
}

/// Represents a type that can coordinate the navigation between the screens
public protocol NavigationCoordinator: ExternalNavigationService {
    var navigationController: UINavigationController { get set }
    var container: DIContainerService { get set }

    func popToRootViewController(animated: Bool)
}

//MARK: - Presentable View

/// Represents a type that can be presented in navigation
public protocol PresentableView {
    func toPresent() -> UIViewController
}

public extension PresentableView where Self: UIViewController {
    func toPresent() -> UIViewController {
        return self
    }
}

public protocol PresentableLoginView: PresentableView {}
public protocol PresentableExtractView: PresentableView {}
public protocol PresentableDetailsView: PresentableView {}
