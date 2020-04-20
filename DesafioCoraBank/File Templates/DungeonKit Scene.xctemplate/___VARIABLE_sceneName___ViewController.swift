//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  ___COPYRIGHT___
//

import Foundation
import DungeonKit

class ___FILEBASENAMEASIDENTIFIER___: DKViewController<___VARIABLE_sceneName___SceneFactory> {
    
    fileprivate var interactor: ___VARIABLE_sceneName___InteractorProtocol? { return self.getAbstractInteractor() as? ___VARIABLE_sceneName___InteractorProtocol }
    
    /*
        Calling super.viewDidLoad() is mandatory in order to setup the VIP cycle.
    */

    override func viewDidLoad() {
        super.viewDidLoad()

        //Your code here...
    }
    
}

extension ___FILEBASENAMEASIDENTIFIER___: ___VARIABLE_sceneName___ViewControllerProtocol {

}
