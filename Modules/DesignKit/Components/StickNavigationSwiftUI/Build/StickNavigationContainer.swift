//
//  StickNavigationContainer.swift
//  DesignKit
//
//  Created by Erik Santos on 16/03/24.
//

import SwiftUI
import UIKit

public struct StickNavigationContainer<Content: View>: View {
    
    @State var rightButton: AccessibleButtonNavigationSwiftUI?
    @State var leftButton: AccessibleButtonNavigationSwiftUI?
    
    let title: AccessibleTitleNavigationSwiftUI
    let font: UIFont?
    let buttonColor: UIColor
    
    let content: Content
    
    public var body: some View {
        VStack(spacing: .zero) {
            StickNavigationSwiftUI(
                rightButton: rightButton,
                leftButton: leftButton,
                title: title,
                font: font,
                buttonColor: buttonColor
            )
            content
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
    
    init(rightButton: AccessibleButtonNavigationSwiftUI? = nil, leftButton: AccessibleButtonNavigationSwiftUI? = nil, title: AccessibleTitleNavigationSwiftUI, font: UIFont?, buttonColor: UIColor, @ViewBuilder content: () -> Content) {
        self.rightButton = rightButton
        self.leftButton = leftButton
        self.title = title
        self.font = font
        self.buttonColor = buttonColor
        self.content = content()
    }
}

#Preview {
    StickNavigationContainer(title: AccessibleTitleNavigationSwiftUI(text: "Teste", textColor: .white, backgroundColor: .red), font: .boldSystemFont(ofSize: 18), buttonColor: .white) {
        ZStack {
            Color.green.ignoresSafeArea()
            Text("TESTE 123")
                .foregroundStyle(.white)
        }
    }
}
