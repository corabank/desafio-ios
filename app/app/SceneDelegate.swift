//
//  SceneDelegate.swift
//  app
//
//  Created by João Gabriel Dourado Cervo on 13/03/24.
//

import UIKit

import Core
import Network
import Login
import Extract

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var appNavigationService: NavigationCoordinator?
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        registerDependenciesToInject()
        guard let _ = (scene as? UIWindowScene) else { return }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }

    
    private func registerDependenciesToInject() {
        guard let navigationController = window?.rootViewController as? UINavigationController else { return }
        navigationController.navigationBar.tintColor = AppColors.primary
        navigationController.navigationBar.backgroundColor = AppColors.navigationBarBackground
        navigationController.navigationBar.titleTextAttributes = [.foregroundColor: AppColors.navigationTitleColor]
        let container = DIContainer()
        
        registerNavigationDependencies(to: container, navigationController: navigationController)
        registerRepositoryDependencies(to: container, navigationController: navigationController)
        registerUseCasesDependencies(to: container, navigationController: navigationController)
        registerViewModelsDependencies(to: container, navigationController: navigationController)
        
        appNavigationService = container.resolve(type: NavigationCoordinator.self)!
    }
    
    private func registerNavigationDependencies(to container: DIContainerService, navigationController: UINavigationController) {
        container.register(type: NavigationCoordinator.self) { _ in
            AppNavigation(navigationController: navigationController, container: container)
        }
        
        container.register(type: LoginCoordinator.self) { container in
            LoginNavigation(container: container, navigationController: navigationController)
        }
        
        container.register(type: ExtractCoordinator.self) { container in
            ExtractNavigator(container: container, navigationController: navigationController)
        }
        
        appNavigationService = container.resolve(type: NavigationCoordinator.self)!
    }
    
    private func registerRepositoryDependencies(to container: DIContainerService, navigationController: UINavigationController) {
        container.register(type: NetworkServiceProtocol.self) { container in
            let service = DefaultNetworkService()
            service.tokenValidationService = DefaultTokenValidationService(networkService: service)
            return service
        }
        
        container.register(type: LoginRepositoryProtocol.self) { container in
            DefaultLoginRepository(networkService: container.resolve(type: NetworkServiceProtocol.self)!)
        }
    }
    
    private func registerUseCasesDependencies(to container: DIContainerService, navigationController: UINavigationController) {
        container.register(type: LogUserUseCase.self) { container in
            DefaultLogUserUseCase(repository: container.resolve(type: LoginRepositoryProtocol.self)!)
        }
    }
    
    private func registerViewModelsDependencies(to container: DIContainerService, navigationController: UINavigationController) {
        container.register(type: LoginViewModelProtocol.self) { container in
            DefaultLoginViewModel(loginUseCase: container.resolve(type: LogUserUseCase.self)!)
        }
    }
}

