//
//  LoginFlowTests.swift
//  DesafioCoraBankTests
//
//  Created by Roger Sanoli on 27/04/20.
//  Copyright © 2020 RogerSanoli. All rights reserved.
//

import XCTest
import KIF

@testable import DesafioCoraBank

class LoginFlowTests: KIFTestCase {

    func testLoginFlow() throws {
        let loginLabel = "Name or email"
        let passwordLabel = "Password"
        let loginButtonLabel = "Access my account"
        let errorLabel = "Invalid credentials"
        let valueCellLabel = "Value Cell"
        let buyerLabel = "Buyer"
        
        tester().waitForView(withAccessibilityLabel: loginLabel)
        tester().tapView(withAccessibilityLabel: loginLabel)
        tester().enterText(intoCurrentFirstResponder: "Roger")
        tester().tapView(withAccessibilityLabel: passwordLabel)
        tester().enterText(intoCurrentFirstResponder: "wrong")
        tester().tapView(withAccessibilityLabel: loginButtonLabel)
        
        let errorLabelView = tester().waitForView(withAccessibilityLabel: errorLabel) as? UILabel
        XCTAssertNotNil(errorLabelView, "should have a visible error.")
        XCTAssertFalse(errorLabelView?.text?.isEmpty ?? true, "The text should be fulfilled.")
        
        tester().tapView(withAccessibilityLabel: passwordLabel)
        tester().enterText(intoCurrentFirstResponder: "cora")
        tester().tapView(withAccessibilityLabel: loginButtonLabel)
        tester().waitForView(withAccessibilityLabel: valueCellLabel)
        tester().tapView(withAccessibilityLabel: valueCellLabel)
        
        let buyerView = tester().waitForView(withAccessibilityLabel: buyerLabel)
        XCTAssertNotNil(buyerView, "should present the detail.")
    }
}

extension XCTestCase {
    func tester(file : String = #file, _ line : Int = #line) -> KIFUITestActor {
        return KIFUITestActor(inFile: file, atLine: line, delegate: self)
    }

    func system(file : String = #file, _ line : Int = #line) -> KIFSystemTestActor {
        return KIFSystemTestActor(inFile: file, atLine: line, delegate: self)
    }
}

extension KIFTestActor {
    func tester(file : String = #file, _ line : Int = #line) -> KIFUITestActor {
        return KIFUITestActor(inFile: file, atLine: line, delegate: self)
    }

    func system(file : String = #file, _ line : Int = #line) -> KIFSystemTestActor {
        return KIFSystemTestActor(inFile: file, atLine: line, delegate: self)
    }
}
