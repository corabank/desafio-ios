import UIKit

protocol HomeViewType where Self: UIView {
    var didTapLogin: (() -> Void)? { get set }
}
