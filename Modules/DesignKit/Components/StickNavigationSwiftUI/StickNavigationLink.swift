//
//  StickNavigationLink.swift
//  CoreKit
//
//  Created by Erik Santos on 23/03/24.
//

import SwiftUI

public struct StickNavigationLinkItems {
    public var rightButton: AccessibleButtonNavigationSwiftUI?
    public var leftButton: AccessibleButtonNavigationSwiftUI?
    
    public var title: AccessibleTitleNavigationSwiftUI
    public let font: UIFont?
    public let buttonColor: UIColor
    
    public init(rightButton: AccessibleButtonNavigationSwiftUI? = nil, leftButton: AccessibleButtonNavigationSwiftUI? = nil, title: AccessibleTitleNavigationSwiftUI, font: UIFont?, buttonColor: UIColor) {
        self.rightButton = rightButton
        self.leftButton = leftButton
        self.title = title
        self.font = font
        self.buttonColor = buttonColor
    }
}

public struct StickNavigationLink<Label: View, Destination: View>: View {
    
    let destination: Destination
    let label: Label
    
    var stickModel: StickNavigationLinkItems
    
    public init(destination: Destination, @ViewBuilder label: () -> Label, stickModel: StickNavigationLinkItems) {
        self.destination = destination
        self.label = label()
        self.stickModel = stickModel
    }
    
    public var body: some View {
        NavigationLink {
            StickNavigationContainer(
                rightButton: stickModel.rightButton,
                leftButton: stickModel.leftButton,
                title: stickModel.title,
                font: stickModel.font,
                buttonColor: stickModel.buttonColor) {
                    destination
                }
                .toolbar(.hidden)
            
        } label: {
            label
        }
    }
}

#Preview {
    CoreNavigationSwiftUI(title: AccessibleTitleNavigationSwiftUI(text: "Titulo", textColor: .white, backgroundColor: .blue), font: .boldSystemFont(ofSize: 15), buttonColor: .red) {
        StickNavigationLink(
         destination: Text("ola"),
         label: {
             Text("Ir para la")
         }, stickModel: StickNavigationLinkItems(title: AccessibleTitleNavigationSwiftUI(text: "Teste", textColor: .red, backgroundColor: .red), font: .boldSystemFont(ofSize: 16), buttonColor: .red)
        )
    }
}
