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
}
