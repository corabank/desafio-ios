//
//  BaseViewController.swift
//  CoraDesafio
//
//  Created by Erik Santos on 13/03/24.
//

import Foundation
import UIKit
import DesignKit

open class BaseViewController<Interactor, V: UIView>: UIViewController, BaseViewControllerProtocol {
    
    // MARK: - Navigation
    
     open var navigationCora: StickNavigationView = {
        let viewModel = StickNavigationViewModel(
            title: StickNavigationTitle(font: .font(14), color: CoraAssets.darkGray.color),
            leftButton: StickNavigationLeftButton(image: .systemImage(CoraStrings.Icons.chevronLeft), color: CoraAssets.defaultPinkColor.color),
            backgroundColor: CoraAssets.lightGray.color
        )
    
        let view = StickNavigationView.instantiate(viewModel: viewModel)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Properties
    
    public var interactor: Interactor
    
    public var rootView = V()
    
    // MARK: - Initialize
    
    public init(interactor: Interactor) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cyle
    
    open override func loadView() {
        view = rootView
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        rootView.addSubview(navigationCora)
    
        NSLayoutConstraint.activate([
            
            navigationCora.topAnchor.constraint(equalTo: rootView.topAnchor),
            navigationCora.leadingAnchor.constraint(equalTo: rootView.leadingAnchor),
            navigationCora.trailingAnchor.constraint(equalTo: rootView.trailingAnchor),
        ])
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
}
