//
//  LayoutHelperTests.swift
//  CoraDesafioTests
//
//  Created by Erik Santos on 24/03/24.
//

import XCTest
import CoreKit
import UIKit

final class LayoutHelperTests: XCTestCase {

    func testMakeLabel() {
         let helper = LayoutHelper.shared
         let label = helper.makeLabel(text: "Test", alignment: .center, numberOfLines: 1, font: UIFont.systemFont(ofSize: 14), textColor: .black)
         XCTAssertEqual(label.text, "Test")
         XCTAssertEqual(label.textAlignment, .center)
         XCTAssertEqual(label.numberOfLines, 1)
         XCTAssertEqual(label.font, UIFont.systemFont(ofSize: 14))
         XCTAssertEqual(label.textColor, .black)
     }

     func testMakeBold() {
         let helper = LayoutHelper.shared
         let label = UILabel()
         label.text = "This is a test"
         let boldLabel = helper.makeBold(label, textBold: "test", fontBold: UIFont.boldSystemFont(ofSize: 14))
         let attributedText = boldLabel.attributedText
         XCTAssertNotNil(attributedText)
     }

     func testAdjustLineHeight() {
         let helper = LayoutHelper.shared
         let label = UILabel()
         label.text = "This is a test"
         let adjustedLabel = helper.adjustLineHeight(label, height: 24)
         let attributedText = adjustedLabel.attributedText
         XCTAssertNotNil(attributedText)
         let paragraphStyle = attributedText?.attribute(.paragraphStyle, at: 0, effectiveRange: nil) as? NSParagraphStyle
         XCTAssertEqual(paragraphStyle?.lineHeightMultiple, 24 / label.font.lineHeight)
     }

     func testMakeStackView() {
         let helper = LayoutHelper.shared
         let stackView = helper.makeStackView(aligment: .center, spacing: 8, axis: .horizontal)
         XCTAssertEqual(stackView.alignment, .center)
         XCTAssertEqual(stackView.spacing, 8)
         XCTAssertEqual(stackView.axis, .horizontal)
     }

     func testGetSafeTopAreaHeight() {
         let helper = LayoutHelper.shared
         let safeAreaHeight = helper.getSafeTopAreaHeight()
         XCTAssertGreaterThanOrEqual(safeAreaHeight, CGFloat.zero)
     }

}
