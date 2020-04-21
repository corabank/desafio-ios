//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  ___COPYRIGHT___
//

import Foundation
import DungeonKit

class ___FILEBASENAMEASIDENTIFIER___: DKAbstractRouter {
    
    required init() {}
    
    func generateInteractor(_ args: Any?) -> DKAbstractInteractor {
        return ___VARIABLE_sceneName___Interactor()
    }
    
    func generatePresenter(_ args: Any?) -> DKAbstractPresenter {
        return ___VARIABLE_sceneName___Presenter()
    }
}
