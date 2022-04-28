import UIKit
import Components

protocol PassFormViewProtocol: UIViewController {
    func set(delegate: PassFormViewDelegate)
    func changeButtonStatus(_ value: ButtonState)
}
