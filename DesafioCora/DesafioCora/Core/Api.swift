import Foundation

class Api<E: Decodable> {
    typealias Completion = (Result<E, Error>) -> Void
    static func execute(_ endpoint: EndpointProtocol, completion: @escaping Completion) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 1.5) {
            do {
                let response = try JSONDecoder().decode(E.self, from: ApiMock.loginResponse)
                completion(.success(response))
            } catch (let error) {
                completion(.failure(error))
            }
        }
    }
    
    private enum ApiMock {
        static var loginResponse: Data {
            """
            {
                "welcome": "Bem-vindo ao app!"
            }
            """.data(using: .utf8) ?? Data()
        }
    }
}
