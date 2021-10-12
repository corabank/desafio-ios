import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var coordinator: Coordinator?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        let navigationController = UINavigationController()
        self.coordinator = AppCoordinator(navigationController: navigationController)
        self.coordinator?.start()
        
        self.window = UIWindow()
        self.window?.windowScene = scene as? UIWindowScene
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
    }
}
