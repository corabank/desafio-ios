//
//  coraUITests.swift
//  coraUITests
//
//  Created by Lucas Silveira on 16/04/21.
//

import XCTest

class LoginUITests: XCTestCase {
    var app: XCUIApplication!
    
    // MARK: - XCTestCase
    
    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments.append("--uitesting")
    }
    
    // MARK: - Tests
    
    func testGoingThrougASuccessfullLogin() {
        MakeLogin.run(app: app)
        
        let existsPredicate = NSPredicate(format: "exists == TRUE")
        let userLabel = app.staticTexts["userNameLabel"]
        self.expectation(for: existsPredicate, evaluatedWith: userLabel) {
            if userLabel.isEnabled {
                let label = "Hello, Lucas Silveira"
                XCTAssertEqual(userLabel.label, label)
                return true
            }
            return false
        }
        self.waitForExpectations(timeout: 40, handler: nil)
    }
    
    func testGoingThroughLoginWithEmptyEmailAndPasword() {
        app.launch()
        
        app.buttons["button"].tap()
        XCTAssertEqual(app.staticTexts["errorLabel"].label, "Email and password are required")
    }
    
    func testGoingThroughLoginWithEmptyEmail() {
        app.launch()
        let scrollView = app.scrollViews["scrollview"]
        let passwordTextInput = app.secureTextFields["passwordTextInput"]
        let button = app.buttons["button"]
        
        passwordTextInput.tap()
        passwordTextInput.typeText("caveira2021")
        scrollView.tap()
        button.tap()
        XCTAssertEqual(app.staticTexts["errorLabel"].label, "Email is required")
    }
    
    func testGoingThroughLoginWithEmptyPassword() {
        app.launch()
        let scrollView = app.scrollViews["scrollview"]
        let emailTextInput = app.textFields["emailTextInput"]
        let button = app.buttons["button"]
        
        emailTextInput.tap()
        emailTextInput.typeText("lucas.fernandes.silveira@gmail.com")
        scrollView.tap()
        button.tap()
        XCTAssertEqual(app.staticTexts["errorLabel"].label, "Password is required")
    }
    
    func testGoingThroughLoginWithInvalidEmail() {
        app.launch()

        let emailTextInput = app.textFields["emailTextInput"]
        emailTextInput.tap()
        emailTextInput.typeText("wrong@mail.com")
        
        let passwordTextInput = app.secureTextFields["passwordTextInput"]
        passwordTextInput.tap()
        passwordTextInput.typeText("caveira2021")
        
        app.buttons["button"].tap()
        
        let existsPredicate = NSPredicate(format: "label BEGINSWITH 'Invalid email or password'")
        let errorLabel = app.staticTexts["errorLabel"]
        self.expectation(for: existsPredicate, evaluatedWith: errorLabel) {
            if errorLabel.label != "" {
                XCTAssertEqual(errorLabel.label, "Invalid email or password")
                return true
            }
            
            return false
        }
        self.waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testGoingThroughLoginWithInvalidPassword() {
        app.launch()
        let emailTextInput = app.textFields["emailTextInput"]
        emailTextInput.tap()
        emailTextInput.typeText("lucas.fernandes.silveira@gmail.com")
        
        let passwordTextInput = app.secureTextFields["passwordTextInput"]
        passwordTextInput.tap()
        passwordTextInput.typeText("wrongpassword")
        
        app.buttons["button"].tap()
        
        let existsPredicate = NSPredicate(format: "label BEGINSWITH 'Invalid email or password'")
        let errorLabel = app.staticTexts["errorLabel"]
        self.expectation(for: existsPredicate, evaluatedWith: errorLabel) {
            if errorLabel.label != "" {
                XCTAssertEqual(errorLabel.label, "Invalid email or password")
                return true
            }
            
            return false
        }
        self.waitForExpectations(timeout: 10, handler: nil)
    }
}
