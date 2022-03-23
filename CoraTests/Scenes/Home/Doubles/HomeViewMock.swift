import UIKit

@testable import Cora

final class HomeViewMock: UIView, HomeViewType {
    var didTapLogin: (() -> Void)?
}
