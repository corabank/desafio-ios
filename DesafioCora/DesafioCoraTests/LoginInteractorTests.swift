import XCTest
@testable import DesafioCora

final class LoginPresenterSpy: LoginPresenting {
    
    var viewController: LoginDisplay? = nil
    
    var didLoginWithCallsCount: Int = 0
    var didLoginWithInvocations: [String] = []
    
    func didLoginWith(_ message: String) {
        didLoginWithCallsCount += 1
        didLoginWithInvocations.append(message)
    }
    
    var somenthingWrongDidHappenCallsCount: Int = 0
    var somenthingWrongDidHappenInvocations: [String] = []
    
    func somenthingWrongDidHappen(_ message: String) {
        somenthingWrongDidHappenCallsCount += 1
        somenthingWrongDidHappenInvocations.append(message)
    }
    
    var prepareForLoadingCallsCount: Int = 0
    
    func prepareForLoading() {
        prepareForLoadingCallsCount += 1
    }
}

final class LoginServiceMock: LoginServicing {
    var expectedResult: (Result<LoginModelResponse, Error>)?
    
    func requestLogin(_ loginModel: LoginModelRequest, completion: @escaping (Result<LoginModelResponse, Error>) -> Void) {
        guard let result = expectedResult else { return }
        completion(result)
    }
}

final class DesafioCoraTests: XCTestCase {
    
    let presenterSpy = LoginPresenterSpy()
    let serviceMock = LoginServiceMock()
    let analyticsSpy = AnalyticsSpy()
    lazy var dependencies: Dependencies = {
        let deps = DependencyContainerMock()
        deps.analytics = analyticsSpy
        return deps
    }()
    
    lazy var sut: LoginInteracting = LoginInteractor(presenterSpy, service: serviceMock, container: dependencies)
    
    enum ApiMockError: Error, LocalizedError {
        case decodeFail
        static let message = "Falha no decode do JSON"
        
        var errorDescription: String? {
            return ApiMockError.message
        }
    }

    func testLoginInteractorWhenSuccessShouldInvokeDidLoginFunction() throws {
        // Given
        let welcomeMessage = "Welcome message"
        let response = LoginModelResponse(welcome: welcomeMessage)
        serviceMock.expectedResult = .success(response)
        
        // When
        sut.login("leonardo.saragiotto", password: "123456")
        
        
        // Then
        XCTAssertEqual(presenterSpy.didLoginWithCallsCount, 1)
        XCTAssertEqual(presenterSpy.didLoginWithInvocations.first, welcomeMessage)
        XCTAssertEqual(analyticsSpy.logEventCallsCount, 1)
        XCTAssertEqual(analyticsSpy.logEventInvocations.first?.name, "Login - Sucesso")
    }
    
    func testLoginInteractorWhenFailShouldInvokeSomenthingWrongDidHappen() throws {
        // Given
        serviceMock.expectedResult = .failure(ApiMockError.decodeFail)
        
        // When
        sut.login("leonardo.saragiotto", password: "123456")
        
        
        // Then
        XCTAssertEqual(presenterSpy.somenthingWrongDidHappenCallsCount, 1)
        XCTAssertEqual(presenterSpy.somenthingWrongDidHappenInvocations.first, ApiMockError.message)
        XCTAssertEqual(analyticsSpy.logEventCallsCount, 1)
        XCTAssertEqual(analyticsSpy.logEventInvocations.first?.name, "Login - Erro")
    }
}
