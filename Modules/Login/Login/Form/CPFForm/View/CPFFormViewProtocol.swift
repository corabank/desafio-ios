import UIKit
import Components

protocol CPFFormViewProtocol: UIViewController {
    func set(delegate: CPFFormViewDelegate)
    func changeButtonStatus(_ value: ButtonState)
}
