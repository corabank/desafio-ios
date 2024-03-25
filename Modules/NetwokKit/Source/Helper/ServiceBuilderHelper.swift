//
//  ServiceBuilderHelper.swift
//  CoreKit
//
//  Created by Erik Santos on 15/03/24.
//

import Foundation
import CoreKit

final class ServiceBuilderHelper {
    
    // MARK: - Properties
    
    private let baseApi: String
    
    // MARK: - Initialize
    
    public init() {
        self.baseApi = Bundle.main.object(forInfoDictionaryKey: "ServerUrl") as? String ?? ""
    }
    
    // MARK: - Public Methods
    
    func setFormattedAPI(_ apiType: APIProvider) -> String {
        return baseApi.appending(apiType.value)
    }
    
    // MARK: - Static Methods
    
    static func buildRequest(_ data: ServiceRequestData) throws -> URLRequest? {
        var request = NSMutableURLRequest()
        request.httpMethod = data.httpMethod.rawValue
        request.timeoutInterval = 10.0
        
        guard let completeUrl = URL(string: data.url) else { throw BaseError.invalidUrl }
        
        try ServiceBuilderHelper.updateRequest(&request, data: data, completeUrl: completeUrl)
  
        return request as URLRequest
    }
    
    static func verifyResponseCode(_ info: URLResponse) throws {
        guard let status = info as? HTTPURLResponse, status.statusCode != 401 else { throw BaseError.invalidStatusCode }
    }
    
    static func decodeObject<T: Decodable>(_ data: Data) throws -> T {
        do {
            guard let dataResponse = try? JSONDecoder().decode(T.self, from: data) else { throw BaseError.invalidResponse }
            return dataResponse
        } catch {
            throw BaseError.invalidResponse
        }
    }
    
    static func updateRequest(_ request: inout NSMutableURLRequest, data: ServiceRequestData, completeUrl: URL) throws {
        guard var urlComponents = URLComponents(url: completeUrl, resolvingAgainstBaseURL: false) else { throw BaseError.invalidUrl }
        
        if let bodyParameters = data.parameters?.bodyParameters {
            request.httpBody = try JSONSerialization.data(withJSONObject: bodyParameters, options: [.fragmentsAllowed])
        }
        
        if let queryParameters = data.parameters?.queryParameters {
            let parametersItems: [String] = queryParameters.map { par in
                let value = !par.1.isEmpty ? par.1 : "Nill"
                
                print("\(par.0)=\(value)")
                return "\(par.0)=\(value)"
            }
            
            urlComponents.query = parametersItems.joined(separator: "&")
        }
        
        request.url = urlComponents.url
        request.cachePolicy = .reloadIgnoringLocalCacheData
        
        
        data.header.forEach { par in
            request.addValue(par.value, forHTTPHeaderField: par.key)
        }
    }
}
