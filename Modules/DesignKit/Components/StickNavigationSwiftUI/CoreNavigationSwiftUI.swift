//
//  CoreNavigationSwiftUI.swift
//  DesignKit
//
//  Created by Erik Santos on 16/03/24.
//

import SwiftUI
import UIKit

public struct CoreNavigationSwiftUI<Content: View>: View {
    
    @State var rightButton: AccessibleButtonNavigationSwiftUI?
    @State var leftButton: AccessibleButtonNavigationSwiftUI?
    
    let title: AccessibleTitleNavigationSwiftUI
    let font: UIFont?
    let buttonColor: UIColor
    
    let content: Content
    
    public var body: some View {
        NavigationStack {
            StickNavigationContainer(
                rightButton: rightButton,
                leftButton: leftButton,
                title: title,
                font: font,
                buttonColor: buttonColor) {
                    content
                }
                .toolbar(.hidden)
        }
    }
    
    public init(rightButton: AccessibleButtonNavigationSwiftUI? = nil, leftButton: AccessibleButtonNavigationSwiftUI? = nil, title: AccessibleTitleNavigationSwiftUI, font: UIFont?, buttonColor: UIColor, @ViewBuilder content: () -> Content) {
        self.rightButton = rightButton
        self.leftButton = leftButton
        self.title = title
        self.font = font
        self.buttonColor = buttonColor
        self.content = content()
    }
}

#Preview {
    CoreNavigationSwiftUI(
        leftButton: AccessibleButtonNavigationSwiftUI(Image: UIImage(systemName: "chevron.right"), action: {}),
        title: AccessibleTitleNavigationSwiftUI(text: "Teste", textColor: .white, backgroundColor: .gray),
        font: .boldSystemFont(ofSize: 18),
        buttonColor: .white) {
            Color.red.ignoresSafeArea()
    }
}
