//
//  MakeLogin.swift
//  coraUITests
//
//  Created by Lucas Silveira on 24/04/21.
//

import XCTest

class MakeLogin: XCTestCase {
    static func run(app: XCUIApplication) {
        app.launch()
        
        let emailTextInput = app.textFields["emailTextInput"]
        let passwordTextInput = app.secureTextFields["passwordTextInput"]
        
        emailTextInput.tap()
        emailTextInput.typeText("lucas.fernandes.silveira@gmail.com")
        passwordTextInput.tap()
        passwordTextInput.typeText("caveira2021")
        
        app.buttons["button"].tap()
    }
}
