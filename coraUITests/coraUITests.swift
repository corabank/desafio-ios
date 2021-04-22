//
//  coraUITests.swift
//  coraUITests
//
//  Created by Lucas Silveira on 16/04/21.
//

import XCTest

class coraUITests: XCTestCase {
    var app: XCUIApplication!
    
    // MARK: - XCTestCase
    
    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments.append("--uitesting")
    }
    
    // MARK: - Tests
    
    func makeLogin() {
        app.launch()
        
        let emailTextInput = app.textFields["emailTextInput"]
        let passwordTextInput = app.secureTextFields["passwordTextInput"]
        
        emailTextInput.tap()
        emailTextInput.typeText("lucas.fernandes.silveira@gmail.com")
        passwordTextInput.tap()
        passwordTextInput.typeText("caveira2021")
        
        app.buttons["button"].tap()
    }
    
    func testGoingThrougASuccessfullLogin() {
        makeLogin()

        let doesNotExistPredicate = NSPredicate(format: "exists == FALSE")
        self.expectation(for: doesNotExistPredicate, evaluatedWith: app.buttons["button"], handler: nil)
        self.waitForExpectations(timeout: 20, handler: nil)
        
        
        let existsPredicate = NSPredicate(format: "exists == TRUE")
        self.expectation(for: existsPredicate, evaluatedWith: app.staticTexts["userNameLabel"], handler: nil)
        self.waitForExpectations(timeout: 40, handler: nil)
    }
    
    func testGoingThroughLoginWithEmptyEmailAndPasword() {
        app.launch()
        
        app.buttons["button"].tap()
        XCTAssertEqual(app.staticTexts["errorLabel"].label, "Email e senha são obrigatórios")
    }
    
    func testGoingThroughLoginWithEmptyEmail() {
        app.launch()
        let passwordTextInput = app.secureTextFields["passwordTextInput"]
        passwordTextInput.tap()
        passwordTextInput.typeText("caveira2021")
        
        app.buttons["button"].tap()
        XCTAssertEqual(app.staticTexts["errorLabel"].label, "O email é obrigatório")
    }
    
    func testGoingThroughLoginWithEmptyPassword() {
        app.launch()
        let emailTextInput = app.textFields["emailTextInput"]
        emailTextInput.tap()
        emailTextInput.typeText("lucas.fernandes.silveira@gmail.com")
        
        app.buttons["button"].tap()
        XCTAssertEqual(app.staticTexts["errorLabel"].label, "A senha é obrigatória")
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
        
        
        let existsPredicate = NSPredicate(format: "label BEGINSWITH 'Email ou senha inválidos'")
        self.expectation(for: existsPredicate, evaluatedWith: app.staticTexts["errorLabel"], handler: nil)
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
        
        
        let existsPredicate = NSPredicate(format: "label BEGINSWITH 'Email ou senha inválidos'")
        self.expectation(for: existsPredicate, evaluatedWith: app.staticTexts["errorLabel"], handler: nil)
        self.waitForExpectations(timeout: 10, handler: nil)
    }
}
