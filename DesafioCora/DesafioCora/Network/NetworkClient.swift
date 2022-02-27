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
            guard let httpUrlResponse = response as? HTTPURLResponse else {
                completion(.failure(ServiceError.networkError(error)))
                return
            }
            
        
            let successRange = 200...299
            if successRange.contains(httpUrlResponse.statusCode) {
                guard let data = data else {
                    return completion(.failure(ServiceError.noResponseData))
                }
                
                do {
                    let decoded = try JSONDecoder().decode(Response.self, from: data)
                    completion(.success(decoded))
                } catch {
                    completion(.failure(ServiceError.decodingError))
                }
            } else {
                self.parseError(data: data, completion: completion)
            }
        }.resume()
    }
    
    private func parseError<Response: Decodable>(data: Data?, completion: @escaping (Result<Response, Error>) -> Void) {
        let defaultError = ServiceErrorData(code: -1, title: "Algo deu errado", message: "Tente novamente mais tarde.")
        if let data = data {
            do {
                let decodedError = try JSONDecoder().decode(ServiceErrorData.self, from: data)
                completion(.failure(ServiceError.requestError(decodedError)))
            } catch {
                completion(.failure(ServiceError.requestError(defaultError)))
            }
        }
        
        completion(.failure(ServiceError.requestError(defaultError)))
    }
}
