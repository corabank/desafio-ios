import UIKit

protocol BuildableView {
    func setupHierarchy()
    func setupConstraints()
    func setupStyles()
}

extension BuildableView where Self: UIView {
    func buildView() {
        setupHierarchy()
        setupConstraints()
        setupStyles()
    }
    
    func setupStyles() { }
}

extension BuildableView where Self: UIViewController {
    func buildView() {
        setupHierarchy()
        setupConstraints()
        setupStyles()
    }
    
    func setupStyles() { }
}
