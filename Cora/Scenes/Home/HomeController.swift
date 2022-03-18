import UIKit

final class HomeController: UIViewController {
    private let contentView = HomeView()

    override func viewDidLoad() {
        view = contentView
    }
}
