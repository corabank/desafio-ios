import XCTest
@testable import DesafioCora

class LoginPresenterSpy: LoginPresenting {
    
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
}

class LoginServiceMock: LoginServicing {
    var expectedResult: (Result<String, Error>)?
    
    func requestLogin(_ loginModel: LoginModel, completion: @escaping (Result<String, Error>) -> Void) {
        guard let result = expectedResult else { return }
        completion(result)
    }
}

class AnalyticsSpy: AnalyticsProtocol {
    var logEventCallsCount: Int = 0
    var logEventInvocations: [String] = []
    
    func logEvent(_ eventName: String) {
        logEventCallsCount += 1
        logEventInvocations.append(eventName)
    }
}

class DependencyContainerMock: Dependencies {
    var mainThread: DispatchQueue = DispatchQueue.global()
    var analytics: AnalyticsProtocol = AnalyticsSpy()
}

class DesafioCoraTests: XCTestCase {
    
    let presenterSpy = LoginPresenterSpy()
    let serviceMock = LoginServiceMock()
    let analyticsSpy = AnalyticsSpy()
    lazy var dependencies: Dependencies = {
        let deps = DependencyContainerMock()
        deps.analytics = analyticsSpy
        return deps
    }()
    
    lazy var sut: LoginInteracting = LoginInteractor(presenterSpy, service: serviceMock, container: dependencies)

    func testLoginInteractorWhenSuccessShouldInvokeDidLoginFunction() throws {
        let welcomeMessage = "Welcome message"
        serviceMock.expectedResult = .success(welcomeMessage)
        sut.login("leonardo.saragiotto", password: "123456")
        
        XCTAssertEqual(presenterSpy.didLoginWithCallsCount, 1)
        XCTAssertEqual(presenterSpy.didLoginWithInvocations.first, welcomeMessage)
        XCTAssertEqual(analyticsSpy.logEventCallsCount, 1)
        XCTAssertEqual(analyticsSpy.logEventInvocations.first, "user did login")
    }
}
