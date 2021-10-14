import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var coordinator: Coordinator?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        let navigationController = UINavigationController()
        navigationController.navigationBar.prefersLargeTitles = true
        let window = UIWindow()
        
        self.window = window
        self.window?.windowScene = scene as? UIWindowScene
        
        self.coordinator = AppCoordinator(window: window, navigationController: navigationController)
        self.coordinator?.start()
    }
}
