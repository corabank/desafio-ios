//
//  StringTests.swift
//  Desafio CoraTests
//
//  Created by João Pedro DTI on 23/05/22.
//

@testable import Desafio_Cora
import XCTest

class StringTests: XCTestCase {

    func test_amountFormatter() throws {
        XCTAssertEqual("R$ 123.456,00", "123456.0".realAmountFormatter())
        XCTAssertEqual("", "".realAmountFormatter())
    }

    func test_CNPJFormatter() throws {
        XCTAssertEqual("11.111.111/1111-11", "11111111111111".formatCNPJ())
    }
}
