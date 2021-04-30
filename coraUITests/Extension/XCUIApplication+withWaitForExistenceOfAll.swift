//
//  XCUIApplication+withWaitForExistenceOfAll.swift
//  coraUITests
//
//  Created by Lucas Silveira on 30/04/21.
//

import XCTest

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
