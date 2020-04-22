//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  ___COPYRIGHT___
//

import Foundation
import RogueKit

public enum ___FILEBASENAMEASIDENTIFIER___: RKRepository {
    
    /*
    Sample code:

    case listUser,
    createUser(user: UserEntity)
    */
    
    public var domain: String { return "https://yourserver.domain.com" }
    
    public func createRequest() throws -> RKRequest {
        switch self {
        /*
        case .listUser:
            return RKRequest.get("/listUser")
        case let .createUser(user):
            return RKRequest.post("/createUser", entity: user)
        */
        }
    }
}
