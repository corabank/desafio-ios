import UIKit
import Resources
import ViewCode
import Components

final class StatementDetailView: UIViewController {
    
    private var viewModel: StatementDetailViewDelegate?
    
    private lazy var navTitle: String = ""
    
    private lazy var stackScroll: StackScrollView = StackScrollView(spacing: Dimensions.medium)
    
    private lazy var navigation: NavigationBar = {
        let nav = NavigationBar(title: navTitle, share: true)
        nav.set(delegate: self)
        return nav
    }()
    
    required init?(coder: NSCoder) { return nil }
    init(navTitle: String) {
        super.init(nibName: nil, bundle: nil)
        self.navTitle = navTitle
        setupView()
    }
}

extension StatementDetailView: ViewCode {
    func setSubviews() {
        //
    }
    
    func setConstraints() {
        //
    }
    
    
}

extension StatementDetailView: StatementDetailViewProtocol {
    func set(delegate: StatementDetailViewDelegate) {
        //
    }
}

extension StatementDetailView: NavigationBarDelegate {
    func tapBack() {
        viewModel?.tapBack()
    }
    
    func tapShare() { }
}
