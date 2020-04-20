//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  ___COPYRIGHT___
//

import Foundation
import DungeonKit

class ___FILEBASENAMEASIDENTIFIER___: DKAbstractSceneFactory {
    
    required init() {}
    
    func generateInteractor() -> DKAbstractInteractor {
        return ___VARIABLE_sceneName___Interactor()
    }
    
    func generatePresenter() -> DKAbstractPresenter {
        return ___VARIABLE_sceneName___Presenter()
    }
}
