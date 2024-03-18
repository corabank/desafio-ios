//
//  File.swift
//  
//
//  Created by João Gabriel Dourado Cervo on 14/03/24.
//

import UIKit

public struct Images {
    private init() {}
    
    //MARK: - general
    
    public struct General {
        public static let coraLogo = UIImage(named: "cora-logo")!
        public static let rightArrowRed = UIImage(named: "arrow-right-red")!
        public static let rightArrowWhite = UIImage(named: "arrow-right-white")!
        public static let eyeHiddenRed = UIImage(named: "eye-hidden-red")!
    }
    
    //MARK: - login
    
    public struct Login {
        public static let backgroundImage = UIImage(named: "login-image")!
    }
    
    //MARK: - extract
    
    public struct Extract {
        public static let icFilterIcon = UIImage(named: "ic_filter")!
        public static let signOutIcon = UIImage(named: "sign-out")!
        public static let arrowUpOut = UIImage(named: "ic_arrow-up-out")!
        public static let arrowDownIn = UIImage(named: "ic_arrow-down-in")!
        public static let arrowReturn = UIImage(named: "ic_arrow-return")!
    }
}
