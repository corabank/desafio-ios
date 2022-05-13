//
//  BaseViewController.swift
//  Desafio Cora
//
//  Created by João Pedro DTI on 12/05/22.
//

import UIKit

public class NavigationController: UINavigationController {

    public override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationAppearence()
    }
    
    func setNavigationAppearence(color: UIColor = .red) {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = color
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]

        UINavigationBar.appearance().tintColor = .primary
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().isTranslucent = false
        
        let backButtonAppearence = UIBarButtonItemAppearance()
        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.clear]
        backButtonAppearence.normal.titleTextAttributes = titleTextAttributes
        backButtonAppearence.highlighted.titleTextAttributes = titleTextAttributes
        appearance.backButtonAppearance = backButtonAppearence
    }
}
