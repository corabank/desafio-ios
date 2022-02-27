//
//  NetworkClient.swift
//  DesafioCora
//
//  Created by user205543 on 2/26/22.
//

import Foundation
protocol NetworkClient {
    func execute<Request: ServiceRequest, Response: Decodable>(request: Request, responseType: Response.Type, completion: @escaping (Result<Response, Error>) -> Void)
}

class DefaultNetwoktClient: NetworkClient {
    let session: URLSession
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func execute<Request, Response>(
        request: Request,
        responseType: Response.Type,
        completion: @escaping (Result<Response, Error>) -> Void
    ) where Request : ServiceRequest, Response : Decodable {
        guard let url = URL(string: request.baseUrl + request.path) else {
            return completion(.failure(ServiceError.invalidURL))
        }
        
        session.dataTask(with: URLRequest(url: url)) { data, response, error in
            if let error = error {
                completion(.failure(ServiceError.requestError(error)))
                return
            }
            
            guard let data = data else {
                return completion(.failure(ServiceError.noResponseData))
            }

            do {
                let decoded = try JSONDecoder().decode(Response.self, from: data)
                completion(.success(decoded))
            } catch {
                completion(.failure(ServiceError.decodingError))
            }
        }
    }
}
