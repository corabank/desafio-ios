//
//  CoraDesafioTests.swift
//  CoraDesafioTests
//
//  Created by Erik Santos on 24/03/24.
//

import XCTest

@testable import CoraDesafio
final class AppDelegateTests: XCTestCase {
    
    var appDelegate: AppDelegate!
    
    override func setUp() {
        super.setUp()
        appDelegate = AppDelegate()
    }
    
    override func tearDown() {
        appDelegate = nil
        super.tearDown()
    }
    
    func test_Application_DidFinis_LaunchingWith_Options_ReturnsTrue() {
        let application = UIApplication.shared
        let launchOptions = [UIApplication.LaunchOptionsKey: Any]()
        
        let didFinishLaunching = appDelegate.application(application, didFinishLaunchingWithOptions: launchOptions)
        
        XCTAssertTrue(didFinishLaunching)
    }
}
