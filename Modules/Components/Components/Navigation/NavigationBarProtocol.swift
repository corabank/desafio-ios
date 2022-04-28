import UIKit

public protocol NavigationBarProtocol {
    func tapBack()
    func tapShare()
    func set(delegate: NavigationBarDelegate)
}
