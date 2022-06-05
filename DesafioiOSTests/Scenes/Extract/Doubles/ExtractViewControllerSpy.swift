//
//  ExtractViewControllerSpy.swift
//  DesafioiOSTests
//
//  Created by Allana Castenharo Santamaria on 05/06/22.
//

import Foundation
@testable import DesafioiOS

typealias ExtractViewControllerDummy = ExtractViewControllerSpy

final class ExtractViewControllerSpy: ExtractDisplaying {
    private(set) var displayExtractCalled = false
    func displayExtract() {
        displayExtractCalled = true
    }
}
