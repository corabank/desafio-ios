//
//  ExtractViewModel.swift
//  desafio-ios
//
//  Created by Amaryllis Baldrez on 26/03/22.
//

import Foundation

protocol URLSessionProtocol {
    func fetchData(with urlRequest: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void)
}

extension URLSession: URLSessionProtocol {
    func fetchData(with urlRequest: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        let dataTask = dataTask(with: urlRequest, completionHandler: completionHandler)
        dataTask.resume()
    }
}

enum HTTPClientError: Error {
    case unexpectedStatusCode
    case invalidData
    case decodeError
    case invalidJson
}

class ExtractViewModel {
    
    private let session: URLSessionProtocol
    var days: [DayExtract] = []
        
    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }
    
    func getExtracts(completion: @escaping (Result<[DayExtract], Error>) -> Void) {
        guard let path = Bundle.main.path(forResource: "days", ofType: "json") else { return
            completion(.failure(HTTPClientError.invalidJson))
        }
        
        let configuration = URLSessionConfiguration.default

        configuration.protocolClasses = [ExtractMock.self]

        let session = URLSession(configuration: configuration)
        
        let task = session.dataTask(with: URL(fileURLWithPath: path)) { data, response, error in
            
            if let error = error {
                completion(.failure(error))
            }
            
            guard let data = data else {
                completion(.failure(HTTPClientError.invalidData))
                return
            }
            
            guard response != nil else {
                completion(.failure(HTTPClientError.unexpectedStatusCode))
                return
            }
            
            do {
                let dayExtract = try JSONDecoder().decode([DayExtract].self, from: data)
                DispatchQueue.main.async {
                    self.days = dayExtract
                }
                completion(.success(dayExtract))
            } catch {
                completion(.failure(HTTPClientError.decodeError))
                print(error.localizedDescription)
            }
        }

        task.resume()
        }
}
