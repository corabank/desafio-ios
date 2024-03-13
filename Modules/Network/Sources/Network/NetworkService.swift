//
//  NetworkService.swift
//
//
//  Created by João Gabriel Dourado Cervo on 13/03/24.
//

import Foundation

class NetworkService {
    private let urlSession: URLSession
    
    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    /// Performs an asynchronous network request and decodes the response data
    /// into the specified type.
    ///
    /// - Parameters:
    ///   - router: An object conforming to the `URLRequestConvertible` protocol.
    ///   - returnType: The type into which the response data should be decoded.
    ///
    /// - Throws:
    ///   - `NetworkError.dataConversionFailure` if data cannot be decoded into the specified type.
    ///
    /// - Returns:
    ///   The decoded data of the specified type.
    func request<T: Decodable>(_ returnType: T.Type, router: Router, completionHandler: @escaping ((Result<T, NetworkError>) -> Void)) throws {
        let request = try router.asURLRequest()
        
        urlSession.dataTask(with: request) { data, response, requestError in
            guard let data, let response, requestError == nil else {
                completionHandler(.failure(.generic(error: requestError)))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completionHandler(.failure(.invalidResponse))
                return
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                completionHandler(.failure(.requestFailed(statusCode: httpResponse.statusCode)))
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let decodedData = try decoder.decode(returnType, from: data)
                completionHandler(.success(decodedData))
            } catch {
                completionHandler(.failure(.dataConversionError))
            }
        }.resume()
    }
}
