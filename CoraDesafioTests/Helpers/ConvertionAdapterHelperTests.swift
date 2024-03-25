//
//  ConvertionAdapterHelperTests.swift
//  CoraDesafioTests
//
//  Created by Erik Santos on 24/03/24.
//

import XCTest
import CoreKit

final class ConvertionAdapterHelperTests: XCTestCase {

    func test_Convert_To_Concurrent() {
        let helper = ConvertionAdapterHelper.shared
        let oneHundred = helper.convertToCurrency(10000)
        let oneThousand = helper.convertToCurrency(1_00000)
        let tenThousand = helper.convertToCurrency(10_00000)
        
        XCTAssertEqual("100,00", oneHundred)
        XCTAssertEqual("1.000,00", oneThousand)
        XCTAssertEqual("10.000,00", tenThousand)
    }
    
    func testExtractTimeWithoutSeconds() {
        let helper = ConvertionAdapterHelper.shared
        let dateString = "2024-02-01T08:15:17Z"
        XCTAssertEqual(helper.extractTimeWithoutSeconds(from: dateString), "05:15")
    }

    func testConverToDateDetails() {
        let helper = ConvertionAdapterHelper.shared
        let dateStringNotToday = "2024-03-23T08:15:17Z"
        
        XCTAssertEqual(helper.converToDateDetails(dateStringNotToday, formatter: .yyyMMDDTHHmmssZ), "sábado - 23 de março")
    }

    func testFormatCPFOrCNPJ() {
        let helper = ConvertionAdapterHelper.shared
        let cpf = "12345678900"
        let cnpj = "12345678000199"

        XCTAssertEqual(helper.formatCPFOrCNPJ(cpf, type: "CPF"), "123.456.789-00")
        XCTAssertEqual(helper.formatCPFOrCNPJ(cnpj, type: "CNPJ"), "12.345.678/0001-99")
    }
}
