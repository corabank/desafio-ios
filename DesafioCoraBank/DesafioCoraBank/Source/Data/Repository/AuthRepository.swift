//
//  AuthRepository.swift
//  DesafioCoraBank
//
//  Created by Roger Sanoli on 22/04/20.
//  Copyright © 2020 RogerSanoli. All rights reserved.
//

import Foundation
import RogueKit

public enum AuthRepository: RKRepository {
    
    case loginUser(user: UserEntity)
    
    public var domain: String { return "https://yourserver.domain.com" }
    
    public func createRequest() throws -> RKRequest {
        switch self {
        case let .loginUser(user):
            return try RKRequest.post("/loginUser", entity: user)
        }
    }
    
    public func createMockForRequest<T: Entity>(completion: @escaping(ResultCallback<T>)) {
        switch self {
        case let .loginUser(requestUser):
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                if requestUser.userName == "Roger" && requestUser.password == "cora" {
                    if let loggedUser = UserEntity(userName: "Roger", password: nil, accessToken: "abcd") as? T {
                        completion(.success(loggedUser))
                    } else {
                        completion(.failure(RKError(.invalidData)))
                    }
                } else {
                    completion(.failure(RKError(.serverError(code: 401, message: "forbidden access"))))
                }
            }
        }
    }
}
