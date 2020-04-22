//
//  LoginViewSpec.swift
//  DesafioCoraBankTests
//
//  Created by Roger Sanoli on 21/04/20.
//  Copyright © 2020 RogerSanoli. All rights reserved.
//

import Quick
import Nimble
import Nimble_Snapshots

@testable import DesafioCoraBank

class LoginViewSpec: QuickSpec {
    override func spec() {
        describe("The Login View") {
            context("On an iPhone SE") {
                it("should have the expected appearance") {
                    let loginView = LoginView()
                    loginView.widthAnchor.constraint(equalToConstant: 320).isActive = true
                    loginView.heightAnchor.constraint(equalToConstant: 568).isActive = true
                    loginView.animateViews(true)
                    expect(loginView) == snapshot("LoginViewSE")
                }
            }
            
            context("On an iPhone 8") {
                it("should have the expected appearance") {
                    let loginView = LoginView()
                    loginView.widthAnchor.constraint(equalToConstant: 375).isActive = true
                    loginView.heightAnchor.constraint(equalToConstant: 667).isActive = true
                    loginView.animateViews(true)
                    expect(loginView) == snapshot("LoginView8")
                }
            }
            
            context("On an iPhone 11") {
                it("should have the expected appearance") {
                    let loginView = LoginView()
                    loginView.widthAnchor.constraint(equalToConstant: 414).isActive = true
                    loginView.heightAnchor.constraint(equalToConstant: 896).isActive = true
                    loginView.animateViews(true)
                    expect(loginView) == snapshot("LoginView11")
                }
            }
            
            context("On an iPhone 11 Pro Max") {
                it("should have the expected appearance") {
                    let loginView = LoginView()
                    loginView.widthAnchor.constraint(equalToConstant: 621).isActive = true
                    loginView.heightAnchor.constraint(equalToConstant: 1344).isActive = true
                    loginView.animateViews(true)
                    expect(loginView) == snapshot("LoginView11ProMax")
                }
            }
            
            it("should not init with coder") {
                let loginView = LoginView(coder: NSCoder())
                expect(loginView).to(beNil())
            }
        }
    }
}
