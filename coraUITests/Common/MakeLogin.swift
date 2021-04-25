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
        let button = app.buttons["button"]
        
        if app.waitForExistenceOfAll(elements: [emailTextInput, passwordTextInput, button], for: 20) {
            emailTextInput.tap()
            emailTextInput.typeText("lucas.fernandes.silveira@gmail.com")
            passwordTextInput.tap()
            passwordTextInput.typeText("caveira2021")
            app.buttons["button"].tap()
        }
    }
}

extension XCUIApplication {
    func waitForExistenceOfAll(elements: [XCUIElement], for timeout: TimeInterval) -> Bool {
            guard elements.count > 0 else {
                return true
            }
            let startTime = NSDate.timeIntervalSinceReferenceDate
            while (NSDate.timeIntervalSinceReferenceDate - startTime <= timeout) {
                var allExist = true
                for element in elements {
                    if !element.exists {
                        allExist = false
                        break
                    }
                }
                if allExist {
                    return true
                }
                sleep(1)
            }
            return false
    }
}
