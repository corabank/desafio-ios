import UIKit
import XCTest
import Components
@testable import Login

final class CPFFormViewMock: UIViewController, CPFFormViewProtocol {
    
    var delegate: CPFFormViewDelegate?
    var buttonStatus: ButtonState? = nil
    
    func set(delegate: CPFFormViewDelegate) {
        self.delegate = delegate
    }
    
    func changeButtonStatus(_ value: ButtonState) {
        buttonStatus = value
    }
    
    func nextWithInput(input: String) {
        delegate?.inputCPF(input)
    }
    
    func goBack() {
        delegate?.tapBack()
    }
}
