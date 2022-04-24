//
//  CoraLoginRouter.swift
//  CoraChallenge
//
//  Created by Fellipe Ricciardi Chiarello on 4/21/22.
//

import Foundation
import UIKit

public class CoraLoginRouter: NSObject {
    
    @objc public static  func goToLogin(from controller: UIViewController) {
        let vc = UserLoginViewController()
        
        controller.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc public static func goToPassword(from controller: UIViewController) {
        let vc = PasswordViewController()
        
        controller.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc public static func goToStatement(from controller: UIViewController) {
        let vc = StatementViewController()
        let repository = StatementRepository()
        let presenter = StatementPresenter(viewController: vc)
        let interactor = StatementInteractor(repository: repository, presenter: presenter)
        
        vc.interactor = interactor
        
        controller.navigationController?.pushViewController(vc, animated: true)
    }
}
